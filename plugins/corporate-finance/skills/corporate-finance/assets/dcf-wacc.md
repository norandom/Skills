# Asset spec — DCF valuation with WACC build-up (XLSX)

Fill-in spec for an FCFF discounted-cash-flow valuation with a WACC build-up and a sensitivity table. Read `references/valuation-dcf-wacc.md` first.

## Context packet

| Field | Symbol | Your value |
|---|---|---|
| Entity | E | _______ |
| Explicit horizon | P | 5–7 years (min 5) |
| Currency / units | C | _______ |
| Inputs | H | forecast EBIT, tax, D&A, ΔNWC, CAPEX → from model |
| WACC + g | A | risk-free, ERP, beta, premiums, cost of debt, tax, terminal g → yellow |
| Sources | S | source sheets/cells and evidence status for each input |
| Math trace | M | source -> formula -> substitution -> step-by-step calculation -> result -> units -> check -> Python verification -> mismatch status |
| Output | O | Enterprise value → Equity value + sensitivity |

## Sheet list

1. **Assumptions** — WACC inputs + terminal growth (yellow).
2. **FCFF forecast** — per year.
3. **Discounting** — discount factor + discounted CF.
4. **Terminal value**.
5. **EV → Equity bridge**.
6. **Sensitivity** — WACC × g table.
7. **Evidence & Audit Trail** — formula map and trace for every valuation output.

## FCFF (per year)

```
FCFF = EBIT - cash taxes + non-cash add-backs - increase in NWC - CAPEX
```

Equivalent NOPAT form: `FCFF = EBIT × (1 - tax rate) + D&A - increase in NWC - CAPEX`. Use a positive increase in NWC as a cash outflow; a decrease in NWC is a cash inflow.

## WACC build-up (yellow inputs, worked anchor)

| Component | Anchor | Note |
|---|---|---|
| Risk-free rate | 1.98% | govt bond, maturity + currency matched |
| Equity risk premium | 4.72% | equity excess over risk-free |
| Unlevered beta | 0.81 | all-equity |
| Gearing ND/E | 0.5636 | used to relever |
| Relevered beta | 1.1501 | < 1 less risky, > 1 riskier |
| + Size premium | 0.5% | Damodaran disputes — consider skipping |
| + Country risk premium | 0.5% | only if ERP not already developed-market; avoid double count |
| + Specific risk premium | 0.7% | subjective |
| = Cost of equity | 9.11% | |
| Cost of debt (pre-tax) | 3.58% | × (1 − tax); interest tax-deductible |
| Tax rate | 25.5% | |

WACC = (E/V × cost of equity) + (D/V × after-tax cost of debt).

## Discounting

```
Discount factor (year t) = (1 + WACC)^t
Discounted CF            = FCFF / discount factor
```

## Terminal value (Gordon growth)

```
TV = CF_n × (1 + g) / (WACC - g)
```
Discipline: **g must never exceed** historical growth, nominal GDP, or the risk-free rate. **Red flag** if discounted TV ≈ 99% of EV (over-reliance on terminal value).

## EV → Equity bridge (worked anchor)

```
Enterprise value                 15,035
- interest-bearing debt            (700)
+/- debt equivalents / hybrids     (766)
+/- asset adjustments              (225)
= Equity value                   13,945
```

## Sensitivity table (required)

Build a WACC × terminal-growth grid (and ideally a price × volume grid on revenue). A 2% WACC rise can roughly halve NPV — show it.

## Evidence & Audit Trail sheet

| Output | Sheet/cell | Source | Formula | Inputs/cells | Substitution | Step-by-step calculation | Result | Units | Check | Python verification | Mismatch status |
|---|---|---|---|---|---|---|---|---|---|---|---|
| FCFF | FCFF forecast | IS, WC, CAPEX | EBIT - cash taxes + D&A - increase in NWC - CAPEX | linked cells | show values | show arithmetic sequence | output | currency | ties to statements | Python recomputation | match/resolved/open |
| WACC | WACC sheet | assumptions | E/V x CoE + D/V x after-tax CoD | linked assumptions | show values | show arithmetic sequence | output | % | E/V + D/V = 100% | Python recomputation | match/resolved/open |
| Terminal value | Terminal value sheet | FCFF, WACC, g | CF_n x (1 + g) / (WACC - g) | linked cells | show values | show arithmetic sequence | output | currency | g discipline passes | Python recomputation | match/resolved/open |
| Enterprise value | Discounting | PV FCFF, PV TV | sum(PV FCFF) + PV TV | linked cells | show values | show arithmetic sequence | output | currency | TV share shown | Python recomputation | match/resolved/open |
| Equity value | Bridge | EV, debt, cash, adjustments | entity value - interest-bearing liabilities - NCI | linked cells | show values | show arithmetic sequence | output | currency | bridge reconciles | Python recomputation | match/resolved/open |

Do not report last-cent precision. Present a value range when WACC, growth, margins, or cash-flow assumptions are volatile.

## Reflection gates (before presenting)

- Story consistency (Damodaran 3-dimension): high growth + low reinvestment + low risk is contradictory.
- Terminal value not dominating EV.
- Multiples (if used) adjusted for growth / debt / geography — no apples-to-oranges.

## Validation checks

| Check | Pass |
|---|---|
| g ≤ GDP, risk-free, and history | true |
| Discounted TV share of EV shown and < ~75% | true |
| WACC inputs in yellow, formulas elsewhere | true |
| Sensitivity grid present | true |
| Evidence trace complete with Python verification | true |

*Based on personal notes from Bojan Radojicic / bojanfin.com materials and MBA financial-modeling materials; not an original-source excerpt.*
