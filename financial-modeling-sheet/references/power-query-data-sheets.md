# Power Query data sheets

Power Query output is **loaded data, not authored data**. It arrives with Excel's own formatting, it is overwritten on every refresh, and it belongs at the end of the workbook where nobody mistakes it for analysis.

This is the one place in the standard where an Excel table (`ListObject`) is correct, and the one place where a large uniform fill is correct.

---

## 1. Position and naming

**Data sheets go last** — after the task sheets and after any support-calculation sheet. They are the most inert content in the workbook: nothing is derived on them, and a reader walking left to right should reach them only when they want to know where a number came from.

Name them:

```
Data <n> <short id>
```

- `Data 1 fx_rates`
- `Data 2 gl_export`
- `Data 3 tick_2026q2`

Rules:

- `<n>` runs in load order and never gets reused, even if a query is deleted. A gap in the numbering is information.
- `<short id>` is a short slug identifying the query, and it **matches the Power Query query name**. Same name in the Queries pane and on the tab, or the mapping has to be rediscovered every time.
- Keep it short. Excel caps sheet names at 31 characters, and the space in the name means every reference to the sheet must be quoted: `='Data 1 fx_rates'!C7`. Long slugs make every downstream formula worse.
- Lowercase, underscore-separated slugs. No spaces inside the slug — the one space in `Data 1 ` is enough.

**Tab color `#BFBFBF`.** Mid gray, matching the gray family that means source data throughout the workbook, and dark enough to be distinguishable from Documentation's near-white `#E8E8E8` on the tab strip.

List data sheets in the menu. A reader auditing a figure needs to find the source, and unlike support calculations these sheets carry the workbook's provenance.

---

## 2. The data is referenced, never copied

Everything downstream **references** the data sheet:

```excel
='Data 1 fx_rates'!D7
=XLOOKUP($C9,'Data 1 fx_rates'!$C:$C,'Data 1 fx_rates'!$E:$E)
```

Never:

- Paste PQ output into a task sheet. The copy goes stale at the next refresh and there is no signal that it has.
- Type into a PQ output range. **A refresh overwrites it silently** — the edit is not preserved, not warned about, and not recoverable.
- Add a formula column inside the loaded table. It survives some refreshes and not others depending on how the query shape changes. Put derived columns on a task sheet, or in the query itself.

The rule to state on the sheet: *this table is machine-written; edit the query, not the cells.*

Where a derived column genuinely belongs next to the data, put it **outside the table** with a blank column between, and say so in a `Note`.

---

## 3. Replace the Power Query table style

Excel loads every query with a built-in table style — banded blue rows, its own header formatting, filter dropdowns. That styling overrides named styles and collides with the palette. Strip it and apply the house style on top.

| Element | Replace with |
|---|---|
| Table style | **None** (`TableStyleMedium2` etc. removed); banded rows and banded columns off |
| PQ caption row | `RowTitle` — `#333399`, Arial 9 bold, font `#FFFF00` |
| Table header row | `SectionHeader` — `#333399`, Arial 9 bold, white |
| Data body cells | `SourceData` — `#D0D0D0`, Arial 10, black |
| Total row | off |
| AutoFilter | **keep** — this is the sanctioned filtering case |

The body stays uniformly gray, and that is correct here: the whole block is genuinely one semantic class. **A reader must never see an unfilled cell inside a PQ table** — unfilled means "calculated on this sheet", which is exactly what this data is not.

### Surviving a refresh

Formatting applied by hand is lost on refresh unless the query is told to keep it. In **Query Properties → Usage / External Data Properties**:

- ✅ **Preserve cell formatting** — without this, every refresh reverts to the table style and the work is undone.
- ❌ **Adjust column width** — leave off, or refresh resets the widths you set.
- ❌ Include row numbers.

Verify by refreshing once and re-checking the header color before you call the sheet done. A formatting job that does not survive a refresh has not been done.

---

## 4. The PQ caption

Every loaded table is announced by a caption **directly above the table header row**:

```
PQ: <simple headline>
```

Examples:

- `PQ: daily ECB reference rates, 2024-01 onward`
- `PQ: GL export, cost centres 4000–4900`
- `PQ: tick data, resampled to 5-minute bars`

