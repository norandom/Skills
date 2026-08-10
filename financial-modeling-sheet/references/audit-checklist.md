# Application workflow, definition of done, and the audit report

---

## Application workflow

The order matters. Later steps consume decisions made earlier, and doing them out of order produces a menu that disagrees with the tabs and a dashboard that disagrees with the model.

1. **Inspect.** Sheet order, used ranges, tab colors, view settings, formulas, named styles, column widths, notes, charts, hidden structures, existing color conventions.
2. **Classify.** Assign a semantic class to every target block *before* formatting anything (`cell-classes.md`). Write the classification down if the workbook is large.
3. **Preserve.** Identify formatting that is already coherent and leave it alone (`mode-map.md`).
4. **Build the shared inputs first**, before any downstream calculation is styled or created.
5. **Apply named styles**, reusing what the workbook already defines (`named-styles.md`).
6. **Update tab colors** to the purpose code.
7. **Update the menu** — only after the tab order is final, generated from the actual tabs and their actual colors.
8. **Verify every internal hyperlink** resolves.
9. **Verify number formats and negative-value presentation.**
10. **Confirm charts, notes, and outputs are readable** at 100% zoom without clicking anything.
11. **Check for formula errors and broken references.**
12. **Normalize any Power Query output** (`power-query-data-sheets.md`) — position, name, table style, caption, types — and refresh once to confirm the formatting survives.
13. **Run the definition of done** below.

---

## Definition of done

The workbook is deliverable only when every line passes. In AUDIT mode, this list *is* the deliverable — report each line as pass, fail, or not applicable.

### Architecture

- [ ] Sheet order runs menu, documentation, dashboard, then task sheets; optional role sheets (shared inputs, engine, support calculations) are placed correctly, and Power Query data sheets are last.
- [ ] One naming pattern and one language throughout.
- [ ] Tab colors identify sheet purpose; same-level modules share a color; support sheets uncolored.
- [ ] Gridlines and row/column headings visible on every sheet.
- [ ] Freeze panes absent, or present only where justified.

### Layout

- [ ] Rows 1–2 blank and the title on row 3 on every sheet.
- [ ] Columns A and B empty on every sheet; content anchored at column C.
- [ ] Blank row after every title; blank row between major sections.
- [ ] **No merged cells** introduced anywhere — titles span by range formatting, text in the leftmost cell.
- [ ] No truncated titles or labels; no `####` in any numeric cell.
- [ ] Method/source markers in each block's right-hand marker column, not in A or B.

### Navigation

- [ ] Menu order matches tab order exactly.
- [ ] Every user-facing sheet is listed; hidden and purely technical sheets are omitted deliberately.
- [ ] Every menu hyperlink resolves to the intended sheet's `A1`.
- [ ] Menu swatches match the **actual** tab colors exactly.
- [ ] The reader instruction ("fill only the blue and yellow cells; never type over an unfilled calculation cell") appears on the menu and wherever the editable inputs live.

### Semantics

- [ ] One color convention in force — current House Style, Audit Standard, or the legacy house palette — declared on Documentation, never mixed.
- [ ] Source data, assumptions, constants, calculations, model calls, outputs, key results, and recommendations are each visually distinct.
- [ ] Filled-once source data (blue) and tunable assumptions (yellow) are not conflated: a knob is yellow only where it lives and is edited; a copy surfaced into a parameter block is blue.
- [ ] No block was formatted without first being classified; no whole-used-range formatting.
- [ ] Calculations remain unfilled and quiet (House Style, legacy house palette) or uniformly gray (Audit Standard).
- [ ] Navy appears only on genuine key results; yellow fills only on assumptions the reader is invited to tune.
- [ ] **Zero work-in-progress fills remain** — no `#F8CBAD` (House Style), no `#FFFF99` (Audit Standard).
- [ ] Green-font mixed-content cells are zero, or each is justified in Documentation.

### Numbers

