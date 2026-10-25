"""Release tooling for the Skills repo.

Builds every skill/mcp bundle, an installer archive, and a checksum file, all
inside a container so releases are reproducible regardless of the host. The
GitHub Actions workflow calls `dist` on a `v*` tag and uploads the result.

`scan` is the security gate: it runs NVIDIA SkillSpector against every skill
and fails the pipeline if any skill scores HIGH/CRITICAL, which stops a release
before anything is published.
"""

import asyncio
import json
from typing import Annotated

import dagger
from dagger import DefaultPath, dag, function, object_type

# SkillSpector v2.13.1, pinned to the release commit for reproducibility.
_SKILLSPECTOR_REF = "f3b25697d76256998ca9d42c198d256258d4c035"
# ClamAV 1.5.4 (signature databases are still refreshed before each scan).
_CLAMAV_IMAGE = "clamav/clamav:1.5.4@sha256:e19130cdebaeacc71fa46eab3ed6f69941f2f22aa5e08d55e9197f8edf43ce5e"

# Runs inside the ClamAV container. Refreshes signatures (best-effort; the
# pinned image ships a baked database) then recursively scans the repo. clamscan
# exits 0 = clean, 1 = malware found, 2 = error -> `set -e` fails the gate.
_CLAMAV = r"""
set -eu
clamscan --version
echo "Refreshing signatures (best-effort; image ships a baked database)..."
freshclam --quiet || echo "freshclam update failed; using the baked database"
echo "Scanning /src ..."
clamscan -r -i --alert-broken --detect-pua=yes --exclude-dir='\.git' /src
echo "MALWARE SCAN PASSED -- no signatures matched"
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
  "Skills Installer.vbs" bootstrap.sh bootstrap.ps1 bootstrap-gui.ps1 \
  lib.sh lib.ps1 build.sh
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
        anthropic_api_key: Annotated[
            dagger.Secret | None,
            "Anthropic API key; enables the LLM validation pass",
        ] = None,
    ) -> str:
        """Fail-closed security gate; use scan-reports to export evidence before checking.

        Local: dagger call scan --anthropic-api-key=env:ANTHROPIC_API_KEY
        Without a key, run static-only. Missing reports, incomplete coverage,
        degraded analyzers, scanner errors, or risk > 50 fail the gate.
        """
        reports = await self.scan_reports(source, anthropic_api_key)
        check = (
            dag.container().from_("python:3.12-slim")
            .with_mounted_directory("/src", source)
            .with_mounted_directory("/reports", reports)
            .with_exec(["python3", "/src/.dagger/scripts/scan_reports.py", "check", "/reports"])
        )
        try:
            return await check.stdout()
        except dagger.ExecError as exc:
            raise RuntimeError((exc.stdout or "") + (exc.stderr or "")) from exc

    @function
    async def scan_reports(
        self,
        source: Annotated[dagger.Directory, DefaultPath(".")],
        anthropic_api_key: Annotated[
            dagger.Secret | None,
            "Anthropic API key; enables the LLM validation pass",
        ] = None,
    ) -> dagger.Directory:
        """Export sanitized JSON and logs even when individual scans fail.

        Collection is not a passing security verdict. CI must subsequently run
        `python3 .dagger/scripts/scan_reports.py check ./scan-reports`.
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
            raise RuntimeError("No skills found; refusing an empty security scan")

        use_llm = anthropic_api_key is not None and bool(
            (await anthropic_api_key.plaintext()).strip()
        )
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
            # v2.13.1 uses native ChatAnthropic, including explicit effort.
            .with_env_variable("SKILLSPECTOR_PROVIDER", "anthropic")
            .with_env_variable("ANTHROPIC_BASE_URL", "https://api.anthropic.com")
            .with_env_variable("SKILLSPECTOR_MODEL", "claude-haiku-5-5")
            .with_env_variable("SKILLSPECTOR_REASONING_EFFORT", "medium")
            .with_env_variable("SKILLSPECTOR_MODEL_REGISTRY", "/src/.dagger/skillspector-models.yaml")
            .with_mounted_directory("/src", source)
            .with_workdir("/src")
        )
        if use_llm:
            base = base.with_secret_variable("ANTHROPIC_API_KEY", anthropic_api_key)

        async def run_one(name: str):
            command = ["python3", "/src/.dagger/scripts/scan_reports.py", "collect",
                       f"/src/{name}", "/reports", "--attempts", "3"]
            if use_llm:
                command.append("--use-llm")
            ctr = base.with_exec(command)
            # Evaluate each independent container concurrently; collector only
            # returns success after it has recorded scanner status and evidence.
            # Dagger v0.21.3 Directory.sync / with_directory / with_new_file:
            # https://github.com/dagger/dagger/blob/v0.21.3/sdk/python/src/dagger/client/gen.py
            return name, await ctr.directory("/reports").sync()

        # Fan out: all skills scan concurrently, install layer built once.
        results = await asyncio.gather(*(run_one(n) for n in skills))

        reports = dag.directory().with_new_file("manifest.json", json.dumps({
            "schema_version": 1, "skills": skills, "use_llm": use_llm,
            "scanner_commit": _SKILLSPECTOR_REF,
        }))
        for name, directory in results:
            reports = reports.with_directory(name, directory)
        return reports

    @function
    async def malware(
        self,
        source: Annotated[dagger.Directory, DefaultPath(".")],
    ) -> str:
        """Malware-scan the repo with ClamAV (free, offline signature engine).

        Recursively scans every file with the bundled ClamAV database (refreshed
        via freshclam when reachable), unpacking archives so the built
        .skill / .mcpb / .app bundles are covered too. Fails (non-zero) if any
        signature matches, which gates the release.

        Run locally:  dagger call malware
        """
        ctr = (
            dag.container()
            .from_(_CLAMAV_IMAGE)
            .with_mounted_directory("/src", source)
            .with_exec(["sh", "-c", _CLAMAV])
        )
        try:
            return await ctr.stdout()
        except dagger.ExecError as exc:
            # Surface the FOUND lines as the gate failure message.
            raise RuntimeError((exc.stdout or "") + (exc.stderr or "")) from exc

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
