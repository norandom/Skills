# Core concepts: the numbers and mindsets

This layer defines the quantities every negotiation manipulates and the mindsets that decide how you use them. Set these *before* you plan any bid (`references/tactics.md`) or value any trade-off (`references/frameworks.md`).

---

## 1. Reservation price

Also called the indifference price or walk-away price: the price at which a party is indifferent between agreement and no agreement.

- **Buyer:** maximum willingness to pay (WTP).
- **Seller:** minimum acceptable price (WTA).

**Warning: this is a floor, never a target.** Your reservation price is exactly where the counterpart wants to push you. Use it only as an absolute boundary in the back of your mind. If you find yourself negotiating near it, stop and use a reversible no (`references/tactics.md`) to climb back out.

---

## 2. BATNA: best outside option

BATNA = **Best Alternative To a Negotiated Agreement**: the best thing you can do if *this* negotiation breaks down. It is your real source of power and it defines the **boundary of the bargaining range**.

- Each time you improve your outside option, the bargaining zone shrinks in your favor.
- At the limit, a strong BATNA *replaces* your preference-based reservation price as the binding boundary: once your best outside option is better than your indifference price, only the BATNA matters.
- **Action:** before conceding anything, ask "can I improve my BATNA instead?" Cultivating a second bidder, a fallback supplier, or a do-nothing option is often worth more than any tactic at the table.
- If the BATNA is uncertain (a competing offer that may or may not materialize), model it as a **stochastic BATNA** with a three- or four-point estimate (`references/frameworks.md`), not a single guessed number.

---

## 3. ZOPA, surplus, and the bid-ask gap

- ZOPA, the zone of possible agreement, lies between the two reservation prices. If the buyer's maximum is at least the seller's minimum, a deal is possible. Example: buyer's RP 80, seller's RP 70, so ZOPA is 70 to 80.
- **Surplus / the pie** = the total value to be divided = buyer's RP - seller's RP. House example: buyer's RP EUR250k, seller's RP EUR200k means surplus = EUR50k. Agree at EUR220k and the buyer keeps EUR30k while the seller keeps EUR20k. Negotiation is the fight over how the surplus is split, plus, in integrative cases, how to enlarge it.
- **Bid-ask gap** is the distance between the stated offers. Example: you demand 100, they offer 50, so the gap is 50-100. This is not the ZOPA. The offers are strategic positions; the reservation prices are private. In reality you almost never know either the ZOPA or the counterpart's reservation price. You infer them from how the other side bids.

---

## 4. Aspiration levels

From bounded rationality (Herbert Simon): instead of a full utility function, a negotiator works with a few discrete evaluation thresholds. Lay them out as a ladder before you start. Seller's view shown; invert for a buyer. Higher is always better for *you*.

| Rank | Level | Meaning |
|------|-------|---------|
| 1 | **BPO -- Best Possible Outcome** | Theoretical maximum, roughly the counterpart's reservation price. A mental reference, not a plan. |
| 2 | **AT -- Ambitious Target** | Ambitious but realistically achievable. This is your psychological focus point. Every step below it feels like a loss. |
| 3 | **Target / most-likely satisfactory level** | The outcome you genuinely expect to settle around. |
| 4 | **RL -- Reservation Level** | Your reservation price. Absolute floor. No deal below this. |
| 5 | **NDO -- No-Deal Outcome** | The negotiation fails. Worst for both sides. |

The useful finding: negotiators who focus on the Ambitious Target usually do better than those who fixate on their reservation price. Anchor your attention and your opening logic on level 2, not level 4.

Use the ladder live: if your running position has slipped to the RL zone, that is the trigger for a Tactical No and a re-anchor toward the AT.

---

## 5. Strategic mindsets

### 5a. Target focus
Decide your Ambitious Target explicitly and keep your attention there. This is the mindset version of section 4, turned into action in the bidding algorithm: the target price sits in the middle of the bargaining range, never at the reservation price (`references/tactics.md`).

### 5b. Risk-aversion modeling
Outcomes under uncertainty must be discounted by the decision-maker's risk attitude. A risk-averse party values a certain settlement above a gamble with the same expected value, and may rationally accept a worse expected deal to remove variance. When you model an uncertain BATNA or a scenario fan (`references/frameworks.md`), apply the relevant party's risk aversion: yours when deciding your floor, theirs when predicting their behavior. A risk-averse counterpart can be moved by adding uncertainty to their no-deal outcome; a risk-averse you should value mechanisms that lock in certainty, such as milestones or escrow.

### 5c. Win-win verification vs Pareto efficiency
- A deal both sides accept is not automatically good. Pareto efficiency means no party can be made better off without making another worse off, but a lopsided split can still be Pareto-efficient.
- Win-win is the stronger, integrative claim: both sides come out better than their BATNA, and the deal was expanded through trades across issues before it was divided.
- Verify win-win explicitly at the close: did each side beat its BATNA, and did you leave value on the table that a trade could have captured? Don't confuse "they signed" with "this is jointly optimal."

---

## 6. Strategic bidding vs incentive-compatible mechanisms

- **Incentive-compatible mechanism:** a procedure in which revealing your true willingness to pay is rational, such as a Vickrey second-price auction, where bidding your true value is the dominant strategy.
- In ordinary bilateral negotiation, no such mechanism exists. Strategic bidding, meaning deliberately bidding away from your true reservation price to raise your expected share of the surplus, is almost always rational.
- Never volunteer your true reservation price in a normal negotiation. Doing so hands the entire surplus to the counterpart. This is why the bid-ask gap exists and why section 3 warns that offers are strategic positions, not the real boundaries.
- The exception is when the mechanism itself makes truth-telling optimal, as in Vickrey-style auctions and rule-bound negotiauctions in `references/frameworks.md`. Recognize which game you're in before you decide how honest to be about your number.

---

## Cross-references
- Plan the opening bid and concession path: `references/tactics.md`.
- Value non-price terms, model uncertainty, design auctions/incentives: `references/frameworks.md`.
- Worked sequences: `references/playbooks.md`.
