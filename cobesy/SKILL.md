---
name: cobesy
version: 1.0.0
description: >
  COBESY (Cognitive Behavioral Systemic) turns an AI agent into a compiler that
  translates static knowledge (docs, repos, architecture, decks) into active
  organizational skill (adoption, agendas, buy-in). It runs a three-layer stack:
  a SYSTEMIC base (Schein deep assumptions, Edmondson psychological safety,
  Scientist-Mode falsifiability), a BEHAVIORAL vector (Centola complex contagion,
  Jackson network centrality, Berger REDUCE, sequential cascades), and a
  COGNITIVE interface (Minto Pyramid, Dirksen cognitive load, Knowles andragogy),
  plus Gamestorming exercises for live sessions. Use when asked to drive
  adoption, roll out a tool or process, get buy-in, run change management, design
  a meeting agenda or briefing, overcome resistance, make an idea stick, onboard
  a team, or turn a knowledge asset into something an organization will actually
  use. Emits a culturally-safe framing protocol, a cognitively-compressed
  agenda/brief, and a behavioral adoption plan. Not for pure factual lookup or
  single-fact Q&A.
---

# COBESY: Cognitive Behavioral Systemic

COBESY makes the AI agent the **compiler** between *static knowledge* and *active
organizational skill*. A document does not change an organization. Behavior
spreading through a network does. COBESY is the engine that translates the
former into the latter.

> **Static knowledge → COBESY compiler → operational skill**
> (Docs, repos, architecture) → (layered stack engine) → (adoption, agendas, buy-in)

This skill bypasses legacy facilitation (chronological agendas, all-hands
broadcasts, icebreakers, political persuasion). It replaces them with an
algorithmic stack grounded in nine source works on culture, networks, learning,
and influence. See `references/source-map.md` for the full bibliography and the
substitutions made.

---

## The execution stack

Read **top-down** (what the audience touches) but **compile bottom-up** (what
governs whether anything sticks):

```
┌──────────────────────────────────────────────────────────────┐
│  3. COGNITIVE INTERFACE   Minto · Dirksen · Knowles            │  ← what they see
│     (compress knowledge to fit working memory + adult learners)│
└───────────────────────────────┬──────────────────────────────┘
                                ▼
┌──────────────────────────────────────────────────────────────┐
│            THE COBESY COMPILER  (this agent)                  │
│     translates compressed hierarchies into execution skill     │
└───────────────────────────────┬──────────────────────────────┘
                                ▼
┌──────────────────────────────────────────────────────────────┐
│  2. BEHAVIORAL VECTOR   Centola · Jackson · Berger · cascades  │  ← how it spreads
│     (engineer the transmission path for voluntary adoption)    │
└───────────────────────────────┬──────────────────────────────┘
                                ▼
┌──────────────────────────────────────────────────────────────┐
│  1. SYSTEMIC BASE   Schein · Edmondson · Scientist Mode        │  ← whether it survives
│     (map + neutralize the hidden rules of the organization)    │
└──────────────────────────────────────────────────────────────┘
```

**Run order: Systemic → Cognitive → Behavioral → Assemble → Validate.**
You diagnose the ground (systemic) before you compress the message (cognitive)
before you route it through people (behavioral). The cognitive layer sits at the
top of the *stack the audience experiences*, but it is compiled second, because
content that ignores the culture gets rejected regardless of how clear it is.

---

## The three compiler inputs

Map every engagement to these three inputs. If one is missing, ask for it or
infer it explicitly in Phase 0.

| Input | Question it answers | Feeds layer | Output artifact |
|---|---|---|---|
| `raw_knowledge` | *What* are we transferring? (docs, repo, decision, tool) | Cognitive | `agenda_structure` |
| `cultural_assumptions` | *Where* are we landing it? (hidden rules, safety level) | Systemic | `framing_protocol` |
| `network_topology` | *Through whom* does it spread? (anchors, clusters) | Behavioral | `target_nodes` |

The compiler contract (the Python `AISkillCompiler` mental model) and the
legacy-vs-COBESY comparison live in `references/compiler.md`.

