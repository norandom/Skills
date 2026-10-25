# The three-statement model

The integrated **Income Statement + Balance Sheet + Cash Flow** model is the backbone of corporate finance. Schedules drive the P&L, the P&L and schedules drive the Balance Sheet, and the Cash Flow Statement reconciles the two. Build it in the order below so every figure traces back to an assumption.

Notes layer: personal notes about `02 3 Statements model.xlsx` and `50 Spreadsheets in finance models.pdf` from Bojan Radojicic / bojanfin.com materials. This is not original source text. Pair this with `assets/three-statement-model.md` to generate the workbook and `spreadsheet-conventions.md` for cell-coloring and validation rules.

---

## The master model map (50-sheet legend)

A complete operating model is organized into five families. You rarely build all 50 — pick the sheets the intent needs.

| Family | Sheets |
|---|---|
| **Analysis** | Historical Financials, Visual Financials, Ratio Analysis, Vertical Analysis, EBITDA KPIs, Breakeven, Horizontal Analysis, P&L Templates (manufacture / SaaS / retail / real estate / wholesale / services), KPIs Dashboard |
| **Planning (schedules that drive the IS)** | Budget Model, Revenue, COGS & Gross Profit, Headcount, Salaries, Overhead Expenses, Non-Cash Expenses, Working Capital (AR/Inv/AP), CAPEX (asset + depreciation), Financing (debt / dividends / capital), Income Statement, Balance Sheet, KPI Planning, Subscription Revenue (MRR/ARR), Income Tax, WACC |
| **Valuation** | DCF, Comparable Companies, Precedent Transactions, NPV, EVA, IRR, Conversion Rates (LTV/CAC), Replacement Costs, Venture Capital, Berkus, Net Book Value |
| **Accounting / M&A** | Bonus Schemes, Accrued Expenses, Deferred Income, Deferred Taxes, EBITDA Adjustment, Quality of Earnings, Paper LBO, Goodwill Impairment |
| **Cash Flow** | 13 Weeks CF Forecast (direct), Cash Flow Statement (indirect), Cash KPIs |
| **Infrastructure** | Instructions, Assumptions, Validation Checks |

---

## Structure and granularity

Two time grains, same logic:

- **Monthly-detailed:** Jan … Dec + Total FY.
- **Yearly-detailed:** Year 1 … Year 12.

Each sheet uses columns: **Baseline | Assumptions | period columns | Total FY | Instructions**.

## Build order (schedules first)

1. **Revenue** — volume × price, segments, seasonality, acquisition/retention.
2. **COGS & Gross Profit** — % of revenue or unit-cost driven.
3. **Headcount → Salaries** — headcount × avg salary × % increase.
4. **Overhead / Opex** — YoY growth vs baseline.
5. **CAPEX** — investment timing → tangible + intangible asset schedules → **depreciation** feeds Non-Cash Expenses.
6. **Financing** — debt schedules → interest expense + principal; dividends; capital increases.
7. **Working Capital** — AR (DSO), Inventory (DIO), AP (DPO). See `cash-flow-working-capital.md`.
8. **Income Tax** — effective rate on NIBT, adjusted for incentives/deferred.
9. **Income Statement** — assembles all of the above.
10. **Cash Flow Statement** — indirect, schedule-driven (see below).
11. **Balance Sheet** — closes via the links below.

---

## The three linkages that make it integrate

1. **Cash** on the Balance Sheet is linked from the **Cash Flow Statement** (Cash end).
2. **Equity** = opening Equity + Net Income − Dividends (retained earnings roll-forward).
3. **Other current assets/liabilities** are projected as a share of total assets / driven by their working-capital ratio.

If those three links are wired, the Balance Sheet balances automatically (Assets = Liabilities + Equity). A balance break means one of the three is mis-linked — that is the first thing to check.

---

## Indirect cash flow (worked shape)

```
Net income
  + D&A (non-cash)
  +/- change in working capital (AR, Inventory, AP)      = CF operating
  - CAPEX  +/- other investments                          = CF investing
  + increase in financial debt  - dividends paid          = CF financing
  -----------------------------------------------------------
  = Total CF
Cash beginning + Total CF = Cash end   ->  Balance Sheet Cash
```

Worked five-year anchor (from the template, currency '000): OCF 1,337 / 1,363 / 1,651 / 1,754 / 1,920; Investing (800) / (970) / (180) / (405) / (145); Financing (224) / (66) / 244 / (192) / (241); Total CF 313 / 327 / 1,715 / 1,157 / 1,534; Cash end 1,623 / 1,950 / 3,665 / 4,822 / 6,356.

---

## Standard abbreviations

AP, AR, BS, CAPEX, CCC, CF, CIT, COGS, D&A, DIO, DPO, DSO, EBIT, EBITDA, FS, G&A, GM, GP, IP, IS, KPI, LY, MoM, NFP, NPV.

---

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
