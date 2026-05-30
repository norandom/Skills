"""Release tooling for the Skills repo.

Exposes `dist`, which builds every skill/mcp bundle, an installer archive, and
a checksum file inside a container, then returns them as a directory to export
or publish. Called by .github/workflows/release.yml on a version tag.
"""

from .main import Skills as Skills
