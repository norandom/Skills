# Draw.io concepts for game-theoretic negotiation

Use a diagram when the negotiation is too tangled to hold in a list. The diagram should preserve the same actor names, claims, assumptions, and options used by the other skills so the work can move between foresight, investigation, intelligence analysis, and negotiation without losing context.

## Shared context packet

Carry this packet across skills:

| Field | What to capture | Usually produced by |
| --- | --- | --- |
| Actors | Parties, agents, approvers, hidden principals (cobesy adds network role: anchor, bridge, seed cluster) | game-theory-negotiation, investigation-theory, cobesy |
| Claims | What each party says is true | investigation-theory |
| Evidence | Proof, source, confidence, gaps | investigation-theory, intana-viz |
| Assumptions | Beliefs that drive the choice (cobesy: Schein basic underlying assumptions) | intana-viz, strategic-foresight-viz, cobesy |
| Scenarios | External futures that change payoffs | strategic-foresight-viz |
| Options | Offers, concessions, outside options | game-theory-negotiation |
| Payoffs | Money, risk, time, reputation, control | game-theory-negotiation |
| Constraints | Deadlines, authority, law, policy, technical limits (cobesy: cultural "safe to say" limits) | all skills |
| Open questions | Unknowns that change the next move (cobesy: disproof conditions) | investigation-theory, intana-viz, cobesy |

Use stable IDs when possible: `A1 buyer`, `A2 supplier`, `C3 demand forecast`, `S2 recession case`, `O4 staged rollout`. These IDs make separate draw.io diagrams easy to cross-reference.

## Diagram types

### 1. Player and incentive map

Use this when the main question is who wants what.

Best tool: Mermaid flowchart through draw.io.

Include:
- Actors and hidden principals.
- Stated goal and likely real incentive.
- BATNA, reservation price, and authority boundary.
- Conflicts, dependencies, and possible coalitions.

Handoff:
- Send disputed incentives to `investigation-theory` as claims to test.
- Send external drivers to `strategic-foresight-viz` as scenario inputs.

### 2. Information asymmetry map

Use this when not all parties are truthful, informed, or aligned.

Best tool: XML if you need a matrix; Mermaid if a simple flow is enough.

Include:
- Claim.
- Source.
- Evidence for and against.
- Who benefits if the claim is false.
- What would verify or falsify it.

Handoff:
- Route the evidence work to `investigation-theory`.
- Route competing explanations to `intana-viz` with ACH or Key Assumptions Check.

### 3. Sequential move tree

Use this when timing matters: offer, counter, no, concession, escalation, walk-away.

Best tool: Mermaid flowchart for editable draw.io trees.

Include:
- Decision nodes for each party.
- Chance nodes for uncertain events.
- Payoff notes at terminal outcomes.
- Information revealed at each step.

Handoff:
- Send uncertain external branches to `strategic-foresight-viz`.
- Send hostile or deceptive branches to `intana-viz` for Red Teaming.

### 4. Payoff matrix

Use this when each side has a small set of clear choices.

Best tool: XML table or a simple draw.io matrix.

Include:
- Choices for each party.
- Payoff pair in each cell.
- Risk-adjusted payoff when uncertainty matters.
- Dominated strategies and likely equilibrium.

Handoff:
- Use foresight scenarios to produce one payoff matrix per future.
- Use investigation findings to discount payoffs based on trust or deception risk.

### 5. Deal architecture map

Use this for multi-issue negotiations where value comes from trades, not just price.

Best tool: XML or Mermaid grouped flowchart.

Include:
- Price issue.
- Non-price terms from the virtual price list.
- Asymmetric values.
- Concession schedule.
- Late-add-on defenses.
- Verification points between handshake and signature.

Handoff:
- Send each non-price term with external uncertainty to `strategic-foresight-viz`.
- Send each unverifiable promise to `investigation-theory`.

## Cross-skill workflow

1. Start with the user's business question. Write it as a negotiation decision, not as a diagram request.
2. Build the shared context packet. If the packet lacks evidence, call `investigation-theory`. If it lacks future conditions, call `strategic-foresight-viz`. If it contains contested assumptions, call `intana-viz`.
3. Return to this skill to price the options, estimate BATNA/ZOPA, and choose the negotiation move.
4. Pick one diagram type from this file. Do not generate every possible view.
5. Render through draw.io. Use Mermaid for move trees and simple maps. Use XML for matrices, payoff tables, and multi-panel maps.
6. End with the decision: recommended move, confidence, unresolved questions, and which diagram should be updated if new facts arrive.

For a new negotiator, the default diagram is a player and incentive map. It gives them something useful to keep open during prep: who is involved, what each party wants, what each party can do, which claims need verification, and where the next move sits. Move to a payoff matrix only after the choices are clear enough to compare.

## Example routing

Scenario: a supplier says a price increase is unavoidable because of future scarcity.

1. `investigation-theory`: test the claim. What evidence supports scarcity? Who benefits if the claim is false?
2. `strategic-foresight-viz`: map plausible supply futures and early warning signs.
3. `intana-viz`: run ACH on explanations for the price increase: real scarcity, opportunistic anchoring, capacity constraint, or competitor pressure.
4. `game-theory-negotiation`: update BATNA, reservation price, concession plan, and non-price trades.
5. draw.io: produce a player/incentive map plus a payoff matrix for the top two supplier moves and top two buyer responses.
