# Sheet standards

What each sheet **role** must contain and how it is laid out. Roles, not names — only Menu, Documentation, and Dashboard are named sheets; everything else is named after the actual work (`workbook-architecture.md`).

All sheets share the skeleton: rows 1–2 blank, title on row 3, columns A and B empty, content anchored at column C, blank row after the title.

---

## Dashboard

The dashboard answers the question the workbook exists to answer. A reader who opens only this sheet should leave with the conclusion and know where it came from.

Layout:

| Row | Element |
|---|---|
| 1–2 | blank |
| 3 | navy title bar `C3:F3+` — `#000080`, white bold Arial 12–13, row height up to `22 pt` |
| 4 | blank |
| 5 | indigo context bar — `#333399`, **yellow** bold Arial 9 (`RowTitle`): scope, period, currency, as-of date |
| 6 | blank or first section bar |
| 7+ | content blocks |

Palette in use:

| Element | Fill |
|---|---:|
| Title | `#000080` |
| Context bar, section bars | `#333399` |
| Table headers | `#333399` (white text) |
| Surfaced inputs | `#BDD7EE` |
| Outputs | `#F2F2F2` |
| Recommendation | `#E2EFDA` |
| Key metric | `#000080` (white bold font) |
| Explanatory card | `#FFFFCC` |

Hard rules:

- **Every dashboard value links to a source cell** — a reference to the sheet that computed it, never a retyped number. A dashboard that duplicates a result will diverge from it, and the reader has no way to know which copy is stale.
- **Never hardcode a dashboard result that already exists elsewhere in the workbook.** This is the single most damaging defect in this standard.
- Key-result rows are vertically centered, ~`30 pt` high.
- Mirror the workbook-level integrity checks here, so a reader sees at a glance whether the workbook is internally consistent.
- Charts on the dashboard must be readable without zooming.
- Keep it to one screen where possible. A dashboard that scrolls is a report.

---

## Documentation

Everything a future reader — including the author in six months — needs in order to trust and re-run the workbook.

Required sections, each opened by an indigo `#333399` bar with white bold Arial 9:

1. **Purpose and scope** — what question this workbook answers, for whom, as of when.
2. **Methodology** — the approach, the formulas that matter, why this method over alternatives.
3. **Color convention** — the declared palette profile, spelled out (`palette-profiles.md`). This is not optional; it is the legend for the entire workbook.
4. **Sign and unit conventions** — what is negative, which currency, which scale.
5. **Technical dependencies** — Excel version, required functions, whether Python, an add-in, or an API is needed to recalculate.
6. **External libraries** — name and version of anything the workbook calls; described in prose, never as source code in cells.
7. **Data sources** — where each input came from, with `Hlink` URLs and retrieval dates.
8. **Limitations** — what the workbook does not capture, and where it should not be trusted.
9. **Operating instructions** — which cells to change, what to press, what to re-read.
10. **Update requirements** — what must be refreshed, how often, by whom.

Formatting: narrative notes on `#FFFFCC` wrapped and top-aligned; tool and library descriptions in gray italic `ExplanatoryText`; links in `Hlink`. External URLs belong here or in a dedicated Sources block — **not** in calculation grids.

Where a sheet was deliberately left out of the menu, say so here.

---

## Task sheets

The working sheets. One per task or analysis, named after the work.

Each analytical block follows the same six-part shape:

1. **Section title** — indigo bar, `SectionHeader`.
2. **Methodology note** — `Note` or `ExplanatoryText`, where the method is not self-evident.
3. **Parameter block** — the inputs this block consumes, blue `SourceData` (blue even when surfaced by a cross-sheet link — nobody edits it here), before any formula.
4. **Calculation block** — unfilled, Arial 10, long formulas split into helper rows.
5. **Output block** — `Output`, bordered.
6. **Interpretation or recommendation** — what the numbers mean; `Result` for the decisive figure, `Recommended` where a choice is made.

