# Asset: the input block

The single source of truth for everything editable. In a larger workbook it gets its own sheet (tab color `#FFC000`, placed before the task sheets); in a small one it is the first block on the task sheet. The rules are the same either way.

---

## Layout

| Row | Content | Style |
|---|---|---|
| 1–2 | *empty* | top margin (sheet form only) |
| 3 | title | `Header` |
| 4 | *empty* | spacer |
| 5 | reader instruction | `ExplanatoryText` |
| 6 | *empty* | spacer |
| 7 | first group bar | `SectionHeader` |
| 8 | table header | `SectionHeader` |
| 9+ | input rows | see classes below |

Columns A and B empty.

## Column layout

| C | D | E | F |
|---|---|---|---|
| Label | Value | Unit | Source / method marker |

Widths: C ~`117 pt`, D ~`80 pt`, E ~`60 pt`, F ~`90 pt`.

---

## The three input classes, kept apart

Group them. Do not interleave — the whole point of three fills is that a reader can see at a glance which cells are filled once (blue) and which they are invited to keep tuning (yellow).

```
 7   BASE DATA .......................................
 8   Driver                Value     Unit    Source
 9   Spot price            118.40    EUR     exchange close 2026-07-31   <- SourceData, blue #BDD7EE
10   Volume                12,400    units   ERP export 2026-07-28       <- SourceData
11   Volatility            0.2100    p.a.    estimated, see Docu §2      <- SourceData
12
13   SCENARIO CONTROLS ...............................
14   Control               Value     Unit    Note
15   Scenario              Base      —       Base / Upside / Downside    <- Input, yellow #FFFF00, bordered
16   Horizon               12        months  1–36                        <- Input
17   Stress multiplier     1.00      x       1.00 = no stress            <- Input
18
19   FIXED CONSTANTS .................................
20   Constant              Value     Unit    Basis
21   Day count             360       days    methodology                 <- Constant, gold #FFD966, thin top border
22   Confidence level      0.9500    —       task specification          <- Constant
```

- **Base data** (`SourceData`, blue) — what the workbook consumes, filled once from the world. Every row needs a source in column F.
- **Scenario controls** (`Input`, yellow, bordered) — what the reader turns. Column F states the permitted range or the allowed values.
- **Fixed constants** (`Constant`, gold) — given by the task or methodology. Column F states the basis.
- Blank row between groups.

The labels in column C are plain Arial 10, unfilled. **Color the value, not its name.**

---

## Rules

- Every editable number in the workbook is here. If a formula elsewhere contains a literal a reader might want to change, it is a defect (`integrity-and-checks.md`).
- Every input is referenced by at least one formula. An unreferenced input is dead, or a link is broken — find out which before delivering.
- The only acceptable input outside this block is a scenario control sitting directly beside the block it drives, and even then prefer a link back here.
- Units in column E, never inside the value cell.
- Percentages stored as fractions, formatted `0.00%`.
- The reader instruction on row 5, verbatim:

  > Fill only the blue and yellow cells. Never type over an unfilled calculation cell.

---

## Build checklist

- [ ] Base data, scenario controls, and constants in separate labeled groups.
- [ ] Every base-data row has a source; every control has a permitted range; every constant has a basis.
- [ ] Labels unfilled; only values carry a class fill.
- [ ] Units in column E; no unit text inside numeric cells.
- [ ] Every input referenced by at least one formula.
- [ ] No editable literal survives inside any formula in the workbook.
- [ ] Reader instruction present.
