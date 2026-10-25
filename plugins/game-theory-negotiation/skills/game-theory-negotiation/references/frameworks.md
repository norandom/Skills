# Frameworks: analytical tools, auctions, and incentives

This layer holds the analytical machinery you use to *prepare* and *structure* a deal: valuing trade-offs, modeling uncertainty, protecting against opportunism, splitting fairly, designing auctions, and setting incentives. Set your numbers first (`references/core-concepts.md`) and pick your live moves from (`references/tactics.md`).

---

## 1. Virtual price list

A pre-built table that assigns a money value to every non-price term in the deal. It lets you trade across issues instead of fighting on price alone. It also binds you to a consistent valuation so you do not blurt out arbitrary values under pressure.

- For each negotiable item, record what it costs you and what you think it is worth to them: delivery time, warranty length, payment terms, training, exclusivity, pickup, faster service, or a closing sweetener.
- The leverage comes from asymmetric valuations. Give them something cheap for you but valuable to them, and take back something valuable to you but cheap for them. That is how integrative bargaining enlarges the pie.
- It turns the degressive-bidding closing sweetener (`references/tactics.md` section 1) into a quantified move. You know what the in-kind token costs you and what goodwill it buys.
- It is the defense against the nibble. When a late non-price demand appears, apply the predefined price tag, keep the agreed contract untouched, and negotiate the extra separately (`references/tactics.md` section 5). "Happy to leave the fridge. It costs EUR200."

Use `assets/virtual-price-list-template.md`.

---

## 2. Scenario analysis and the Rumsfeld matrix

Structure what you do not know before it bites you. The Rumsfeld matrix separates manageable risk from deeper uncertainty. Note the mapping carefully: risk lives in the known knowns, not the known unknowns.

| State | Course meaning | Treatment |
|-------|----------------|-----------|
| **Known knowns** | Things we know we know. This is risk: modelable with a probability distribution. | Expected-value reasoning works, discounted by risk aversion (`references/core-concepts.md` section 5b). |
| **Known unknowns** | We know there is something we do not know, such as a pending regulatory change. No reliable probabilities. | Do not fake a point estimate. Run separate scenarios and buy information where cheap. |
| **Unknown unknowns** | Things we do not know and do not even know that we do not know. | Build slack, options, and reversibility. Favor mechanisms that protect you regardless of which surprise lands: milestones, escrow, exit clauses. |

Scenario analysis exists because true uncertainty cannot be collapsed into a single expected value. Treat meaningfully different futures separately.

- Do not optimize for a single scenario when structural breaks are plausible.
- Find a strategy that leaves you in a good position across very different scenarios. Prefer robustness over point-optimality.
- Run a small scenario fan and pre-decide your moves in each before you sit down.

---

## 3. Three-point and four-point estimates (uncertain BATNA)

When your outside option is not a fixed offer and depends on an uncertain event, such as going to court or waiting for a competing bid, it is a probability distribution, not a single number.

- **Three-point estimate:** define the worst, middle, and best payoff in the success cases, then assign probabilities to each. Include a realistic probability of succeeding at all. Compute the expected value.
- **Four-point estimate:** model the complete-loss case separately, plus the three-point distribution for the win outcomes.
- **Do not stop at the expected value.** Deduct for psychological stress and risk aversion. Regret often weighs more than the pleasant surprise of doing better than expected. What remains is the certainty equivalent: the sure amount that gives you the same utility as the uncertain lottery.
- **The certainty equivalent is your true walk-away limit.** Feed it, not the raw expected value, into the aspiration ladder as your Reservation Level (`references/core-concepts.md` section 4). A high-variance outside option yields a lower certainty equivalent for a risk-averse party, so certainty-locking mechanisms such as milestones and escrow matter more.

---

## 4. Holdup protection

The holdup problem is the strategic exploitation of a dependency that appears after agreement, once one party has made a relationship-specific investment. Think custom tooling, a booked-and-cancelled alternative, or anything worth far less outside this deal. That leaves the party locked in: no good exit option and high switching costs. The other side then reopens terms to grab value. The nibble (`references/tactics.md` section 5) is the small end-of-deal cousin; holdup is the structural version.

Protect by binding the parties before the vulnerable investment is made:

