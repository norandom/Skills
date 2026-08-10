# Asset: Power Query data sheet

Last tabs in the workbook. Tab color `#BFBFBF`. One query per sheet. Full rules in `references/power-query-data-sheets.md`.

---

## Naming

```
Data <n> <short id>
```

- `Data 1 fx_rates`, `Data 2 gl_export`, `Data 3 tick_2026q2`
- `<n>` in load order, never reused — a gap is information.
- `<short id>` matches the Power Query query name. Lowercase, underscore-separated, short. Sheet names cap at 31 characters and the space forces quoting in every reference: `='Data 1 fx_rates'!C7`.

## Cell map

| Row | Range | Content | Style |
|---|---|---|---|
| 1–2 | — | *empty* | top margin |
| 3 | `C3:F3` | sheet name as title (text in `C3`) | `Header` — `#000080`, Arial 12 bold white |
| 4 | — | *empty* | spacer |
| 5 | `C5:F5` | `PQ: <simple headline>` (text in `C5`), `PQ` in the marker column | `RowTitle` — `#333399`, Arial 9 bold, font `#FFFF00` |
| 6 | `C6:…` | table header row — the loaded table's own header | `SectionHeader` — `#333399`, Arial 9 bold white |
| 7+ | `C7:…` | data body | `SourceData` — `#BDD7EE`, Arial 10 black |

Columns A and B empty, ~`20 pt`. **Load destination is `C6`.**

## Worked example

```
      C            D          E        F
 3   Data 1 fx_rates .............................    <- Header, navy
 4
 5   PQ: daily ECB reference rates            PQ      <- RowTitle, indigo/yellow
 6   Date         Currency   Rate                     <- SectionHeader, table header row
 7   2026-07-31   EUR/USD    1.0842                   <- SourceData blue from here down
 8   2026-07-30   EUR/USD    1.0817
 9   2026-07-29   EUR/USD    1.0863
...
     Note: gaps on TARGET holidays are expected;      <- Note, #FFFFCC, below the table
     the query does not forward-fill.
```

## Table settings

| Setting | Value |
|---|---|
| Table style | **None** — the built-in Power Query style is removed |
| Banded rows / banded columns | off |
| Total row | off |
| AutoFilter | **kept** — the sanctioned filtering case |
| First column / last column emphasis | off |

## Query properties

| Setting | Value | Why |
|---|---|---|
| Preserve cell formatting | **on** | without it every refresh reverts the house style |
| Adjust column width | **off** | otherwise refresh resets the widths you set |
| Include row numbers | off | — |

Refresh once and re-check the header color before calling the sheet done.

## Column types

Set the type **in the query** (`Changed Type` step), then apply the display format per column:

| Content | Format |
|---|---|
| Dates | real date serial, `YYYY-MM-DD` |
| Counts | `#,##0` |
| Amounts | `0.00`, unit in the header |
| High-precision measures | `0.0000` |
| Percentages | `0.00%`, **stored as a fraction** |
| Ratios | `0.00x` |
| Codes / IDs with leading zeros | text |
| Free text, categories | `General` |

One format per column, uniform top to bottom. Negatives with a leading minus, black.

## Consumption

```excel
='Data 1 fx_rates'!D7
=XLOOKUP($C9,'Data 1 fx_rates'!$C:$C,'Data 1 fx_rates'!$E:$E)
```

Never copy the data into a task sheet. Never type inside the loaded range — a refresh overwrites it silently. Derived columns go on a task sheet or into the query.

---

## Build checklist

- [ ] Last in tab order; tab `#BFBFBF`; listed in the menu.
- [ ] Named `Data <n> <short id>`, slug matching the query name, under 31 characters.
- [ ] Loaded at `C6`; rows 1–2 blank, title on row 3, columns A and B empty.
- [ ] Built-in table style removed; banding and total row off; AutoFilter kept.
- [ ] `PQ: <headline>` caption on row 5 in `RowTitle`, `PQ` in the marker column.
- [ ] Header row `SectionHeader`; body uniformly `SourceData` blue, no unfilled cells.
- [ ] Types set in the query; display formats uniform per column; percentages as fractions; leading-zero codes as text.
- [ ] Preserve cell formatting on, adjust column width off, **verified by an actual refresh**.
- [ ] Every consumer references the sheet; nothing copies it; no typed values or formula columns inside the table.
- [ ] Source system, refresh cadence, and owner recorded in Documentation.
