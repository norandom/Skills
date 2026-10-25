"""Collect sanitized SkillSpector artifacts, then enforce their verdict separately.

JSON fields follow the pinned v2.13.1 nodes/report.py and scan-completeness contract:
https://github.com/NVIDIA/SkillSpector/blob/v2.13.1/src/skillspector/nodes/report.py
No scanner nonzero exit is hidden: collection succeeds to permit artifact export,
but `check` and `dagger call scan` fail unless every expected report is valid/clean.
"""

import argparse
import json
import math
from pathlib import Path
import re
import subprocess
import tempfile
import time

from scan_diagnostics import redact, redact_json


def write_json(path, value):
    path.write_text(json.dumps(redact_json(value), indent=2) + "\n", encoding="utf-8")


def collect(skill, output, attempts=3, use_llm=False):
    """Raw output stays in ephemeral scratch; only sanitized files are exported."""
    output.mkdir(parents=True, exist_ok=True)
    history = []
    with tempfile.TemporaryDirectory(prefix="skillspector-") as scratch:
        for attempt in range(1, attempts + 1):
            report_path = Path(scratch) / "report.json"
            report_path.unlink(missing_ok=True)
            command = ["skillspector", "scan", str(skill), "--fail-on-incomplete",
                       "--format", "json", "--output", str(report_path)]
            if not use_llm:
                command.append("--no-llm")
            try:
                result = subprocess.run(command, capture_output=True, text=True,
                                        encoding="utf-8", errors="replace", check=False)
                code, log = result.returncode, result.stdout + "\n" + result.stderr
            except OSError as exc:
                code, log = 127, f"Scanner could not start: {exc}"
            safe_log = redact(log)
            (output / f"attempt-{attempt}.log").write_text(safe_log, encoding="utf-8")
            degraded = "LLM call failed" in log
            history.append({"attempt": attempt, "exit_code": code, "llm_degraded": degraded})
            report = None
            if report_path.exists():
                raw = report_path.read_text(encoding="utf-8", errors="replace")
                try:
                    report = json.loads(raw)
                except (ValueError, RecursionError):
                    report = None
                    (output / f"attempt-{attempt}.invalid-report.txt").write_text(
                        redact(raw), encoding="utf-8")
            # A null report is explicit failure evidence and prevents an older
            # report at the export destination being mistaken for this attempt.
            write_json(output / f"attempt-{attempt}.json", report)
            if use_llm and degraded and attempt < attempts:
                time.sleep(5)
                continue
            break
    write_json(output / "status.json", {
        "schema_version": 1, "skill": skill.name, "use_llm": use_llm,
        "attempts": history, "final_attempt": len(history),
    })