Rules:

- Parameters come **before** the formulas that use them. A reader scrolling down should meet inputs, then arithmetic, then answers.
- One blank row between major blocks.
- Keep intermediate calculations unfilled — they are scaffolding, not results.
- Move long helper schedules to a support-calculation sheet; a task sheet should hold the analysis, not the bookkeeping.
- Tasks at the same analytical level share a tab color.
- A task sheet that has grown past two or three blocks is usually two tasks.

---

## Shared inputs

The role, wherever it lives — its own sheet in a larger workbook, or a block at the top of a task sheet in a small one.

It is the **single source of truth**: if a number can be changed, it is here.

Structure:

| Row | Element |
|---|---|
| 1–2 | blank |
| 3 | title |
| 4 | blank |
| 5 | first section header (`SectionHeader`) |
| 6 | table header |
| 7+ | input rows |

Column layout:

| C | D | E | F |
|---|---|---|---|
| Label | Value | Unit | Source / method marker |

- Base data and sourced parameters use blue `SourceData` — filled once, changed only when the world changes.
- Yellow `Input` marks the assumptions and drivers the user tunes — growth rates, margins, scenario and model settings — kept in their own clearly-headed block, not interleaved with base data. This sheet is where the yellow knobs live; elsewhere they appear only as blue surfaced links.
- `Constant` for values fixed by the task or methodology.
- Blank row between groups.
- Every non-obvious value gets a source in column F or a `Note`.

Rules:

- **Do not scatter editable values across calculation blocks.** The exception is a clearly identified scenario control adjacent to the block it drives — and even then, prefer a link back to the shared inputs.
- Every input must be referenced by at least one formula. An unused input is either dead or evidence of a broken link; find out which.
- Repeat the reader instruction near the top: *fill only the blue and yellow cells; never type over an unfilled calculation cell.*

---

## Engine / external model

Where computation from outside Excel lands — Python, a solver, an API, a quantitative library.

- Title on row 3, like everywhere else; a long model title may drop to Arial 10–12 bold to fit.
- Method markers (`Py`, `Model`, `API`, `Solver`) in the marker column to the right of each block, or as an `ExplanatoryText` line above it.
- Where a call returns a spilled array, the call formula may sit in the first cell of the block's indigo output header, with the spill filling the block below.
- Multi-line model answers get ~`42 pt` rows or autofit, with wrap on.
- Intermediate steps stay unfilled; delivered results take `Output`; the decisive one takes `Result`.
- **No source code in cells.** Describe the code in Documentation.

---

## Power Query data

Query output loaded to the worksheet. Full rules in `power-query-data-sheets.md`; the short version:

- **Last in tab order**, after everything else. Tab color `#BFBFBF`. Listed in the menu — these sheets carry the workbook's provenance.
- Named `Data <n> <short id>`, the slug matching the Power Query query name.
- Loaded to `C6` so the sheet keeps the standard skeleton, one query per sheet.
- The built-in table style is **replaced**: banding off, total row off, AutoFilter kept, header row `SectionHeader`, body uniformly `SourceData` blue — imported data is source data, filled once by the refresh.
- A `PQ: <simple headline>` caption in `RowTitle` sits directly above the header row, with `PQ` in the marker column.
- Column types set in the query; display formats applied per column.
- **Everything downstream references the data.** Never copy it, never type into it — a refresh silently overwrites the edit.

---

## Support calculations

Machinery. Long schedules, lookup tables, intermediate grids, unit conversions, scratch derivations.

- Last in tab order, **no tab color**.
- Omitted from the menu unless users need direct access — note the omission in Documentation.
- Same skeleton (row 3 title, columns A/B empty) so it does not feel like a different workbook.
- Still classified: blue for sourced inputs, unfilled for calculations, `Output` where something feeds a task sheet.
- This is where "it got long" goes. It is not where "it got messy" goes — the same rules apply.
