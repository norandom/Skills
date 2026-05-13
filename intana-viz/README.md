# intana-viz

Draws intelligence-analysis diagrams through the draw.io MCP. You name a technique, or describe the analysis you're doing, and the skill picks a diagram pattern and opens it in draw.io. From there it's a regular draw.io file: edit it, rearrange it, export it.

There are three MCP tools the skill routes to:

- `mcp__drawio__open_drawio_xml` — precise spatial layouts: matrices, networks, hub-and-spoke, custom shapes.
- `mcp__drawio__open_drawio_mermaid` — flows, trees, sequences, cycles.
- `mcp__drawio__open_drawio_csv` — tabular data turned into a diagram.

The catalog below is the complete list of techniques the skill recognizes. Each row gives the diagram shape and which tool produces it. Exact layout specs (canvas sizes, node coordinates, style strings) are in `references/diagram-templates.md`. Longer notes per technique are in `references/technique-catalog.md`.

## Visualizations

### 1. Foundational frameworks

| Technique | Diagram | Tool |
| --- | --- | --- |
| Three Types of Analysis (Descriptive / Predictive / Prescriptive) | Three-column horizontal pipeline | Mermaid `graph LR` or XML |
| What / So What / Now What | Three-stage flow with detail sub-boxes | Mermaid `graph LR` or XML |
| Three Types of Thinking (Critical / Creative / Conceptual) | Three overlapping ellipses (Venn) | XML |

### 2. Solution identification

| Technique | Diagram | Tool |
| --- | --- | --- |
| Negative Brainstorming | Tree: idea → assumptions, vulnerabilities, mitigations | Mermaid `graph TD` |
| Problem Solving Strategies Matrix | 2×3 grid (Prevention, Elimination, Reduction, Treatment, Tolerance, Redirection) | XML |
| Powers of Ten (scale-based ideation) | Concentric rings or expanding timeline | XML or Mermaid |

### 3. Solution analysis