Rules:

- Style `RowTitle` — yellow bold on indigo, so it outranks the white-on-indigo header row immediately below it and reads as the block's caption.
- Plain language. What the data is and what it covers — not the query's M code, not the connection string.
- The `PQ:` prefix is literal and mandatory. It is how a reader knows the block below is machine-written before they read a single value.
- Put `PQ` in the marker column of the caption row as well, alongside `Py`, `Model`, and `API` — the same provenance vocabulary used everywhere else in the workbook.

Connection details — source system, path or endpoint, refresh cadence, owner — go in Documentation, not in the caption.

---

## 5. Data types

Set the type **in the query** wherever possible. A `Changed Type` step in Power Query lands the column as a real date, number, or text; a number format applied to a text column in Excel changes nothing but the alignment, and the values stay unusable.

Then infer and apply the display format per column:

| Inferred content | Number format | Watch for |
|---|---|---|
| Dates | real date serial, explicit format (`YYYY-MM-DD`) | text that merely looks like a date — the classic PQ import defect |
| Counts, IDs used as numbers | `#,##0` | — |
| Amounts | `0.00` | unit in the header, never in the cell |
| High-precision measures | `0.0000` | only where the source is genuinely that precise |
| Percentages | `0.00%` | must be stored as a fraction; PQ often lands `4.89`, not `0.0489` |
| Ratios | `0.00x` | — |
| Codes, IDs with leading zeros | text | typing them as numbers destroys the leading zeros irreversibly |
| Free text, categories | `General` | — |

Rules:

- One format per column, uniform down the whole column. Mixed precision within a loaded column means the type was never set.
- Negatives follow the workbook convention: leading minus, black, no red, no parentheses (`number-formats.md`).
- Units and scale go in the header row or a `Note`, never inside the value cells.
- Where a type genuinely cannot be inferred, leave it `General` and flag it in a `Note`. Guessing wrong is worse than leaving it alone.

---

## 6. Sheet layout

```
      A     B  |  C            D          E         F
  1   (empty)  |
  2   (empty)  |
  3   (empty)  |  Data 1 fx_rates ..........................    <- Header, navy
  4   (empty)  |
  5   (empty)  |  PQ: daily ECB reference rates            PQ   <- RowTitle, indigo/yellow; marker in F
  6   (empty)  |  Date         Currency   Rate                  <- SectionHeader = table header row
  7   (empty)  |  2026-07-31   EUR/USD    1.0842                <- SourceData gray, from here down
  8   (empty)  |  2026-07-30   EUR/USD    1.0817
```

- Standard skeleton: rows 1–2 blank, title on row 3, row 4 blank, columns A and B empty.
- **Load destination is `C6`** — the table's header row sits on row 6, body from row 7, so the sheet matches every other sheet in the workbook. Set the destination when loading, or move the table afterwards; a query loaded to `A1` is a finding.
- One query per sheet. Two tables on one data sheet defeats the naming scheme and makes the refresh behavior ambiguous.
- A `Note` below the table records anything a reader needs: known gaps, filters applied in the query, row count expectations.

---

## 7. Checklist

- [ ] Data sheets are last in tab order, after task and support sheets.
- [ ] Named `Data <n> <short id>`, slug matching the Power Query query name, under 31 characters.
- [ ] Tab color `#BFBFBF`; listed in the menu.
- [ ] Loaded at `C6`; rows 1–2 blank, title on row 3, columns A and B empty.
- [ ] Built-in table style removed; banding off; total row off; AutoFilter kept.
- [ ] `PQ: <headline>` caption in `RowTitle` directly above the header row, with `PQ` in the marker column.
- [ ] Header row `SectionHeader`; body uniformly `SourceData` gray with no unfilled cells.
- [ ] Column types set in the query; display formats applied per column, uniform down each column.
- [ ] Percentages stored as fractions; leading-zero codes stored as text; dates are real dates.
- [ ] "Preserve cell formatting" enabled; "Adjust column width" disabled; **verified by an actual refresh**.
- [ ] Nothing downstream copies the data — every consumer references it.
- [ ] No typed values and no formula columns inside the loaded range.
- [ ] Connection source, cadence, and owner recorded in Documentation.
