# Mode map: what each mode may touch

Four modes. Identify one, lock it, and stay inside it until its output is complete. The modes differ mainly in **what they are allowed to destroy**.

---

## Recognizing the mode

| The user says | Mode |
|---|---|
| "build a workbook for…", "I need a model for…", "make me a template" | **CREATE** |
| "add a sheet", "add a scenario module", "extend this with a dashboard" | **EXTEND** |
| "check this against the standard", "does this follow the house style", "review the formatting" | **AUDIT** |
| "standardize this", "clean this up", "apply the house style to this file" | **RESTYLE** |

Ambiguity rules:

- "Fix this workbook" is **AUDIT first**. Report, then ask which findings to apply. Do not assume permission to write.
- "Make it look professional" on an existing file is **RESTYLE**, and needs the RESTYLE gate below.
- If the request is really about whether the numbers are right, it is not a mode of this skill. Say so, and offer the presentation work instead.

---

## CREATE

You control every cell, so there is nothing to preserve and no gate.

Order of construction — this order matters, because navigation and dashboards depend on decisions made earlier:

1. Decide the sheet list and the final tab order (`workbook-architecture.md`).
2. Declare the palette profile and the sheet-naming pattern; record both on Documentation.
3. Create sheets in tab order, apply tab colors, set view (gridlines on, headings on, no freeze panes).
4. Build the **shared inputs** first. Nothing downstream may contain an editable constant.
5. Build the engine sheet if there is one, then the task sheets in increasing complexity.
6. Build support calculations; move long helper schedules there. Load any Power Query output to its own `Data <n> <short id>` sheet at the end (`power-query-data-sheets.md`).
7. Build the Dashboard, linking every value back to a source cell.
8. Build Documentation.
9. Build the **Menu last**, generated from the actual tab order.
10. Run `audit-checklist.md`.

---

## EXTEND

You are adding to a workbook someone else's reader already knows. The new material must be indistinguishable in style from the old.

Before writing anything, inspect and record:

- Sheet order and tab colors — where does the new sheet belong, and which level color does it inherit?
- The existing palette profile — infer it from how formula cells are filled, not from what looks nicer.
- Named styles already present — reuse them; do not create `Input2` or `Header_new`.
- Title row, content anchor column, and helper column conventions actually used in this file. If the file anchors at column B rather than C, **match the file**, not this document.
- Number-format and precision conventions per table.

Then:

- Add the sheet at the correct position, not at the end, unless it is a support-calculation sheet.
- Add the menu row in the matching position, with the swatch read from the actual tab color.
- Leave every existing cell alone. An EXTEND that changes existing formatting has silently become a RESTYLE.

If the existing workbook contradicts this standard *coherently* (a consistent alternate convention), follow the workbook. Note the deviation in your response; offer a RESTYLE separately.

---

## AUDIT

**AUDIT never writes to the workbook.** Not a fill, not a tab color, not a fixed typo. The deliverable is a report.

Inspect in this order and record findings against `audit-checklist.md`:

1. Sheet order vs. the architecture; hidden and very-hidden sheets.
2. Tab colors vs. the purpose code; duplicated colors across different levels.
3. View settings per sheet: gridlines, headings, freeze panes, zoom.
4. Merged cells anywhere in menus, tables, headers, or calculation areas.
5. Title rows, anchor columns, blank-row discipline.
6. Menu: order vs. tab order, swatch fidelity, every hyperlink target resolves.
7. Cell classification: sample each block and ask whether its fill matches its role. Flag whole-range formatting.
8. Palette coherence: is one profile in force, or have two been mixed?
9. Number formats and precision within each row and table; unit text stored inside numeric cells.
10. Negative-value presentation, including conditional formatting that recolors negatives.
11. Formula integrity: error values, hardcoded constants inside formulas, dashboard values that duplicate rather than link.
12. Charts: type, 3D, titles, axis titles, blanks handling, legend placement.
13. Residual work-in-progress fills.
14. Power Query output: still carrying a built-in table style, loaded to `A1`, copied rather than referenced, or edited in place.

Classify every finding as **blocking** (misleads a reader about a cell's role, or the workbook cannot be trusted), **major** (breaks navigation or consistency), or **minor** (cosmetic). Use `assets/audit-report-template.md`.

Report, then stop. If the user wants the fixes applied, that is a new RESTYLE run.

---

## RESTYLE

The only destructive mode. Three gates before the first write:

1. **Explicit go-ahead.** The user must have asked for the workbook to be changed, or approved an audit's findings. "Take a look at this" is not approval.
2. **A backup.** Work on a copy, or confirm the original is under version control. State the backup path in your response.
3. **A scope decision.** Full restyle or targeted fixes? A full restyle overwrites coherent local formatting; targeted fixes do not. Default to **targeted** unless the user explicitly asked for a full restyle.

### The preservation contract

Unless the user explicitly asked for a full restyle, these survive untouched:

- Every formula and every cross-sheet reference.
- Named ranges, defined names, and data validation.
- Charts, images, and their source ranges.
- Cell comments and notes.
- Existing named styles (reuse; do not redefine).
- Column widths and row heights that are already deliberate.
- Hidden rows, columns, sheets, grouping, and outlining — do not unhide without asking; something may be hidden for a reason.
- Locally coherent formatting: a block that follows *some* consistent convention is preserved even if it is not this one, unless converting it is the point of the request.
- Print areas, headers/footers, and page setup.

What RESTYLE may change: fills, fonts, borders, alignment, number formats, tab colors, sheet order (with approval), the menu sheet, and row heights/column widths that truncate content.

**Never** in RESTYLE: rewrite a formula to "clean it up", delete a sheet, unmerge a merged cell that carries a value without relocating the value first, or reorder a populated workbook without approval.

### The change log

Every RESTYLE ends with a log the user can review and reverse:

| Sheet | Range | Before | After | Reason |
|---|---|---|---|---|
| `Task 1` | `D7:D19` | no fill, Calibri 11 | `SourceData` (blue `#BDD7EE`, Arial 10) | sourced parameters were indistinguishable from calculations |
| Dashboard | tab color | none | `#7030A0` | tab color is the purpose code |

Report counts too: cells reclassified, sheets recolored, links repaired, formats normalized. If you left something alone deliberately, say so — an unexplained omission reads as an oversight.

---

## Mode boundary violations to avoid

- Drifting AUDIT -> RESTYLE because a fix was one click away.
- Drifting EXTEND -> RESTYLE by "harmonizing" the sheets you passed on the way.
- Drifting CREATE -> content authorship: this skill formats the model, it does not invent the assumptions. Ask for the numbers or mark them clearly as placeholders using the WIP convention in `palette-profiles.md`.
- Silently converting a coherent Audit Standard workbook to House Style because House Style is the default.
