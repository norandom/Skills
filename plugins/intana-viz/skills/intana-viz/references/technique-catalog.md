# Intelligence Analysis Visualization Technique Catalog

This catalog maps every technique from the course material to its visualization type and draw.io implementation approach. When the user requests a visualization, match their request to the closest technique(s) below and follow the diagram guidance.

Based on course notes (I-Intelligence, July 2021) Pallaris et. al., and personal research.

**Output tools:** `open_drawio_xml` (spatial layouts, matrices, networks), `open_drawio_mermaid` (flows, trees, sequences), `open_drawio_csv` (tabular-to-diagram).

## Informal upstream credits

The techniques in this catalog mostly predate the I-Intelligence course; the course is the framing it was learned through. Best-effort attributions (not exhaustive, not formally cited):

- **Analysis of Competing Hypotheses (ACH)** — Richards J. Heuer Jr., *Psychology of Intelligence Analysis* (CIA, 1999).
- **Pre-Mortem** — Gary Klein, HBR (2007).
- **Key Assumptions Check / What-If Analysis / Indicators of Change / Devil's Advocacy / Team A vs Team B / Red Team / Alternative Futures / High Impact-Low Probability** — CIA *Tradecraft Primer: Structured Analytic Techniques* (2009) and Heuer & Pherson, *Structured Analytic Techniques for Intelligence Analysis* (2010+).
- **Six Thinking Hats** — Edward de Bono (1985).
- **Fishbone (Ishikawa)** — Kaoru Ishikawa (1968).
- **Five Whys** — Sakichi Toyoda, Toyota Production System.
- **Futures Wheel** — Jerome C. Glenn (1972).
- **OODA loop** — John Boyd (US Air Force, 1970s).
- **Recognition-Primed Decision Model / Situation-Cues-Patterns-Actions** — Gary Klein, *Sources of Power* (1998).
- **Argument Mapping** — Stephen Toulmin, *The Uses of Argument* (1958).
- **McKinsey 7S** — Tom Peters & Robert Waterman, *In Search of Excellence* (McKinsey, 1982).
- **Burke-Litwin Causal Model** — W. Warner Burke & George Litwin (1992).
- **Leavitt's Diamond** — Harold J. Leavitt (1965).
- **Weisbord's Six Box** — Marvin Weisbord (1976).
- **Johnson's Cultural Web** — Gerry Johnson (1992).
- **Ansoff Matrix (Opportunity Matrix variant)** — Igor Ansoff (1957).
- **Nominal Group Technique** — Delbecq & Van de Ven (1971).
- **Design Thinking process** — Stanford d.school / IDEO lineage, Tim Brown.
- **Piaget's Learning Cycle** — Jean Piaget.
- **Prospect Theory / Loss Aversion** — Kahneman & Tversky (1979).
- **System 1 vs System 2 thinking** — Daniel Kahneman, *Thinking, Fast and Slow* (2011).
- **After-Action Review** — US Army training doctrine.
- **CoA Analysis / Wargaming / Mission Analysis / Sideswimming Chart / Critical Path / String of Pearls** — military planning doctrine (US Army FM 5-0, NATO/UK MoD planning manuals).

Anything not listed above is based on course notes and personal research.