def inspect_report(report, status, log):
    """Fail closed on absent/malformed evidence, not merely CLI exit status."""
    reasons = []
    if not isinstance(status, dict) or status.get("schema_version") != 1:
        return ["missing or invalid runner status"], None, None
    history = status.get("attempts")
    final = status.get("final_attempt")
    if (not isinstance(history, list) or not history or type(final) is not int
            or final != len(history) or type(status.get("use_llm")) is not bool
            or any(not isinstance(item, dict) or item.get("attempt") != index
                   or type(item.get("exit_code")) is not int
                   or type(item.get("llm_degraded")) is not bool
                   for index, item in enumerate(history, 1))):
        return ["malformed runner attempt history"], None, None
    last = history[-1]
    if last["exit_code"] != 0:
        reasons.append(f"scanner exit code {last['exit_code']}")
    if last["llm_degraded"] or "LLM call failed" in log:
        reasons.append("LLM validation degraded")
    if not isinstance(report, dict):
        return reasons + ["missing or malformed JSON report"], None, None
    score = report.get("risk_assessment", {}).get("score") if isinstance(report.get("risk_assessment"), dict) else None
    if type(score) not in (int, float) or not math.isfinite(score) or not 0 <= score <= 100:
        reasons.append("missing or invalid risk score")
        score = None
    elif score > 50:
        reasons.append("risk score exceeds 50")
    if report.get("execution_successful") is not True:
        reasons.append("scanner execution not successful")
    completeness = report.get("analysis_completeness")
    if not isinstance(completeness, dict):
        return reasons + ["missing completeness evidence"], score, None
    if completeness.get("is_complete") is not True or completeness.get("status") != "complete":
        reasons.append("analysis incomplete")
    for key in ("partially_inspected_files", "entirely_uninspected_files"):
        value = completeness.get(key)
        if type(value) is not int or value != 0:
            reasons.append(f"{key}: {value}")
    for key in ("limitations", "ledger_exceptions"):
        values = completeness.get(key)
        if not isinstance(values, list):
            reasons.append(f"missing or malformed {key}")
        elif values:
            reasons.append(f"{key}: " + json.dumps(values, ensure_ascii=False))
    statuses = completeness.get("analyzer_statuses")
    if not isinstance(statuses, list) or not statuses:
        reasons.append("missing analyzer statuses")
    else:
        for analyzer in statuses:
            allowed = isinstance(analyzer, dict) and analyzer.get("status") == "completed"
            if isinstance(analyzer, dict) and analyzer.get("status") == "not_applicable":
                allowed = analyzer.get("planned_work") == 0
            if (isinstance(analyzer, dict) and analyzer.get("status") == "disabled"
                    and not status["use_llm"]):
                allowed = (str(analyzer.get("analyzer_id", "")).startswith("semantic_")
                           and analyzer.get("planned_work") == 0)
            if not allowed:
                reasons.append("analyzer not completed: " + json.dumps(analyzer, ensure_ascii=False))
    return reasons, score, completeness


def read_json(path):
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError, RecursionError):
        return None


def check(root):
    manifest = read_json(root / "manifest.json")
    skills = manifest.get("skills") if isinstance(manifest, dict) else None
    if (not isinstance(manifest, dict) or manifest.get("schema_version") != 1
            or type(manifest.get("use_llm")) is not bool
            or not isinstance(skills, list) or not skills
            or any(not isinstance(name, str) or not re.fullmatch(r"[a-z0-9][a-z0-9.-]*", name)
                   or ".." in name for name in skills)
            or len(set(skills)) != len(skills)):
        print("SECURITY GATE ERROR: missing or malformed expected-skill manifest")
        return 1
    failed = []
    for name in skills:
        folder = root / name
        status = read_json(folder / "status.json")
        final = status.get("final_attempt") if isinstance(status, dict) else None
        report = read_json(folder / f"attempt-{final}.json") if type(final) is int else None
        try:
            log = (folder / f"attempt-{final}.log").read_text(encoding="utf-8")
            log_missing = False
        except OSError:
            log, log_missing = "", True
        reasons, score, completeness = inspect_report(report, status, log)
        if log_missing:
            reasons.append("missing scanner log")
        if not isinstance(status, dict) or status.get("skill") != name:
            reasons.append("runner skill identity mismatch")
        if not isinstance(status, dict) or status.get("use_llm") is not manifest["use_llm"]:
            reasons.append("runner LLM mode does not match manifest")
        if reasons:
            failed.append(name)
        state = completeness.get("status") if completeness else "unknown"
        print(f"GATE {'FAIL' if reasons else 'PASS'}: {name}; risk={score}; coverage={state}")
        for reason in reasons:
            # Complete records remain in artifacts; CI gets a bounded summary.
            print("  " + redact(reason)[:4000].replace("\n", " "))
    if failed:
        print("SECURITY GATE FAILED: " + ", ".join(failed))
        return 1
    print(f"SECURITY GATE PASSED: {len(skills)} complete scans")
    return 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)
    collect_parser = commands.add_parser("collect")
    collect_parser.add_argument("skill", type=Path)
    collect_parser.add_argument("output", type=Path)
    collect_parser.add_argument("--attempts", type=int, default=3, choices=range(1, 11))
    collect_parser.add_argument("--use-llm", action="store_true")
    check_parser = commands.add_parser("check")
    check_parser.add_argument("root", type=Path)
    args = parser.parse_args()
    if args.command == "collect":
        collect(args.skill, args.output, args.attempts, args.use_llm)
        return 0
    return check(args.root)


if __name__ == "__main__":
    raise SystemExit(main())
