# Asset: task sheet

One sheet per task or analysis, named after the actual work (`Task 1`, `Exposure`, `Q3 Reforecast`). Tab color by analytical level: `#94DCF8` foundational, `#61CBF3` transitional, `#0C769E` intermediate, `#074F69` advanced. Tasks at the same level share a color.

---

## The six-block shape

Every analytical block on the sheet follows the same order. A reader scrolling down meets **inputs, then arithmetic, then answers, then meaning** — never the reverse.

```
      C                        D          E        F
  1
  2
  3   Task 2 — Scenario sensitivity ..................   <- Header, navy
  4
  5   Method: two-driver grid, expected value at each     <- ExplanatoryText or Note
      node; downside taken at the 5th percentile
  6
  7   PARAMETERS .....................................    <- SectionHeader, indigo
  8   Driver                Value      Unit    Source
  9   Discount rate         0.0850     —       Inputs D9      <- SourceData, blue
 10   Volatility            0.2100     p.a.    Inputs D11     <- SourceData
 11   Horizon               12         months  Inputs D16     <- SourceData
 12
 13   CALCULATION ....................................
 14   Discount factor       0.9217     —                      <- no fill
 15   Drift term            0.0620     —                      <- no fill
 16   Node value            12.4038    EUR k                  <- no fill
 17
 18   OUTPUT .........................................
 19   Metric                Value      Unit    Method
 20   Expected value        12.40      EUR k                  <- Output, #F2F2F2, bordered
 21   Downside (P5)         -6.69      EUR k   Py             <- Output, marker in F
 22
 23   INTERPRETATION .................................
 24   Downside exceeds the tolerance at horizons              <- Note, #FFFFCC, wrapped
      beyond 18 months; Option B is preferred.
 25   Selected option       Option B                          <- Recommended, #E2EFDA
```

1. **Section title** — indigo `SectionHeader` bar.
2. **Methodology note** — `Note` or `ExplanatoryText`, where the method is not self-evident.
3. **Parameter block** — the inputs this block consumes, blue `SourceData`, before any formula. Cross-sheet links to the shared inputs stay blue: role beats mechanism — the knob is yellow only where it lives and is tuned.
4. **Calculation block** — unfilled, Arial 10. Long formulas split into named helper rows.
5. **Output block** — `Output`, bordered, with units and a method marker in the right-hand column.
6. **Interpretation** — what the numbers mean; navy `Result` for the decisive figure, `Recommended` where a choice is made.

---

## Rules

- **Parameters before formulas.** Always.
- One blank row between blocks; a second block on the same sheet repeats the six-part shape from its own `SectionHeader` bar.
- **Intermediate calculations stay unfilled.** They are scaffolding.
- Method markers (`Py`, `Model`, `API`, `Solver`) in the marker column on the **right**; columns A and B stay empty.
- Move long helper schedules to a support-calculation sheet. A task sheet holds the analysis, not the bookkeeping.
- Consistent precision within each table; units in their own column; negatives with a leading minus in black.
- A task sheet that has grown past two or three blocks is usually two tasks.

## Charts

Placed to the right of or below the block whose data they show — same sheet, so the reader can see the source. `XYScatter` for two-metric comparisons, `XYScatterLines` for curves, `Line` for ordered trends. Title names the subject and both metrics; axis titles on analytical scatters; blanks plotted as not plotted.

---

## Build checklist

- [ ] Rows 1–2 blank, title on row 3, columns A and B empty.
- [ ] Six-block shape in order, with parameters before formulas.
- [ ] Parameter cells blue, including cross-sheet links.
- [ ] Calculations unfilled and quiet.
- [ ] Outputs bordered light gray; exactly one navy `Result` where there is a decisive figure.
- [ ] Method markers in the right-hand column.
- [ ] No editable literal inside any formula.
- [ ] Blank row between blocks; no merged cells.
- [ ] Tab color matches the task's analytical level and its peers.
