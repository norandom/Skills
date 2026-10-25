# Charts, tables, and conditional formatting

---

## When a chart earns its place

Use a chart only for a **decision-useful relationship**. If the reader needs exact figures, they need a table. If the shape of the relationship carries the message — a frontier, a payoff curve, a trend, a cluster — they need a chart. If neither, they need neither.

A chart that restates a five-row table is decoration and should be deleted.

## Chart types

| Type | Use for |
|---|---|
| `XYScatter` | risk/return, risk/reward, correlation, any two-metric comparison across alternatives |
| `XYScatterLines` | payoff curves, response curves, distributions, continuous model comparisons |
| `Line` | ordered trends and multiple scenarios over a common sequence (time, periods, steps) |

Scatter versus line is not a style choice: **scatter plots two measurements against each other; line plots one measurement across an ordered sequence.** Using a line chart for two metrics implies an ordering that does not exist.

- **No 3D charts, ever.** They distort magnitudes and add nothing.
- No pie charts for quantitative comparison. If shares must be shown, use a table with percentages.
- No secondary axes unless the two series share a natural relationship and both axes are labeled with units.

## Chart rules

- **Plot blanks as not plotted** (`gap`), never as zero. A gap is missing data; zero is a measurement.
- **Explicit titles naming the subject and both metrics**: "Portfolio risk vs. expected return, 12 candidate allocations" — not "Chart 1", not "Risk/Return".
- Standard chart title: **Aptos Narrow 12, bold, `#595959`, centered, no overlay.** Large comparison charts may use Aptos Narrow 14 bold.
- **Axis titles are required on analytical scatter charts**, including units.
- **Legend at the top** for multi-series line charts. **Hide the legend** on color-coded scatter charts when the title already explains what the colors mean.
- **Green for strong / high / good, red for weak / low / bad.** Keep this consistent across every chart in the workbook. Do not also use red for a neutral series somewhere else.
- Place each chart to the **right of or below its source data**, on the same sheet, so the reader can see what produced it. Dashboard charts are the exception and must link to data elsewhere.
- Dashboard charts must be readable without zooming: fewer series, larger fonts, no dense gridlines.
- Do not let a chart obscure cells. Anchor it in empty space.

---

## Tables and pivot tables

**Default to formatted ranges, not Excel tables.**

- Do not create Excel tables (`ListObject`) or pivot tables by default.
- **The sanctioned exception is Power Query output**, which necessarily loads as a `ListObject`. There, strip the built-in table style and apply the house style over it, and keep the AutoFilter — see `power-query-data-sheets.md`.
- Use a formal table only when filtering, structured references, or dynamic aggregation genuinely require it.
- Where you do create one, apply the house header formatting on top of a plain table style — do not accept the default blue banded style, which collides with the palette.

Why: Excel tables impose their own formatting layer that overrides named styles, auto-expand in ways that break adjacent blocks, and rename references in a way that makes formulas harder to read in a printed audit. In a workbook whose whole point is a legible convention, they fight the convention.

---

## Conditional formatting

- **Do not add conditional formatting for decoration.** Data bars, color scales, and icon sets inside a calculation grid make it impossible to tell the semantic fill from the computed one.
- **Never use conditional formatting to alter the negative-number convention.** Negatives are black with a leading minus (`number-formats.md`).
- Where conditional formatting is genuinely useful — a large grid where outliers matter, a heatmap of sensitivities — keep its colors **separate from the core input/output palette**. Do not use `#BDD7EE`, `#FFFF00`, `#FFD966`, `#F2F2F2`, `#000080`, or `#E2EFDA` in a conditional rule — nor `#FFCC99` or `#D0D0D0` in an Audit Standard workbook.
- Check cells are the sanctioned exception: PASS/WARN/FAIL colors may be applied by conditional formatting, since they sit outside the core palette by design.
- Document every conditional-formatting rule in Documentation. An invisible rule that colors a cell is indistinguishable from a manual fill to the next reader, and it will be wrong eventually.

---

## Sensitivity and comparison grids

Common enough to deserve a house pattern:

- Row and column headers use `RowTitle` (indigo, yellow bold) so the axes of the grid are unmistakable.
- Grid cells are `Output` if they are results to read, unfilled if they are intermediate.
- The base case gets the `Result` style (navy fill, white bold figure); the selected case, if different, gets the pale-green recommendation fill.
- One number format across the whole grid — mixed precision in a sensitivity table is unreadable.
- Put the two varied drivers' names and units in the corner cell as `ExplanatoryText`.
