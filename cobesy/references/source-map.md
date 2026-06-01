# Source Map

COBESY compiles nine source works into a three-layer stack, plus six writing
works that drive the Cognitive layer's composition back-end. This file records
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

## Composition back-end (Cognitive layer, six writing works)

These drive `references/composition.md` and emit `composition_blueprint`. COBESY
sorts them by grain, from the whole piece down to the sentence. That grain ladder
is this skill's adapter, not a named source framework.

| Grain | Work | Author | Role in COBESY |
|---|---|---|---|
| Macro | *Writing Your Journal Article in Twelve Weeks* | Wendy Laura Belcher | Single significant idea; argue don't report; post-outline; surface the structure |
| Macro | *The Pyramid Principle* | Barbara Minto | (shared with agenda back-end) top-down MECE hierarchy for prose |
| Opening | *Wired for Story* | Lisa Cron | Hook; protagonist / situation / stakes on the first screen |
| Opening | *Successful Writing at Work* | Philip C. Kolin | Four keys (audience, purpose, message, tone) + the action |
| Meso | *They Say / I Say* | Graff & Birkenstein | Paragraph as a move; they-say/I-say; the naysayer |
| Micro | *Several Short Sentences About Writing* | Verlyn Klinkenborg | Short sentences; cut the anxiety of sequence |
| Micro | *Style: Lessons in Clarity and Grace* | Williams & Bizup | Subjects=characters, verbs=actions, old-before-new cohesion |

## Notebook sources

Two NotebookLM notebooks back this skill.

**COBESY — between skills and knowledge systems** (9 sources): Dirksen ·
Gray (Gamestorming) · Centola · Schein · Knowles · Berger · Edmondson · Minto ·
Jackson. Drives the three-layer adoption stack.

**COBESY: Successful Writing and Technical Reporting for Change** (6 sources):
Cron · Klinkenborg · Graff & Birkenstein · Belcher · Kolin · Williams & Bizup.
Drives the composition back-end. All layer content was synthesized from
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

## Artifact mapping (quick reference)

- `framing_protocol` ← Systemic (Schein + Edmondson + Scientist Mode)
- `agenda_structure` ← Cognitive (Minto + Dirksen + Knowles)
- `target_nodes` ← Behavioral (Centola + Jackson + Berger + cascades)
- `composition_blueprint` ← Cognitive composition back-end (Belcher + Minto + Cron
  + Kolin + Graff & Birkenstein + Klinkenborg + Williams & Bizup)
