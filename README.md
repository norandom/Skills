# Skills

Skills I use with Claude and a few compatible tools. Each one is a folder with a `SKILL.md` and a version. For tools that prefer a single bundle, run `./build.sh` to pack each into a `<name>.skill` zip, or download the prebuilt bundles from a [GitHub Release](https://github.com/norandom/Skills/releases) — they are not committed to the repo. Install whichever you want; more will land here over time.

## Skills in this repo

### premortem `v1.0.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/premortem.skill)

Stress-tests a real decision by assuming it has already failed and reasoning backward to expose the hidden assumption you didn't think to question.

### reflect `v1.1.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/reflect.skill)

Turns a rough request into a clear prompt using Gartner's ReFLECT framework: Role, Format, Language, Example, Context, and Task. It asks only for missing pieces that matter, confirms the resolved prompt, and then does the work. Includes an optional scored review pass for high-stakes output.

### drawio `v1.0.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/drawio.skill)

General draw.io diagram creation through the MCP tools. Covers the three tool types (Mermaid, XML, CSV), URL presentation rules for the Hermes WebUI, Mermaid syntax shortcuts, and executive/boardroom palettes. The base for the domain-specific viz skills below; use it for any draw.io task that doesn't fit one of them.

### intana-viz `v1.0.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/intana-viz.skill)

Intelligence-analysis visualizations rendered through the draw.io MCP. Maps 80+ structured analytic techniques (ACH, Pre-Mortem, CoA comparison, Cultural Web, McKinsey 7S, Six Thinking Hats, …) to specific diagram templates with consistent intel-grade styling.

### strategic-foresight-viz `v1.0.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/strategic-foresight-viz.skill)

Strategic-foresight and futures-analysis visualizations rendered through the draw.io MCP. 24 techniques across seven categories: environmental scanning (PESTLE / GRNO, Macro / Meso / Micro), trend analysis, weak signals & perception, basic and advanced scenario planning (Three Futures, Futures Cone, Dator's Archetypes, Intuitive Logics, Lum's Four Steps, Layered Timeline), VUCA / CATUR assessments, What If / Then cross-impact, Consequence Analysis, Analogical Reasoning, and Stakeholder Analysis. Pairs with `intana-viz` for techniques outside the foresight catalog (ACH, Pre-Mortem, Futures Wheel, etc.).

### investigation-theory `v1.0.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/investigation-theory.skill)

SOC / DFIR workflow from the Investigation Theory curriculum: the Diagnostic Inquiry loop, the question taxonomy (preceding / context / succeeding / proximate / capability-matching / utility), GAPSS data manipulation, three-tier escalation, modified CJCSM 6510 dispositions, the *Once Upon a Time* compromise report, Security M&M peer review, and five locked draw.io diagram types. Fires on alert triage, log analysis, phishing, lateral movement, C2/beaconing, exfil, malware, and insider-threat cases.

### game-theory-negotiation `v1.1.1` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/game-theory-negotiation.skill)

Negotiation playbook for bargaining, auctions, procurement, and incentive design. It leads a new negotiator from messy intake to a ready-room brief: numbers, truth checks, scenarios, offer plan, guardrails, first script, and a draw.io map of players, incentives, information gaps, moves, or payoffs. It also covers concession planning, counter-offers, reversible no, nibble defense, higher-authority delegation, virtual price lists, holdup protection, fairness criteria, negotiauctions, Vickrey mechanisms, and profit-share sizing.

### cobesy `v1.0.1` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/cobesy.skill)

COBESY (Cognitive Behavioral Systemic) helps an agent turn static knowledge (docs, repos, architecture, decks) into work people actually adopt. It checks the culture first with Schein, Edmondson, and Scientist Mode. Then it compresses the message with Minto, Dirksen, and Knowles, and plans how adoption moves through the network with Centola, Jackson, Berger REDUCE, and cascade logic.

Use it for rollouts, buy-in, change management, briefings, resistance, or onboarding. It returns a framing protocol, an agenda or brief, and an adoption path. It can pull inputs from `premortem`, `intana-viz`, and `strategic-foresight-viz`, pass incentive questions to `game-theory-negotiation`, and send final prose through `humanizer`. Source attribution for all nine works lives in [`cobesy/references/source-map.md`](./cobesy/references/source-map.md).

## MCP servers

Prebuilt `.mcpb` bundles for Claude Desktop live under [`mcp_servers/`](./mcp_servers), alongside their sources so you can rebuild or fork.

- **`drawio-remote.mcpb`** · [⬇ .mcpb](https://github.com/norandom/Skills/releases/latest/download/drawio-remote.mcpb) — bridges Claude Desktop to a remote draw.io MCP server. Defaults to `https://drawmcp.because-security.com/mcp`; override via the **Remote MCP URL** user config to point at your own deployment. See [`mcp_servers/README.md`](./mcp_servers/README.md) for rebuild instructions.

The download links above always resolve to the [latest release](https://github.com/norandom/Skills/releases/latest); verify them against its `SHA256SUMS`.

## Build

`build.sh` rebuilds every artifact from source:

```bash
./build.sh            # all skills + all mcpb bundles
./build.sh skill premortem
./build.sh mcpb  drawio-remote
```

It zips each skill folder into `<skill>/<skill>.skill` (top-level `<skill>/` prefix preserved) and each `mcp_servers/<name>/` into `mcp_servers/<name>.mcpb` (flat layout — `manifest.json` at the root). Existing `.skill` artifacts are excluded from their own archive.

## Install

### Quick install / update (no git required)

One command downloads the latest source, unpacks it to a managed location, and links the skills into your tools. **Re-running it is also how you update** — it re-downloads the latest and relinks, so install and update are the same command.

**macOS / Linux:**

```bash
curl -fsSL https://raw.githubusercontent.com/norandom/Skills/main/bootstrap.sh | bash
# target specific tools by passing install.sh flags:
curl -fsSL https://raw.githubusercontent.com/norandom/Skills/main/bootstrap.sh | bash -s -- --claude --opencode
```

**Windows (PowerShell):**

```powershell
irm https://raw.githubusercontent.com/norandom/Skills/main/bootstrap.ps1 | iex
```

The source is unpacked to `~/.local/share/skills` (macOS/Linux) or `%LOCALAPPDATA%\Skills` (Windows); override with `SKILLS_HOME`. Needs only `curl`/`tar` (or `wget`) or, on Windows, built-in PowerShell — no `git`. The skills are symlinked from that copy, so a re-run that refreshes it updates every linked tool at once.

### GUI installer (double-click)

If you'd rather click than type, after cloning or bootstrapping the repo:

- **macOS** — double-click **`Skills Installer.app`** for native dialogs with no Terminal window. (If you downloaded the repo as a zip rather than cloning, macOS may quarantine it; right-click → Open once, or run `xattr -dr com.apple.quarantine "Skills Installer.app"`.) The plain `install-gui.command` still works too, but opens a Terminal.
- **Linux** — double-click `install-gui.command` (mark it executable / "Run" if your file manager asks). Uses **zenity** if present; otherwise falls back to a terminal wizard.
- **Windows** — double-click **`Skills Installer.vbs`** for the WinForms wizard with no console window (the equivalent of the macOS app; it starts PowerShell hidden). The `install-gui.cmd` shim also works but flashes a console; double-clicking the `.ps1` directly just opens an editor.

The wizard walks you through: Install or Uninstall, which tools to target (detected ones pre-checked), which skills to link, a dry-run **preview**, then apply. It reuses the same logic as the CLI scripts below, so the result is identical. Force a specific backend with `SKILLS_UI=zenity|osascript|terminal` on Unix.

### macOS / Linux (CLI)

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
| `--hermes` | `~/.hermes/skills/` |
| `--opencode` | `~/.config/opencode/skills/` |
| `--deepseek` | `~/.deepseek/skills/` (DeepSeek TUI) |
| `--agy` | `~/.gemini/antigravity-cli/skills/` (Antigravity CLI) |
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

### Windows

```powershell
git clone https://github.com/norandom/Skills.git $env:USERPROFILE\Source\Skills
cd $env:USERPROFILE\Source\Skills
.\install.ps1            # auto-detect: install into every tool whose dir exists
```

`install.ps1` mirrors the bash script. It tries to create real symbolic links first and falls back to NTFS directory junctions when SymbolicLink is denied — junctions need no elevation and behave identically for skill discovery. For true symlinks, either enable **Settings → Privacy & security → For developers → Developer Mode** or run PowerShell as administrator.

| Flag | Target |
| ---- | ------ |
| `-Claude` | `%USERPROFILE%\.claude\skills` (Claude Code) |
| `-Hermes` | `%USERPROFILE%\.hermes\skills` |
| `-Opencode` | `%USERPROFILE%\.config\opencode\skills` |
| `-Deepseek` | `%USERPROFILE%\.deepseek\skills` |
| `-Agy` | `%USERPROFILE%\.gemini\antigravity-cli\skills` |
| `-All` | every target above whose parent dir exists (default) |
| `-DryRun` | preview without changing anything |
| `-Force` | replace existing entries at the destination |
| `-Uninstall` | remove the links |

If PowerShell refuses to run unsigned scripts, allow it for this process only: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`.

### Skill-description validation

Both installers check each skill's `description:` field before linking. Claude Desktop and Claude Code silently drop any skill whose description exceeds **1024 characters**, so the script prints a `WARN` line for each oversize skill and proceeds. Trim the description in `SKILL.md` to fix it. Override the cap with `LIB_DESC_MAX=2048 ./install.sh` (bash) or `$env:LIB_DESC_MAX = 2048; .\install.ps1` (PowerShell) if you need to test against a different limit.

### Upload-based tools (Claude Desktop, ChatGPT app)

The symlink installers do **not** target Claude Desktop or the ChatGPT app — these tools don't discover skills from linked folders. Instead you upload the packed `.skill` bundle (or share it org-wide), and the tool stores its own copy.

1. Get the bundle: download it from the [latest release](https://github.com/norandom/Skills/releases/latest) (the `⬇ .skill` links above), or build it locally with `./build.sh` (or `./build.sh skill <name>`) to produce `<name>/<name>.skill`.
2. Upload it:
   - **Claude Desktop** — **Settings → Capabilities → Skills**, then add the bundle, e.g. `premortem.skill`. For a team, an admin can upload it once in the Anthropic Console / admin settings to **share it org-wide** so members don't each upload their own copy.
   - **ChatGPT app** — add the `.skill` bundle in the app's skills/upload area, or have a workspace admin share it across the organization.

Each `.skill` is a self-contained zip, so re-upload the rebuilt bundle whenever you pull updates (org-wide shares update for everyone at once).

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

## Releases

Bundles are not committed; they are published as release assets. A [Dagger](https://dagger.io) module builds them in a container so the result is reproducible on any machine.

Cut a release by pushing a version tag:

```bash
git tag v1.2.0
git push origin v1.2.0
```

That fires `.github/workflows/release.yml`, which runs the Dagger pipeline and attaches the artifacts to a GitHub Release: every `<name>.skill`, every `<name>.mcpb`, a `skills-installer.zip` (scripts, launchers, bootstrap, and the no-console `Skills Installer.vbs`), a `skills-installer-macos-app.zip` (the no-terminal `Skills Installer.app`, executable bit preserved), and a `SHA256SUMS` file.

To build the same artifacts locally (requires Docker and the [Dagger CLI](https://docs.dagger.io/install)):

```bash
dagger call dist export --path=./dist
```

The module lives in `.dagger/` (Python SDK, pinned in `dagger.json`). Generated SDK bindings under `.dagger/sdk/` are not committed; Dagger regenerates them on load.

> Note: Dagger 0.21+ auto-loads `.env` files from the working directory upward. If an ancestor directory holds a `.env` with `export`-style lines, Dagger aborts with a parse error. Drop a local `.env` containing `DUMMY=dummy` in the repo root to shield it — Dagger loads the nearest file and stops walking up. This file is git-ignored.