| Technique | Diagram | Tool |
| --- | --- | --- |
| Speed Critique | Three-column table (Like / Don't Like / Unsure) | XML |
| Jumping Obstacles | Solutions × Obstacles × Mitigations matrix | XML or CSV |
| Resource Checklist | Solution × Resource RAG heatmap (Money, Knowledge, Skills, Time) | XML |
| Prioritisation Map | 2×2 scatter (Ease vs Benefit) with Do Now / Park / Deprioritise / Discard quadrants | XML |
| Design Thinking Process | Five-stage flow (Empathise → Define → Ideate → Prototype → Test) | Mermaid `graph LR` |

### 4. Prescriptive analysis

| Technique | Diagram | Tool |
| --- | --- | --- |
| Task Analysis Framework | Timeline matrix (Before / Beginning / During / After) × Functions | XML swimlane |
| Sideswimming Chart | Swimlanes across functional roles, ordered by phase | XML |
| Sub-Goal Decomposition | Goal-to-task hierarchy | Mermaid `graph TD` |
| String of Pearls | Sequential numbered pearls connected in a chain | XML |
| Spiderweb Chart (String of Pearls detail) | Radial: assumptions, dependencies, 2nd/3rd-order effects | XML |
| Risk Criticality Matrix | Pearl chain annotated with R/F risk flags | XML |
| N-Order Effects Analysis | Cascading tree of 1st / 2nd / 3rd-order effects | Mermaid `graph TD` |
| Course of Action (CoA) Comparison | Multi-criteria table with RAG cells or scored bars | XML |
| Mission Analysis | Q&A matrix (Objective, Intent, Consequences, Risks, Assumptions) | XML or Mermaid |
| Adversary Identification & Analysis | Adversary × Capability/Requirement table | XML |
| 5W1H / Starbursting | Central topic with six radiating branches | XML or Mermaid |
| Collection Strategy / Planning | Need × Discipline × Method × Timing × Owner table | XML or CSV |
| Issue Mapping | Network of issues, causes, stakeholders, impacts | XML or Mermaid |
| Concept Mapping | Labeled concept network with relationship arrows | XML or Mermaid |
| If/Then Analysis (Cross-Impact Matrix) | Scenario × Reaction × Risk of action / inaction | XML |
| Adversary Action-Reaction Wargaming | Alternating move/countermove timeline | XML |
| Critical Path Analysis | PERT network with critical path highlighted | XML or Mermaid |
| Pre-Mortem Analysis | Hub-and-spoke around a central "FAILURE" node | XML |

### 5. Challenge analysis

| Technique | Diagram | Tool |
| --- | --- | --- |
| Structured Self-Critique | Checklist with confidence scoring | XML |
| Argument Mapping | Hypothesis tree, blue support / red contradict / amber assumption | Mermaid `graph TD` or XML |
| Four Ways of Seeing | 2×2 (or N×N) actor-perspective grid | XML |
| Red Teaming Process | Three-column flow (Diagnostic → Creative → Challenge) | XML or Mermaid |
| Key Assumptions Check | Assumption × evidence × confidence × impact table | XML |
| Quality of Data and Sources Check | Source × Reliability × Credibility × Timeliness matrix | XML |
| Deception Check | Indicator decision tree | Mermaid `graph TD` |
| Outside-in Thinking | Concentric rings (external → inward) | XML |
| Alternative Futures Analysis | Branching scenario tree with probability labels | Mermaid `graph LR` or XML |
| What If Analysis | Conditional decision tree with diamond nodes | Mermaid `graph TD` |
| Indicators of Change | Timeline with marker flags and threshold lines | XML |
| Analysis of Competing Hypotheses (ACH) | Hypothesis × Evidence matrix with C / I / N/A cells | XML |
| High Impact / Low Probability | Impact × Probability 2×2 quadrant | XML |
| War Gaming | Multi-turn action-reaction sequence with branches | Mermaid or XML |
| Team A / Team B | Side-by-side argument with jury panel | XML |
| Devil's Advocacy (5Cs + CATUR) | Horizontal bar scorecard grouped by framework | XML |
| Six Thinking Hats | Six colored sections (White / Red / Black / Yellow / Green / Blue) | XML |

### 6. Opportunity analysis

| Technique | Diagram | Tool |
| --- | --- | --- |
| OS3 Model (Seeking / Screening / Seizing) | Three-phase funnel | Mermaid `graph LR` or XML |
| Mind Frame / Heart Flame / Gut Game | Three columns (Mind / Heart / Gut) → convergence | XML |
| Finding Opportunities Grid | 2×4 grid of eight opportunity sources | XML |
| Opportunity Matrix (Ansoff variant) | 2×2 (Resources × Policies) with named strategies | XML |
| 12R Model (Opportunity Screening) | 12 horizontal scored bars | XML |
| Constraints-Based Ideation | Ranked Constraint × Impact × How-to-Overcome table | XML |
| Obstacles and Objections Matrix | Opportunity × Obstacles × Overcome × Objections × Counter table | XML or CSV |
| Nominal Group Technique | Five-step flow (Brainstorm → Share → Discuss → Vote → Rank) | Mermaid `graph LR` |
| Opportunity Viability Assessment | Feasibility × Innovation Potential scatter | XML |

### 7. Perception & mindsets

| Technique | Diagram | Tool |
| --- | --- | --- |
| Signal Detection Framework | 2×2 contingency matrix (TP / FP / TN / FN) | XML |
| Perceptual Thresholds | Sensitivity scale with threshold markers | XML |
| Top-Down vs Bottom-Up Processing | Two side-by-side pyramids (inverted vs upright) | XML |
| Piaget's Learning Cycle | Four-stage circular flow | XML or Mermaid cycle |
| Schema Analysis | Strengths / Hindrances split with poor-schema sub-tree | XML |
| System 1 vs System 2 Thinking | Two-column comparison | XML |
| Situation-Cues-Patterns-Actions | Four-node circular flow | XML or Mermaid |
| Recognition-Primed Decision Model | Flow with feedback loop | Mermaid `graph TD` or XML |
| Decision Requirements Table | Multi-column table | XML or CSV |
| Fishbone Diagram (Ishikawa) | Central spine with angled cause branches | XML |
| Causal Factor Trees | Effect-to-root-cause hierarchy | Mermaid `graph TD` |
| Futures Wheel | Central event with concentric rings of consequences | XML |
| Root Cause Analysis | Cascading tree or fishbone | Mermaid or XML |
| Blindspot Analysis | Assumption dependency network with vulnerability flags | XML |
| Reframing Exercises | Hub-and-spoke alternative perspectives | XML |
| After-Action Review | Four-quadrant board (Expected / Actual / Went well / Improve) | XML |
| Post-mortem Analysis | Event → cause → lesson → action timeline | Mermaid or XML |
| Impact Analysis | Stakeholder × Impact severity matrix | XML |

### 8. Bias management

| Technique | Diagram | Tool |
| --- | --- | --- |
| Cognitive Bias Catalog (30+ biases) | Grouped grid by category | XML |
| Prospect Theory / Loss Aversion | S-curve value function (gains vs losses) | XML |
| Temporal Discounting | Discount curve over time (SSR vs LLR) | XML |
| Blindspots / Assumption Analysis | Assumption dependency map with risk flags | XML |
| Decision Blindspots | Decision × Blindspot × Impact × Mitigation table | XML |
| Framestorming | Three-phase flow (Calibration → Framestorm → Study) | Mermaid `graph LR` |
| Episodic Future Thinking | Future timeline with event markers and probabilities | XML |
| Information Avoidance / Ostrich Effect | Seek-vs-avoid decision tree | Mermaid `graph TD` |
| Action Bias | 2×2 (Act vs Don't Act) × (Warranted vs Not) | XML |
| Scarcity vs Abundance Mindset | Two-column behaviors-and-outcomes comparison | XML |

### 9. Organizational analysis

| Technique | Diagram | Tool |
| --- | --- | --- |
| Five Architectures Framework | Pentagon / five-node network (Org, Op, Info, Tech, Cog) | XML |
| Persistent Uncertainty Framework | Eight-segment wheel of uncertainty types | XML |
| Six Deficits Model | Six bars or hexagonal layout | XML |
| Burke-Litwin Model | 12-element interconnected influence network | XML |
| Leavitt's Diamond | Four-vertex diamond (Structure / Process / People / Technology) | XML |
| Weisbord's Six Box Model | Six boxes within an Environment boundary | XML |
| McKinsey 7S Framework | Star/wheel with Shared Values at the center | XML |
| Johnson's Cultural Web | Central Paradigm with six connected elements | XML |
| The 4Ps of Culture | Purpose → Policy → Practice → People cycle | Mermaid or XML |
| Cultural Subcultures Framework | Five-segment pentagon (Reporting / Just / Flexible / Learning / Mindful) | XML |
| Five Whys | Cascading vertical "why" tree | Mermaid `graph TD` |
| Inputs-Process-Outputs Model | Three-stage flow with feedback edge | Mermaid `graph LR` |
| Churchill's Audit | Four-question framework (Know / Don't know / Need to know / How) | XML or Mermaid |
| Reflexive Practice | Circular learning cycle | XML or Mermaid |
| The Consulting Process (9 phases) | Nine-step sequential flow | Mermaid `graph LR` |
| Process Analysis / Bottleneck Analysis | PERT/flow network with bottleneck highlighting | XML |
| Waste Category Framework (8 types) | Eight-cell grid or wheel | XML |
| Process Variability Classification | Two-branch tree (Customer-introduced vs Process-introduced) | Mermaid `graph TD` |

## Color palette

Every diagram uses the same colors. The point is that a stack of outputs looks like one analyst's work, not nine random charts pasted together.

| Role | Hex | Use |
| --- | --- | --- |
| Background | `#F8FAFC` | Canvas |
| Card / node | `#FFFFFF` | Default node fill |
| Border / text | `#334155` | Strokes and labels |
| Accent | `#2563EB` | Primary highlights, interactive elements |
| Supporting | `#059669` | Positive, supporting, "Do It Now" |
| Warning | `#F59E0B` | Assumptions, caution, "Park for Later" |
| Critical | `#DC2626` | Risks, contradicting evidence, "Discard" |
| Neutral | `#64748B` | Deprioritised, secondary |
| Highlight | `#8B5CF6` | Uncertain / neutral items |

## How requests get matched

When you ask for "a chart that shows…" without naming a technique, the skill checks `references/technique-catalog.md` for the closest match. If several fit (say you ask to "compare three options", which could be a CoA Comparison, a Prioritisation Map, or a scorecard), it names the candidates and recommends one. If the request is too vague ("show me the risks"), it asks which analytical structure you want before drawing.

## Output

One MCP call per request. The diagram opens in draw.io. From there you edit, rearrange, and export to PNG, SVG, or PDF like any other draw.io file.
