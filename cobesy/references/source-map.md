# Source Map

COBESY compiles nine source works into a three-layer stack. This file records
the bibliography, where each work plugs in, and the substitutions made relative
to the original framework spec.

## Bibliography → layer

| Layer | Work | Author | Role in COBESY |
|---|---|---|---|
| Systemic | *Organizational Culture and Leadership* | Edgar Schein | Three levels of culture; diagnose basic underlying assumptions |
| Systemic | *The Fearless Organization* | Amy Edmondson | Psychological safety × accountability 2×2; failure types |
| Systemic | (Scientist Mode) | Adam Grant | Falsifiability; ban prosecutor/politician; disproof conditions |
| Behavioral | *How Behavior Spreads* | Damon Centola | Simple vs complex contagion; wide bridges; clustered seeding |
| Behavioral | *The Human Network* | Matthew Jackson | Centrality types; eigenvector anchors; diffusion |
| Behavioral | *The Catalyst* | Jonah Berger | REDUCE; remove barriers; reactance |
| Behavioral | (Sequential cascades) | Easley & Kleinberg | Order choices; positive information cascades |
| Cognitive | *The Pyramid Principle* | Barbara Minto | Top-down MECE pyramid; SCQA |
| Cognitive | *Design for How People Learn* | Julie Dirksen | Cognitive load; Elephant/Rider; gap types |
| Cognitive | *The Adult Learner* | Malcolm Knowles | Andragogy; six assumptions about adults |
| Facilitation | *Gamestorming* | Gray, Brown & Macanufo | Open/explore/close games for live sessions |

## Notebook sources (COBESY NotebookLM, 9 sources)

Dirksen · Gray (Gamestorming) · Centola · Schein · Knowles · Berger · Edmondson ·
Minto · Jackson. All layer content in this skill was synthesized from
source-grounded queries against these works.

## Substitutions vs the original spec

The original framework topology named **Heath & Heath** (stickiness), **Grant**
(hypothesis), and **Easley & Kleinberg** (cascades) as explicit nodes. The
working notebook instead carried **Berger**, **Knowles**, and **Gamestorming**.
COBESY maps them as follows:

| Spec node | Realized as | Rationale |
|---|---|---|
| Heath & Heath — stickiness / resistance | **Berger REDUCE** | Both address why a message fails to land; REDUCE adds the barrier-removal mechanics. |
| Grant — Scientist Mode / hypothesis | **Folded into Edmondson** (Systemic) | Falsifiability is a safety/accountability practice; kept as the disproof condition. |
| Easley & Kleinberg — cascades | **Described inside the Behavioral layer** | Sequential cascade modeling is a routing tactic alongside Centola/Jackson. |
| (added) Knowles — andragogy | **Cognitive layer** | Adult-learner psychology sharpens the cognitive interface for senior/expert audiences. |
| (added) Gamestorming | **Facilitation reference** | Provides the live-session execution layer the spec implied but didn't name. |

## Three-artifact mapping (quick reference)

- `framing_protocol` ← Systemic (Schein + Edmondson + Scientist Mode)
- `agenda_structure` ← Cognitive (Minto + Dirksen + Knowles)
- `target_nodes` ← Behavioral (Centola + Jackson + Berger + cascades)
