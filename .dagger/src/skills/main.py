"""Release tooling for the Skills repo.

Builds every skill/mcp bundle, an installer archive, and a checksum file, all
inside a container so releases are reproducible regardless of the host. The
GitHub Actions workflow calls `dist` on a `v*` tag and uploads the result.

`scan` is the security gate: it runs NVIDIA SkillSpector against every skill
and fails the pipeline if any skill scores HIGH/CRITICAL, which stops a release
before anything is published.
"""

from typing import Annotated

import dagger
from dagger import DefaultPath, dag, function, object_type

# SkillSpector has no release tags yet, so pin to a commit for reproducibility.
# Bump this to re-pin against a newer scanner.
_SKILLSPECTOR_REF = "2eb844780ab163f01468ecf142c40a2ec0fcaec0"

# Runs inside the scanner container (cwd = mounted repo). Writes per-skill
# reports to /reports and exits non-zero if any skill breaches the gate.
# SkillSpector itself exits 1 when a skill's risk_score > 50 (HIGH/CRITICAL).
_SCAN = r"""
set -uo pipefail
mkdir -p /reports

if [ -n "${NVIDIA_INFERENCE_KEY:-}" ]; then
  LLM_FLAG=""
  echo "SkillSpector: LLM validation ENABLED (provider=${SKILLSPECTOR_PROVIDER:-nv_build})"
else
  LLM_FLAG="--no-llm"
  echo "SkillSpector: no API key -> static-only scan (--no-llm)"
fi

mapfile -t skills < <(find . -maxdepth 2 -name SKILL.md -printf '%h\n' | sed 's#^\./##' | sort -u)
if [ "${#skills[@]}" -eq 0 ]; then
  echo "no skills found"; exit 0
fi

overall=0
for s in "${skills[@]}"; do
  name=$(basename "$s")
  echo
  echo "============================================================"
  echo "SkillSpector gate: $name"
  echo "============================================================"
  set +e
  skillspector scan "$s" $LLM_FLAG --format markdown --output "/reports/${name}.md"
  rc=$?
  set -e
  cat "/reports/${name}.md" 2>/dev/null || true
  if [ "$rc" -eq 0 ]; then
    echo "GATE PASS: $name"
  elif [ "$rc" -eq 1 ]; then
    echo "GATE FAIL: $name -- risk_score > 50 (HIGH/CRITICAL, do not install)"
    overall=1
  else
    echo "GATE ERROR: $name -- skillspector exited $rc"
    overall=1
  fi
done

echo
if [ "$overall" -ne 0 ]; then
  echo "SECURITY GATE FAILED"
else
  echo "SECURITY GATE PASSED -- ${#skills[@]} skills clean"
fi
exit $overall
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
        nvidia_inference_key: Annotated[
            dagger.Secret | None,
            "NVIDIA build.nvidia.com key; enables the LLM validation pass",
        ] = None,
    ) -> str:
        """Security-gate every skill with NVIDIA SkillSpector.

        Scans each <skill>/SKILL.md for SkillSpector's 64 vulnerability
        patterns (prompt injection, data exfiltration, excessive agency,
        supply-chain, MCP issues, ...) and fails (non-zero) if any skill scores
        risk > 50 (HIGH/CRITICAL). In CI this gates the release so a flagged
        skill is never published.

        With a key the scan runs the nv_build LLM validation pass; without one
        it falls back to static-only (--no-llm).

        Static only:  dagger call scan
        With LLM:     dagger call scan --nvidia-inference-key=env:NVIDIA_INFERENCE_KEY
        """
        ctr = (
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
            .with_env_variable("SKILLSPECTOR_PROVIDER", "nv_build")
            .with_mounted_directory("/src", source)
            .with_workdir("/src")
        )
        if nvidia_inference_key is not None:
            ctr = ctr.with_secret_variable(
                "NVIDIA_INFERENCE_KEY", nvidia_inference_key
            )
        return await ctr.with_exec(["bash", "-c", _SCAN]).stdout()

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