- **Mutual exposure:** structure the deal so both sides are equally exposed. Symmetric exposure removes the incentive to hold up.
- **Milestones:** require partial performance or interim results at defined times. This turns one big project into a sequence of smaller ones, so neither side is ever far ahead and exposed.
- **Self-binding / forced functions:** use a physical or system constraint rather than only a legal promise. Example: use a deliberately small delivery truck so movers cannot hold all your furniture hostage at once. It is inefficient on purpose, but it enforces the constraint mechanically.
- **Automated triggers:** make a predefined event trigger a defined consequence. Example: if the work is not complete and defect-free by date X, the contractor owes penalty Y. Self-executing triggers leave less room to renegotiate.

Design these in at structuring time; they're far cheaper than fighting a holdup once you're exposed.

---

## 5. Fairness criteria

The fight over which criterion applies is the first stage of the game. Once the criterion is accepted, it often determines the outcome. Do not argue fairness in the abstract. Agree on the criterion, then apply it.

Entitlement-based criteria:
- **Contribution / time invested:** whoever invested more time gets a larger share. Backward-looking; good when inputs are measurable.
- **Productivity / output:** the decider is measurable contribution to the final result, not time. Forward- and performance-looking; useful for incentive design.

Procedural criteria:
- **Cut-and-Choose / divide-and-choose:** one divides, the other chooses. It does not guarantee a specific outcome, but it gives the divider a reason to divide fairly. Self-enforcing for two parties.
- **Voting:** several independent observers vote on the fair division.
- **Lottery:** impartial random allocation.
- **Rotation:** inequality now is acceptable if future rounds even it out.
- **Veto / unanimity:** fair if no party would reject it.
- **Impartial judge:** a neutral third party decides.

The meta-move: shift the dispute from "what's fair?" to "which criterion do we both accept?" Also watch for the other side quietly installing a criterion that favors them.

---

## 6. Win-win versus mere Pareto efficiency

These two terms get confused all the time.

- **Pareto efficiency:** no party can be made better off without making another worse off. Everything distributable has been distributed. It says nothing about fairness. A split of (10, 0) can be Pareto-efficient even though one side gets nothing.
- **Win-win, in the strict sense:** the agreement is Pareto-efficient and the parties' interests inside the agreement zone are aligned, leaving little or no distributive conflict. True win-win is rare. The phrase is often misused for any agreement both sides accepted.
- **Practical check:** when someone says "win-win," ask whether they mean aligned interests, mere Pareto efficiency, or a settlement that happens to sit near your reservation price. "They signed" proves acceptance, not aligned interests.

Use virtual-price-list trades to enlarge the pie and remove distributive conflict where possible. That is usually the closest you get to genuine win-win. Then verify each side ended above its outside option.

---

## 7. Negotiauctions and incentive-compatible mechanisms

For procurement and multi-supplier situations, choose the mechanism, not just the tactics.

- **Incentive-compatible mechanism:** a design where revealing your true value is rational, such as a Vickrey second-price auction, where truthful bidding is the dominant strategy. In ordinary bilateral talks no such mechanism exists, so strategic bidding rules (`references/core-concepts.md` section 6).
- **Negotiauction:** a hybrid of auction and negotiation used in B2B procurement. The buyer publishes a strict, transparent, pre-announced rule set that:
  - binds the buyer to the rules;
  - uses reputation to enforce the commitment, because leaking one bidder's price to another would cause serious reputational damage;
  - forces suppliers to prepare carefully and submit their best price, because the rules are fixed;
  - blocks opportunistic renegotiation by committing everyone to the same procedure;
  - creates procedural fairness because all parties accept the same announced rules.

Use a negotiauction when you have multiple credible suppliers and want auction-grade price discovery plus the flexibility of negotiated terms. It only works if your reputation can credibly enforce the rules.

---

## 8. Incentive design: profit-share and bonus sizing

Give the agent a variable income component, such as a profit share or bonus, when their effort materially affects the outcome. This is the practical face of the principal-agent problem.

The discipline is questioning the size of the variable component, not just its presence:
- Do not default to round, large shares. Why 50%? A benchmark like investment banking may be around 2% of transaction volume, which can equal about 15% of value created. That is far from 50%.
- Calibrate the share to how much the agent's effort actually drives the outcome, the value genuinely created, and the market rate for that role. Tie it where possible to a productivity fairness criterion.
- An incentive that's too large overpays for luck and value the agent didn't create; too small fails to motivate. Size it deliberately.

---

## Cross-references
- The numbers these frameworks feed: BATNA, reservation price, aspiration ladder, risk aversion, win-win in `references/core-concepts.md`.
- Live moves: degressive bidding, counter-offer, reversible no, nibble defense, higher authority in `references/tactics.md`.
- Worked sequences: `references/playbooks.md`.
