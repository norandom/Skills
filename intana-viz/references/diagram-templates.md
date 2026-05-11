# Diagram Templates — Exact Specifications per Diagram Type

These templates define the exact layout, dimensions, styles, and structure for each diagram type. Follow them precisely so every diagram produced by this skill has a consistent, professional look.

## Table of Contents
1. [Global Style Constants](#global-style-constants)
2. [Quadrant / 2×2 Matrix](#quadrant--22-matrix)
3. [Hub-and-Spoke](#hub-and-spoke)
4. [Scored Assessment / Bar Scorecard](#scored-assessment--bar-scorecard)
5. [Comparison Table / Matrix](#comparison-table--matrix)
6. [Hierarchical Tree (Mermaid)](#hierarchical-tree-mermaid)
7. [Process Flow (Mermaid)](#process-flow-mermaid)
8. [Sequential Chain (Mermaid)](#sequential-chain-mermaid)
9. [Circular Cycle (Mermaid)](#circular-cycle-mermaid)
10. [Network / Interconnected Model (XML)](#network--interconnected-model-xml)
11. [Diamond Layout (XML)](#diamond-layout-xml)
12. [Star / Wheel Layout (XML)](#star--wheel-layout-xml)
13. [Web Layout (XML)](#web-layout-xml)
14. [Fishbone / Ishikawa (XML)](#fishbone--ishikawa-xml)
15. [Concentric Rings (XML)](#concentric-rings-xml)
16. [Multi-Column Layout (XML)](#multi-column-layout-xml)
17. [Three-Column Perspective (XML)](#three-column-perspective-xml)
18. [Six-Segment Layout (XML)](#six-segment-layout-xml)

---

## Global Style Constants

Use these EVERYWHERE. Never deviate.

### Colors (hex)
```
BACKGROUND    = #F8FAFC
WHITE         = #FFFFFF
BORDER        = #334155
TEXT          = #334155
TEXT_SECONDARY = #64748B
ACCENT        = #2563EB
ACCENT_LIGHT  = #DBEAFE
SUPPORTING    = #059669
SUPPORT_LIGHT = #D1FAE5
WARNING       = #F59E0B
WARN_LIGHT    = #FFFBEB
CRITICAL      = #DC2626
CRIT_LIGHT    = #FEE2E2
NEUTRAL       = #64748B
NEUTRAL_LIGHT = #F1F5F9
HIGHLIGHT     = #8B5CF6
GRID_LINE     = #CBD5E1
AXIS_LINE     = #94A3B8
```

### Typography
```
TITLE_SIZE    = 16
SUBTITLE_SIZE = 11
HEADER_SIZE   = 13
ITEM_SIZE     = 10
DETAIL_SIZE   = 9
LEGEND_SIZE   = 9
```

### Common XML Style Strings
```
TITLE_STYLE    = "text;html=1;align=center;verticalAlign=middle;whiteSpace=wrap;fontSize=16;fontColor=#334155;"
SUBTITLE_STYLE = "text;html=1;align=center;verticalAlign=middle;whiteSpace=wrap;fontSize=11;fontColor=#64748B;"
LEGEND_TITLE   = "text;html=1;align=left;fontSize=10;fontColor=#334155;fontStyle=1;"
LEGEND_DOT     = "rounded=1;whiteSpace=wrap;html=1;strokeColor=none;"  (add fillColor)
LEGEND_LABEL   = "text;html=1;align=left;fontSize=9;fontColor=#334155;"
DASHED_LINE    = "endArrow=none;dashed=1;strokeColor=#94A3B8;strokeWidth=2;"
OUTER_BORDER   = "rounded=0;whiteSpace=wrap;html=1;fillColor=none;strokeColor=#CBD5E1;strokeWidth=1;"
```

### Node Styles
```
ITEM_NODE = "rounded=1;whiteSpace=wrap;html=1;fontSize=10;shadow=1;align=left;spacingLeft=8;spacingRight=8;"
  — Add fillColor, fontColor, strokeColor per category.

HEADER_NODE = "rounded=1;whiteSpace=wrap;html=1;fontSize=13;verticalAlign=middle;shadow=1;"
  — Add fillColor=#[CATEGORY_COLOR], fontColor=#FFFFFF, strokeColor=#[DARKER_VARIANT].
```

---

## Quadrant / 2×2 Matrix

**Used by:** Prioritisation Map, Four Ways of Seeing, Opportunity Matrix, Signal Detection, High Impact/Low Probability, Action Bias.

### Canvas
- Total diagram area: 600×500 starting at x=100, y=70
- Title at x=150, y=10, width=500, height=50
- Outer border: x=100, y=70, width=600, height=500

### Quadrant Backgrounds
Four rectangles, each 300×250, no stroke, opacity=60:

| Quadrant | Position | Fill | Label Color | Label |
|----------|----------|------|-------------|-------|
| Top-Left | x=100, y=70 | ACCENT_LIGHT (#DBEAFE) | ACCENT (#2563EB) | (varies by technique) |
| Top-Right | x=400, y=70 | SUPPORT_LIGHT (#D1FAE5) | SUPPORTING (#059669) | (varies) |
| Bottom-Left | x=100, y=320 | CRIT_LIGHT (#FEE2E2) | CRITICAL (#DC2626) | (varies) |
| Bottom-Right | x=400, y=320 | NEUTRAL_LIGHT (#F1F5F9) | NEUTRAL (#64748B) | (varies) |

### Axes
- Vertical dashed line: x=400, from y=70 to y=570
- Horizontal dashed line: y=320, from x=100 to x=700
- X-axis label: centered at x=300, y=580, width=200
- Y-axis label: centered at x=30, y=280, width=180, rotation=-90

### Quadrant Labels
- Position: 80px inset from quadrant corner
- Style: `text;html=1;align=center;fontSize=11;fontColor=#[LABEL_COLOR];opacity=50;fontStyle=1;`

### Item Nodes
- Style: ITEM_NODE with category fill/stroke/font colors
- Width: 120–140, Height: 55–65
- Position: approximate x,y within quadrant based on scores
  - Score 1 = quadrant edge, Score 10 = quadrant far corner
  - Map score to position: `x = quadrant_x + (score / 10) * quadrant_width`
- Label format: `<b>N. Short Name</b><br><font style='font-size:9px;color:#64748B'>Metric1: X | Metric2: Y</font>`
- Fill colors by quadrant: SUPPORTING (top-right), ACCENT (top-left), NEUTRAL_LIGHT+dark text (bottom-right), CRITICAL (bottom-left)

### Legend
- Position: x=720, y=70
- One row per quadrant: colored dot (14×14) + label text
- Dot style: `LEGEND_DOT` + `fillColor=#[COLOR]`
- Spacing: 20px vertical between rows

---

## Hub-and-Spoke

**Used by:** Pre-Mortem, Failure Causation, Stakeholder Analysis, 5W1H/Starbursting, Reframing Exercises.

### Canvas
- Center point: cx=400, cy=320
- Spoke radius: 220px from center
- Title at x=100, y=10, width=600, height=50

### Central Node
- Shape: ellipse
- Style: `ellipse;whiteSpace=wrap;html=1;fillColor=#334155;fontColor=#FFFFFF;strokeColor=#1E293B;fontSize=14;fontStyle=1;shadow=1;`
- Size: 120×120
- Position: x=cx-60, y=cy-60
- Label: technique-specific (e.g., "OPERATION FAILED", "CENTRAL TOPIC")

### Spoke Nodes
- Arrange in a circle at radius 220px from center
- Angle increment: 360° / N spokes (e.g., 8 spokes = 45° apart, starting at -90° / top)
- Position formula: `x = cx + radius * cos(angle) - nodeWidth/2`, `y = cy + radius * sin(angle) - nodeHeight/2`
- Style: `rounded=1;whiteSpace=wrap;html=1;fontSize=10;shadow=1;align=left;spacingLeft=8;spacingRight=8;`
- Size: 150×60
- Fill color by severity/category:
  - Critical: fillColor=#DC2626, fontColor=#FFFFFF, strokeColor=#B91C1C
  - High: fillColor=#F59E0B, fontColor=#FFFFFF, strokeColor=#D97706
  - Medium: fillColor=#8B5CF6, fontColor=#FFFFFF, strokeColor=#7C3AED
  - Low: fillColor=#64748B, fontColor=#FFFFFF, strokeColor=#475569
- Label format: `<b>Short Name</b><br><font style='font-size:9px;color:#[LIGHT_TEXT]'>Detail line</font>`

### Spoke Edges
- Style: `endArrow=none;strokeColor=#94A3B8;strokeWidth=1.5;`
- Source: central node, Target: spoke node
- Straight lines (no curves)

### Legend
- Position: x=660, y=480 (bottom-right)
- One row per severity level

---

## Scored Assessment / Bar Scorecard

**Used by:** Devil's Advocacy (5Cs + CATUR), 12R Model, Weisbord's Six Box scoring.

### Canvas
- Title at x=100, y=10, width=600, height=50
- Bar area starts at x=100, y=80

### Bar Layout
- Each dimension is one horizontal bar
- Bar height: 30px
- Vertical spacing between bars: 8px
- Group header (e.g., "5Cs Framework"): full-width text, fontSize=12, fontStyle=1, height=30
- Group spacing: 20px between groups

### Bar Structure (per dimension)
- Label: x=100, width=180, right-aligned text with dimension name
- Bar background: x=290, width=300, height=30, fillColor=#E2E8F0, strokeColor=#CBD5E1, rounded=0
- Bar fill: x=290, width=(score/maxScore)*300, height=30, fillColor=#[CATEGORY_COLOR], strokeColor=none, rounded=0
- Score label: x=600, width=50, text="{score}/{max}", fontSize=10, fontColor=#334155

### Bar Colors
- Score ≥ 8: fillColor=#059669 (SUPPORTING)
- Score 6–7: fillColor=#2563EB (ACCENT)
- Score 4–5: fillColor=#F59E0B (WARNING)
- Score ≤ 3: fillColor=#DC2626 (CRITICAL)

### Summary Box
- Below all bars, 20px gap
- Style: `rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFBEB;strokeColor=#FDE68A;fontSize=10;align=left;spacingLeft=12;spacingRight=12;`
- Width: 500, Height: auto (based on content)
- Contains average scores and key insights

---

## Comparison Table / Matrix

**Used by:** CoA Comparison, Resource Checklist, If/Then Analysis, ACH Matrix, Key Assumptions Check, Collection Strategy.

### Canvas
- Title at x=50, y=10, width=700, height=50
- Table starts at x=50, y=70

### Table Structure
- Header row: height=40, fillColor=#334155, fontColor=#FFFFFF, fontSize=11, fontStyle=1
- Data rows: height=35, alternating fillColor=#FFFFFF and #F8FAFC
- Column widths: first column (row labels) = 180px, data columns = equal share of remaining width
- Cell style: `whiteSpace=wrap;html=1;fontSize=10;fontColor=#334155;strokeColor=#CBD5E1;`
- Header cell style: `whiteSpace=wrap;html=1;fontSize=11;fontColor=#FFFFFF;fillColor=#334155;strokeColor=#1E293B;fontStyle=1;`

### RAG-Colored Cells
When cells contain ratings:
- High/Good/Consistent: fillColor=#D1FAE5, fontColor=#059669
- Medium/Partial: fillColor=#FEF3C7, fontColor=#D97706
- Low/Bad/Inconsistent: fillColor=#FEE2E2, fontColor=#DC2626
- N/A: fillColor=#F1F5F9, fontColor=#94A3B8

### Column Header Labels
- Centered horizontally and vertically
- Bold text

---

## Hierarchical Tree (Mermaid)

**Used by:** Argument Mapping, Five Whys, Negative Brainstorming, Causal Factor Trees, Sub-Goal Decomposition.

### Mermaid Template
```
graph TD
    ROOT["<b>Root Node Title</b>"]
    
    ROOT --> CHILD1["Child 1 Label"]
    ROOT --> CHILD2["Child 2 Label"]
    CHILD1 --> LEAF1["Leaf 1"]
    CHILD1 --> LEAF2["Leaf 2"]

    classDef root fill:#334155,color:#fff,stroke:#1E293B,stroke-width:2px
    classDef support fill:#059669,color:#fff,stroke:#047857,stroke-width:1px
    classDef contradict fill:#DC2626,color:#fff,stroke:#B91C1C,stroke-width:1px
    classDef assumption fill:#F59E0B,color:#fff,stroke:#D97706,stroke-width:1px
    classDef neutral fill:#64748B,color:#fff,stroke:#475569,stroke-width:1px
    classDef default_node fill:#FFFFFF,color:#334155,stroke:#CBD5E1,stroke-width:1px

    class ROOT root
```

### Class Assignment Rules
- Root/hypothesis: `root` class
- Supporting evidence/positive: `support` class
- Contradicting evidence/negative: `contradict` class
- Assumptions/uncertain: `assumption` class
- Neutral/informational: `neutral` class
- Default: `default_node` class

### Node Label Format
- Root: `["<b>Title</b>"]`
- Children: `["<b>Short Label</b><br>Detail text"]`
- Keep labels under 50 characters per line

---

## Process Flow (Mermaid)

**Used by:** Red Teaming, What/So What/Now What, OS3 Model, Task Analysis, CoA Phasing, Consulting Process, Design Thinking.

### Mermaid Template
```
graph LR
    subgraph Phase1["<b>Phase 1 Name</b>"]
        A1["Step 1"]
        A2["Step 2"]
        A1 --> A2
    end
    subgraph Phase2["<b>Phase 2 Name</b>"]
        B1["Step 1"]
        B2["Step 2"]
        B1 --> B2
    end
    Phase1 --> Phase2

    classDef phase1 fill:#DBEAFE,color:#334155,stroke:#2563EB,stroke-width:1px
    classDef phase2 fill:#D1FAE5,color:#334155,stroke:#059669,stroke-width:1px
    classDef phase3 fill:#FFFBEB,color:#334155,stroke:#F59E0B,stroke-width:1px
    classDef decision fill:#FFFFFF,color:#334155,stroke:#334155,stroke-width:2px

    class A1,A2 phase1
    class B1,B2 phase2
```

### Phase Colors (cycle through in order)
1. Phase 1: fill=#DBEAFE, stroke=#2563EB (blue)
2. Phase 2: fill=#D1FAE5, stroke=#059669 (green)
3. Phase 3: fill=#FFFBEB, stroke=#F59E0B (amber)
4. Phase 4: fill=#FEE2E2, stroke=#DC2626 (red)
5. Phase 5: fill=#F3E8FF, stroke=#8B5CF6 (violet)
6. Phase 6+: repeat from 1

### Decision Diamonds
- Use `{Decision Question}` syntax
- Style: white fill, dark border, 2px stroke

---

## Sequential Chain (Mermaid)

**Used by:** String of Pearls, Critical Path, Adversary Wargaming.

### Mermaid Template
```
graph LR
    P1(("1")):::pearl --> P2(("2")):::pearl --> P3(("3")):::critical --> P4(("4")):::pearl

    classDef pearl fill:#2563EB,color:#fff,stroke:#1D4ED8,stroke-width:2px
    classDef critical fill:#DC2626,color:#fff,stroke:#B91C1C,stroke-width:3px
    classDef annotation fill:#FFFBEB,color:#334155,stroke:#FDE68A,stroke-width:1px
```

### Node Shape
- Pearls: `(("N"))` — circle nodes with number
- Annotations: `["Text"]` — rectangle nodes linked with dotted lines

### Critical Path Highlighting
- Normal pearls: `pearl` class (blue)
- Critical/at-risk pearls: `critical` class (red, thicker stroke)
- Annotations: `annotation` class (amber background)

### Wargaming Alternation
- Our action: `pearl` class (blue)
- Their reaction: `contradict` class (red)
- Alternate classes for each turn

---

## Circular Cycle (Mermaid)

**Used by:** Piaget's Learning Cycle, OODA, Situation-Cues-Patterns-Actions, Reflexive Practice, 4Ps of Culture.

### Mermaid Template
```
graph LR
    A["Stage 1"] --> B["Stage 2"] --> C["Stage 3"] --> D["Stage 4"] --> A

    classDef stage1 fill:#2563EB,color:#fff,stroke:#1D4ED8,stroke-width:2px
    classDef stage2 fill:#059669,color:#fff,stroke:#047857,stroke-width:2px
    classDef stage3 fill:#F59E0B,color:#fff,stroke:#D97706,stroke-width:2px
    classDef stage4 fill:#8B5CF6,color:#fff,stroke:#7C3AED,stroke-width:2px

    class A stage1
    class B stage2
    class C stage3
    class D stage4
```

### Stage Colors (cycle through)
- Stage 1: blue (#2563EB)
- Stage 2: green (#059669)
- Stage 3: amber (#F59E0B)
- Stage 4: violet (#8B5CF6)
- Stage 5+: red (#DC2626), then repeat

---

## Network / Interconnected Model (XML)

**Used by:** Burke-Litwin (12 elements), Blindspot Analysis, Concept Mapping, Issue Mapping.

### Canvas
- Title at x=100, y=10, width=600, height=50
- Network area: 700×500 starting at x=50, y=70

### Nodes
- Shape: rounded rectangle
- Style: `rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#334155;strokeWidth=1.5;fontSize=10;fontColor=#334155;shadow=1;`
- Size: 120×50
- Position: distribute evenly across canvas (use grid-like or force-layout positions)
- For models with a canonical layout (Burke-Litwin's hierarchy), follow that layout

### Edges
- Style: `endArrow=classic;endFill=1;strokeColor=#94A3B8;strokeWidth=1;curved=1;`
- For bidirectional: `endArrow=classic;startArrow=classic;endFill=1;startFill=1;`
- Label if needed: edge value text in fontSize=9

### Highlight Nodes
- Primary/central node: fillColor=#334155, fontColor=#FFFFFF
- Flagged/vulnerable: fillColor=#FEE2E2, strokeColor=#DC2626

---

## Diamond Layout (XML)

**Used by:** Leavitt's Diamond.

### Canvas
- Center: cx=400, cy=300
- Diamond radius: 180px

### Four Vertices
Position at compass points:
- Top (Structure): x=cx-60, y=cy-180-25, size=120×50
- Right (Technology): x=cx+180-60, y=cy-25, size=120×50
- Bottom (Process): x=cx-60, y=cy+180-25, size=120×50
- Left (People): x=cx-180-60, y=cy-25, size=120×50

### Node Style
- `rounded=1;whiteSpace=wrap;html=1;fillColor=#2563EB;fontColor=#FFFFFF;strokeColor=#1D4ED8;fontSize=12;fontStyle=1;shadow=1;`

### Edges
- Bidirectional arrows connecting all four vertices (6 edges total)
- Style: `endArrow=classic;startArrow=classic;endFill=1;startFill=1;strokeColor=#94A3B8;strokeWidth=1.5;curved=1;`

---

## Star / Wheel Layout (XML)

**Used by:** McKinsey 7S Framework, Five Architectures Framework.

### Canvas
- Center: cx=400, cy=320
- Outer radius: 200px

### Central Node
- Shape: ellipse
- Style: `ellipse;whiteSpace=wrap;html=1;fillColor=#334155;fontColor=#FFFFFF;strokeColor=#1E293B;fontSize=13;fontStyle=1;shadow=1;`
- Size: 100×100
- Position: x=cx-50, y=cy-50
- Label: central element (e.g., "Shared Values")

### Spoke Nodes
- Arrange N nodes in a circle at radius 200px
- Angle increment: 360°/N, starting at -90° (top)
- Style: `rounded=1;whiteSpace=wrap;html=1;fillColor=#2563EB;fontColor=#FFFFFF;strokeColor=#1D4ED8;fontSize=11;fontStyle=1;shadow=1;`
- Size: 110×50
- For 7S: differentiate Hard (fillColor=#2563EB) vs Soft (fillColor=#8B5CF6) elements

### Edges
- Each spoke node connects to central node
- Style: `endArrow=classic;startArrow=classic;endFill=1;startFill=1;strokeColor=#94A3B8;strokeWidth=1.5;`

---

## Web Layout (XML)

**Used by:** Johnson's Cultural Web.

### Canvas
- Center: cx=400, cy=320
- Inner radius (Paradigm): 60px
- Outer radius (elements): 180px

### Central Node (Paradigm)
- Shape: ellipse
- Style: same as Star central node
- Size: 120×120
- Position: x=cx-60, y=cy-60

### Six Surrounding Nodes
- Equally spaced at 60° intervals starting at -90°
- Style: `rounded=1;whiteSpace=wrap;html=1;fillColor=#FFFFFF;strokeColor=#334155;strokeWidth=1.5;fontSize=10;fontColor=#334155;shadow=1;`
- Size: 130×55

### Web Lines
- Each outer node connects to Paradigm AND to its two adjacent outer nodes
- Inner connections: `strokeColor=#334155;strokeWidth=1.5;`
- Outer web connections: `strokeColor=#CBD5E1;strokeWidth=1;dashed=1;`

---

## Fishbone / Ishikawa (XML)

**Used by:** Fishbone Diagram, Root Cause Analysis.

### Canvas
- Spine runs horizontally from x=80 to x=700 at y=300
- Effect box at right end (x=700): width=120, height=50

### Spine
- Style: `endArrow=classic;endFill=1;strokeColor=#334155;strokeWidth=3;`
- From x=80,y=300 to x=700,y=300

### Effect Box
- Position: x=700, y=275
- Style: `rounded=1;whiteSpace=wrap;html=1;fillColor=#DC2626;fontColor=#FFFFFF;strokeColor=#B91C1C;fontSize=12;fontStyle=1;shadow=1;`
- Size: 140×50

### Cause Branches
- Alternate above and below spine
- Branch angle: 30° from horizontal
- Main branches: 6 categories max, evenly spaced along spine
- Branch style: `endArrow=none;strokeColor=#64748B;strokeWidth=2;`
- Category label: `text;html=1;fontSize=11;fontColor=#334155;fontStyle=1;` at branch tip

### Sub-Cause Twigs
- Shorter lines branching off main branches
- Style: `endArrow=none;strokeColor=#94A3B8;strokeWidth=1;`
- Label: `text;html=1;fontSize=9;fontColor=#64748B;` at twig tip

### Category Colors (branch labels)
Alternate through: ACCENT, SUPPORTING, WARNING, CRITICAL, HIGHLIGHT, NEUTRAL

---

## Concentric Rings (XML)

**Used by:** Futures Wheel, Powers of Ten, Outside-in Thinking, Persistent Uncertainty.

### Canvas
- Center: cx=400, cy=320

### Rings
- Ring 1 (center): radius=50, fillColor=#334155 (darkest)
- Ring 2: radius=130, fillColor=#64748B
- Ring 3: radius=210, fillColor=#94A3B8
- Ring 4: radius=290, fillColor=#CBD5E1
- Draw from outermost to innermost so inner rings overlay outer
- Style: `ellipse;whiteSpace=wrap;html=1;fillColor=#[COLOR];strokeColor=#[DARKER];strokeWidth=1;opacity=30;`

### Center Label
- On the innermost circle
- Style: `text;html=1;align=center;fontSize=12;fontColor=#FFFFFF;fontStyle=1;`

### Ring Labels / Items
- Place as rounded rectangles on each ring at appropriate angles
- Style: ITEM_NODE with white fill and dark text
- Size: 100–130 wide, 35–45 tall

---

## Multi-Column Layout (XML)

**Used by:** Team A/Team B, System 1 vs System 2, Scarcity vs Abundance, Top-Down vs Bottom-Up.

### Canvas
- Two columns, each 320px wide, gap=40px between
- Left column starts at x=60, right at x=420
- Title spans both columns at top

### Column Headers
- Width: 320, Height: 60
- Left: fillColor=#2563EB, fontColor=#FFFFFF
- Right: fillColor=#DC2626, fontColor=#FFFFFF (or other contrast color)
- Style: HEADER_NODE

### Column Items
- Width: 300, Height: 45
- Left items: fillColor=#EFF6FF, strokeColor=#BFDBFE
- Right items: fillColor=#FEF2F2, strokeColor=#FECACA
- Spacing: 10px vertical between items
- Position: 10px inset from column edge

### Center Divider (optional)
- Vertical dashed line at x=390 from top to bottom
- Style: DASHED_LINE

---

## Three-Column Perspective (XML)

**Used by:** Mind Frame/Heart Flame/Gut Game, Red Teaming (Diagnostic/Creative/Challenge), Speed Critique.

### Canvas
- Three columns, each 240px wide, gap=20px
- Column starts: x=80, x=340, x=600
- Title at top spanning all three

### Column Headers
- Width: 240, Height: 70
- Column 1: fillColor=#2563EB (blue), fontColor=#FFFFFF
- Column 2: fillColor=#DC2626 (red), fontColor=#FFFFFF
- Column 3: fillColor=#F59E0B (amber), fontColor=#FFFFFF
- Style: HEADER_NODE with subtitle line

### Column Items
- Width: 240, Height: 55
- Column 1 items: fillColor=#EFF6FF, strokeColor=#BFDBFE
- Column 2 items: fillColor=#FEF2F2, strokeColor=#FECACA
- Column 3 items: fillColor=#FFFBEB, strokeColor=#FDE68A
- Spacing: 10px vertical
- Label: `<b>N. Title</b><br><font style='font-size:9px;color:#64748B'>Detail</font>`

### Convergence Section (optional)
- Full-width dashed container below columns
- fillColor=#F8FAFC, strokeColor=#CBD5E1, dashed=1
- Convergence items: fillColor=#059669 (green), fontColor=#FFFFFF
- Arrows from bottom of each column into convergence box

---

## Six-Segment Layout (XML)

**Used by:** Six Thinking Hats, Weisbord's Six Box, Six Deficits.

### Canvas
- 3×2 grid layout
- Each cell: 220×120, gap=15px
- Grid starts at x=80, y=80

### Cell Positions
| Cell | Row | Col | x | y |
|------|-----|-----|---|---|
| 1 | 0 | 0 | 80 | 80 |
| 2 | 0 | 1 | 315 | 80 |
| 3 | 0 | 2 | 550 | 80 |
| 4 | 1 | 0 | 80 | 215 |
| 5 | 1 | 1 | 315 | 215 |
| 6 | 1 | 2 | 550 | 215 |

### Cell Style
- `rounded=1;whiteSpace=wrap;html=1;fontSize=10;shadow=1;align=left;spacingLeft=10;spacingRight=10;verticalAlign=top;`
- Width: 220, Height: 120

### Six Thinking Hats Colors
| Hat | Fill | Stroke | Font |
|-----|------|--------|------|
| White (Facts) | #FFFFFF | #CBD5E1 | #334155 |
| Red (Emotions) | #FEE2E2 | #DC2626 | #DC2626 |
| Black (Risks) | #334155 | #1E293B | #FFFFFF |
| Yellow (Benefits) | #FFFBEB | #F59E0B | #D97706 |
| Green (Creativity) | #D1FAE5 | #059669 | #059669 |
| Blue (Process) | #DBEAFE | #2563EB | #2563EB |

### Generic Six-Segment Colors
Cycle through: ACCENT, SUPPORTING, WARNING, CRITICAL, HIGHLIGHT, NEUTRAL with their light backgrounds.
