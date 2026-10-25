# Asset spec — Budget model (XLSX)

Fill-in spec for a driver-based annual budget (12 monthly periods + Total). Read `references/budgeting.md` and `references/spreadsheet-conventions.md` first. Pick the budgeting method before building (see decision below).

## Context packet

| Field | Symbol | Your value |
|---|---|---|
| Entity | E | _______ |
| Periods | P | 12 months + Total (or 4 quarters rolling) |
| Currency / units | C | _______ |
| Baseline | H | last actual year per line → blue cells |
| Method | — | ZBB ☐ / Incremental ☐ / Continuous-rolling ☐ / Beyond budgeting ☐ |
| Output | O | budgeted P&L → net income → BS link |

## Method selection (set before building)

| Method | Build behaviour | Use when |
|---|---|---|
| Zero-based (ZBB) | every line starts at 0, justify each | cutting legacy cost, reallocating to strategy |
| Incremental | baseline ± adjustment % | stable, predictable business |
| Continuous / rolling | append a new period to hold a constant horizon | dynamic environment |
| Beyond budgeting | relative/dynamic KPI targets, no fixed annual number | volatile industry |

## Sheet list

1. **Instructions** — colour legend + method note.
2. **Assumptions** — revenue plan, GP rate, headcount plan, growth %, tax rate (yellow).
3. **Revenue budget** — volume × price or growth on baseline.
4. **Cost lines** — one block per line using the driver matrix below.
5. **Budgeted P&L** — sums to Net income.
6. **Balance-sheet link** — net income → equity; PPE link → separate CAPEX model.
7. **Validation checks**.

## Cost-driver matrix (per cost line: Driver | Calculation | Data source)

| Cost line | Driver | Calculation | Source |
|---|---|---|---|
| COGS | volume, GP rate, purchase price | GP rate applied to sales | sales plan |
| Direct labour | headcount, avg salary | headcount × avg salary × (1+increase%) | HR/CEO |
| Consultancy | revenue / contracts | % of revenue | contracts |
| Repairs & maint. | revenue or direct cost | % of revenue | GL |
| D&A | useful life + new CAPEX | schedule from FA register + CAPEX | FA register |
| Utilities/Rent/Office | YoY growth | baseline × (1+growth%) | trial balance/GL |
| Scrap | COGS or avg inventory | % of COGS | GL |
| Bad debt | revenue or avg receivables | % of revenue | GL |
| Bonuses | salaries or net profit | % of salaries / % NP | HR |
| Marketing | budgeted revenue | % of budgeted revenue | plan |
| Travel/Licenses/R&D/Insurance | historical | baseline × growth | GL |
| Interest | loan schedule | rate × balance, roll-forward | financing |
| Tax | NIBT | effective rate on NIBT (incentive-adjusted) | tax |

## Model mechanics

Per line: **Starting position | assumption % | 12 forecast periods | Total**. Project variable costs as a **share in revenue** (use the historical %, let the user revise it in yellow). Flow each line to net income, then to the balance sheet. Keep PPE / fixed assets in a separate CAPEX model and link it in.

## Validation checks

| Check | Pass |
|---|---|
| Each cost line references a driver, not a hardcode | true |
| Variable costs reconcile to revenue share | true |
| Total column = sum of periods | = 0 diff |
| Net income flows to equity | linked |

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
