# strategic-foresight-viz

Draws strategic-foresight diagrams through the draw.io MCP. You name a technique (PESTLE, VUCA, Futures Cone, Dator's Archetypes…), or describe the assessment you're running, and the skill picks the matching template, asks for the input fields it needs, and opens the diagram in draw.io. From there it's a regular draw.io file: edit, rearrange, export.

The catalog covers 24 techniques across seven categories of foresight work, from environmental scanning at the start of an exercise through scenario development, weak-signal detection, and stakeholder strategy at the end. Based on course notes (I-Intelligence, July 2021) Pallaris et. al., and personal research. Per-technique upstream credits are listed informally in the catalog.

## When to use this skill vs. intana-viz

These two skills share the same draw.io styling and overlap at the edges. The split:

- **strategic-foresight-viz** — anticipating the future. Trends, scenarios, weak signals, environmental scans, foresight workflows, futures cones, scenario archetypes, stakeholder mapping under disruption.
- **intana-viz** — analyzing a hypothesis, a decision, an organization, or an argument. ACH, Pre-Mortem, Red Teaming, Cultural Web, Fishbone, McKinsey 7S, Futures Wheel, Six Thinking Hats, 80+ techniques.

If you describe the analysis without naming a technique, whichever skill fits will trigger on the description. If you want a specific technique, ask for it by name.

## The MCP tools the skill routes to

- `mcp__drawio__open_drawio_xml` — precise spatial layouts: matrices, cones, swimlanes, hub-and-spoke, multi-panel tables. Used by most techniques.
- `mcp__drawio__open_drawio_mermaid` — flows and decompositions. Used by Lum's Four Steps and What / So What / Now What.
- `mcp__drawio__open_drawio_csv` — tabular data turned into a diagram. Rare in this catalog.

When none of these is registered, the skill falls back to emitting Mermaid in a fenced code block and tells you to paste it into Typora, Obsidian, or VS Code with the Mermaid preview extension. Some foresight layouts (cones, multi-panel matrices) lose styling in Mermaid; the skill calls that out when it happens.

## Catalog

### 1. Environmental scanning

| Technique | Diagram | Tool |
| --- | --- | --- |
| PESTLE / GRNO Scan | Multi-column matrix (6 PESTLE columns × Trends/Events, with geographic overlay) | XML |
| Macro / Meso / Micro Analysis | Three-row layered matrix across user-defined factors | XML |

### 2. Trend analysis

| Technique | Diagram | Tool |
| --- | --- | --- |
| Trend Stage Analysis | 2×2 matrix: Lifecycle Stage × Impact | XML |
| Trend Impact Analysis (Layered) | Comparison table: trends × Personal / Org / Country / Europe | XML |
| Trend Impact Analysis (Temporal) | Comparison table: trends × 1y / 3y / 5y / 10y | XML |
| Trend-on-Trend Cross-Impact | 5×5 cross-impact matrix with interaction strength | XML |
| Countertrends & Cycles | Comparison table: trends × countertrends × cycles | XML |
| Threat / Opportunity Analysis | Comparison table: threats + policy / opportunities + policy | XML |

### 3. Weak signals & perception

| Technique | Diagram | Tool |
| --- | --- | --- |
| Perception Analysis (See / Hear / Think / Feel) | Hub-and-spoke with four perception spokes | XML |
| What / So What / Now What | Three-phase left-to-right flow | Mermaid |
| Weak Signal Analysis I | Comparison table: detected / anticipated / monitoring methods | XML |
| Weak Signal Analysis II | Comparison table: signal × actors × hypotheses × research questions | XML |

### 4. Scenario planning — basic

| Technique | Diagram | Tool |
| --- | --- | --- |
| Three Futures (Best / Likely / Worst) | Three-column comparison with severity coloring | XML |
| Futures Cone | Concentric arcs: Probable → Plausible → Possible, with wildcards | XML |
| Dator's Four Archetypes | 2×2 quadrant: Continuation, Transformation, Discipline & Constraint, Collapse | XML |

### 5. Scenario planning — advanced

| Technique | Diagram | Tool |
| --- | --- | --- |
| Intuitive Logics | 2×2 scenario matrix + scenario comparison table (Risks / Opportunities / Strategy / Resources / Knowledge) | XML |
| Lum's Four Steps to the Future | Sequential flow: Past → Present → Future → Aspiration | Mermaid |
| Layered Timeline (Lum) | Three swimlanes (Daily Life / Systems / Values) × Past / Present / Future | XML |

### 6. Assessment frameworks

| Technique | Diagram | Tool |
| --- | --- | --- |
| VUCA Analysis | Two integrated matrices: VUCA × geography + VUCA × Knowledge / Investments / Actions / Perspectives | XML |
| CATUR Analysis | 5 elements (Complexity, Ambiguity, Tension, Uncertainty, Risk) × geography | XML |
| What If / Then Cross-Impact | Two tables: scenarios (trigger / indicator / impact) + actions (reaction / risk of action / risk of inaction) | XML |
| Consequence Analysis | Per-trigger table: three narratives × positive / negative impacts × policy options × planning | XML |

### 7. Comparative & historical

| Technique | Diagram | Tool |
| --- | --- | --- |
| Analogical Reasoning | Two-column comparison (similarities / differences) + seven lesson questions | XML |
| Stakeholder Analysis (Lum) | Hub-and-spoke or table: Resisters / Channelers / Accelerators / Emerging across four disruption scenarios | XML |

## Color palette

Every diagram uses the same colors so a sequence of outputs reads as one analyst's work, not a stack of mismatched charts. Same palette as `intana-viz`, plus a couple of grid utilities:

| Role | Hex | Use |
| --- | --- | --- |
| Background | `#F8FAFC` | Canvas |
| Card / node | `#FFFFFF` | Default node fill |
| Border / text | `#334155` | Strokes and labels |
| Accent | `#2563EB` | Primary highlights, current trends |
| Supporting | `#059669` | Best case, positive outcomes, opportunities |
| Warning | `#F59E0B` | Likely case, caution, emerging trends |
| Critical | `#DC2626` | Worst case, risks, collapse |
| Neutral | `#64748B` | Established trends, secondary items |
| Highlight | `#8B5CF6` | Transformation, wildcards, uncertain |
| Grid / Axis | `#CBD5E1` | Matrix gridlines and axis lines |

## How requests get matched

When you ask for a foresight chart without naming a technique, the skill checks `references/use-cases.md` first. That file maps situations and questions to techniques in two ways: by **foresight phase** (scanning, trend ID, early warning, scenario development, impact assessment, historical analysis, stakeholder strategy) and by **question type** ("What are the early warning signs?" → Weak Signal Analysis; "What's possible, plausible, probable?" → Futures Cone).

If multiple techniques fit (say "compare three options under uncertainty" → Three Futures, Intuitive Logics, or Dator's Archetypes), the skill names the candidates and recommends one based on the time horizon, the granularity you want, and whether you already have axis variables in mind.

The catalog entries each list the **user inquiry fields** that technique needs. Before drawing, the skill asks for those fields so the diagram contains real content. If you give it unstructured notes, it extracts the entities first and shows you the extraction for confirmation.

## Common workflows

`references/use-cases.md` documents five workflow chains:

- **Full foresight cycle** — PESTLE → Trend Stage → Trend Impact → Weak Signals → Three Futures or Dator's → VUCA / CATUR → What If / Then → Stakeholder. For strategic-planning exercises and annual foresight cycles.
- **Quick strategic scan** — PESTLE → Three Futures → VUCA. For executive briefings and board prep.
- **Deep scenario planning** — Trend suite (Stage + Impact + Cross-Impact) → Intuitive Logics → Consequence Analysis → Stakeholder. For long-range planning and major investment decisions.
- **Emerging threat assessment** — Weak Signals → What If / Then → CATUR → Consequence Analysis. For crisis prep and competitive intelligence.
- **Historical lessons applied** — Analogical Reasoning → Layered Timeline → Three Futures.

Pick a chain or sequence the techniques yourself. The skill generates one diagram per call; the palette stays constant across calls so the final deck looks like one analyst's output, not a stack of mismatched charts.

## Files in this skill

- `SKILL.md` — operating contract loaded by the model.
- `references/technique-catalog.md` — all 24 techniques with diagram type, layout description, required input fields, and color mapping.
- `references/diagram-templates.md` — exact draw.io style strings, canvas sizes, node coordinates, and XML skeletons for each template.
- `references/use-cases.md` — selection guide by foresight phase and by question type, plus the workflow chains above.
