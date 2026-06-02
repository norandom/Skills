# Asset spec — Three-statement operating model (XLSX)

Fill-in build spec for generating an integrated Income Statement + Balance Sheet + Cash Flow workbook via Claude for Excel or a written XLSX. Schedules drive the statements; the statements link to each other. Read `references/three-statement-model.md` and `references/spreadsheet-conventions.md` first.

## Context packet (fill before building)

| Field | Symbol | Your value |
|---|---|---|
| Entity | E | _______ |
| Periods | P | Monthly (Jan–Dec + Total FY) ☐  /  Yearly (Y1–Y…) ☐ |
| Currency / units | C | _______ (e.g. EUR '000) |
| History (opening balances) | H | last actual BS + P&L → blue cells |
| Assumption set | A | growth %, margins, DSO/DIO/DPO, CAPEX, debt terms → yellow cells |
| Sources | S | source statements, source cells, evidence status |
| Math trace | M | source -> formula -> substitution -> result -> units -> check |
| Output | O | 3 linked statements + checks |

## Cell colour legend (apply in every sheet)

| Colour | Meaning | Who edits |
|---|---|---|
| Blue | Starting amount / opening balance | user, once |
| Yellow | Assumption / driver | user, tunes |
| No fill | Formula | never edit |

## Sheet list (create in this order)

1. **Instructions** — how to use, colour legend, abbreviations (AP, AR, BS, CAPEX, CCC, CF, CIT, COGS, D&A, DIO, DPO, DSO, EBIT, EBITDA, GP, IS, KPI, NWC, NPV).
2. **Assumptions** — all yellow drivers in one place: revenue growth %, gross margin %, opex growth %, DSO/DIO/DPO days, CAPEX plan, depreciation rate/useful life, debt draw/repay + interest rate, dividend policy, tax rate.
3. **Revenue** — volume × price (or growth % on baseline); seasonality if monthly.
4. **COGS & Gross Profit** — COGS as % of revenue or GP rate; GP = Revenue − COGS.
5. **Headcount & Salaries** — headcount × avg salary × (1+increase%).
6. **Overhead / Opex** — per line: baseline × growth or % of revenue.
7. **CAPEX & Depreciation** — asset additions + depreciation schedule (feeds D&A and PPE).
8. **Financing** — debt schedule (opening, draw, repay, closing), interest = rate × balance; dividends; capital increases.
9. **Working Capital** — AR = DSO×Rev/365; Inventory = DIO×COGS/365; AP = DPO×COGS/365.
10. **Income Statement** — Revenue → COGS → GP → Opex → EBITDA → D&A → EBIT → Interest → EBT → Tax → Net income.
11. **Cash Flow (indirect)** — see shape below.
12. **Balance Sheet** — Assets = Liabilities + Equity.
13. **Evidence & Audit Trail** — formula trace for material outputs.
14. **Validation checks** — see checks table.

## Income statement skeleton (formula cells)

```
Revenue                 = Revenue sheet
- COGS                  = COGS sheet
= Gross Profit
- Operating expenses    = Overhead + Salaries
= EBITDA
- Depreciation & Amort. = CAPEX sheet
= EBIT
- Interest expense      = Financing sheet
= Earnings before tax
- Income tax            = tax% × EBT (if positive)
= Net income            → flows to Equity + Cash Flow
```

## Cash flow (indirect) skeleton

```
Net income                              from IS
+ Depreciation & amortisation           from CAPEX (non-cash add-back)
+/- change in working capital           from WC sheet (increase in AR/Inv = cash out; increase in AP = cash in)
= Cash flow from OPERATING
- CAPEX                                  from CAPEX sheet
+/- other investments
= Cash flow from INVESTING
+ increase in financial debt            from Financing
- dividends paid                        from Financing
= Cash flow from FINANCING
= Total cash flow
Cash beginning + Total cash flow = Cash ending   → links to Balance Sheet Cash
```

Worked 5-year anchor (sanity scale, '000): Cash ending ≈ 1623 / 1950 / 3665 / 4822 / 6356.

## The three integration links (must wire)

1. **Cash**: Balance Sheet Cash = Cash ending from the Cash Flow statement.
2. **Equity**: Closing equity = opening equity + Net income − Dividends (retained earnings roll).
3. **Other current assets/liabilities**: project as a share of total assets / ratio of the driver, not hardcoded.

## Evidence & Audit Trail sheet

Create one row for each material output.

| Output | Sheet/cell | Source | Formula | Inputs/cells | Substitution | Result | Units | Check |
|---|---|---|---|---|---|---|---|---|
| EBITDA | IS!B? | Revenue/Opex schedules | Revenue - COGS - Opex | linked cells | show values | output | currency | ties to IS |
| Cash ending | CF!B? | CF lines | Cash beginning + total CF | linked cells | show values | output | currency | ties to BS Cash |
| Equity | BS!B? | opening equity, NI, dividends | Opening equity + NI - dividends | linked cells | show values | output | currency | equity roll check |

## Validation checks (put on the checks sheet)

| Check | Formula intent | Pass |
|---|---|---|
| Balance sheet balances | Total assets − (Liabilities + Equity) | = 0 |
| Cash ties | BS Cash − CF Cash ending | = 0 |
| Equity roll | Closing equity − (opening + NI − dividends) | = 0 |
| No hardcodes in statements | statements reference schedules only | true |
| Debt non-negative | closing debt | ≥ 0 |
| Evidence trace complete | source/formula/substitution/result/units/check for material outputs | true |

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
