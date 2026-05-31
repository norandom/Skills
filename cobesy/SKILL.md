---
name: cobesy
version: 1.0.0
description: >
  COBESY (Cognitive Behavioral Systemic) turns an AI agent into a compiler that
  translates static knowledge (docs, repos, architecture, decks) into active
  organizational skill (adoption, agendas, buy-in). It runs a three-layer
  execution stack: a SYSTEMIC base (Schein deep assumptions, Edmondson
  psychological safety + accountability, Scientist-Mode falsifiability), a
  BEHAVIORAL vector (Centola complex contagion / wide bridges, Jackson network
  centrality, Berger REDUCE, sequential cascades), and a COGNITIVE interface
  (Minto Pyramid, Dirksen cognitive load, Knowles andragogy), with Gamestorming
  exercises to facilitate live. Use when asked to drive adoption, roll out a
  tool or process, get buy-in, run change management, design a meeting agenda or
  briefing, overcome resistance, make an idea stick, onboard a team, or convert
  a knowledge asset into something an organization will actually use. Emits three
  artifacts: a culturally-safe framing protocol, a cognitively-compressed
  agenda/brief, and a behavioral adoption plan. Does not fire on pure factual
  lookup or single-fact Q&A.
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
