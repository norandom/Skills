# Domain entry points: who this is for

The core skill is field-neutral on purpose. The same five numbers (reservation price, BATNA, ZOPA, surplus, aspiration ladder) and the same moves (degressive bidding, counter-offer, reversible no, nibble defense, higher authority) drive every negotiation. This file translates that vocabulary into the language of specific roles so the guidance is usable without re-deriving it each time.

Each section gives: the situation the role faces, a vocabulary bridge (their words ↔ skill concepts), the concepts that matter most, the sibling skills worth pulling in, and one short worked example. Read the matching section, then go to `references/core-concepts.md` to set the numbers.

---

## 1. Salary and compensation (candidates, hiring managers, HR)

**Situation:** an offer, a raise, a counter-offer from a competing employer, a promotion band.

| Their words | Skill concept |
| --- | --- |
| Competing offer / outside opportunity | BATNA (model it as a *stochastic* BATNA if the other offer is not yet in hand) |
| Walk-away salary | Reservation price (a floor, never your ask) |
| Salary band / market range | ZOPA between your floor and the employer's budget ceiling |
| Target number | Ambitious Target — anchor here, not on your floor |
| Signing bonus, equity, PTO, title, remote days | Virtual price list — non-cash terms you can trade |
| "Best and final" | Boulwarism — usually a tactic, answer with a counter-offer anyway |

**Concepts that matter most:** aspiration ladder, BATNA improvement (a real competing offer moves the band more than any phrasing), degressive concessions on the number, and the virtual price list to trade salary against equity/bonus/start-date/title.

**Cross-skill:** none usually needed. For a multi-year equity decision under an uncertain company outcome, pull a `strategic-foresight-viz` scenario fan before valuing the equity.

**Example:** floor $150k, market band $160–185k, competing verbal offer at $170k (70% likely to firm up → certainty-equivalent ~$162k → that becomes your real floor). Open the conversation anchored at $185k (Ambitious Target), concede degressively (185 → 178 → 174 → 172), and close the last gap with a non-cash ask (extra week PTO, earlier review) rather than another dollar.

---

## 2. Security compliance and conflict management (CISO, GRC, audit, risk)

**Situation:** getting a product team to remediate a finding, negotiating a risk-acceptance sign-off, settling security clauses in a vendor contract, or de-escalating a control dispute between teams. Compliance work is mostly *internal negotiation under a policy constraint* — treat it as one.

| Their words | Skill concept |
| --- | --- |
| Remediation deadline / SLA | Deadline constraint + automated trigger (penalty/escalation if missed) |
| Risk acceptance | The other party's BATNA to fixing it — make the no-deal outcome (audit finding, liability) visible |
| Compensating control | Non-price trade on the virtual price list |
| Policy / regulatory floor | A hard constraint, not a bargaining variable — name it as the boundary |
| Exception request | A nibble at the altar — price-tag it and isolate it from the agreed baseline |
| Escalate to the steering committee | Higher authority — for time, face-saving, and rule enforcement |
| Contract security addendum (SOC 2, breach notice, audit rights) | Multi-issue deal architecture with asymmetric values |

**Concepts that matter most:** higher authority (a security committee enforces rules an individual bends under delivery pressure), holdup protection and automated triggers (bake remediation milestones into the agreement so neither side drifts), fairness criteria (decide *which* criterion settles a control dispute before arguing it), and nibble defense for the steady stream of "just this once" exception requests.

**Cross-skill:**
- `investigation-theory` — when a team *claims* a control is infeasible or a risk is negligible, test the claim and its evidence before accepting it.
- `intana-viz` — run Key Assumptions Check or a Pre-Mortem on a risk-acceptance decision; map stakeholders for a contested cross-team control.

**Example:** a team wants to ship with an unremediated finding ("the risk is low, fix next quarter"). Their BATNA is *ship now, accept risk*. Make the no-deal outcome concrete (the finding stays open on the audit, named owner, board-visible). Offer a trade: ship now **with** a compensating control plus a milestone-triggered remediation date that auto-escalates if missed. Route the "risk is low" claim to `investigation-theory` rather than conceding it.

---

## 3. Quants and mechanism designers (pricing, markets, auction design)

**Situation:** designing an auction or RFQ mechanism, setting incentive schemes, pricing under uncertainty, or choosing between bilateral bargaining and a rule-bound process.

| Their words | Skill concept |
| --- | --- |
| Truthful / strategy-proof mechanism | Incentive-compatible mechanism (Vickrey second-price as the canonical case) |
| Expected value of the position | Three-/four-point estimate of an uncertain BATNA |
| Risk-adjusted value | Certainty equivalent (deduct for risk aversion — feed *this* into the floor, not raw EV) |
| Bid shading | Strategic bidding away from true value (rational in first-price / bilateral, not in Vickrey) |
| RFQ / reverse auction with negotiated terms | Negotiauction (Subramanian) — published, binding, reputation-enforced rule set |
| Winner's curse | Over-anchoring on optimistic payoffs — discount before bidding |

