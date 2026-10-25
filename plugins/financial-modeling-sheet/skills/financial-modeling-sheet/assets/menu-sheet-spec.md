# Asset: menu sheet, cell by cell

Sheet name: `Menu`. First tab. Tab color `#000000`.

Built **last**, generated from the actual tab order and actual tab colors.

---

## Cell map

| Cell / range | Content | Style |
|---|---|---|
| A:B (all rows) | *empty* | width ~`20 pt` each |
| `A1:F2` | *empty* | top margin |
| `C3:F3` | workbook title (text in `C3` only) | `Header` — fill `#000080`, Arial 12 bold white, **centered**, row `15.75 pt`, no merge |
| row 4 | *empty* | spacer |
| `C5:F5` | `Contents` (text in `C5`) | fill `#000080`, Arial 10 bold white, vertically centered, row `12.75 pt` |
| `C6` | `Sheet` | `RowTitle` — fill `#333399`, Arial 9 bold, font `#FFFF00` |
| `D6` | `Color` | `RowTitle` |
| `E6:F6` | `Note` | `RowTitle` |
| `C7` onward | one navigation row per sheet, in tab order | see below |

## Navigation row (repeat from row 7)

| Column | Content | Style |
|---|---|---|
| C | `=HYPERLINK("#SheetName!A1","SheetName")` | `Hlink` — Aptos Narrow 11, `#467886`, single underline |
| D | *empty*, solid fill = the sheet's actual tab color | fill only |
| E:F | one-line purpose description | `ExplanatoryText` — Aptos Narrow 11 italic `#7F7F7F` |

Row height `15 pt`.

## Column widths

| Column | Points | Excel width |
|---|---:|---:|
| A, B | 20 | 3.8 |
| C | 228 | 43.4 |
| D | 60 | 11.4 |
| E | 60 | 11.4 |
| F | 60 | 11.4 |

---

## Worked example

```
      C                              D         E                                          F
 3   Portfolio Risk Assessment 2026  ▓         ▓                                          ▓    <- navy bar, text in C3
 4
 5   Contents                        ▓         ▓                                          ▓    <- navy bar
 6   Sheet                           Color     Note
 7   Documentation                   [gray]    methodology, sources, limitations
 8   Dashboard                       [purple]  results and recommendation — start here
 9   Shared Inputs                   [amber]   all editable inputs — change values here
10   Model                           [plum]    Python engine; outputs feed Dashboard
11   Exposure Base                   [lt blue] foundational: exposure and base metrics
12   Sensitivity Screens             [lt blue] foundational: single-driver screens
13   Scenario Grid                   [mid blue] intermediate: two-driver scenario grid
14   Optimization                    [dk blue] advanced: constrained optimization results
15
16   Fill only the blue and yellow cells. Never type over an unfilled calculation cell.
```

Row 15 blank; row 16 is the reader instruction in `ExplanatoryText`.

`Support Calculations` is deliberately absent — technical support sheets are omitted unless users need direct access.

---

## Hyperlink forms

| Sheet name | Formula |
|---|---|
| `Dashboard` | `=HYPERLINK("#Dashboard!A1","Dashboard")` |
| `Scenario Grid` (space) | `=HYPERLINK("#'Scenario Grid'!A1","Scenario Grid")` |
| `Bob's Model` (apostrophe) | `=HYPERLINK("#'Bob''s Model'!A1","Bob's Model")` |
| `2026 Review` (leading digit) | `=HYPERLINK("#'2026 Review'!A1","2026 Review")` |

Always keep the leading `#`. Quote when unsure.

---

## Build checklist

- [ ] Built after the tab order was frozen.
- [ ] Row order equals the actual tab order exactly.
- [ ] Swatches read programmatically from each sheet's actual tab color.
- [ ] Every hyperlink clicked or programmatically resolved against the sheet list.
- [ ] Hidden and technical sheets omitted deliberately; the omission noted in Documentation.
- [ ] No merged cells.
- [ ] Reader instruction present.
