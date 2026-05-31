# Layer 2 — Behavioral Vector

**Inputs:** `network_topology` · **Output:** `target_nodes`
**Sources:** Centola *How Behavior Spreads*; Jackson *The Human Network*; Berger
*The Catalyst*; Easley & Kleinberg sequential cascades (folded in).

This layer engineers the exact transmission path for change. It uses network
topology to trigger **voluntary adoption cascades** instead of broadcasting.

---

## Centola — simple vs complex contagion

| | **Simple contagion** | **Complex contagion** |
|---|---|---|
| Trigger | A single exposure | **Multiple reinforcing** exposures |
| Examples | Information, news, disease | Costly / risky / identity-relevant behavior change |
| Spreads via | **Weak ties** (casual acquaintances) | **Wide bridges** (many overlapping ties) |
| Best network | Random / broad | **Clustered** |

**Most organizational adoption is complex.** Adopting a new tool, process, or
norm carries cost and risk, so it needs repeated, overlapping social proof — not
one announcement.

### Why weak ties fail here
For complex contagion, weak ties **slow** diffusion: a lone enthusiastic
acquaintance is drowned out by the countervailing signal of everyone else not
adopting. You need **redundancy over reach**.

### Four mechanisms that make a behavior "complex"
1. **Strategic complementarity** — worth more when others also adopt.
2. **Credibility** — belief grows with each independent confirmation.
3. **Legitimacy** — seeing peers adopt makes it socially acceptable.
4. **Emotional contagion** — affect amplifies in clusters.

### Org principles
- **Clustered seeding** — concentrate early adopters in one dense group; do *not*
  scatter them across the org.
- **Wide bridges > individual brokers** — multiple connections between groups
  carry behavior; a single broker carries only information.
- **Social incubators** — a tight cluster protects a fragile new behavior until
  it is strong enough to cross bridges.
- **Homophily / relevance** — adoption transmits best from a *similar, relevant*
  source.
- **Design for social comparison** — make adjacent adoption visible.
- The **hardest-to-convince**, once converted, become the **most committed** carriers.

**Anti-cringe:** never roll out via all-hands email. Make an adjacent, trusted
team adopt first; visible peer adoption converts individual FOMO into structural
group momentum.

---

## Jackson — network centrality (who to target)

| Centrality | Measures | Best for |
|---|---|---|
| **Degree** | Direct connections (popularity/reach) | Broadcasting simple info fast |
| **Closeness** | Avg. shortest path to everyone | Fast dissemination from one seed |
| **Betweenness** | Sits on paths between groups (brokerage) | **Bridging silos**; removal fragments the network (Medici) |
| **Eigenvector** | Connected to *well-connected* people (prestige) | **Driving consensus / cascades** (DeGroot, PageRank) |
| **Diffusion** | Reach within limited hops | Best real-world adoption predictor |

Evidence: in the India microfinance study, seeding the **top** eigenvector nodes
vs the bottom **tripled** participation. Position beats enthusiasm.

### Targeting rule
- Simple info → **degree + closeness**.
- Behavior cascade → **eigenvector anchors**.
- Cross-silo change → **betweenness** brokers + wide bridges.

### How to find the anchors
Ask people: **"Whose opinion do you check before you adopt something new?"** The
repeatedly-named people are your eigenvector anchors — target them with early,
private documentation drops before any public rollout.

---

## Berger — REDUCE (remove barriers, don't push)

Pushing harder triggers **reactance** (an anti-persuasion radar). Instead, find
and remove the barrier. Five barriers, five moves:

| Barrier | Symptom | Move |
|---|---|---|
| **R**eactance | Resists being told | Offer a menu of options; ask, don't tell; let them argue themselves into it; tactical empathy |
| **E**ndowment | Overvalues the status quo (needs ~2× benefit to switch) | Surface the cost of inaction; "burn the ships" |
| **D**istance | Idea is in the region of rejection → backfires | Find the movable middle; ask for less / chunk; switch to common ground |
| **U**ncertainty | Hits pause; won't risk the unknown | Freemium / trial; reduce upfront cost; make it reversible |
| **C**orroborating **E**vidence | One source isn't enough for a big change | Multiple *independent* sources, concentrated in time (fire-hose, not sprinkle) |

Corroborating evidence ≈ Centola's social reinforcement: the same principle from
the individual-psychology side.

---

## Easley & Kleinberg — sequential cascades

People choose **sequentially**, observing prior choices and often **overriding
their own private signal** to follow the crowd.

- **Sequence** meetings, votes, and pilots deliberately.
- Place **respected, objective, technical** voices **first** in the speaking
  order. Their early validation starts a positive information cascade and lowers
  the resistance of later, more skeptical participants.
- Conversely, a credible early *no* can cascade negatively — protect the opening.

---

## Output: `target_nodes`

Produce a concrete rollout plan:
- **Contagion class** (simple vs complex) and the implied strategy.
- **Seed cluster**: the first dense group to adopt.
- **Anchors**: named eigenvector targets + how they were identified.
- **Bridges**: where wide bridges must be built to cross silos.
- **REDUCE notes**: the top barrier and the move to remove it.
- **Speaking/rollout sequence**: who goes first, second, third, and why.
