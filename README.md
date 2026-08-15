# Skills

[![SkillSpector](https://img.shields.io/github/actions/workflow/status/norandom/Skills/skillspector.yml?branch=main&label=SkillSpector)](https://github.com/norandom/Skills/actions/workflows/skillspector.yml)
[![ClamAV](https://img.shields.io/github/actions/workflow/status/norandom/Skills/clamav.yml?branch=main&label=ClamAV)](https://github.com/norandom/Skills/actions/workflows/clamav.yml)

Skills I use primarily with Codex, [opencode](https://opencode.ai), and Claude Code, plus a few other compatible tools (Hermes, DeepSeek TUI, Antigravity CLI). Each one is a folder with a `SKILL.md` and a version. For tools that prefer a single bundle, run `./build.sh` to pack each into a `<name>.skill` zip, or download the prebuilt bundles from a [GitHub Release](https://github.com/norandom/Skills/releases) — they are not committed to the repo. Install whichever you want; more will land here over time.

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

📖 Background: [Hermes: the moment of business AI](https://osroadwarrior.info/hermes-the-moment-of-business-ai/).

### investigation-theory `v1.0.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/investigation-theory.skill)

SOC / DFIR workflow from the Investigation Theory curriculum: the Diagnostic Inquiry loop, the question taxonomy (preceding / context / succeeding / proximate / capability-matching / utility), GAPSS data manipulation, three-tier escalation, modified CJCSM 6510 dispositions, the *Once Upon a Time* compromise report, Security M&M peer review, and five locked draw.io diagram types. Fires on alert triage, log analysis, phishing, lateral movement, C2/beaconing, exfil, malware, and insider-threat cases.

📖 Background: [because-security.com](https://www.because-security.com/).

### game-theory-negotiation `v1.1.1` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/game-theory-negotiation.skill)

Negotiation playbook for bargaining, auctions, procurement, and incentive design. It leads a new negotiator from messy intake to a ready-room brief: numbers, truth checks, scenarios, offer plan, guardrails, first script, and a draw.io map of players, incentives, information gaps, moves, or payoffs. It also covers concession planning, counter-offers, reversible no, nibble defense, higher-authority delegation, virtual price lists, holdup protection, fairness criteria, negotiauctions, Vickrey mechanisms, and profit-share sizing.

### cobesy `v1.3.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/cobesy.skill)

COBESY (Cognitive Behavioral Systemic) helps an agent turn static knowledge (docs, repos, architecture, decks) into work people actually adopt. It checks the culture first with Schein, Edmondson, and Scientist Mode. Then it compresses the message with Minto, Dirksen, and Knowles, and plans how adoption moves through the network with Centola, Jackson, Berger REDUCE, and cascade logic.

The same Cognitive engine also structures written and projected pieces. Point it at a blog post, a thesis, slides, or a journal article and it compiles your material into a first-pass skeleton grid instead of a live agenda: headlines, bullets, emphasis notes, writing advice, style guidance, audience-leading cues, and keywords to use. It does not draft article, paper, or slide prose unless explicitly asked. It uses Belcher, Cron, Kolin, Graff and Birkenstein, Klinkenborg, and Williams and Bizup, and runs a writing linter for the usual failures: first-paragraph drop-off, information overload, a table of contents that no longer matches the text, scope creep, flat exposition, and expert fog.

Use it for rollouts, buy-in, change management, briefings, resistance, or onboarding. It returns a framing protocol, an agenda or brief, and an adoption path. It can pull inputs from `premortem`, `intana-viz`, and `strategic-foresight-viz`, pass incentive questions to `game-theory-negotiation`, and send final prose through [`humanizer`](https://github.com/blader/humanizer). Source attribution for all fifteen works lives in [`cobesy/references/source-map.md`](./cobesy/references/source-map.md).

📖 Background: [COBESY or SNAFU?](https://hanse-hedge.fund/cobesy-or-snafu/).

### corporate-finance `v1.3.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/corporate-finance.skill)

corporate-finance starts with what the user is trying to do: build, analyze, advise, or reflect. From there it pulls the right explanation and the right spreadsheet structure. MODEL/BUILD covers three-statement models, budgets, 13-week cash flows, DCF/WACC, ratio dashboards, and EBITDA bridges as XLSX or Claude for Excel workbooks. ANALYZE/DIAGNOSE covers common-size, ratio, and trend analysis. ADVISE/CONSULT handles valuation-method and budgeting-method choices, EBITDA levers, and cash levers. REFLECT checks terminal value, sensitivity, and Non-GAAP / manipulation risks. The workflow stays on the selected intent until the output and checks are done.

It ships ten references (EBITDA, ratios and analysis, the three-statement model, cash flow and working capital, DCF/WACC valuation, budgeting, modeling best practices, spreadsheet conventions, auditability/math rigor, and the intent map) plus six fill-in asset specs. The workbook rules are blunt: schedules first, blue cells for starting amounts, yellow cells for assumptions, formula cells left alone, dedicated assumptions/instructions and Evidence & Audit Trail sheets, validation checks, and no hardcoded values. Every material number must show source, formula, substitution, step-by-step calculation, result, units, Python verification, and mismatch status before the skill treats it as fact. It hands reflection work to [`premortem`](./premortem) and [`reflect`](./reflect), visual output to [`drawio`](./drawio) and [`intana-viz`](./intana-viz), and rollout of findings to [`cobesy`](./cobesy). Finance content is based on personal notes about Bojan Radojicic / bojanfin.com materials and MBA financial-modeling materials, not excerpts from the originals.

📖 Background: [Autopilot lies. AI analysis crashed. Fix here.](https://hanse-hedge.fund/autopilot-lies-ai-analysis-crashed-fix-here/).

### financial-modeling-sheet `v1.1.0` · [⬇ .skill](https://github.com/norandom/Skills/releases/latest/download/financial-modeling-sheet.skill)

House style for quantitative Excel workbooks. It governs how a workbook looks and is organized, not what it calculates — the goal being a file where a reader can tell, without clicking a single cell, which numbers were typed, which were chosen, which were calculated, which were imported, and which one is the answer. It is applied inside Excel through an assistant add-in (Claude for Excel, ChatGPT for Excel) driving the live workbook. Four modes: CREATE, EXTEND, AUDIT (never writes), and RESTYLE (gated behind approval, a backup, and a change log).

It ships two deliberately non-mixable palette profiles — the semantic House Style default (blue source data, yellow assumptions, unfilled formulas) and the classic Audit Standard (orange inputs, gray calculations), which read the same fills in contradictory ways — plus nine semantic cell classes, a named style registry with legacy aliases, tab colors as a purpose code, a layout skeleton every sheet shares (rows 1–2 blank, title on row 3, columns A and B empty, content at column C), a menu generated last from the actual tab order and actual tab colors, number formats with a leading-minus negative convention, chart selection rules, formula-integrity rules, and a definition of done that doubles as the audit deliverable. Power Query output gets its own treatment: moved to `Data <n> <short id>` sheets at the end, the built-in table style stripped and replaced by the house header and body styles, a `PQ: <headline>` caption above the header row, types set in the query, formatting verified to survive a refresh, and the data referenced rather than copied. It prescribes roles, not sheet names: only Menu, Documentation, and Dashboard are named; task sheets follow the actual work.

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

One command downloads the latest source, unpacks it to a managed location, and installs the skills into your tools. **Re-running it is also how you update** — it refreshes both the source and the installed skills, so install and update are the same command.

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

For the native Windows GUI, stream the launcher directly—there is no installer
file to save first:

```powershell
irm https://raw.githubusercontent.com/norandom/Skills/main/bootstrap-gui.ps1 | iex
```

To launch it from the Run dialog without a console window:

```text
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command "iex (irm 'https://raw.githubusercontent.com/norandom/Skills/main/bootstrap-gui.ps1')"
```

The source is unpacked to `~/.local/share/skills` (macOS/Linux) or `%LOCALAPPDATA%\Skills` (Windows); override with `SKILLS_HOME`. Needs only `curl`/`tar` (or `wget`) or, on Windows, built-in PowerShell — no `git`. macOS/Linux use symlinks; Windows uses managed directory copies that are refreshed on every re-run.

### GUI installer

If you'd rather click than type, after cloning or bootstrapping the repo:

- **macOS** — double-click **`Skills Installer.app`** for native dialogs with no Terminal window. (If you downloaded the repo as a zip rather than cloning, macOS may quarantine it; right-click → Open once, or run `xattr -dr com.apple.quarantine "Skills Installer.app"`.) The plain `install-gui.command` still works too, but opens a Terminal.
- **Linux** — double-click `install-gui.command` (mark it executable / "Run" if your file manager asks). Uses **zenity** if present; otherwise falls back to a terminal wizard.
- **Windows** — use the streamed `bootstrap-gui.ps1` command above, or double-click **`Skills Installer.vbs`** from a clone/release archive. Both open the WinForms wizard without a console window. The `install-gui.cmd` shim also works but flashes a console; double-clicking the `.ps1` directly just opens an editor.

The wizard walks you through: Install or Uninstall, which tools to target (detected ones pre-checked), which skills to install, a dry-run **preview**, then apply. The Windows streamed launcher first refreshes the managed `%LOCALAPPDATA%\Skills` source and then refreshes the selected tool integrations from it. The wizard reuses the same logic as the CLI scripts below, so the result is identical. Force a specific backend with `SKILLS_UI=zenity|osascript|terminal` on Unix.

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

`install.ps1` installs managed directory copies by default. This works in ordinary PowerShell without Developer Mode, elevation, junctions, or symbolic-link privileges. Re-run it after updating the source to refresh the installed copies. Existing links created by older installer versions are migrated automatically. Pass `-Link` only if you explicitly prefer links; that mode tries a symbolic link first and falls back to an NTFS directory junction.

| Flag | Target |
| ---- | ------ |
| `-Codex` | `%USERPROFILE%\.codex\skills` (Codex) |
| `-Claude` | `%USERPROFILE%\.claude\skills` (Claude Code) |
| `-Hermes` | `%USERPROFILE%\.hermes\skills` |
| `-Opencode` | `%USERPROFILE%\.config\opencode\skills` |
| `-Deepseek` | `%USERPROFILE%\.deepseek\skills` |
| `-Agy` | `%USERPROFILE%\.gemini\antigravity-cli\skills` |
| `-All` | every target above whose parent dir exists (default) |
| `-DryRun` | preview without changing anything |
| `-Force` | replace existing entries at the destination |
| `-Link` | opt into directory links instead of managed copies |
| `-Uninstall` | remove installer-managed copies or links |

If PowerShell refuses to run unsigned scripts, allow it for this process only: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`.

### Skill-description validation

Both installers check each skill's `description:` field before installation. Claude Desktop and Claude Code silently drop any skill whose description exceeds **1024 characters**, so the script prints a `WARN` line for each oversize skill and proceeds. Trim the description in `SKILL.md` to fix it. Override the cap with `LIB_DESC_MAX=2048 ./install.sh` (bash) or `$env:LIB_DESC_MAX = 2048; .\install.ps1` (PowerShell) if you need to test against a different limit.

### Upload-based tools (Claude Desktop, ChatGPT app)

The local filesystem installers do **not** target Claude Desktop or the ChatGPT app — these tools don't discover skills from those folders. Instead you upload the packed `.skill` bundle (or share it org-wide), and the tool stores its own copy.

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

That fires `.github/workflows/release.yml`, which runs the Dagger pipeline and attaches the artifacts to a GitHub Release: every `<name>.skill`, every `<name>.mcpb`, a `skills-installer.zip` (scripts, launchers, CLI and Windows GUI bootstraps, and the no-console `Skills Installer.vbs`), a `skills-installer-macos-app.zip` (the no-terminal `Skills Installer.app`, executable bit preserved), and a `SHA256SUMS` file.

To build the same artifacts locally (requires Docker and the [Dagger CLI](https://docs.dagger.io/install)):

```bash
dagger call dist export --path=./dist
```

The module lives in `.dagger/` (Python SDK, pinned in `dagger.json`). Generated SDK bindings under `.dagger/sdk/` are not committed; Dagger regenerates them on load.

> Note: Dagger 0.21+ auto-loads `.env` files from the working directory upward. If an ancestor directory holds a `.env` with `export`-style lines, Dagger aborts with a parse error. Drop a local `.env` containing `DUMMY=dummy` in the repo root to shield it — Dagger loads the nearest file and stops walking up. This file is git-ignored.

## Security gates

Two free, self-hosted scanners run before anything ships, both as Dagger functions so they behave identically in CI and locally:

```bash
dagger call scan                                      # SkillSpector, static-only
dagger call scan --openai-api-key=env:OPENAI_API_KEY  # SkillSpector + LLM validation
dagger call malware                                   # ClamAV
```

They run as **parallel, blocking gates**:

- **`skillspector.yml`** and **`clamav.yml`** each run on every pull request and push to `main` (one badge above per scanner, linking to its results).
- **`release.yml`** runs both as jobs `release` depends on — if either fails, nothing is published.

**SkillSpector (skill vulnerabilities).** [NVIDIA SkillSpector](https://github.com/NVIDIA/skillspector) checks each `SKILL.md` against 64 vulnerability patterns — prompt injection, data exfiltration, excessive agency, supply-chain risks, MCP issues, and more — and assigns a risk score. The gate fails if any skill scores above 50 (HIGH/CRITICAL). Skills scan in parallel (one container each, shared install layer), so wall-clock is the slowest single skill. With an LLM key the scan runs SkillSpector's second-stage validation (provider `openai`) to cut false positives — without it, benign content like draw.io XML comments can trip the static "hidden instructions" heuristic. Without a key it falls back to static-only (`--no-llm`). To enable the LLM pass in CI, add a repository secret named **`OPENAI_API_KEY`**. If a validation call drops mid-scan the gate retries the skill and fails closed rather than trusting the degraded static result. The scanner is pinned to a commit in `.dagger/src/skills/main.py` (`_SKILLSPECTOR_REF`) for reproducibility; bump it to re-pin.

**ClamAV (malware).** [ClamAV](https://www.clamav.net) recursively scans the repo with its signature database, unpacking archives so the built `.skill` / `.mcpb` / `.app` bundles are covered too. The gate fails if any signature matches. It needs no key or account; the pinned `clamav/clamav:1.4` image ships a baked database that `freshclam` refreshes when the mirror is reachable.
