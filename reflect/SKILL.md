---
name: reflect
version: 1.1.0
description: "Take a user's raw request and harden it into a well-formed prompt using the ReFLECT framework (Role, Format, Language, Example, Context, Task) before acting on it. Question the user for any missing high-priority elements — always for a missing Task, and for absent Context or Example — then proceed once they answer or pick. Use when the user says 'reflect this', 'apply ReFLECT', 'turn this into a good prompt', 'engineer this prompt', or hands over a vague request they want sharpened before it runs. Skip when the request is already complete and unambiguous — just do the work."
---

# ReFLECT

ReFLECT is Gartner's prompt-engineering framework. It treats a prompt as a **first-class artifact** rather than a casual instruction. It is a tiered checklist for constructing a prompt: the **Task** is mandatory, **Context** and **Example** materially improve output quality, and **Role / Format / Language** refine it. This skill reads whatever the user asked for, maps it onto those six elements, asks only for the high-value pieces that are missing, and then runs the completed prompt.

The reason it matters: an underspecified prompt produces plausible-but-wrong output that looks finished. Catching the gap *before* generation — especially a missing Task or absent grounding Context — is cheaper than regenerating after a bad result.

---

## The framework

| Element | Description | Priority |
| ------- | ----------- | -------- |
| **R**ole | The persona of the AI, or the audience it writes for. | Nice to have |
| **F**ormat | Desired response structure (list, table, doc, JSON, code). | Nice to have |
| **L**anguage | Voice, tone, reading level, writing style. | Nice to have |
| **E**xample | A short sample of the desired output shape. | Important |
| **C**ontext | The project, task background, and any private/proprietary facts the model can't know. | Important |
| **T**ask | The specific action expected. | **Must have** |

Three pillars sit underneath every element: **Clarity** (no wording that drifts from the objective), **Context** (everything needed to interpret the request), and **Constraints** (explicit boundaries and limits).

---

## When NOT to run it

- The request is already complete and unambiguous — just do the work, don't interrogate.
- The user wants a quick answer to a factual question — answer it.
- You're mid-task and the user gives a small follow-up correction — apply it directly.

Don't turn a 10-second ask into a questionnaire. ReFLECT is for requests substantial enough that a wrong interpretation wastes real effort.

---

## Phase 1 — Parse against the six elements

Read the user's request and silently map what's present onto Role, Format, Language, Example, Context, Task. Mark each as **present**, **inferable**, or **missing**.

**Infer before asking.** Scan what's already available — the conversation, attached files, `CLAUDE.md`, any `memory/` folder, the repo itself. If the Format is obvious from the request ("write a function" → code), don't ask. Spend ~30 seconds; an element you can reasonably infer is not missing.

---

## Phase 2 — Question the gaps

Ask **only** for high-value elements that are missing and not inferable, in this order of importance:

1. **Task (must have).** If you cannot state in one sentence what action is expected, you must ask. Everything else is secondary to this.
2. **Context (important).** If the request depends on a project, dataset, audience, or proprietary facts you don't have — and the model would otherwise fabricate them — ask. *Information-source awareness* is a core skill here: name what the model can't know and request it.
3. **Example (important).** If the output shape is non-obvious or the user clearly has a specific format in mind, ask for a short sample.

Use the `AskUserQuestion` tool when there are discrete choices to offer (e.g. format options, tone, depth), so the user can pick rather than type. Use plain prose for a single open-ended gap like a missing Task. Offer your best-guess default as a selectable option so the user can move fast.

Don't ask about **Role / Format / Language** unless they're genuinely load-bearing for this request — they're refinements, and over-questioning them is the failure mode that makes prompt authoring feel like a chore. Ask the minimum set; stop the moment the Task is clear and the important gaps are closed.

---

## Phase 3 — Assemble the hardened prompt

Once the user has answered or chosen, compose the completed prompt from the filled elements. Apply the technique that fits the task:

