# Valuation: DCF, WACC, and method choice

Valuation estimates intrinsic or relative worth. The DCF discounts future cash flows at a risk-reflecting rate; multiples and cost methods cross-check it. This reference covers the DCF process, the WACC build-up, terminal value discipline, when each method applies, and the mistakes that wreck a valuation.

Notes layer: personal notes about `DCF steps.pdf`, `Valuation handbook.pdf`, `Startup valuation methods - models.xlsx`, and `Discounting explained.pdf` from Bojan Radojicic / bojanfin.com materials. This is not original source text. Pair with `assets/dcf-wacc.md`.

---

## Why FCFF (and when FCFE)

**FCFF** = cash to **both** equity and debt holders, unlevered, values the whole enterprise independent of capital structure → discount at **WACC**. **FCFE** = levered, equity-only → discount at **cost of equity** (more common for financial-sector firms).

FCFF = EBIT − cash taxes + non-cash add-backs − increase in NWC − CAPEX.

Equivalent NOPAT form: FCFF = EBIT × (1 − tax rate) + D&A − increase in NWC − CAPEX. Use a positive **increase in NWC** as a cash outflow; if NWC decreases, the subtraction becomes a cash inflow.

---

## DCF process (8 steps)

1. Forecast FCF (explicit horizon, reliable ~5–7 years, minimum 5).
2. Compute discount factors: DF = (1 + WACC)^t; discounted CF = FCF / DF.
3. Set long-term growth g (~ nominal GDP).
4. Terminal value: **TV = CFn × (1 + g) / (WACC − g)** (Gordon growth).
5. Sum discounted CF + discounted TV.
6. = **Enterprise Value**.
7. Adjust: − interest-bearing debt / debt equivalents / hybrid claims; +/- non-operating assets and NWC; + cash.
8. = **Equity Value**, then run sensitivity.

EV→Equity worked bridge: EV 15,035; debt (700); adjustments (766); (225) → Equity 13,945.

For each valuation output, show the source sheets/cells, formula, substitution, result, units, and validation check. Do not state a point valuation without the trace and sensitivity range.

---

## WACC build-up

| Component | Note |
|---|---|
| Risk-free rate | Government bond, maturity + currency matched (anchor 1.98%, 3-mo T-bill) |
| Equity risk premium (ERP) | Equity excess over risk-free (anchor 4.72%) |
| Beta | Unlevered (all-equity, anchor 0.81) → relevered for D/E gearing (ND/E 0.5636 → 1.1501); <1 less risky, >1 riskier |
| Size premium | Smaller firms (+0.5%); **Damodaran disputes it — consider skipping** |
| Country risk premium | Only if ERP used a developed-market base (+0.5%); avoid double counting |
| Specific risk premium | Subjective, unique company risks (+0.7%) |
| Cost of debt | Pre-tax × (1 − tax); interest is tax-deductible (anchor 3.58%, tax 25.5%) |

Worked: cost of equity 9.11%. WACC = weight cost of equity and after-tax cost of debt by E/V and D/V.

Formula map:

| Output | Formula | Source/check |
|---|---|---|
| Cost of equity | Risk-free + relevered beta × ERP + premiums | cost-of-capital assumptions |
| After-tax cost of debt | Pre-tax cost of debt × (1 − tax rate) | debt schedule / tax assumption |
| WACC | E/V × cost of equity + D/V × after-tax cost of debt | capital structure weights sum to 100% |
| Discount factor | 1 / (1 + WACC)^t | ties to WACC and period t |
| PV FCFF | FCFF × discount factor | ties to FCFF forecast |
| PV terminal value | TV × terminal-year discount factor | ties to TV calculation |
| Enterprise value | sum(PV FCFF) + PV TV | reconciles to valuation output |
| Equity value | entity value − interest-bearing liabilities − non-controlling interest | bridge reconciles to debt/cash assumptions |

---

## Terminal value discipline

- g must **never exceed** historical growth, nominal GDP, or the risk-free rate.
- **Red flag:** if discounted TV ≈ 99% of EV, the explicit forecast is doing no work — extend the horizon or revisit assumptions.

---

## Method selection

| Approach | Method | Use when |
|---|---|---|
| **Income** | DCF | Cash flows are projectable; growing, stable companies |
| **Market** | Comparable Companies (EV/EBITDA, etc.) | Public peers exist; good for startups / no cash flow |
| **Market** | Precedent Transactions | M&A context; includes control premium — adjust for time / synergy / size / risk |
| **Cost** | Net Book Value + Replacement Cost | No comparables + unpredictable cash flows; pre-revenue / distressed / asset-heavy |

Other methods in the catalog: NPV, EVA, IRR, Berkus, Venture Capital, Conversion Rates (LTV/CAC).

---

## The 40+ value drivers (six categories)

**Financial** (net-income trend, CF predictability, optimized FCF rate, tax incentives); **Market** (TAM growth, dynamic industry, entry barriers); **Sales** (scalability, diverse channels, churn improvement, managed CAC, recurring revenue); **Human Resources** (workforce stability, low fluctuation, key-personnel expertise, cultural alignment); **Organizational** (high ESG, minimal owner dependence, reproducible cost structure, quality standards); **Tech & IP** (cybersecurity, privacy, IP protection + transferability, innovative tech / AI).

---

## Mistakes (the reflect layer)

- **Over-reliance on terminal value** (see 99% red flag).
- **Inconsistent story** — Damodaran's 3-dimension check: high growth + low reinvestment + low risk is contradictory.
- **Sensitivity ignorance** — a 2% WACC rise can halve NPV; always run a WACC × g table.
- **Apples-to-oranges multiples** — adjust for growth / debt / geography; circular logic if the whole sector is mispriced.
- **False precision** — volatile value drivers require a range, not last-cent precision.

---

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt. WACC commentary in the notes references Aswath Damodaran.*
