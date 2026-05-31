# The COBESY Compiler

The agent is not a knowledge repository or a chatbot. It is an **algorithmic
translation layer** that sits between static knowledge assets and dynamic
operational execution.

```
┌──────────────────────┐   ┌────────────────────────┐   ┌─────────────────────┐
│   STATIC KNOWLEDGE   │ → │   THE COBESY COMPILER  │ → │  OPERATIONAL SKILL  │
│ docs · repos ·       │   │   (layered stack       │   │ adoption · agendas ·│
│ architecture · decks │   │    engine)             │   │ buy-in · onboarding │
└──────────────────────┘   └────────────────────────┘   └─────────────────────┘
```

## The contract (mental model)

```python
class AISkillCompiler:
    def __init__(self, raw_knowledge, network_topology, cultural_assumptions):
        self.knowledge = raw_knowledge          # → Cognitive layer
        self.network   = network_topology       # → Behavioral layer
        self.culture   = cultural_assumptions   # → Systemic layer

    def compile_output(self, target_domain, operational_use_case):
        # 1. Systemic filter — make it safe to say and falsifiable
        safe_framework     = self._apply_schein_edmondson(self.culture)
        # 2. Cognitive compression — make it fit working memory
        compressed_content = self._compress_minto_dirksen(self.knowledge)
        # 3. Behavioral sequencing — make it spread voluntarily
        adoption_path      = self._sequence_centola_cascade(self.network, target_domain)

        return {
            "framing_protocol":  safe_framework.get_scientist_mode_prompts(),
            "agenda_structure":  compressed_content.to_top_down_hierarchy(),
            "target_nodes":      adoption_path.get_high_eigenvector_anchors(),
        }
```

This is a *mental model*, not code to execute. Each private method maps to one
reference file. You, the agent, perform the compilation by reasoning through
those files.

## Input → layer → output (1:1 mapping)

| Compiler input | Layer / file | Emitted artifact |
|---|---|---|
| `cultural_assumptions` | Systemic · `01-systemic-layer.md` | `framing_protocol` |
| `raw_knowledge` | Cognitive · `03-cognitive-layer.md` | `agenda_structure` |
| `network_topology` | Behavioral · `02-behavioral-layer.md` | `target_nodes` |

## Why this order

Compile **Systemic → Cognitive → Behavioral**:

1. **Systemic first.** If the message violates a basic underlying assumption or
   lands in a low-safety quadrant, the organization's defense mechanism rejects
   it no matter how clear or well-routed it is. The systemic pass produces the
   constraints (what is safe to say, the disproof condition) that the other two
   layers must respect.
2. **Cognitive second.** Once you know what is safe, compress the knowledge so it
   survives working memory and speaks to adult learners.
3. **Behavioral third.** Only a clear, safe message is worth routing. Sequence it
   through clusters and anchors.

The audience *experiences* the stack top-down (they touch the cognitive
interface first), but you *build* it bottom-up.

## Legacy facilitation vs COBESY

| Use case | Legacy approach | COBESY execution |
|---|---|---|
| **Agenda building** | Chronological topic list → long discussion, low engagement. | Top-down Minto pyramid: the core decision leads; supporting items in a strict, MECE, network-validated sequence. |
| **Content evaluation** | Judged on style, brand, personal taste. | Audited against Dirksen working-memory limits and Minto MECE; flags density that would trigger cultural resistance. |
| **Leadership & buy-in** | Political persuasion, 1:1 hand-holding, generic change toolkits. | Maps network topology; drops dense content into wide-bridge clusters to automate adoption via structured social proof. |
| **Resistance** | Push harder, repeat the message, escalate. | REDUCE — find and remove the barrier; pushing triggers reactance. |
| **Kickoff** | Icebreaker. | Diagnostic-contrast prompt: analyze a past failure to surface the real survival rules. |

## The validation gate (anti-cringe)

Run every artifact through this before delivery. A failed check sends you back to
the named layer — never ship around it.

| Check | Question | Layer | Fail action |
|---|---|---|---|
| **MECE** | Are supporting points mutually exclusive and collectively exhaustive? | Cognitive | Regroup the pyramid. |
| **Load** | Does any single step exceed ~7±2 chunks of working memory? | Cognitive | Chunk; move detail to a job aid. |
| **Safety** | Is it safe to say this in this culture right now? | Systemic | Reframe; raise safety first. |
| **Disproof** | Does each proposal state what would prove it wrong? | Systemic | Add falsifiability or reject the item. |
| **Cascade** | Does this spread via clusters/anchors, not a broadcast? | Behavioral | Re-sequence through wide bridges. |
| **Reactance** | Does this remove a barrier rather than push? | Behavioral | Switch to REDUCE. |

## Anti-cringe replacements (defaults)

- Icebreakers → **diagnostic-contrast prompts** (analyze past project failures).
- All-hands broadcast → **clustered seeding** (adjacent trusted team first).
- "Here's why you should…" → **menu of options + tactical empathy** (Berger).
- Chronological agenda → **Minto pyramid** (conclusion first).
- "Any questions?" → **explicit disproof condition** ("we are wrong if ___").
- Persuading individuals → **wide bridges + eigenvector anchors**.