- **Zero-shot** — direct instruction, no example. Default for well-specified tasks.
- **Few-shot** — include the user's Example(s) to lock the output pattern.
- **Chain of thought** — ask for explicit step-by-step reasoning when the task involves multi-step logic.
- **Prompt chaining** — split into sequential steps where each builds on the last; good for stable, well-defined pipelines.
- **Prompt orchestration** — run multiple chains with branching logic; for variable logic and external interactions.

Echo the assembled prompt back to the user in a short, scannable block (the six elements as you resolved them) so they can confirm or correct before it runs. Keep this tight — it's a confirmation, not a report.

---

## Phase 4 — Execute

Run the hardened prompt and produce the actual deliverable. This is the point of the skill — don't stop at the well-formed prompt; carry it through to the result the user wanted.

---

## Phase 5 — Evaluate (optional, scales with stakes)

For high-stakes or repeated output, self-assess as a **calibrated LLM-as-a-judge** before delivering. Behave like a calibrated evaluator, not a casual reviewer: score against the rubric below, ignore style bias, and judge only against the resolved Task, Context, and Constraints — not your own preferences.

**Score each metric 1–5 against these anchors:**

| Metric | 1 (fail) | 3 (borderline) | 5 (pass) |
| ------ | -------- | -------------- | -------- |
| **Relevance** | Misses the query | Partly on-target, some drift | Directly answers the Task |
| **Accuracy / Faithfulness** | Contains hallucination or unsupported claims | Mostly supported, one weak claim | Every claim traceable to source |
| **Completeness** | Major aspects of the Task unaddressed | Covers the core, misses an edge | Covers all aspects of the Task |
| **Groundedness** | Fabricates beyond provided Context | Mixes grounded and invented detail | Relies only on provided Context |
| **Instruction following** | Ignores Format / Language / Constraints | Follows most, breaks one | Adheres to every constraint set |
| **Safety** | Harmful or offensive content | Borderline / needs a caveat | Clean |
| **Verbosity** | Padded or truncated | Slightly long or terse | Concise and complete |

**Pass threshold:** accept only when **Accuracy/Faithfulness ≥ 4**, **Safety = 5**, and **no metric scores below 3**. Anything else fails the gate.

**Map the scorecard to a risk decision:**

- **Accept** — threshold met.
- **Regenerate** — Relevance, Completeness, Instruction following, or Verbosity below 3 (a prompt-quality miss — tighten the ReFLECT elements and rerun).
- **Retrieve more context** — Groundedness or Accuracy below 4 because the model lacked information (a Context gap, not a reasoning error).
- **Escalate to the user** — scores conflict, the Task itself was ambiguous, or judgment is genuinely subjective.
- **Block** — Safety below 5.

**Calibrate the judge.** These anchors only mean something if your scoring matches a human's. When the skill is used repeatedly for the same kind of output, spot-check a few results against the user's own rating and adjust the anchors until they align — an uncalibrated judge drifts toward leniency. For one-off everyday tasks a light pass is enough; reserve the full scorecard for output that ships, repeats at scale, or carries real consequences.

---

## Operating notes

- **Task is non-negotiable.** Never proceed past Phase 2 without a one-sentence Task you could repeat back.
- **Infer aggressively, ask sparingly.** The skill's value is catching the *real* gap, not generating a form.
- **Name what the model can't know.** Knowledge recency and proprietary data are the two reliable blind spots — surface them as Context requests.
- **Echo before you execute.** A 5-line confirmation of the resolved elements costs little and prevents building on a misread.
- **Carry through to the deliverable.** The hardened prompt is the means; the answer is the end.

---

*Source: the ReFLECT framework is Gartner's. The tiering of elements (Task as must-have; Context and Example as important; Role/Format/Language as nice-to-have), the prompt-management and modular-prompting practices, and the LLM-as-a-judge evaluation model follow Gartner's prompt-engineering guidance.*
