# Tactics: live moves and the bidding algorithm

This layer holds the moves you make *at the table*: how to bid (degressive vs Boulwarism) and the four core tactical actions. Set your numbers first (`references/core-concepts.md`).

---

## 1. Degressive bidding: the default algorithm

Use this as your default concession plan.

1. **Place your target price in the middle of the bargaining range, not at your reservation price.** This is target focus made concrete (`references/core-concepts.md` section 5a). Aim at the Ambitious Target / middle, never the floor.
2. **Open with a plausible maximum position (MPP).** This is a maximally ambitious but still defensible first offer. The MPP sets the distance from your opening to your target; that distance is your concession budget.
3. **Each concession halves the remaining distance** between your last bid and your target price. The first step is relatively large, which signals good-faith movement.
4. **Steps get smaller, and the numbers get more precise** as you go. Example: 1000, 750, 625, 562, not 1000, 750, 500. Shrinking, precise, irregular steps tell a credible story: you started flexible and are now nearing your limit. Two cautions:
   - **Don't land exactly on the mathematical midpoint every time.** Mechanical halving lets the other side detect the algorithm and extrapolate your target.
   - **Don't over-round.** Precise figures, such as EUR18,650 rather than EUR18,000, read as calculated limits.
5. **When the steps get tiny, stop conceding on price and close the final gap with a small non-cash sweetener.** Throw in an accessory, a service, faster delivery, pickup, or some other low-cost item. Deploy it exactly when monetary steps have shrunk to noise. Leaving this out can sour an otherwise good deal because the other side feels squeezed rather than satisfied.

Why it works: the shrinking pattern is a signal. A large first concession followed by smaller, more precise ones says "I started flexible, now I'm near my limit" without revealing your reservation price.

See `assets/concession-plan-template.md` to lay out the schedule.

---

## 2. Boulwarism: the anti-pattern

Named after Lemuel Boulware (General Electric, late 1940s labor negotiations): compute one supposedly objective first offer and never move. Take it or leave it.

Use it only with eyes open, because it:
- Provokes breakdowns. The other side still wants to negotiate, and a one-sided refusal to move drives them away.
- Feels frustrating and often reads as bad-faith negotiation.
- Ignores the psychological value of the bargaining process. People need some ritual of mutual concession to feel ownership of the outcome.
- Pretends a single objective number exists, even though the proposer has an obvious interest in that exact "fair" figure.

Default to degressive bidding. Reserve a take-it-or-leave-it posture for cases where you genuinely have a dominant BATNA and want to signal it, and accept the elevated breakdown risk.

---

## 3. Counter-offer

**Golden rule: you always make a counter-offer. Yes, always.**

- In the Ultimatum Game, the proposer holds structural power; the responder can only accept or reject. Whoever makes the last credible ultimatum is in the strong position.
- Letting the responder make one counter-offer flips the roles. The responder becomes the new proposer and takes back power.
- Operationally: never say "I reject." Say "I offer you ..." The counter-offer is a form of no that re-anchors the negotiation from your side and reverses the proposer/responder roles.
- Even a token counter-offer is better than a flat rejection, because rejection leaves the power with the other side's last number.

---

## 4. Reversible no

A no that rejects one proposal and remains completely reversible. The deal stays alive; you are only reworking specific points.

- Contrast this with an irreversible no, which kills the whole deal.
- Purpose 1: stop the slide. It halts the counterpart from pushing you into the red zone near your reservation price (`references/core-concepts.md` section 4). If your running position has reached the Reservation Level, use it.
- Purpose 2: buy time. It shuts off the pull to settle now and gives you room to analyze the situation and build a proper counter-offer.
- Tie it to the aspiration ladder. If you keep ending up in the red zone, something is structurally wrong with the deal or your BATNA. Step back rather than concede again.

---

## 5. Nibble defense

The nibble is an unethical last-minute tactic, a milder cousin of holdup. It exploits the vulnerable window between the handshake and the official signing. The opponent asks for a small concession deliberately kept under your rejection threshold: a full tank of gas, "leave the fridge," "just EUR100 less."

Three defenses, escalating:

1. **Price-tag and isolate.** Attach an explicit price to the nibble and pull it out of the agreed deal: "Happy to leave the fridge. It's EUR200." The agreed contract stays untouched; the nibble becomes its own micro-deal. This breaks the "it's tiny, just say yes" frame.
2. **Counter-nibble.** Demand a small concession back: "Fine, then I'm taking the toolbox out." Keep a few small penalties in reserve so you can answer a nibble with one.
3. **Threaten to reopen the entire negotiation.** "You've reopened it. I now want EUR500 more, not EUR100 less." Nibblers hate this because it puts their whole gain at risk for a small grab. Use it when the first two don't stop the nibbling.

---

## 6. Higher authority / strategic delegation

A self-binding mechanism: defer final approval to an absent authority, such as a board, committee, manager, or deliberately invented approval step.

Four benefits:
1. Buys time to think, gather information, and cool down before committing.
2. Enables a face-saving retreat. "The committee said no" lets both parties step back without personal blame.
3. Strengthens rule enforcement. A committee can uphold rules an individual might bend under pressure at the table.
4. Forces the opponent to negotiate against an absent party. They must give you the arguments to convince the invisible authority, revealing their reasoning while you concede nothing.

Counterparties can use the same move against you by presenting their own higher authority as an ultimatum. Recognize it and answer with a counter-offer aimed past the absent authority.

---

## Cross-references
- The numbers these tactics protect: reservation price, ZOPA, aspiration ladder in `references/core-concepts.md`.
- Valuing the in-kind sweetener and other non-price terms: virtual price list in `references/frameworks.md`.
- Holdup, the serious cousin of the nibble, and its protections: `references/frameworks.md`.
- Worked sequences: `references/playbooks.md`.
