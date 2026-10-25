"""Exercise collection, artifact redaction, and fail-closed verdicts without LLM calls."""

import contextlib
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

SCRIPTS = Path(__file__).parents[1] / "scripts"
sys.path.insert(0, str(SCRIPTS))
import scan_reports as gate
from scan_diagnostics import redact, redact_json


def clean_report():
    return {
        "risk_assessment": {"score": 0}, "execution_successful": True,
        "analysis_completeness": {
            "is_complete": True, "status": "complete", "partially_inspected_files": 0,
            "entirely_uninspected_files": 0, "ledger_exceptions": [], "limitations": [],
            "analyzer_statuses": [{"analyzer": "static", "status": "completed"}],
        },
    }


class ScanGateTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.skill = self.root / "fixture"
        self.skill.mkdir()
        self.output = self.root / "reports" / "fixture"
        self.output.parent.mkdir()
        gate.write_json(self.output.parent / "manifest.json", {"schema_version": 1, "skills": ["fixture"], "use_llm": True})

    def collect(self, report=None, code=0, log="", malformed=False, missing=False, use_llm=True):
        report = clean_report() if report is None else report
        gate.write_json(self.output.parent / "manifest.json", {"schema_version": 1, "skills": ["fixture"], "use_llm": use_llm})

        def fake_scanner(command, **kwargs):
            self.assertIn("--fail-on-incomplete", command)
            self.assertEqual("--no-llm" in command, not use_llm)
            if not missing:
                target = Path(command[command.index("--output") + 1])
                target.write_text("{broken" if malformed else json.dumps(report), encoding="utf-8")
            return subprocess.CompletedProcess(command, code, log, "")

        with patch.object(gate.subprocess, "run", side_effect=fake_scanner), patch.object(gate.time, "sleep"):
            gate.collect(self.skill, self.output, attempts=2, use_llm=use_llm)

    def verdict(self):
        capture = io.StringIO()
        with contextlib.redirect_stdout(capture):
            code = gate.check(self.output.parent)
        return code, capture.getvalue()

    def test_clean_llm_pass(self):
        self.collect()
        self.assertEqual(self.verdict()[0], 0)

    def test_static_pass(self):
        self.collect(use_llm=False)
        self.assertEqual(self.verdict()[0], 0)

    def test_mixed_static_llm_bundle_fails(self):
        self.collect(use_llm=True)
        second = self.output.parent / "static-fixture"
        second.mkdir()
        for artifact in self.output.iterdir():
            (second / artifact.name).write_bytes(artifact.read_bytes())
        status = gate.read_json(second / "status.json")
        status.update(skill="static-fixture", use_llm=False)
        gate.write_json(second / "status.json", status)
        gate.write_json(self.output.parent / "manifest.json", {
            "schema_version": 1, "skills": ["fixture", "static-fixture"], "use_llm": True,
        })
        code, summary = self.verdict()
        self.assertEqual(code, 1)
        self.assertIn("GATE PASS: fixture", summary)
        self.assertIn("GATE FAIL: static-fixture", summary)
        self.assertIn("runner LLM mode does not match manifest", summary)

    def test_manifest_llm_mode_must_be_boolean(self):
        self.collect()
        for mode in (None, 1, "true"):
            with self.subTest(mode=mode):
                gate.write_json(self.output.parent / "manifest.json", {
                    "schema_version": 1, "skills": ["fixture"], "use_llm": mode,
                })
                self.assertEqual(self.verdict()[0], 1)

    def test_score_over_threshold_fails_even_with_zero_exit(self):
        report = clean_report()
        report["risk_assessment"]["score"] = 51
        self.collect(report)
        code, summary = self.verdict()
        self.assertEqual(code, 1)
        self.assertIn("risk=51", summary)

    def test_incomplete_zero_exit_fails(self):
        report = clean_report()
        report["analysis_completeness"].update(is_complete=False, status="partial")
        self.collect(report)
        self.assertEqual(self.verdict()[0], 1)

    def test_degraded_analyzer_fails_despite_complete_flag(self):
        report = clean_report()
        report["analysis_completeness"]["analyzer_statuses"][0]["status"] = "degraded"
        self.collect(report)
        self.assertIn("analyzer not completed", self.verdict()[1])

    def test_nonapplicable_analyzer_is_not_a_failure(self):
        report = clean_report()
        report["analysis_completeness"]["analyzer_statuses"].append(
            {"analyzer_id": "behavioral_ast", "status": "not_applicable", "planned_work": 0})
        self.collect(report)
        self.assertEqual(self.verdict()[0], 0)

    def test_disabled_semantic_analyzer_only_allowed_in_static_mode(self):
        report = clean_report()
        report["analysis_completeness"]["analyzer_statuses"].append(
            {"analyzer_id": "semantic_security_discovery", "status": "disabled", "planned_work": 0})
        self.collect(report, use_llm=False)
        self.assertEqual(self.verdict()[0], 0)
        self.collect(report, use_llm=True)
        self.assertEqual(self.verdict()[0], 1)

    def test_exception_details_are_not_lost(self):
        report = clean_report()
        report["analysis_completeness"]["ledger_exceptions"] = [{"reason_code": "reference_missing", "path": "SKILL.md"}]
        self.collect(report)
        self.assertIn("reference_missing", self.verdict()[1])

    def test_nonzero_exit_retains_complete_reports(self):
        self.collect(code=2)
        self.assertTrue((self.output / "attempt-1.json").exists())
        self.assertEqual(self.verdict()[0], 1)

    def test_degraded_zero_exit_retries_and_fails(self):
        self.collect(log="LLM call failed")
        self.assertTrue((self.output / "attempt-2.log").exists())
        self.assertEqual(self.verdict()[0], 1)

    def test_missing_report_fails(self):
        self.collect(missing=True)
        self.assertEqual(self.verdict()[0], 1)

    def test_malformed_report_fails_and_is_preserved(self):
        self.collect(malformed=True)
        self.assertTrue((self.output / "attempt-1.invalid-report.txt").exists())
        self.assertEqual(self.verdict()[0], 1)

    def test_missing_status_fails(self):
        self.collect()
        (self.output / "status.json").unlink()
        self.assertEqual(self.verdict()[0], 1)

    def test_missing_manifest_fails(self):
        (self.output.parent / "manifest.json").unlink()
        self.assertEqual(self.verdict()[0], 1)

    def test_missing_expected_skill_fails(self):
        self.collect()
        gate.write_json(self.output.parent / "manifest.json", {"schema_version": 1, "skills": ["fixture", "absent"], "use_llm": True})
        self.assertEqual(self.verdict()[0], 1)

    def test_invalid_score_and_completeness_fail(self):
        for value in (True, "0", None, float("nan")):
            with self.subTest(value=value):
                report = clean_report()
                report["risk_assessment"]["score"] = value
                self.collect(report)
                self.assertEqual(self.verdict()[0], 1)

    def test_missing_log_fails(self):
        self.collect()
        (self.output / "attempt-1.log").unlink()
        self.assertEqual(self.verdict()[0], 1)

    def test_full_sanitized_json_and_logs_survive_collection(self):
        secret = "fixture-private-credential"
        report = clean_report()
        report["findings"] = [{"details": secret, "authorization": "Basic private-value"}]
        long_log = "first evidence\n" + "line\n" * 60 + secret
        with patch.dict(os.environ, {"ANTHROPIC_API_KEY": secret}):
            self.collect(report, log=long_log)
        artifact_text = "\n".join(p.read_text() for p in self.output.iterdir())
        self.assertNotIn(secret, artifact_text)
        self.assertNotIn("private-value", artifact_text)
        self.assertIn("first evidence", artifact_text)
        self.assertIn("findings", artifact_text)
        self.assertIn("[REDACTED]", artifact_text)

    def test_collection_failure_is_recorded(self):
        with patch.object(gate.subprocess, "run", side_effect=OSError("not installed")):
            gate.collect(self.skill, self.output)
        self.assertEqual(self.verdict()[0], 1)
        self.assertIn("Scanner could not start", (self.output / "attempt-1.log").read_text())


class DiagnosticTests(unittest.TestCase):
    def test_credentials_are_redacted(self):
        with patch.dict(os.environ, {"ANTHROPIC_API_KEY": "test-private-value"}):
            result = redact("test-private-value sk-ant-example Authorization: Bearer test-token")
        for value in ("test-private-value", "sk-ant-example", "test-token"):
            self.assertNotIn(value, result)

    def test_headers_and_nested_json_are_redacted(self):
        self.assertNotIn("private-value", redact("x-api-key: private-value\n"))
        self.assertEqual(redact_json({"nested": [{"api_key": "private-value"}]}),
                         {"nested": [{"api_key": "[REDACTED]"}]})

    def test_workflow_commands_are_neutralized(self):
        self.assertFalse(redact("::error::example").startswith("::"))


if __name__ == "__main__":
    unittest.main()