**Concepts that matter most:** the strategic-bidding vs incentive-compatible distinction (know which game you're in before deciding how honest to be), Vickrey-style mechanisms and negotiauction design for procurement, certainty equivalents for any uncertain position, and the principal-agent section for sizing variable compensation.

**Cross-skill:** `strategic-foresight-viz` to generate the scenario set behind a payoff distribution; build one payoff matrix per future and pick the robust strategy rather than optimizing a single forecast.

**Example:** sourcing one contract across five credible suppliers. Bilateral haggling invites holdup and leaks. Instead design a negotiauction: publish a fixed, transparent rule set, commit to it (reputation enforces the commitment), and let suppliers submit their best price knowing the rules won't move. You get auction-grade price discovery with negotiated non-price terms.

---

## 4. M&A consultants (mergers, acquisitions, deal structuring)

**Situation:** purchase-price negotiation, earnouts, reps and warranties, the gap between buyer and seller valuation, post-signing integration leverage.

| Their words | Skill concept |
| --- | --- |
| Valuation gap / bid-ask spread | Bid-ask gap (the stated positions, *not* the ZOPA) |
| Each side's standalone / no-deal value | BATNA and reservation price |
| Synergies | The surplus / the pie to be divided (and enlarged via integrative trades) |
| Earnout | Risk-sharing under an uncertain BATNA + holdup protection via staged, trigger-based payment |
| Reps, warranties, escrow, indemnities | Holdup protection — bind value before the relationship-specific investment |
| Material adverse change clause | Automated trigger tied to a defined event |
| Best-and-final / exploding offer | Boulwarism + higher authority (the IC / board as the absent approver) |

**Concepts that matter most:** holdup protection (post-signing, the party that has invested in the deal is exposed — milestones, escrow, and earnouts with automated triggers neutralize it), three-/four-point estimates for an uncertain standalone value, win-win verification (synergy claims are often mere Pareto-tolerable splits dressed up), and deal-architecture trades across price and non-price terms.

**Cross-skill:**
- `investigation-theory` — diligence: which seller claims (pipeline, churn, IP ownership) are verified vs asserted, and who benefits if a claim is false.
- `intana-viz` — stakeholder map of the buy/sell side, board, regulators; ACH on competing explanations for a soft metric.
- `strategic-foresight-viz` — scenario fan for the combined entity before pricing synergies.

**Example:** seller asks 8× EBITDA; buyer's standalone view is 6×. The 6–8× gap is the bid-ask spread, not the ZOPA. Real synergy is the surplus. Bridge it with an earnout: pay 6.5× up front and the rest on milestone-triggered performance over two years — shifting risk to the party who controls the outcome and protecting the buyer from holdup. Route the seller's growth claims to `investigation-theory` first.

---

## 5. Business managers and leaders (procurement, vendors, internal resourcing)

**Situation:** vendor and supplier contracts, budget and headcount allocation, cross-functional disputes, bonus and incentive design, partnership terms.

| Their words | Skill concept |
| --- | --- |
| Vendor quote / list price | Their opening position (MPP), not their floor |
| Our budget ceiling | Your reservation price |
| Alternative supplier / build-it-ourselves | BATNA — cultivate a second one before negotiating |
| Scope, SLA, support, payment terms, exclusivity | Virtual price list for cross-issue trades |
| Year-end "one more thing" from a vendor | Nibble — price-tag, counter-nibble, or threaten to reopen |
| Sign-off needed from finance/legal | Higher authority |
| Bonus / commission / profit-share plan | Incentive design — size the variable component deliberately |
| "Win-win partnership" | Verify it: did each side beat its BATNA, or is it just a split they accepted? |

**Concepts that matter most:** BATNA cultivation (a credible second supplier moves price more than any tactic), the virtual price list for vendor contracts, degressive bidding for the price line, nibble defense for end-of-quarter vendor asks, incentive design for compensation plans, and win-win verification before celebrating a partnership.

**Cross-skill:** `strategic-foresight-viz` for multi-year vendor lock-in or partnership decisions; `intana-viz` for a stakeholder map when an internal resourcing fight has many players; `investigation-theory` when a vendor's capability or scarcity claim drives the price.

**Example:** a SaaS vendor renewal opens 20% up "due to increased costs." Treat the increase as a claim, not a fact (route to `investigation-theory`). Cultivate a credible alternative to sharpen your BATNA. Trade across issues with a virtual price list (longer term for a flat price, fewer seats for a discount, slower support tier you don't use). Defend the close against the inevitable end-of-quarter nibble.

---

## Cross-references

- Set the numbers behind any of the above: `references/core-concepts.md`.
- Live moves: `references/tactics.md`.
- Mechanism design, holdup, fairness, incentives: `references/frameworks.md`.
- Diagrams and the cross-skill handoff packet: `references/drawio-concepts.md`.
- Worked end-to-end sequences: `references/playbooks.md`.
