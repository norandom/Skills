# Formula integrity, checks, and legacy normalization

Formatting makes a model legible. Integrity makes it true. This standard requires both, and a beautifully formatted workbook with a broken reference fails the definition of done.

---

## Formula integrity rules

- **Preserve formulas and cross-sheet references.** Never replace a formula with its computed value to "clean up" — that severs the model.
- **The shared inputs are the source of editable parameters.** Anything a reader might change lives there or in a marked control block.
- **No editable hardcodes inside formulas.** `=D7*1.19` hides an assumption. Move `1.19` to the shared inputs and reference it. Mark surviving instances with a green font (`palette-profiles.md`) and treat them as a to-do.
  - Exempt: structural constants that are arithmetic rather than assumptions — `12` months, `365`/`360` day count, `100` for percent, `2` in an average, `1` in `1+g`.
  - Test: could a reasonable reader want a different value? If yes, it is an assumption.
- **Use helper cells for complex logic.** A formula that does not fit in the formula bar cannot be checked by a human. Split it into named steps on the sheet or on Support Calculations.
- **Label external model calls** with a marker in the block's right-hand marker column.
- **Dashboard values link to source calculations.** No duplicated results anywhere.
- **No source code in cells** — no VBA, no Python scripts, no shell. Cells hold values, formulas, and calls.
- **Preserve the workbook's calculation and sign conventions** even where you would have chosen differently.

## Errors that block delivery

No workbook ships containing:

- `#REF!` — a reference was deleted. Always a real defect.
- `#DIV/0!` — wrap with a guard (`=IFERROR(...)` or an explicit denominator test) **and** decide what zero should display as. Do not blanket-`IFERROR` a sheet; that hides the next bug too.
- `#VALUE!` — usually a unit string stored in a numeric cell (`number-formats.md`) or a text/number mismatch.
- `#NAME?` — a missing function, add-in, or defined name; often a model call that cannot run on this machine. Document the dependency.
- `#N/A` — acceptable **only** when it means "genuinely not applicable" and a `Note` says so. Unexplained `#N/A` is a defect.
- `#SPILL!` — a spilled array blocked by content below it. Clear the range; do not shrink the model output.

Also blocking, though not error values:

- A circular reference that is not a deliberate, documented iterative calculation.
- A formula referencing an empty cell where a value is required.
- An assumption that no formula references (dead input, or a broken link).

---

## The check block

Where a workbook has internal consistency conditions, make them visible. Put a check block at the top or the end of each relevant sheet, and mirror the workbook-level set on the Dashboard.

A check row has four parts:

| C | D | E | F |
|---|---|---|---|
| What is being checked | Measured delta | Status | Affected location |

Formatting per `cell-classes.md`:

| State | Fill | Font | Shows |
|---|---:|---:|---|
| PASS | `#C6EFCE` | `#006100` | `OK` and the delta (`0.00`) |
| WARN | `#FFEB9C` | `#9C5700` | the tolerance breached and the delta |
| FAIL | `#FFC7CE` | `#9C0006` | `DEVIATION`, the delta, and the cell reference |

Rules:

- **Always show the measured delta**, not just the word. `OK` with no number cannot be falsified, and a check nobody can falsify is decoration.
- **Never rely on color alone** — a colorblind reader and a black-and-white printout both need the text.
- **Never rely on text alone** — the color is what makes a failure visible from across the sheet.
- Do not reuse input or output colors for checks.
- State the tolerance explicitly where one applies (`|delta| < 0.01`), as `ExplanatoryText`.

### Checks worth having

Domain-neutral:

- Totals reconcile: components sum to the stated total.
- Cross-sheet ties: a value surfaced on the Dashboard equals its source.
- No hardcodes: a count of green-font (mixed-content) cells, target zero.
- Every assumption referenced at least once.
- Sign discipline: outflows negative, inflows positive.
- Units consistent within each table.
- No error values anywhere in the workbook.

Domain-specific checks — a balance sheet that balances, a mass balance that closes, a probability set that sums to one — are the model author's to define. This standard does not know them; it requires only that wherever they exist, they are visible, show their delta, and surface on the Dashboard.

---

## Legacy normalization

Real workbooks accumulate inconsistencies. Three specific ones show up in reference material and **must not be reproduced** in a standardized workbook:

1. **Menu order that does not match tab order.** A legacy menu written from the plan rather than from the workbook drifts as sheets move. The standardized menu follows the tabs, always. Fix the menu, not the tabs — unless a reorder was approved.
2. **Menu swatches that are *nearly* the tab color.** A dashboard swatch one shade off the actual dashboard tab teaches the reader that the color code is approximate. Read swatches programmatically from the actual tab colors.
3. **Support Calculations omitted from the menu.** This one is *deliberate* and should be **preserved** — the sheet is machinery. Only add it if users need direct access, and note the decision in Documentation.

The general rule for legacy quirks: an inconsistency that misleads gets fixed; an inconsistency that is a deliberate simplification gets preserved and documented. When you cannot tell which one you are looking at, report it in AUDIT rather than guessing in RESTYLE.

---

## Integrity checklist

- [ ] No `#REF!`, `#DIV/0!`, `#VALUE!`, `#NAME?`, `#SPILL!` anywhere.
- [ ] Every `#N/A` explained by an adjacent note.
- [ ] No unintended circular references.
- [ ] No editable constants inside formulas; zero green-font cells remaining, or each justified in Documentation.
- [ ] Every dashboard value is a link, not a retyped number.
- [ ] Every assumption referenced by at least one formula.
- [ ] Long formulas decomposed into helper rows.
- [ ] External model calls marked and their dependencies documented.
- [ ] Check block present, showing deltas and locations, in both color and text.
- [ ] Sign and unit conventions applied consistently and stated in Documentation.
