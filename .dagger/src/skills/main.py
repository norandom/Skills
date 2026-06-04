"""Release tooling for the Skills repo.

Builds every skill/mcp bundle, an installer archive, and a checksum file, all
inside a container so releases are reproducible regardless of the host. The
GitHub Actions workflow calls `dist` on a `v*` tag and uploads the result.

`scan` is the security gate: it runs NVIDIA SkillSpector against every skill
and fails the pipeline if any skill scores HIGH/CRITICAL, which stops a release
before anything is published.
"""

import asyncio
from typing import Annotated

import dagger
from dagger import DefaultPath, dag, function, object_type

# SkillSpector has no release tags yet, so pin to a commit for reproducibility.
# Bump this to re-pin against a newer scanner.
_SKILLSPECTOR_REF = "2eb844780ab163f01468ecf142c40a2ec0fcaec0"

# Scans ONE skill (env SKILL_DIR), exit 0 = pass, non-zero = gate breach.
# Run one container per skill so the whole set scans concurrently; the install
# layer is shared, so wall-clock is the slowest single skill, not the sum.
#
# When an LLM call drops, SkillSpector silently falls back to its fragile static
# heuristics (e.g. flagging XML comments as "hidden instructions"). That verdict
# is unreliable, so we retry the skill rather than trust it. We never PASS on a
# degraded scan, and fail closed if the LLM stays unreachable after retries.
_SCAN_ONE = r"""
set -uo pipefail
name="$(basename "$SKILL_DIR")"
status="error"
attempt=1
while [ "$attempt" -le "${MAX_ATTEMPTS:-3}" ]; do
  set +e
  skillspector scan "$SKILL_DIR" $LLM_FLAG --format markdown \
    --output "/tmp/${name}.md" >"/tmp/${name}.log" 2>&1
  rc=$?
  set -e
  if [ "$rc" -eq 0 ]; then
    status="pass"; break
  fi
  if [ "${USE_LLM:-0}" = "1" ] && grep -q "LLM call failed" "/tmp/${name}.log"; then
    echo ">> $name: LLM degraded (attempt ${attempt}/${MAX_ATTEMPTS:-3}); retrying..." >&2
    attempt=$((attempt + 1))
    sleep 5
    continue
  fi
  # rc != 0 with a clean LLM verdict -> a genuine HIGH/CRITICAL finding.
  status="fail"; break
done
if [ "$status" = "pass" ]; then
  echo "GATE PASS: $name"
  exit 0
elif [ "$status" = "fail" ]; then
  echo "GATE FAIL: $name -- risk_score > 50 (HIGH/CRITICAL, do not install)"
  echo "---- report ----"
  cat "/tmp/${name}.md" 2>/dev/null || cat "/tmp/${name}.log" 2>/dev/null || true
  exit 1
else
  echo "GATE ERROR: $name -- LLM unreachable after ${MAX_ATTEMPTS:-3} attempts (failing closed)"
  exit 1
fi
"""

# Runs inside the build container (cwd = mounted repo). Produces /dist.
_BUILD = r"""
set -euo pipefail
./build.sh
mkdir -p /dist
# per-skill bundles: <skill>/<skill>.skill
find . -maxdepth 2 -name '*.skill' -exec cp {} /dist/ \;
# mcp server bundles: mcp_servers/<name>.mcpb
if ls mcp_servers/*.mcpb >/dev/null 2>&1; then cp mcp_servers/*.mcpb /dist/; fi
# installer archive: scripts, launchers, and the no-console .vbs (flat layout)
zip -j /dist/skills-installer.zip \
  install.sh install.ps1 install-gui.command install-gui.ps1 install-gui.cmd \
  "Skills Installer.vbs" bootstrap.sh bootstrap.ps1 lib.sh lib.ps1 build.sh
# macOS no-terminal launcher — a bundle, so keep its tree and the executable bit
zip -qry /dist/skills-installer-macos-app.zip "Skills Installer.app"
# checksums — written via a temp file so SHA256SUMS never lists itself
( cd /dist && sha256sum * > /tmp/SHA256SUMS && mv /tmp/SHA256SUMS SHA256SUMS )
"""


