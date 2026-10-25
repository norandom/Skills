# Asset spec — EBITDA bridge & KPI block (XLSX)

Fill-in spec for an EBITDA calculation, Bojan's four EBITDA KPIs, and an improvement-lever tracker. Read `references/ebitda.md` first.

## Context packet

| Field | Symbol | Your value |
|---|---|---|
| Entity | E | _______ |
| Periods | P | 3-year series (or monthly) |
| Currency / units | C | _______ |
| Inputs | H | P&L lines + employee count + interest expense → blue |
| Adjustments | A | one-off add-backs (yellow) |
| Output | O | EBITDA + 4 KPIs + lever tracker |

## EBITDA calculation (show both)

```
Bottom-up:  Net income + Interest + Taxes + Depreciation & Amortisation = EBITDA
Top-down:   EBIT + Depreciation & Amortisation = EBITDA
```

## Adjusted EBITDA bridge (M&A / due diligence)

```
Reported EBITDA
+ excess owner compensation
+ stock-based compensation
+ GAAP one-off / non-recurring items
+/- transfer-pricing to arm's length
= Adjusted EBITDA
```
Caveat row: management-adjusted EBITDA can flatter results — review each add-back critically.

## The four KPIs (Bojan)

| KPI | Formula | Read |
|---|---|---|
| Absolute EBITDA | (from bridge) | scale of operating profit |
| EBITDA margin | EBITDA / Revenues | profitability vs peers |
| EBITDA-to-interest coverage | EBITDA / Interest expense | debt-service capacity (lending) |
| EBITDA per employee | EBITDA / Employee count | operational productivity |

Considerations row: consistency over time, industry standards, life cycle (startups low/negative), economic conditions, treat cash flow separately, evaluate alongside debt.

## Improvement-lever tracker

| Lever | Action | Owner | Target impact |
|---|---|---|---|
| Capitalize expenditures | move qualifying spend below EBITDA line | | |
| Pricing strategy | raise price / mix | | |
| Cost control | supplier terms, procurement | | |
| Process automation | reduce opex | | |
| Inventory optimization | cut carrying cost | | |
| Revenue diversification | new streams | | |
| Talent | productivity | | |

## Reflection note (always include)

EBITDA is **not cash flow** — "you can't take EBITDA home." It excludes interest, taxes, CAPEX and working-capital movements, and as a non-GAAP measure it is inconsistent across companies and open to manipulation (it can mask high debt). Never present EBITDA alone; pair it with cash flow and leverage.

## Validation checks

| Check | Pass |
|---|---|
| Bottom-up EBITDA = top-down EBITDA | = 0 diff |
| Each add-back labelled and justified | true |
| KPIs link to source cells | true |
| Cash-flow caveat present | true |

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
