# Number formats, precision, and negatives

A number format is a claim about what kind of quantity a cell holds and how precisely it is known. Inconsistent formats within one table are read as a mistake, and usually are one.

---

## Format by measurement type

| Measurement | Format |
|---|---|
| Whole numbers / counts | `#,##0` |
| Standard amounts | `0.00` |
| High-precision model outputs | `0.0000` |
| Percentages | `0.00%` or `0%` |
| Ratios / multiples | `0.00x` |
| Text, codes, categories | `General` |

The `x` suffix for multiples is part of the **number format**, not typed text: `0.00"x"` keeps the cell numeric so it still sorts, charts, and calculates.

---

## Rules

- **Consistent precision within a row or table.** If one revenue figure shows two decimals, all of them do. Mixed precision in a column is the single most common formatting defect.
- **High precision only where it is analytically necessary.** `0.0000` belongs on rates, weights, correlations, greeks, and coefficients. It does not belong on headcount or on a currency amount whose inputs are known to the nearest thousand.
- **Units live in a separate adjacent column.** Never store `EUR`, `%`, `days`, or `kg` inside a numeric cell — it forces the cell to text and silently breaks every downstream formula.
- **Do not put unit text in the number format either**, with the single exception of the `x` multiple suffix. A currency symbol in the format is acceptable when the whole sheet is one currency and the header says so; a unit *word* is not.
- **Let Excel localize decimal and thousands separators.** Write formats with `.` and `,` and let the locale render them. Do not hardcode German or US separators.
- State the unit and scale in the block header where a whole table shares one: `Revenue (EUR '000)`.
- Do not mix scales within a table. If one row is in thousands and another in units, the reader will compare them anyway.

### Precision honesty

Do not present more digits than the inputs support. A DCF whose growth assumption is "about 3%" cannot produce an enterprise value meaningful to four decimals. When a model's own precision exceeds its inputs', format down and say so in a note. False precision reads as confidence the model has not earned.

---

## The negative-value convention

This standard uses **leading minus, same color as positives**. It is deliberate and it overrides Excel's defaults.

- Show a leading minus sign: `-6.69`.
- Keep the **same black or dark-gray font** as positive values.
- **Do not** display negatives in red.
- **Do not** use parentheses: `(6.69)` is wrong here.
- **Do not** use conditional formatting solely to recolor negatives.
- **Do not** replace zero with a dash. Display zero according to the row's format: `0.00`, `0%`, `0`.

Worked examples:

| Type | Format | Negative renders as |
|---|---|---|
| Standard amount | `0.00` | `-6.69` |
| High precision | `0.0000` | `-0.4791` |
| Ratio / multiple | `0.00x` | `-2.37x` |
| Percentage | `0.00%` | `-4.89%` |
| Count | `#,##0` | `-1,204` |

Why: in a quantitative assessment, negative values are ordinary results — a negative delta, a short position, a drawdown, a residual — not exceptions. Red-flagging them trains the reader to treat routine arithmetic as an alarm, and it collides with the check/warning colors, which *are* alarms. Reserve red for the FAIL state.

The format string that produces this is simply the positive format with no negative section: `0.00`, not `0.00;[Red]-0.00` and not `0.00;(0.00)`. A single-section format lets Excel render the minus itself.

If a workbook already uses parentheses or red negatives coherently throughout, that is a preserved convention in EXTEND mode — match the file and note the deviation. Changing it is a RESTYLE decision.

---

## Sign conventions

Separate from formatting, and equally important to state once in Documentation:

- Decide whether outflows are negative and inflows positive (the usual choice) and apply it everywhere.
- Never flip a sign inside a display formula to make a chart look better; flip it in a clearly labeled helper row.
- Preserve an existing workbook's sign convention even where you would have chosen the other one.

---

## Dates and text

- Dates use a real date serial with an explicit format (`YYYY-MM-DD` for unambiguous technical sheets, or the locale's short date for reader-facing ones). Never a text string that looks like a date.
- Period headers (`Jan`, `Q1`, `Y1`, `W-13`) may be text, but keep them in one row and one style so chart category axes read cleanly.
- Codes, IDs, and categories use `General` or explicit text format — especially anything with leading zeros.

---

## Format checklist

- [ ] Every numeric column has an explicit format, not `General`.
- [ ] Precision is uniform within each row and each table.
- [ ] High precision appears only where the analysis needs it.
- [ ] No unit text, currency words, or `%` characters stored inside numeric cells.
- [ ] Units and scale stated in a separate column or the block header.
- [ ] Negatives show a leading minus, in the normal font color.
- [ ] No conditional formatting recoloring negatives.
- [ ] Zero displays as zero in the row's format, not as a dash.
- [ ] Sign convention stated in Documentation and applied consistently.
- [ ] No `####` anywhere — every numeric cell is wide enough to display.
