"""Release tooling for the Skills repo.

Builds every skill/mcp bundle, an installer archive, and a checksum file, all
inside a container so releases are reproducible regardless of the host. The
GitHub Actions workflow calls `dist` on a `v*` tag and uploads the result.
"""

from typing import Annotated

import dagger
from dagger import DefaultPath, dag, function, object_type

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
