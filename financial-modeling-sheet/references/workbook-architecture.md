# Workbook architecture

Sheet order, tab colors, view settings, and the layout skeleton every sheet shares.

---

## 1. Sheet order

Three fixed sheets, then the work.

1. **Menu** — navigation
2. **Documentation** — methodology, sources, conventions, limitations
3. **Dashboard** — results and recommendation
4. **Task sheets** — one per task or analysis, in the order the tasks are worked: `Task 1`, `Task 2`, `Task 3`, …
5. **Data sheets** — Power Query output, last (`power-query-data-sheets.md`)

The principle: **navigation, then context, then answers, then the work.** A reader who opens the file and reads left to right meets the conclusion before the derivation. A reviewer who wants the derivation walks further right.

### Naming

Only the first three sheets have names this standard prescribes, and even those may follow the project's own vocabulary (`Docu`, `Summary`, `Overview`) as long as their **role** is unmistakable and the naming is consistent within the workbook.

Task sheets are named after the actual work — `Task 1`, `Exposure`, `Sensitivity`, `Q3 Reforecast`, whatever the assessment calls them. **This skill does not prescribe those names.** Use one naming pattern throughout: either numbered (`Task 1`, `Task 2`) or descriptive (`Exposure`, `Sensitivity`), not a mix.

### Optional role sheets

Larger workbooks split three further roles onto their own sheets. Use them when the content justifies a sheet; otherwise keep the role as a block inside a task sheet.

| Role | When it earns a sheet | Where it goes |
|---|---|---|
| **Shared inputs** — parameters more than one task consumes | two or more task sheets read the same value | before the task sheets |
| **Engine** — external model, solver, or API output | computation happens outside Excel | before the task sheets |
| **Support calculations** — long helper schedules | a schedule crowds out the analysis on its sheet | after all task sheets |
| **Data** — Power Query output | any query is loaded to the worksheet | **last**, after everything else |

Wherever they live, the rules that matter are unchanged: shared inputs are the single source of truth for anything editable, engine output carries a method marker, and support calculations are machinery.

### Rules

- **Menu order must match tab order.** Not approximately — exactly. The menu is generated from the tab list, last, after the order is frozen.
- Keep every user-facing sheet visible.
- Purely technical helper sheets go last and may be omitted from the menu.
- **Do not reorder a populated existing workbook without approval.** People navigate by muscle memory and by tab position; reordering silently breaks that.
- One naming pattern and one language throughout.

---

## 2. Tab colors as a purpose code

The tab strip is the workbook's legend. Color encodes role, and the blues encode analytical depth — lighter is more foundational, darker is more advanced.

| Sheet role | Tab color |
|---|---:|
| Menu / navigation | `#000000` |
| Documentation | `#E8E8E8` |
| Dashboard / results | `#7030A0` |
| Shared inputs | `#FFC000` |
| Engine / external model | `#51154A` |
| Foundational task sheets | `#94DCF8` |
| Transition or special task | `#61CBF3` |
| Intermediate task sheets | `#0C769E` |
| Advanced task sheets | `#074F69` |
| Support calculations | *no tab color* |
| Power Query data | `#BFBFBF` |

Rules:

- **Tasks at the same analytical level share a tab color.** If three sheets are all foundational, all three are `#94DCF8`. A unique color per sheet destroys the code.
- Use only the levels the workbook needs. A workbook whose tasks are all at one level uses one blue.
- Support calculations deliberately have *no* color — the absence marks them as machinery.
- The menu swatch must be the **exact** tab color. Read it from the sheet; do not retype it from memory.

---

## 3. Workbook view

Apply to every sheet:

- **Gridlines visible.** Gridlines are the reader's coordinate system in a calculation workbook. Hiding them is a presentation-deck habit that makes auditing harder.
- **Row and column headings visible.** A reviewer needs to be able to say "D17".
- **No freeze panes by default.** Add them only where a sheet is long or wide enough that a header genuinely scrolls out of sight during normal reading. If you add them, freeze below the table header row and to the right of the label column.
- **Consistent zoom** across sheets, 100% unless a wide sheet needs otherwise.
- Do not introduce partial gridline settings within a workbook — all sheets on, or (rarely, and only if the file already does it) all sheets off.