---

## When to use / when not

**Use** when the goal is to make an organization *do* something with knowledge:
roll out a tool/process, get buy-in, design an agenda or briefing, overcome
resistance, make something stick, onboard a team, plan a change.

**Do not load** for pure factual lookup, a single-fact answer, or a task with no
human-adoption dimension. COBESY is overhead if nobody needs to be moved.

---

## The COMPILE workflow

### Phase 0 — Intake
Gather the three inputs. Then state, in one line each:
- **Target behavior**: the specific action you want a named group to take (not "awareness" — an action).
- **One hidden assumption** you suspect governs this group (Schein).
- **One high-leverage anchor** whose adoption would pull others (Jackson).

If you cannot name the target behavior as an observable action, stop and fix
that first. Use `assets/diagnostic-intake.md`.

### Phase 1 — Systemic filter (the ground)
Run the audience through `references/01-systemic-layer.md`.
- Map artifacts → espoused values → **basic underlying assumption** (Schein).
- Locate the org on the Edmondson safety × accountability 2×2.
- Produce a **framing_protocol**: how to frame this work as a learning problem,
  what to *not* say, and an explicit **disproof condition** ("we are wrong if ___").
- **Gate:** if the org sits in the Anxiety quadrant (low safety / high
  accountability), raise safety *before* pushing content. Do not skip.

### Phase 2 — Cognitive compression (the message)
Run `raw_knowledge` through `references/03-cognitive-layer.md`.
- Build a **Minto pyramid**: lead with the conclusion, group support MECE, open
  with SCQA.
- Cut to working-memory limits and talk to the Elephant, not just the Rider (Dirksen).
- If the audience is senior/expert, apply Knowles andragogy (respect experience,
  problem-centered, self-direction).
- Produce **agenda_structure**: a top-down hierarchy, not a chronological list.

### Phase 3 — Behavioral sequencing (the path)
Run the rollout through `references/02-behavioral-layer.md`.
- Classify the change: simple contagion (info) or **complex contagion** (costly
  behavior change)? Most adoptions are complex → need **wide bridges**, not broadcasts.
- Pick targets by centrality (Jackson): eigenvector anchors for cascades.
- Design **clustered seeding** (Centola): adjacent trusted team adopts first.
- Remove barriers with **REDUCE** (Berger) instead of pushing harder.
- Sequence respected, objective voices first to start a positive cascade.
- Produce **target_nodes**: who adopts in what order, through which clusters.

### Phase 4 — Assemble & facilitate
Emit the three artifacts (`framing_protocol`, `agenda_structure`, `target_nodes`)
into the relevant templates in `assets/`. If a live session is needed, pick
exercises from `references/facilitation-games.md` (Gamestorming), respecting the
open→explore→close shape. Hand the user the matching prompts from
`assets/prompt-library.md`.

### Phase 5 — Validate (anti-cringe gate)
Before delivery, run every artifact through the validation gate in
`references/compiler.md`:

| Check | Layer | Fail action |
|---|---|---|
| MECE? | Cognitive | Regroup the pyramid |
| Within working memory? | Cognitive | Chunk / add job aid |
| Safe enough to say? | Systemic | Reframe / raise safety first |
| Disproof condition stated? | Systemic | Add falsifiability or reject item |
| Cascade, not broadcast? | Behavioral | Re-sequence through clusters |
| Removes barriers vs pushes? | Behavioral | Switch to REDUCE |

If any check fails, return to that layer. Do not ship around a failed gate.

---

## Decision points

- **Simple vs complex contagion** → broadcast is fine *only* for simple info;
  anything costly/risky/identity-relevant needs clustered wide bridges.
- **Low psychological safety** → systemic layer first; content is wasted in the
  Anxiety quadrant.
- **High resistance / reactance** → switch from persuasion to Berger's REDUCE
  (remove the barrier; pushing harder backfires).
- **Senior or expert audience** → lead with Knowles (their experience is the
  curriculum; never treat them as empty vessels).

---

## Cross-skill interconnection

