# Skills

Skills I use with Claude and a few compatible tools. Each one is a folder with a `SKILL.md` and a version. Install whichever you want; more will land here over time.

## Skills in this repo

### premortem `v1.0.0`

Stress-tests a real decision by assuming it has already failed and reasoning backward to expose the hidden assumption you didn't think to question.

## MCP servers

Prebuilt `.mcpb` bundles for Claude Desktop live under [`mcp_servers/`](./mcp_servers), alongside their sources so you can rebuild or fork.

- **`drawio-remote.mcpb`** — bridges Claude Desktop to a remote draw.io MCP server. Defaults to `https://drawmcp.because-security.com/mcp`; override via the **Remote MCP URL** user config to point at your own deployment. See [`mcp_servers/README.md`](./mcp_servers/README.md) for rebuild instructions.

## Installation

Every tool below loads the same folder format. Only the install location changes.

Clone the repo somewhere stable:

```bash
git clone https://github.com/norandom/Skills.git ~/Source/Skills
```

Then symlink the skills you want into the tool's skills directory. Symlinks mean `git pull` updates them in place; no copy step.

### Claude Code

```bash
mkdir -p ~/.claude/skills
ln -s ~/Source/Skills/premortem ~/.claude/skills/premortem
```

To verify, start a session and look for `premortem` in the skills list, or call `/premortem`.

### Claude Desktop

Open Settings → Capabilities → Skills and add the skill folder (e.g. `~/Source/Skills/premortem`). Repeat per skill, or add the parent `~/Source/Skills` if your build supports a directory of skills.

If your build doesn't expose Skills in the UI, drop the folder into the platform path and restart Claude Desktop:

- macOS: `~/Library/Application Support/Claude/skills/`
- Windows: `%APPDATA%\Claude\skills\`

### opencode

opencode reads skills from `~/.config/opencode/skills/` (global) or `.opencode/skills/` (per project):

```bash
mkdir -p ~/.config/opencode/skills
ln -s ~/Source/Skills/premortem ~/.config/opencode/skills/premortem
```

## Adding more skills

1. Create a folder at the repo root: `<skill-name>/`.
2. Inside, write a `SKILL.md` with frontmatter: `name`, `version`, and a `description` that explains *when* the skill should fire. The description is what the model matches against, so make the triggers specific.
3. List the skill above with a one-line synthesis and its current version.

## Versioning

Each skill carries a `version` in its `SKILL.md` frontmatter, following semver:

- **MAJOR** for prompt or behavior changes that break how callers invoke the skill.
- **MINOR** for new phases, options, or artifacts (additive only).
- **PATCH** for wording, clarification, and typo fixes.

Bump the version in the same commit as the change. That way `git log -- <skill>/SKILL.md` doubles as a changelog.