### The merge ban

**Do not merge cells** in menus, calculation areas, tables, titles, or section headers. Merged cells break sorting, break range references, break arrow-key navigation, and break most programmatic reads.

To create a title bar spanning several columns: format the whole contiguous range (fill, font, borders) and put the **text only in the leftmost cell**. Visually identical to a merge; structurally intact.

Where a legacy workbook has merged title cells and you are in RESTYLE mode, unmerge only after relocating the value to the leftmost cell, and log it.

---

## 4. The layout skeleton

Every sheet in the workbook shares one skeleton. This constancy is what makes many sheets read as one document.

```
      A     B  |  C                    D          E        F
  1   (empty)  |
  2   (empty)  |
  3   (empty)  |  TITLE ......................................
  4   (empty)  |
  5   (empty)  |  SECTION BAR ................................
  6   (empty)  |  Header      Header     Header   Header
  7   (empty)  |  Label       Value      Unit     Method/Source
  8   (empty)  |  Label       Value      Unit     Method/Source
```

- **Rows 1 and 2 are blank** on every sheet. They are the top margin.
- **The title is on row 3** on every sheet — menu, documentation, dashboard, task sheets, support calculations, data sheets. One rule, no exceptions to remember.
- **Columns A and B are empty** on every sheet. They are the left margin. Set them narrow (about `20 pt` each) so the margin is visible but cheap.
- **Column C is the content anchor.** Titles, section bars, and row labels start in C.
- **Row 4 is blank** — at least one blank row after the title.
- **Row 5 is the first section bar** where the sheet has one; **row 6 is the first table header**; content begins on **row 7**.
- Leave **one blank row between major sections**.

### The marker column

Method and provenance markers — `Py`, `Model`, `API`, `Solver`, or a status label — go in a **marker column on the right of the block**, alongside units and source, not in the left margin. Columns A and B stay empty.

A standard parameter row therefore reads:

| C | D | E | F |
|---|---|---|---|
| Label | Value | Unit | Source / method marker |

For a block produced by an external engine, put the marker in the marker column of the block's header row, or as an `ExplanatoryText` line directly above the block. Either way the reader sees *this block did not come from Excel arithmetic* before they read the numbers.

### Block anatomy

A well-formed block is:

```
row n     section bar        (SectionHeader, fill #333399)
row n+1   table header       (RowTitle or SectionHeader)
row n+2…  content rows
row n+k   blank row
```

Never start a block immediately under the previous block's last row. The blank row is load-bearing: it is how a reader parses where one thing ends.

---

## 5. Hidden structures

- Do not hide sheets to tidy up. Move machinery to a support-calculation sheet instead.
- If sheets are already hidden, do not unhide them in EXTEND or RESTYLE without asking. Report them in AUDIT.
- Do not hide rows or columns inside a calculation block; a reader who copies the visible range will get the wrong answer.
- Grouping/outlining is acceptable for long schedules on support sheets, expanded by default.

---

## 6. Architecture checklist

- [ ] Menu, Documentation, and Dashboard come first, in that order.
- [ ] Task sheets follow, in the order the tasks are worked, under one naming pattern.
- [ ] Optional role sheets (shared inputs, engine, support calculations) are placed correctly and only where the content justifies a sheet.
- [ ] Tab colors applied; same-level tasks share a color; support sheets uncolored.
- [ ] Gridlines and headings visible on every sheet.
- [ ] No freeze panes except where justified.
- [ ] No merged cells anywhere in menus, tables, headers, or calculation areas.
- [ ] Rows 1–2 blank, title on row 3, row 4 blank on every sheet.
- [ ] Columns A and B empty and narrow on every sheet; content anchored at C.
- [ ] Blank row between major sections.
- [ ] Method markers in the block's right-hand marker column, never in A or B.
- [ ] Power Query output on its own `Data <n> <short id>` sheets, last in tab order, referenced rather than copied.