COBESY is the **adoption engine** of this skill set: it takes a knowledge asset
or decision and makes an organization act on it. It is not a draw.io renderer, so
it hands its analysis *out* to the visualization skills and pulls verified inputs
*in* from the analysis skills. Keep actor, cluster, and assumption names stable
across skills so the artifacts line up. Map each handoff to a COMPILE phase:

| Sibling skill | Direction | Phase | What flows |
|---|---|---|---|
| `reflect` | in | Phase 0 | Turn a vague "drive adoption of X" request into a clear prompt with the three compiler inputs before COMPILE starts. |
| `strategic-foresight-viz` | in | Phase 0–2 | Import PESTLE drivers / scenarios as the **Complication** in the SCQA opener — the external reason the change is needed now. |
| `intana-viz` | both | Phase 1–3 | Render the diagnostics: Schein **Cultural Web**, Edmondson 2×2, **stakeholder / network maps**, the Minto agenda pyramid, the adoption map. Route a contested `framing_protocol` assumption through **Key Assumptions Check, Red Teaming, or Pre-Mortem** and bring the verified version back. |
| `premortem` | both | Phase 3–5 | Stress-test the assembled `target_nodes` rollout: assume the adoption failed, reason backward, then feed the failure modes back into **REDUCE barriers** and the framing protocol. The Phase 5 anti-cringe gate is a lighter inline version of this. |
| `game-theory-negotiation` | both | Phase 3 | When buy-in needs a bargain (resourcing, mandate, an anchor's commitment), hand the named **eigenvector anchor** and the incentive question to the negotiation skill; bring back a concession plan and incentive-compatible **profit-share / bonus sizing** for the adoption design. |
| `humanizer` | out | Phase 4 | Clean the emitted brief/agenda so the deliverable reads human, not AI-generated — the writing-level companion to COBESY's structural anti-cringe gate. |

Rule of thumb: **analysis skills verify the inputs, viz skills draw the
artifacts, COBESY sequences the adoption.** A premortem surfaces a barrier →
COBESY routes around it; a negotiation secures an anchor → COBESY seeds from it;
intana-viz renders the cultural map → COBESY frames against it.

**Use the shared context packet.** The sibling skills pass a common packet with
stable IDs (`A1 buyer`, `S2 recession case`, …) so artifacts cross-reference —
see `game-theory-negotiation/references/drawio-concepts.md`. COBESY reads and
writes the same fields rather than inventing parallel names:

| Packet field | COBESY role |
|---|---|
| **Assumptions** | COBESY is a primary producer — Schein basic underlying assumptions become packet `Assumptions`; route contested ones through `intana-viz` to verify. |
| **Actors** | COBESY annotates `Actors` with network role: eigenvector anchor, bridge, seed cluster. Keep actor IDs identical to the negotiation/investigation diagrams. |
| **Scenarios** | Consumed from `strategic-foresight-viz` as the SCQA **Complication**. |
| **Constraints** | The framing protocol's "safe to say" limits and disproof conditions are cultural `Constraints`. |
| **Open questions** | Each disproof condition ("we are wrong if ___") is an `Open question` other skills can pick up. |

---

## Files

**References (load as needed):**
- `references/compiler.md` — the compiler contract, I/O, legacy-vs-COBESY, validation gate.
- `references/01-systemic-layer.md` — Schein, Edmondson, Scientist Mode → `framing_protocol`.
- `references/02-behavioral-layer.md` — Centola, Jackson, Berger, cascades → `target_nodes`.
- `references/03-cognitive-layer.md` — Minto, Dirksen, Knowles → `agenda_structure`.
- `references/facilitation-games.md` — Gamestorming exercises per phase.
- `references/source-map.md` — bibliography, layer mapping, substitutions.

**Templates (fill and deliver):**
- `assets/diagnostic-intake.md` — Phase 0 intake.
- `assets/change-brief.md` — the assembled three-artifact deliverable.
- `assets/agenda-pyramid.md` — Minto agenda skeleton.
- `assets/adoption-map.md` — Centola/Jackson rollout plan.
- `assets/prompt-library.md` — ready prompts to drive the agent per layer.
