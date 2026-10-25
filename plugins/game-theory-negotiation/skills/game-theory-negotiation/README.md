# game-theory-negotiation

Negotiation playbook for bargaining, auctions, procurement, and incentive design.

It helps an agent prepare, run, and review distributive and integrative negotiations:

- **Set the numbers** -- reservation price (a floor, never a target), BATNA, ZOPA, surplus, and an aspiration ladder: Best Possible Outcome, Ambitious Target, Target, Reservation Level, No-Deal Outcome.
- **Bid well** -- use degressive concessions: target in the middle of the range, shrinking steps, precise numbers, and an in-kind sweetener at the close.
- **Hold the line** -- counter-offer, use a reversible no, defend against nibbles, counter-nibble, and bind yourself to higher authority when needed.
- **Analyze** -- use a virtual price list, scenario analysis, and three- or four-point estimates for an uncertain BATNA.
- **Prepare a new negotiator** -- walk from messy intake to a ready-room brief with numbers, truth checks, scenarios, offer plan, guardrails, a diagram, and the first words to say.
- **Apply** -- protect against holdup, choose fairness criteria, check win-win claims, run negotiauctions, use Vickrey-style mechanisms where they fit, and size profit shares deliberately.

## Who this is for

The playbook is field-neutral -- the same numbers and moves drive very different negotiations. `references/domains.md` translates the vocabulary for specific roles, each with a their-words-to-skill-concept bridge and a worked example:

- **Salary and compensation** -- candidates, hiring managers, HR: offers, raises, competing offers, trading salary against equity/bonus/title.
- **Security compliance and conflict management** -- CISO, GRC, audit: remediation deadlines, risk-acceptance sign-offs, vendor security clauses, cross-team control disputes.
- **Quants and mechanism designers** -- auction and RFQ design, incentive-compatible mechanisms, pricing under uncertainty, certainty equivalents.
- **M&A consultants** -- purchase price, earnouts, reps and warranties, valuation gaps, post-signing holdup.
- **Business managers and leaders** -- vendor and procurement contracts, budget and headcount allocation, bonus design, partnership terms.

## Works with other skills

This skill is one node in a four-skill analysis loop that shares a common context packet (actors, claims, evidence, assumptions, scenarios, options, payoffs, constraints). The handoffs run both ways -- see `references/drawio-concepts.md`.

- **`strategic-foresight-viz`** -- import scenarios, weak signals, and external uncertainties before pricing risk or estimating a BATNA; build one payoff matrix per future.
- **`investigation-theory`** -- test stated claims, evidence, and deception risk before trusting a counterpart's preferences or constraints.
- **`intana-viz`** -- route contested assumptions through ACH, Red Teaming, Key Assumptions Check, or Pre-Mortem, and map stakeholders for many-player situations.

All four render through the draw.io MCP, so diagrams from different skills line up when actor and claim names are kept stable.

## Informal upstream credits

Synthesizes standard negotiation-analysis and game-theory literature plus personal research. The concepts predate this skill; below are best-effort attributions (not exhaustive, not formally cited). Several are also cited inline in the reference files.

- **BATNA, principled negotiation, trading across issues** -- Roger Fisher & William Ury, *Getting to Yes* (1981); integrative bargaining traces back to Mary Parker Follett (1920s) and Lax & Sebenius, *The Manager as Negotiator* (1986).
- **ZOPA, reservation price, the analytic frame** -- Howard Raiffa, *The Art and Science of Negotiation* (1982).
- **Surplus / dividing the pie** -- Nash bargaining, John Nash (1950); popularized recently by Barry Nalebuff, *Split the Pie* (2022).
- **Aspiration levels, satisficing, bounded rationality** -- Herbert Simon, *Models of Man* (1957).
- **Boulwarism** -- named after Lemuel Boulware, General Electric labor negotiations (late 1940s).
- **Ultimatum Game** -- Güth, Schmittberger & Schwarze (1982).
- **The nibble, higher (limited) authority** -- practitioner literature: Roger Dawson, *Secrets of Power Negotiating* (1987); Herb Cohen, *You Can Negotiate Anything* (1980).
- **Reversible no** -- William Ury, *The Power of a Positive No* (2007).
- **Risk aversion, certainty equivalent, expected utility** -- von Neumann & Morgenstern, *Theory of Games and Economic Behavior* (1944); risk-attitude measures, Pratt (1964) & Arrow.
- **Rumsfeld matrix (known knowns / unknown unknowns)** -- Donald Rumsfeld (2002); conceptual lineage to the Johari window, Luft & Ingham (1955).
- **Three- / four-point estimates** -- PERT, US Navy Special Projects Office (1958).
- **Holdup problem, relationship-specific investment** -- Klein, Crawford & Alchian (1978); Oliver Williamson (transaction-cost economics); incomplete contracts, Grossman & Hart (1986).
- **Fairness criteria, cut-and-choose / fair division** -- divide-and-choose is ancient; formalized by Steinhaus, Banach & Knaster (1948).
- **Pareto efficiency** -- Vilfredo Pareto (*Manuale di economia politica*, 1906).
- **Vickrey second-price auction, incentive compatibility** -- William Vickrey (1961, Nobel 1996); mechanism design, Leonid Hurwicz.
- **Negotiauction** -- Guhan Subramanian, *Negotiauction: New Dealmaking Strategies for a Competitive Marketplace* (Harvard, 2010); he coined the term.
- **Principal-agent problem, profit-share & bonus sizing** -- Stephen Ross (1973); Jensen & Meckling (1976).
- **Game tree, payoff matrix, dominant strategy** -- von Neumann & Morgenstern (1944); John Nash (1950).

Anything not listed above is based on standard negotiation practice and personal research.

## Layout
- `SKILL.md` -- overview, prime directive, how-to, capability map, routing.
- `references/core-concepts.md` -- the numbers and mindsets.
- `references/tactics.md` -- live moves and the degressive bidding algorithm.
- `references/frameworks.md` -- analytical tools, holdup, fairness, auctions, incentives.
- `references/prep-walkthrough.md` -- guided preparation workflow for a new negotiator.
- `references/drawio-concepts.md` -- game-theory draw.io concepts and cross-skill handoff packets.
- `references/domains.md` -- role-specific entry points (salary, security compliance, quants, M&A, business leaders).
- `references/playbooks.md` -- worked sequences.
- `assets/` -- prep, concession-plan, and virtual-price-list worksheets.
- `evals/evals.json` -- regression scenarios.
