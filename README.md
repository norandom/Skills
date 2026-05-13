# Skills

Skills I use with Claude and a few compatible tools. Each one is a folder with a `SKILL.md` and a version, plus a packed `<name>.skill` zip in the same folder for tools that prefer a bundle. Install whichever you want; more will land here over time.

## Skills in this repo

### premortem `v1.0.0`

Stress-tests a real decision by assuming it has already failed and reasoning backward to expose the hidden assumption you didn't think to question.

### intana-viz `v1.0.0`

Intelligence-analysis visualizations rendered through the draw.io MCP. Maps 80+ structured analytic techniques (ACH, Pre-Mortem, CoA comparison, Cultural Web, McKinsey 7S, Six Thinking Hats, …) to specific diagram templates with consistent intel-grade styling.

### strategic-foresight-viz `v1.0.0`

Strategic-foresight and futures-analysis visualizations rendered through the draw.io MCP. 24 techniques across seven categories: environmental scanning (PESTLE / GRNO, Macro / Meso / Micro), trend analysis, weak signals & perception, basic and advanced scenario planning (Three Futures, Futures Cone, Dator's Archetypes, Intuitive Logics, Lum's Four Steps, Layered Timeline), VUCA / CATUR assessments, What If / Then cross-impact, Consequence Analysis, Analogical Reasoning, and Stakeholder Analysis. Pairs with `intana-viz` for techniques outside the foresight catalog (ACH, Pre-Mortem, Futures Wheel, etc.).

### investigation-theory `v1.0.0`

SOC / DFIR workflow from the Investigation Theory curriculum: the Diagnostic Inquiry loop, the question taxonomy (preceding / context / succeeding / proximate / capability-matching / utility), GAPSS data manipulation, three-tier escalation, modified CJCSM 6510 dispositions, the *Once Upon a Time* compromise report, Security M&M peer review, and five locked draw.io diagram types. Fires on alert triage, log analysis, phishing, lateral movement, C2/beaconing, exfil, malware, and insider-threat cases.

## MCP servers

Prebuilt `.mcpb` bundles for Claude Desktop live under [`mcp_servers/`](./mcp_servers), alongside their sources so you can rebuild or fork.

- **`drawio-remote.mcpb`** — bridges Claude Desktop to a remote draw.io MCP server. Defaults to `https://drawmcp.because-security.com/mcp`; override via the **Remote MCP URL** user config to point at your own deployment. See [`mcp_servers/README.md`](./mcp_servers/README.md) for rebuild instructions.

## Build

`build.sh` rebuilds every artifact from source:

```bash
./build.sh            # all skills + all mcpb bundles
./build.sh skill premortem
./build.sh mcpb  drawio-remote
```

It zips each skill folder into `<skill>/<skill>.skill` (top-level `<skill>/` prefix preserved) and each `mcp_servers/<name>/` into `mcp_servers/<name>.mcpb` (flat layout — `manifest.json` at the root). Existing `.skill` artifacts are excluded from their own archive.

## Install

```bash
git clone https://github.com/norandom/Skills.git ~/Source/Skills
cd ~/Source/Skills
./install.sh             # auto-detect: install into every tool whose dir exists
```

`install.sh` symlinks each skill folder into the selected tool's `skills/` dir. Symlinks mean `git pull` updates everything in place — no copy step. The script is idempotent; rerunning is safe.

Flags:

| Flag | Target |
| ---- | ------ |
| `--claude` | `~/.claude/skills/` (Claude Code) |
| `--claude-desktop` | `~/Library/Application Support/Claude/skills/` (macOS), `~/.config/Claude/skills/` (Linux), `%APPDATA%/Claude/skills/` (Windows) |
| `--hermes` | `~/.hermes/skills/` |
| `--opencode` | `~/.config/opencode/skills/` |
| `--deepseek` | `~/.deepseek/skills/` (DeepSeek TUI) |
| `--all` | every target above whose parent dir exists (default) |
| `-n`, `--dry-run` | preview without changing anything |
| `-f`, `--force` | replace existing entries at the destination |
| `--uninstall` | remove the symlinks |

Examples:

```bash
./install.sh --claude --opencode    # just these two
./install.sh --dry-run              # preview
./install.sh --force                # replace whatever's there
./install.sh --uninstall --all      # tear down
```

### Claude Desktop UI install

If your Claude Desktop build exposes Skills in **Settings → Capabilities → Skills**, you can also add a folder there directly (e.g. `~/Source/Skills/premortem`) or hand it the packed `premortem/premortem.skill` bundle.

## Adding more skills

1. Create a folder at the repo root: `<skill-name>/`.
2. Inside, write a `SKILL.md` with frontmatter: `name`, `version`, and a `description` that explains *when* the skill should fire. The description is what the model matches against, so make the triggers specific.
3. Run `./build.sh skill <skill-name>` to produce `<skill-name>/<skill-name>.skill`.
4. List the skill above with a one-line synthesis and its current version.

## Versioning

Each skill carries a `version` in its `SKILL.md` frontmatter, following semver:

- **MAJOR** for prompt or behavior changes that break how callers invoke the skill.
- **MINOR** for new phases, options, or artifacts (additive only).
- **PATCH** for wording, clarification, and typo fixes.

Bump the version in the same commit as the change. That way `git log -- <skill>/SKILL.md` doubles as a changelog.