## Table of Contents
1. [Foundational Frameworks](#1-foundational-frameworks)
2. [Solution Identification](#2-solution-identification)
3. [Solution Analysis](#3-solution-analysis)
4. [Prescriptive Analysis](#4-prescriptive-analysis)
5. [Challenge Analysis](#5-challenge-analysis)
6. [Opportunity Analysis](#6-opportunity-analysis)
7. [Perception & Mindsets](#7-perception--mindsets)
8. [Bias Management](#8-bias-management)
9. [Organizational Analysis](#9-organizational-analysis)

---

## 1. Foundational Frameworks

### Three Types of Analysis (Descriptive / Predictive / Prescriptive)
- **Diagram:** Three-column horizontal pipeline with arrows
- **Tool:** Mermaid `graph LR` or XML three-box flow

### What / So What / Now What
- **Diagram:** Three-stage horizontal flow with detail sub-boxes per stage
- **Tool:** Mermaid `graph LR` with subgraphs, or XML positioned boxes

### Three Types of Thinking (Critical / Creative / Conceptual)
- **Diagram:** Three overlapping circles (Venn) or three-column comparison
- **Tool:** XML with three overlapping ellipses

---

## 2. Solution Identification

### Negative Brainstorming
- **Diagram:** Tree — central idea branching to assumptions, vulnerabilities, mitigations
- **Tool:** Mermaid `graph TD` tree with color-coded classes (red=vulnerability, green=mitigation)

### Problem Solving Strategies Matrix
- **Diagram:** 2×3 grid — Prevention, Elimination, Reduction, Treatment, Tolerance, Redirection
- **Tool:** XML six-cell grid with colored headers and action items per cell

### Powers of Ten (Scale-Based Ideation)
- **Diagram:** Concentric rings or horizontal timeline with expanding scope (10min → 1hr → 1day → 1week → 1month)
- **Tool:** XML concentric circles or Mermaid `graph LR` timeline

---

## 3. Solution Analysis

### Speed Critique
- **Diagram:** Three-column table (Like / Don't Like / Unsure)
- **Tool:** XML three-column layout with items as rounded rectangles

### Jumping Obstacles
- **Diagram:** Multi-row matrix — Solutions × Obstacles × Mitigations
- **Tool:** XML table layout or CSV

### Resource Checklist
- **Diagram:** Solution × Resource heatmap (Money, Knowledge, Skills, Time) with RAG colors
- **Tool:** XML grid with colored cells (green=have, red=need, amber=partial)

### Prioritisation Map
- **Diagram:** 2×2 scatter quadrant — Ease of Implementation vs. Benefit to User
- **Quadrants:** Do It Now (green), Park for Later (blue), Deprioritise (grey), Discard (red)
- **Tool:** XML with four colored background rectangles, axis lines, item nodes positioned by score

### Design Thinking Process
- **Diagram:** Five-stage horizontal flow (Empathise → Define → Ideate → Prototype → Test)
- **Tool:** Mermaid `graph LR` or XML pipeline

---

## 4. Prescriptive Analysis

### Task Analysis Framework
- **Diagram:** Timeline matrix (Before / Beginning / During / After) × Functions
- **Tool:** XML swimlane with task cards in phase columns

### Sideswimming Chart
- **Diagram:** Swimlane visualization organizing tasks across functional lanes by phase
- **Tool:** XML horizontal swimlanes with task nodes and dependency arrows

### Sub-Goal Decomposition
- **Diagram:** Hierarchical tree breaking complex goals into sub-goals and tasks
- **Tool:** Mermaid `graph TD` tree

### String of Pearls
- **Diagram:** Sequential numbered circles (pearls) connected by lines, color-coded by phase
- **Tool:** XML horizontal chain of circles with connecting edges

### Spiderweb Chart (String of Pearls detail)
- **Diagram:** Central node with radiating spokes — Assumptions (boxes), Dependencies (diamonds), 2nd/3rd-order effects (triangles)
- **Tool:** XML radial layout from central node

### Risk Criticality Matrix
- **Diagram:** Annotated string of pearls with R/F risk flags and color severity
- **Tool:** XML pearl chain with risk badge annotations

### N-Order Effects Analysis
- **Diagram:** Cascading tree showing 1st, 2nd, 3rd-order effects branching from trigger event
- **Tool:** Mermaid `graph TD` multi-level tree with color-coding by order

### Course of Action (CoA) Analysis Suite
Includes: Mission Analysis, Operating Environment, Adversary Matrix, Success Criteria, Intelligence Requirements (5W1H/Starbursting), CoA Phasing, CoA Comparative Matrix

- **Diagram (CoA Comparison):** Multi-column table with RAG rating, or radar-like scored bars
- **Tool:** XML comparison table or horizontal bar segments per criterion

### Mission Analysis Framework
- **Diagram:** Structured Q&A matrix (Objective, Intent, Consequences, Risks, Assumptions)
- **Tool:** XML table or Mermaid flowchart

### Adversary Identification & Analysis Matrix
- **Diagram:** Table with adversary columns vs. Capability/Requirement rows
- **Tool:** XML table layout

### 5W1H / Starbursting
- **Diagram:** Central topic with six radiating branches (Who, What, Where, When, Why, How)
- **Tool:** XML hub-and-spoke or Mermaid `graph TD` from center

### Collection Strategy / Collection Planning
- **Diagram:** Table mapping information needs to collection disciplines, methods, timing, responsible persons
- **Tool:** XML table or CSV

### Issue Mapping
- **Diagram:** Network diagram linking issues to causes, stakeholders, and impacts
- **Tool:** XML network or Mermaid `graph TD`

### Concept Mapping
- **Diagram:** Network of labeled concepts connected by relationship arrows
- **Tool:** XML nodes and edges or Mermaid `graph TD`

### If/Then Analysis (Cross-Impact Matrix)
- **Diagram:** Scenario matrix — Risk Scenario | Reaction | Risks of Action | Risks of Inaction
- **Tool:** XML table with expandable N-order rows

### Adversary Action-Reaction Wargaming
- **Diagram:** Alternating move/countermove timeline (Our Action → Their Reaction → Our Action...)
- **Tool:** XML alternating left/right timeline cards, color-coded by side

### Critical Path Analysis
- **Diagram:** PERT network — nodes (events) + arrows (activities) with critical path highlighted in red
- **Tool:** XML DAG layout with colored critical path, or Mermaid `graph LR`

### Pre-Mortem Analysis
- **Diagram:** Hub-and-spoke failure causation — central "FAILURE" node with radiating failure modes
- **Tool:** XML radial layout with severity-colored spokes

---

## 5. Challenge Analysis

### Structured Self-Critique
- **Diagram:** Checklist-based confidence assessment with scoring
- **Tool:** XML checklist layout with progress bars

### Argument Mapping
- **Diagram:** Hierarchical tree — central hypothesis with supporting (blue) and contradicting (red) evidence branches
- **Tool:** Mermaid `graph TD` with class coloring, or XML tree

### Four Ways of Seeing
- **Diagram:** 2×2 matrix (expandable to N×N) — How Actor A/B view themselves and each other
- **Tool:** XML four-cell grid with perspective labels

### Red Teaming Process
- **Diagram:** Three-column parallel process flow (Diagnostic → Creative → Challenge) with technique cards in each phase
- **Tool:** XML three-column layout or Mermaid subgraphs

### Key Assumptions Check
- **Diagram:** Table listing assumptions, evidence for/against, confidence level, and action if wrong
- **Tool:** XML table with RAG-colored confidence cells

### Quality of Data and Sources Check
- **Diagram:** Source evaluation matrix — Source × Reliability × Credibility × Timeliness
- **Tool:** XML table with scored cells

### Deception Check
- **Diagram:** Decision tree — indicators of deception branching to likelihood assessment
- **Tool:** Mermaid `graph TD` decision tree

### Outside-in Thinking
- **Diagram:** Concentric rings — external perspective layers looking inward at the problem
- **Tool:** XML concentric shapes or onion diagram

### Alternative Futures Analysis
- **Diagram:** Branching scenario tree — present branching into multiple future pathways with probability labels
- **Tool:** Mermaid `graph LR` or XML tree branching right

### What If Analysis
- **Diagram:** Decision tree with conditional branches and outcome nodes
- **Tool:** Mermaid `graph TD` with diamond decision nodes

### Indicators of Change
- **Diagram:** Timeline with indicator markers and threshold lines
- **Tool:** XML timeline with flag/marker annotations

### Analysis of Competing Hypotheses (ACH)
- **Diagram:** Matrix — Hypotheses (columns) × Evidence (rows), cells marked Consistent (C), Inconsistent (I), or Not Applicable (N/A), color-coded
- **Tool:** XML table with green (C), red (I), grey (N/A) cells

### High Impact / Low Probability Analysis
- **Diagram:** 2×2 matrix — Impact (Y) × Probability (X), with items plotted; focus quadrant is high-impact/low-probability
- **Tool:** XML quadrant diagram similar to Prioritisation Map

### War Gaming
- **Diagram:** Multi-turn action-reaction sequence with branching decision points
- **Tool:** Mermaid `graph TD` or XML alternating timeline

### Team A / Team B
- **Diagram:** Side-by-side argument comparison with jury evaluation panel
- **Tool:** XML split layout — left (Team A), right (Team B), center (Jury verdict)

### Devil's Advocacy (5Cs + CATUR)
- **5Cs:** Coherence, Completeness, Compliance, Consistency, Correctness
- **CATUR:** Complexity, Ambiguity, Tension, Uncertainty, Risk
- **Diagram:** Horizontal bar scorecard — one bar per dimension, grouped by framework, color-coded by score
- **Tool:** XML horizontal bars with labels and score fills

### Six Thinking Hats
- **Diagram:** Six colored sections (White=facts, Red=emotions, Black=risks, Yellow=benefits, Green=creativity, Blue=process)
- **Tool:** XML six-segment layout or circular arrangement with hat-colored nodes

---

## 6. Opportunity Analysis

### OS3 Model (Opportunity Seeking / Screening / Seizing)
- **Diagram:** Three-phase funnel or pipeline flow
- **Tool:** Mermaid `graph LR` three-stage flow or XML funnel

### Mind Frame / Heart Flame / Gut Game
- **Diagram:** Three-column layout (blue=Mind, red=Heart, amber=Gut) with convergence section at bottom
- **Tool:** XML three-column with convergence box and arrows

### Finding Opportunities Grid
- **Diagram:** 2×4 grid with eight opportunity sources (Customer Needs, Environment, Trends, Technology, Process, Public Interest, Learning, Experience)
- **Tool:** XML eight-cell grid

### Opportunity Matrix (Ansoff Variant)
- **Diagram:** 2×2 matrix — Existing/New Resources × Existing/New Policies
- **Quadrants:** Policy Optimization, Product/Service Development, New Policy Development, Diversification
- **Tool:** XML four-quadrant grid with strategy labels

### 12R Model (Opportunity Screening)
- **Diagram:** Spider/radar-like layout with 12 dimensions scored — or horizontal bar scorecard
- **Tool:** XML 12 horizontal bars with score fills and labels

### Constraints-Based Ideation (CBI)
- **Diagram:** Ranked constraint-impact matrix (Constraint | Impact | How to Overcome | Feasible Actions)
- **Tool:** XML table ranked by importance

### Obstacles and Objections Matrix
- **Diagram:** Five-column table (Opportunity | Obstacles | Overcome | Objections | Counter)
- **Tool:** XML table or CSV

### Nominal Group Technique
- **Diagram:** Process flow — Individual Brainstorm → Round-Robin Sharing → Discussion → Voting → Ranking
- **Tool:** Mermaid `graph LR` five-step flow

### Opportunity Viability Assessment
- **Diagram:** Scatter plot — Feasibility (X) × Innovation Potential (Y) with items plotted
- **Tool:** XML positioned nodes on axes

---

## 7. Perception & Mindsets

### Signal Detection Framework
- **Diagram:** 2×2 contingency matrix (True Positive / False Positive / True Negative / False Negative)
- **Tool:** XML four-cell grid

### Perceptual Thresholds (Absolute / Difference)
- **Diagram:** Scale/gauge diagram showing threshold markers on a sensitivity continuum
- **Tool:** XML horizontal scale with threshold markers

### Top-Down vs Bottom-Up Processing
- **Diagram:** Two parallel vertical flows — inverted pyramid (top-down) and standard pyramid (bottom-up)
- **Tool:** XML two pyramids side-by-side

### Piaget's Learning Cycle
- **Diagram:** Four-stage circular flow (Assimilation → Equilibrium → Disequilibrium → Accommodation)
- **Tool:** XML four nodes in circle with curved arrows, or Mermaid cycle

### Schema Analysis (Strengths / Hindrances / Poor Schema Types)
- **Diagram:** Two-column comparison (Strengths vs. Hindrances) with poor-schema examples branching below
- **Tool:** XML split layout with sub-tree

### System 1 vs System 2 Thinking
- **Diagram:** Two-column comparison with 13+ characteristics
- **Tool:** XML two-column table

### Situation-Cues-Patterns-Actions Model
- **Diagram:** Four-node circular flow
- **Tool:** XML circular layout or Mermaid cycle

### Recognition-Primed Decision Model
- **Diagram:** Flowchart — Situation → Pattern Recognition → Mental Simulation → Action (with feedback loop)
- **Tool:** Mermaid `graph TD` or XML flow

### Decision Requirements Table
- **Diagram:** Multi-column table (Decision Type, Difficulty, Common Errors, Expert/Novice Differences)
- **Tool:** XML table or CSV

### Fishbone Diagram (Ishikawa)
- **Diagram:** Central spine (effect) with angled branches for cause categories, sub-causes branching off each
- **Tool:** XML — central horizontal line with angled cause branches

### Causal Factor Trees
- **Diagram:** Hierarchical tree organizing causal factors from effect down to root causes
- **Tool:** Mermaid `graph TD` tree

### Futures Wheel
- **Diagram:** Central event with radiating rings of 1st, 2nd, 3rd-order consequences
- **Tool:** XML concentric rings with consequence nodes at each level

### Root Cause Analysis
- **Diagram:** Cascading tree or fishbone tracing symptoms to root causes
- **Tool:** Mermaid `graph TD` or XML fishbone

### Blindspot Analysis
- **Diagram:** Assumption dependency network — nodes for assumptions/opinions with connecting edges showing dependencies, highlighting vulnerable nodes
- **Tool:** XML network diagram

### Reframing Exercises
- **Diagram:** Central situation with radiating alternative frames/perspectives
- **Tool:** XML hub-and-spoke with perspective labels

### Six Thinking Hats
- **Diagram:** Six colored sections — White (facts), Red (emotions), Black (risks), Yellow (benefits), Green (creativity), Blue (process)
- **Tool:** XML six-segment circular or grid layout

### After-Action Review
- **Diagram:** Four-quadrant board (What was expected / What happened / What went well / What to improve)
- **Tool:** XML four-quadrant grid

### Post-mortem Analysis
- **Diagram:** Timeline flow — Event → What happened → Root causes → Lessons → Actions
- **Tool:** Mermaid `graph LR` or XML timeline

### Impact Analysis
- **Diagram:** Stakeholder × Impact matrix with severity coloring
- **Tool:** XML table with RAG cells

### Key Assumptions Check
- **Diagram:** Table — Assumption | Evidence For | Evidence Against | Confidence | Impact if Wrong
- **Tool:** XML table with colored confidence cells

---

## 8. Bias Management

### Cognitive Bias Catalog (30+ biases)
- **Categories:** Probability Assessment, Decision Making, Social, Memory, Expertise/Knowledge
- **Diagram:** Categorized grid or sunburst — bias cards grouped by category
- **Tool:** XML grouped rectangles by category with color-coded headers

### Prospect Theory / Loss Aversion
- **Diagram:** S-curve value function showing asymmetric losses vs gains
- **Tool:** XML custom curve using points, or descriptive diagram with labeled regions

### Temporal Discounting
- **Diagram:** Discount curve — value declining over time horizon (SSR vs LLR comparison)
- **Tool:** XML curve diagram or labeled timeline

### Blindspots Analysis / Assumption Analysis
- **Diagram:** Assumption dependency map — network of assumptions with vulnerability flags
- **Tool:** XML network diagram with colored risk nodes

### Decision Blindspots
- **Diagram:** Structured inquiry table — Decision | Blindspot | Impact | Mitigation
- **Tool:** XML table

### Framestorming (3-step process)
- **Diagram:** Three-phase flow (Calibration → Framestorm → Study Results) with perspective outputs
- **Tool:** Mermaid `graph LR` three-stage flow with sub-items

### Episodic Future Thinking / Episodic Future Simulation
- **Diagram:** Timeline projecting from present into future with event markers and probability annotations
- **Tool:** XML timeline with future-state markers

### Information Avoidance / Ostrich Effect
- **Diagram:** Decision tree — Information Available → Seek vs. Avoid → Consequences of each path
- **Tool:** Mermaid `graph TD` decision tree

### Action Bias
- **Diagram:** 2×2 matrix — Act vs. Don't Act × Situation Warrants Action vs. Doesn't
- **Tool:** XML four-cell grid

### Scarcity vs Abundance Mindset
- **Diagram:** Two-column comparison showing behaviors, decisions, and outcomes for each mindset
- **Tool:** XML split layout

---

## 9. Organizational Analysis

### Five Architectures Framework
- **Diagram:** Five interconnected domains (Organisational, Operational, Informational, Technological, Cognitive)
- **Tool:** XML pentagon or five-node network

### Persistent Uncertainty Framework
- **Diagram:** Eight types of uncertainty arranged as a wheel or categorized grid (Environmental, Issue, Task, Process, Outcome, Informational, Analytic, Decision)
- **Tool:** XML eight-segment wheel or grid

### Six Deficits Model
- **Diagram:** Six capability gaps as a bar chart or hexagonal layout (Resources, Interest, Initiative, Knowledge, Influence, Leadership)
- **Tool:** XML six bars or hexagonal arrangement

### Burke-Litwin Model
- **Diagram:** 12-element interconnected network showing organizational influence relationships
- **Tool:** XML network of labeled nodes with connecting lines

### Leavitt's Diamond
- **Diagram:** Diamond shape — Structure, Process, People, Technology at vertices with bidirectional arrows
- **Tool:** XML four-node diamond

### Weisbord's Six Box Model
- **Diagram:** Six-box grid (Purpose, Structure, Relationships, Leadership, Rewards, Helpful Mechanisms) within Environment boundary
- **Tool:** XML six boxes inside container rectangle

### McKinsey 7S Framework
- **Diagram:** Star/wheel with Shared Values at center and 6 surrounding elements (Strategy, Structure, Systems, Style, Staff, Skills)
- **Hard elements:** Strategy, Structure, Systems
- **Soft elements:** Style, Staff, Skills, Shared Values
- **Tool:** XML radial layout

### Johnson's Cultural Web
- **Diagram:** Web with central Paradigm and 6 surrounding elements (Stories, Rituals, Symbols, Power Structures, Control Systems, Organisational Structures)
- **Tool:** XML central node with six connected elements

### The 4Ps of Culture
- **Diagram:** Four connected elements (Purpose → Policy → Practice → People) in circular flow or diamond
- **Tool:** Mermaid cycle or XML four-node flow

### Cultural Subcultures Framework
- **Diagram:** Five-segment model (Reporting, Just, Flexible, Learning, Mindful cultures)
- **Tool:** XML five-segment layout or pentagon

### Five Whys / Root Cause Analysis
- **Diagram:** Cascading vertical tree — each "Why?" branches deeper to root cause
- **Tool:** Mermaid `graph TD` five-level tree

### After Action Review
- **Diagram:** Four-quadrant board (Expected / Actual / Lessons / Actions)
- **Tool:** XML four-quadrant grid

### Inputs-Process-Outputs Model
- **Diagram:** Three-stage horizontal flow with feedback arrow from Output back to Input
- **Tool:** Mermaid `graph LR` with feedback edge

### Churchill's Audit
- **Diagram:** Structured questioning framework — What do we know? What don't we know? What do we need to know? How do we find out?
- **Tool:** XML four-box flow or Mermaid `graph TD`

### Reflexive Practice (Reflection-on-Action / Reflection-in-Action)
- **Diagram:** Circular learning cycle — Experience → Observe & Reflect → Conceptualise → Active Experimentation → back to Experience
- **Tool:** XML circular flow or Mermaid cycle

### The Consulting Process (9 phases)
- **Diagram:** Nine-step sequential flow (Entry → Identifying Problems → Gathering Info → Identifying Solutions → Planning → Implementing → Managing Issues → Evaluation → Termination)
- **Tool:** Mermaid `graph LR` nine-step flow

### Process Analysis / Bottleneck Analysis
- **Diagram:** PERT/flow network with bottleneck highlighting and waste annotations
- **Tool:** XML DAG layout with colored critical nodes

### Waste Category Framework (8 types)
- **Diagram:** Eight waste categories (Overprocessing, Transportation, Motion, Inventory, Waiting, Defects, Overproduction + Underutilised Talent)
- **Tool:** XML eight-cell grid or circular arrangement

### Process Variability Classification
- **Diagram:** Two-branch tree — Customer-Introduced (Request, Preference, Effort) vs. Process (Design, Employee Ability, Equipment)
- **Tool:** Mermaid `graph TD` two-branch tree
