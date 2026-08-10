# Asset: dashboard sheet

Third tab. Tab color `#7030A0`. The sheet a reader opens first and may be the only one they read.

---

## Cell map

| Row | Range | Content | Style |
|---|---|---|---|
| 1–2 | — | *empty* | top margin |
| 3 | `C3:H3` | workbook title (text in `C3`) | `Header` — `#000080`, Arial 13 bold white, row up to `22 pt` |
| 4 | — | *empty* | spacer |
| 5 | `C5:H5` | scope, period, currency, as-of date (text in `C5`) | `RowTitle` — `#333399`, Arial 9 bold, font `#FFFF00`, row `12.75 pt` |
| 6 | — | *empty* | spacer |
| 7 | `C7:H7` | first section bar, e.g. `Headline result` | `SectionHeader` — `#333399`, Arial 9 bold white |
| 8+ | — | content blocks | see below |

Columns A and B stay empty throughout, ~`20 pt` wide.

---

## Block 1 — headline result

```
 7   HEADLINE RESULT ..................................
 8
 9   Selected option            Option B — hedged     <- Recommended, #E2EFDA, Arial 11 bold #375623, row 30 pt
10   Key metric                 4.31                  <- Result, navy #000080, Arial 10 bold white, links to its source
11   Decision basis             lowest downside at    <- Note, #FFFFCC, wrapped, thin #B2B2B2 border
12                              equal expected value
```

- The key metric is a **link**, never a typed number.
- Exactly one `Result` cell per decision — navy is the scarce look-here color. If there are three, none of them reads as the answer.

## Block 2 — supporting outputs

```
14   SUPPORTING OUTPUTS ...............................
15   Metric              Value      Unit     Source
16   Expected value      12.40      EUR k    Task 2
17   Downside (P5)       -6.69      EUR k    Task 3
18   Ratio to benchmark  1.24x      —        Task 3
```

- Row 15 is the table header (`SectionHeader`, white on indigo).
- Values are `Output` — `#F2F2F2`, Aptos Narrow 11 bold `#3F3F3F`, thin `#3F3F3F` border.
- Every value is a cross-sheet link. Units in their own column. Negatives with a leading minus, black.

## Block 3 — key inputs surfaced

```
20   KEY INPUTS .......................................
21   Driver              Value      Unit     Source
22   Discount rate       0.0850     —        market, 2026-07-31
23   Volatility          0.2100     p.a.     model estimate
```

Surfaced inputs use `SourceData` blue `#BDD7EE` — the dashboard consumes them, nobody edits them here, even though the cell holds a cross-sheet formula. Role beats mechanism. The tunable knob itself is yellow only where it lives and is edited, in the shared inputs.

## Block 4 — integrity checks

```
25   CHECKS ...........................................
26   Check                       Delta     Status      Location
27   Components sum to total     0.00      OK          Task 2 D30
28   Dashboard ties to source    0.00      OK          Task 3 D31
29   No error values             0         OK          workbook
```

`CheckPass` / `CheckWarn` / `CheckFail`. Always show the delta and the location, never the word alone.

## Block 5 — charts

Placed to the right (from column J) or below. `XYScatter` / `XYScatterLines` / `Line` only, titles naming subject and metrics, blanks not plotted, readable without zooming.

---

## Build checklist

- [ ] Every value on this sheet is a link to the sheet that computed it — zero typed results.
- [ ] Exactly one `Result` cell per decision; `Recommended` marks the chosen option.
- [ ] Surfaced inputs are blue, not treated as calculations.
- [ ] Checks show delta and location, in both color and text.
- [ ] Key-result rows vertically centered, ~`30 pt`.
- [ ] Fits one screen, or the overflow is deliberate.
- [ ] No merged cells; title spans by range formatting.
