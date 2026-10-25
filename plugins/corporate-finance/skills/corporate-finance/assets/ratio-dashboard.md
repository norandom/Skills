# Asset spec — Ratio / KPI dashboard (XLSX)

Fill-in spec for a one-sheet ratio dashboard fed by the Income Statement and Balance Sheet. Read `references/ratios-and-analysis.md` first. Each ratio shows: value, prior period, budget, peer/industry benchmark, and a verdict.

## Context packet

| Field | Symbol | Your value |
|---|---|---|
| Entity | E | _______ |
| Periods | P | current + prior + budget |
| Inputs | H | BS + P&L (blue links or pasted actuals) |
| Benchmarks | A | industry / peer values (yellow) |
| Output | O | ratio table + diagnostic notes |

## Dashboard columns

`Ratio | Formula | Current | Prior | Budget | Benchmark | Verdict`

## Ratio rows (group with headers)

**Liquidity**
- Current = CA / CL  (benchmark 1–3; very high = idle assets)
- Quick = (CA − Inventory) / CL  (≥ 1)
- Cash = Cash / CL
- Net working capital = AR + Inventory − AP

**Profitability**
- Gross margin = GP / Revenue
- EBITDA margin = EBITDA / Revenue
- Net margin = Net income / Revenue
- ROE = Net income / Equity
- ROA = Net profit / Total assets
- ROCE = EBIT / (Equity + LT debt)
- ROIC = EBIT(1−tax) / Invested capital

**Efficiency**
- Asset turnover = Revenue / Total assets
- DSO = Avg AR / Revenue × 365
- DIO = Avg Inventory / COGS × 365
- DPO = Avg AP / COGS × 365
- CCC = DSO + DIO − DPO

**Leverage**
- Equity ratio = Equity / (Equity + Liabilities)
- Debt ratio = Debt / (Equity + Liabilities)
- EBITDA-to-interest coverage = EBITDA / Interest expense

**Per employee**
- Revenue / EBITDA / Net profit per employee = each / employee count

**Market multiples (if listed/priced)**
- P/E, P/S, P/B, EV/EBITDA, P/CF, Dividend yield

## Diagnostic notes block (auto-prompts under the table)

- EBITDA margin healthy but net margin lagging → look below the operating line: interest expense (financing policy) and corporate income tax.
- ROA falling YoY → assets growing faster than net income; red flag unless early growth phase.
- CCC declining → cash efficiency improving; but check excessive DPO is not forfeiting early-payment discounts.
- Always compare each ratio three ways: vs last period, vs budget, vs competitors/industry.

## 6-step ratio workflow (reminder on sheet)

1 gather data (BS + P&L) → 2 understand the ratio → 3 apply formula → 4 interpret → 5 comparative (last period / budget / competitors) → 6 risk assessment & action plan.

## Validation checks

| Check | Pass |
|---|---|
| Each ratio links to source cells, no hardcodes | true |
| Benchmark column filled (yellow) | true |
| Verdict references comparison, not raw value | true |

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
