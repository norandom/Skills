# Implementation: working through an Excel add-in

This standard is applied **inside Excel**, through an assistant add-in — Claude for Excel or ChatGPT for Excel — driving the live workbook. Not by generating a file offline and handing it over.

That choice is deliberate. The add-in sees what Excel sees: real named styles, real tab colors, live Power Query connections, evaluated formulas, actual column widths. A file written outside Excel loses connections, drops cached values, and cannot verify its own work.

---

## The operating rules

**1. Instruct per block, by range and semantic class.**

> "Apply the `SourceData` style to `D9:D19` on `Task 1` — fill `#D0D0D0`, Arial 10 black, no border."

Never "format this sheet" or "make the results look good". Every instruction names a range and the class that range belongs to. If you cannot name the class, go back to `cell-classes.md` before touching the cell.

**2. Name the class, not just the color.** The class is what a later reader can check against Documentation; the color is a consequence of it. An instruction that says only "make it gray" produces a workbook nobody can audit.

**3. Create the named styles first, then apply them by name.** One pass to define `Header`, `SectionHeader`, `RowTitle`, `SourceData`, `Input`, `Constant`, `Output`, `Result`, `Recommended`, `Note`, `ExplanatoryText`, `CheckPass/Warn/Fail`. Then every subsequent instruction is "apply `Output` to …". This is what makes a later restyle one change instead of a thousand.

Before creating any style, **check whether the workbook already defines it** — including under a legacy alias (`named-styles.md`). Reuse beats duplication.

**4. Verify by reading back.** After each meaningful batch, ask the add-in to report what is actually in the workbook — the fill of a sample cell, a sheet's tab color, the sheet order, whether a hyperlink resolves — and compare against what you asked for. Add-ins mis-apply ranges and silently skip cells. An unverified formatting pass is an assumption.

**5. Work on a copy for anything destructive.** RESTYLE mode edits a live file with no undo history once the session ends. Duplicate the workbook first and say where the copy is.

**6. Do the work in order.** Styles, then architecture, then classification, then formats, then charts, **then the menu last** (`audit-checklist.md`). Building the menu before the tab order is final guarantees it will be wrong.

---

## Units as Excel reports them

| Property | Excel's unit | This standard |
|---|---|---|
| Row height | points | use the values directly — `15 pt`, `12.75 pt`, `15.75 pt`, `22 pt`, `30 pt` |
| Column width | characters (width of one `0` in the default font) | divide the points in `typography-and-layout.md` by about `5.25` |

So a `228 pt` menu column is roughly width `43`; a `60 pt` column is roughly `11.4`; the empty `20 pt` margin columns A and B are roughly `3.8`.

Set widths **after** the content and styles are in place, then check that nothing truncates and no numeric cell shows `####`.

## Colors

Give hex with the `#`, as Excel's color picker accepts it: `#D0D0D0`, `#333399`, `#FFC000`. The full palette is in `named-styles.md`.

For tab colors and menu swatches: **read the actual tab color out of the workbook and apply that value to the swatch.** Do not retype a color from the architecture table — a sheet may legitimately carry a different level color than you expect, and a swatch that is one shade off teaches the reader the code is approximate.

---

## Things add-ins get wrong

Watch for these specifically, because they are the recurring failure modes:

- **Merging cells to make a title span.** Explicitly forbid it. The instruction is: format `C3:F3`, put the text in `C3` only.
- **Applying a fill to the whole used range** when asked to "style the sheet". Always give bounded ranges.
- **Overwriting a formula with its computed value.** State that formulas must be preserved; spot-check the formula bar afterwards.
- **Reverting a number format when a style is applied.** Apply the style first, then the number format — assigning a style replaces the cell's whole format.
- **Storing a percentage as `4.89` and formatting it `0.00%`**, which renders `489.00%`. Percentages are stored as fractions.
- **Adding a default-styled Excel table** when asked to format a range. Formatted ranges are the default here (`charts-and-tables.md`).
- **Adding red/parenthesis negative formats** out of habit. The convention is a single-section format with a leading minus (`number-formats.md`).
- **Losing leading zeros** on codes and IDs by typing them as numbers. Irreversible; set the column to text first.

## Power Query specifics

All of these are done through Excel's own UI, and the add-in should be instructed to use it rather than to rewrite cells:

- **Load destination `C6`**, one query per sheet, on a `Data <n> <short id>` sheet at the end.
- **Remove the built-in table style** (set the table style to *None*), turn off banded rows and columns, turn off the total row, keep the AutoFilter.
- **Set column types in the query** (a `Changed Type` step), not by formatting the landed cells — formatting a text column as a number changes nothing but the alignment.
- **Query Properties**: "Preserve cell formatting" on, "Adjust column width" off.
- **Refresh once and re-check the header color** before declaring the sheet done. Formatting that does not survive a refresh has not been applied.

Full rules in `power-query-data-sheets.md`.

## Charts

Insert charts through Excel so they carry real series references. `XYScatter`, `XYScatterLines`, or `Line` only; no 3D. Set the title text explicitly, set axis titles on analytical scatters, and set blanks to be plotted as gaps — the default is often "zero", which turns missing data into a measurement.

Chart title styling (Aptos Narrow 12 bold `#595959`, centered, no overlay) is set on the title object directly.

---

## When the add-in cannot do something

Some things are fiddly or unsupported depending on the add-in and Excel build: exact chart-title fonts, conditional-formatting rule management, Query Properties toggles, very large formatting sweeps.

When you hit one:

- Say so plainly rather than approximating.
- Give the user the manual steps — which dialog, which checkbox.
- Record the gap in Documentation if the workbook ships without it, so the next person does not assume it was checked.

Never substitute a visually similar result for the specified one without saying you did.
