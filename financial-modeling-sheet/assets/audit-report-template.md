# Asset: audit report template

The deliverable of AUDIT mode. **No file changes accompany it.**

---

## 1. Verdict

One paragraph. Is this workbook trustworthy for a reader who did not build it? Name the single worst problem, and say whether the workbook is safe to circulate as-is.

> *Example:* Structurally sound and easy to navigate, but not safe to circulate: three dashboard figures are typed constants rather than links, and one of them already disagrees with the sheet that computes it (`4.28` vs `4.31`). Fix that before anyone reads the summary.

## 2. Profile and architecture

- **Palette profile in force:** House Style / Audit Standard / **mixed** / none.
- **Sheet order:** does it run menu, documentation, dashboard, then task sheets?
- **Tab colors:** applied? do same-level sheets share a color?
- **Menu:** does row order match tab order? do swatches match the actual tabs? do all links resolve?
- **Skeleton:** rows 1–2 blank, title on row 3, columns A and B empty, content at column C?

A mixed palette profile is reported here and is always blocking — it inverts the meaning of gray and makes every other finding secondary.

## 3. Findings

Severity-ordered, most severe first.

| # | Severity | Sheet / range | Finding | Why it matters | Fix |
|---|---|---|---|---|---|
| 1 | blocking | Dashboard `D12` | key metric typed as `4.28`, not linked to `'Task 3'!D31` (`4.31`) | the summary already contradicts the workbook | replace with `='Task 3'!D31` |
| 2 | blocking | `Task 2` `D14:D26` | formula cells and typed inputs share the same gray fill | reader cannot tell what is editable | classify and restyle per `cell-classes.md` |
| 3 | major | Menu `C7:C19` | row order does not match tab order | navigation misleads | regenerate from the actual tab order |
| 4 | major | `Task 1` `D7:D19` | mixed precision, 2 and 4 decimals in one column | reads as arithmetic error | pick one, apply to the column |
| 5 | minor | `Task 3` `C:C` | label column truncates at 12 characters | labels unreadable | widen to ~117 pt |

### Severity definitions

- **Blocking** — the workbook misleads a reader about what a number is or where it came from, or it cannot be trusted to recalculate. Includes mixed palette profiles, hardcoded dashboard results, error values, unclassified whole-range formatting, and editable constants buried in formulas.
- **Major** — navigation, consistency, or convention is broken, but no number is wrong. Menu/tab mismatches, missing documentation, inconsistent precision, merged cells.
- **Minor** — cosmetic. Row heights, widths, alignment, spacing.

## 4. Definition-of-done summary

Run `references/audit-checklist.md` and report each group as pass / fail / not applicable:

| Group | Result | Notes |
|---|---|---|
| Architecture | pass | |
| Layout | fail | merged title cells on two task sheets |
| Navigation | fail | menu order, two dead links |
| Semantics | fail | mixed classification on `Task 2` |
| Numbers | pass | |
| Content and integrity | fail | three hardcoded dashboard values |
| Visuals | n/a | no charts |

## 5. What is already right

Say it, specifically. An audit that lists only faults gets read as hostile and acted on selectively.

> *Example:* The tab-color code is applied consistently and the four task sheets at the same level share a color, so the tab strip is genuinely readable. Documentation covers sources with retrieval dates — rare and worth keeping.

## 6. Recommended next step

Usually a scoped RESTYLE:

> Approve a targeted RESTYLE covering findings 1–4. It would touch: Dashboard `D10:D14`, `Task 2` `D14:D26`, the Menu sheet in full, and `Task 1` `D7:D19`. Formulas, charts, notes, and column widths elsewhere stay untouched. Estimated ~60 cells.

Then stop. Do not apply the fixes in the same run.
