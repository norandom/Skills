# Asset spec — 13-week cash flow forecast (XLSX, direct method)

Fill-in spec for a short-term, direct-method weekly cash forecast used as an early-warning tool. Read `references/cash-flow-working-capital.md` first. This is direct method (lists actual receipts and payments), not the indirect statement.

## Context packet

| Field | Symbol | Your value |
|---|---|---|
| Entity | E | _______ |
| Periods | P | 13 weekly columns (W1…W13) |
| Currency / units | C | _______ |
| Opening | H | this week's actual closing cash → blue |
| Drivers | A | AR ageing, supplier ageing, payroll calendar, loan schedule → yellow |
| Output | O | weekly ending cash + low-point flag |

## Layout

Rows = line items; columns = W1…W13. **W1 = actual (do not change).** Weeks W2+ are forecast.

```
Opening cash (W1 = actual; Wn = prior week ending)

INFLOWS
+ AR collections           (from AR ageing × expected collection timing)
+ New sales receipts       (cash sales / deposits)
+ Other inflows            (grants, refunds, asset sales)
= Total inflows

OUTFLOWS
- Supplier payments        (from AP ageing / payment terms)
- Payroll                  (payroll calendar)
- Loan principal + interest (loan schedule)
- Tax / VAT payments
- Other outflows
= Total outflows

Net cash movement = Total inflows − Total outflows
Ending cash       = Opening cash + Net cash movement   → carries to next week's Opening
```

## Early-warning logic

- Add a row: **Minimum cash buffer** (yellow) and a flag `Ending cash < buffer → ALERT`.
- Highlight the lowest weekly ending-cash cell across W1–W13.

## Levers to model if a week breaches the buffer

| Lever | Move | Effect |
|---|---|---|
| DSO | automate dunning, advance payments, interest on overdue, credit limits | pulls AR collections earlier |
| DPO | delay payment without harming relationship, avoid fixed dates, take early-pay discount if margin strong | pushes supplier outflows later |
| DIO | align purchasing, JIT, cut obsolete stock, review safety stock | frees cash from inventory |

Worked CCC sensitivities (scale anchor): DPO 60→75 = +863K; DSO →59 = +1,200K; DPO →30 = −1,455K.

## Validation checks

| Check | Pass |
|---|---|
| W1 opening = last actual closing cash | true |
| Each week's ending carries to next week's opening | linked |
| W1 marked actual / locked | true |
| Buffer flag formula present | true |

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