@object_type
class Skills:
    @function
    async def scan(
        self,
        source: Annotated[dagger.Directory, DefaultPath(".")],
        openai_api_key: Annotated[
            dagger.Secret | None,
            "OpenAI API key; enables the LLM validation pass",
        ] = None,
    ) -> str:
        """Security-gate every skill with NVIDIA SkillSpector.

        Scans each <skill>/SKILL.md for SkillSpector's 64 vulnerability
        patterns (prompt injection, data exfiltration, excessive agency,
        supply-chain, MCP issues, ...) and fails (non-zero) if any skill scores
        risk > 50 (HIGH/CRITICAL). In CI this gates the release so a flagged
        skill is never published.

        With a key the scan runs the OpenAI LLM validation pass; without one it
        falls back to static-only (--no-llm).

        Static only:  dagger call scan
        With LLM:     dagger call scan --openai-api-key=env:OPENAI_API_KEY
        """
        # Discover top-level skill dirs (those holding a SKILL.md).
        skills = []
        for entry in await source.entries():
            name = entry.rstrip("/")
            try:
                contents = await source.directory(name).entries()
            except Exception:
                continue
            if "SKILL.md" in contents:
                skills.append(name)
        skills.sort()
        if not skills:
            return "no skills found"

        use_llm = openai_api_key is not None
        # Shared base: the scanner install is one cached layer reused by every
        # per-skill container, so it is built once even though scans run parallel.
        base = (
            dag.container()
            .from_("python:3.12-slim")
            .with_exec(
                [
                    "bash",
                    "-c",
                    "apt-get update "
                    "&& apt-get install -y --no-install-recommends git ca-certificates "
                    "&& rm -rf /var/lib/apt/lists/*",
                ]
            )
            .with_exec(
                [
                    "pip",
                    "install",
                    "--no-cache-dir",
                    f"skillspector @ git+https://github.com/NVIDIA/skillspector.git@{_SKILLSPECTOR_REF}",
                ]
            )
            .with_env_variable("SKILLSPECTOR_PROVIDER", "openai")
            .with_env_variable("USE_LLM", "1" if use_llm else "0")
            .with_env_variable("LLM_FLAG", "" if use_llm else "--no-llm")
            .with_env_variable("MAX_ATTEMPTS", "3")
            .with_mounted_directory("/src", source)
            .with_workdir("/src")
        )
        if openai_api_key is not None:
            base = base.with_secret_variable("OPENAI_API_KEY", openai_api_key)

        async def run_one(name: str):
            ctr = base.with_env_variable(
                "SKILL_DIR", f"/src/{name}"
            ).with_exec(["bash", "-c", _SCAN_ONE])
            try:
                return name, True, (await ctr.stdout()).strip()
            except dagger.ExecError as exc:
                detail = (exc.stdout or "").strip() or (exc.stderr or "").strip()
                return name, False, detail

        # Fan out: all skills scan concurrently, install layer built once.
        results = await asyncio.gather(*(run_one(n) for n in skills))

        mode = (
            "LLM validation (provider=openai)" if use_llm else "static-only (--no-llm)"
        )
        report = [f"SkillSpector gate: {mode}; {len(skills)} skills in parallel", ""]
        failed = []
        for name, ok, out in results:
            report.append(out)
            if not ok:
                failed.append(name)
        report.append("")
        report.append("=" * 60)
        if failed:
            report.append("SECURITY GATE FAILED: " + ", ".join(failed))
            # Raise so `dagger call` exits non-zero and the CI gate fails.
            raise RuntimeError("\n".join(report))
        report.append(f"SECURITY GATE PASSED -- {len(skills)} skills clean")
        return "\n".join(report)

    @function
    def dist(
        self,
        source: Annotated[dagger.Directory, DefaultPath(".")],
    ) -> dagger.Directory:
        """Build all release artifacts and return them as a /dist directory.

        Artifacts: every <name>.skill bundle, every <name>.mcpb bundle, a
        skills-installer.zip (scripts, launchers, bootstrap, the .vbs), a
        skills-installer-macos-app.zip (the no-terminal .app), and SHA256SUMS.

        Export locally with:  dagger call dist export --path=./dist
        """
        return (
            dag.container()
            .from_("debian:bookworm-slim")
            .with_exec(
                [
                    "bash",
                    "-c",
                    "apt-get update "
                    "&& apt-get install -y --no-install-recommends zip ca-certificates "
                    "&& rm -rf /var/lib/apt/lists/*",
                ]
            )
            .with_mounted_directory("/src", source)
            .with_workdir("/src")
            .with_exec(["bash", "-c", _BUILD])
            .directory("/dist")
        )