- [ ] Every numeric column has an explicit number format.
- [ ] Precision is consistent within each row and table, and no higher than the inputs support.
- [ ] Units and scale live in their own column or the block header — never inside numeric cells.
- [ ] Negatives show a leading minus in the normal font color; no red, no parentheses.
- [ ] Zero displays as zero in the row's format, not as a dash.
- [ ] Sign convention consistent and documented.

### Content and integrity

- [ ] The shared inputs are the single source of truth; no editable constants live in formulas or scatter across calculation blocks.
- [ ] Every dashboard output links to a source calculation; nothing is duplicated.
- [ ] Notes and methodology are present and readable.
- [ ] Documentation covers purpose, methodology, color convention, dependencies, sources, limitations, instructions, and update requirements.
- [ ] Check block present where the model has consistency conditions, showing delta and location.
- [ ] No `#REF!`, `#DIV/0!`, `#VALUE!`, `#NAME?`, `#SPILL!`; every `#N/A` explained.
- [ ] No unintended circular references.

### Visuals

- [ ] Charts use `XYScatter`, `XYScatterLines`, or `Line`; no 3D.
- [ ] Chart titles name the subject and the metrics; axis titles present on analytical scatters.
- [ ] Blanks plotted as not plotted.
- [ ] Legend at top for multi-series lines; hidden on self-explaining color-coded scatters.
- [ ] Dashboard charts readable without zooming.
- [ ] No decorative conditional formatting; no default-styled Excel tables or pivots unless required.

### Power Query

- [ ] Query output lives on its own `Data <n> <short id>` sheet, last in tab order, tab `#BFBFBF`, listed in the menu.
- [ ] Loaded at `C6`; built-in table style removed; banding and total row off; AutoFilter kept.
- [ ] `PQ: <headline>` caption in `RowTitle` directly above the header row, with `PQ` in the marker column.
- [ ] Header row `SectionHeader`; body uniformly `SourceData` blue with no unfilled cells.
- [ ] Column types set in the query; display formats applied per column and uniform down each column.
- [ ] "Preserve cell formatting" on, "Adjust column width" off, verified by an actual refresh.
- [ ] Every consumer references the data; nothing copies it; no typed values or formula columns inside the loaded range.

---

## The audit report

AUDIT mode delivers a report, never a modified file. Structure it as:

**1. Verdict.** One paragraph: is this workbook trustworthy for a reader who did not build it? Name the single worst problem.

**2. Profile and architecture.** Which color convention is in force — current House Style, Audit Standard, or the legacy house palette — or that conventions are mixed; whether the sheet order and tab colors follow the code; whether the menu matches the tabs.

**3. Findings**, severity-ordered:

| # | Severity | Sheet / range | Finding | Why it matters | Fix |
|---|---|---|---|---|---|
| 1 | blocking | Dashboard `D12` | key metric is a typed `4.28`, not a link to `'Task 3'!D31` (`4.31`) | dashboard already disagrees with the workbook | replace with `='Task 3'!D31` |
| 2 | major | Menu `C7:C19` | menu row order does not match tab order | navigation misleads | regenerate the menu from tab order |
| 3 | minor | `Task 1` `D7:D19` | units typed into value cells (`5 %`) | forces text; breaks downstream math | move unit to column E, format `0.00%` |

Severity definitions:

- **Blocking** — the workbook misleads a reader about what a number is or where it came from, or it cannot be trusted to recalculate. Includes mixed palette profiles, hardcoded dashboard results, error values, and unclassified whole-range formatting.
- **Major** — navigation, consistency, or convention is broken but no number is wrong. Includes menu/tab mismatches, missing documentation, inconsistent precision.
- **Minor** — cosmetic. Row heights, widths, alignment, spacing.

**4. What is already right.** Say it. An audit that lists only faults gets read as hostile and acted on selectively.

**5. Recommended next step.** Usually: "approve a targeted RESTYLE covering findings 1–4", with an estimate of what will be touched.

Then stop. Do not apply the fixes in the same run.
