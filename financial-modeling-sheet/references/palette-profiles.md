# Palette profiles: two conventions, never mixed

Two established color conventions exist for quantitative workbooks. They are individually coherent and mutually contradictory. **Gray means the opposite thing in each one.** A workbook that mixes them is worse than a workbook with no convention at all, because the reader believes the colors and is wrong.

Pick one profile per workbook. Declare it on the Documentation sheet. Never mix.

---

## The conflict, stated plainly

| Fill | House Style says | Audit Standard says |
|---|---|---|
| Gray | **source data / assumption the model consumes** | **calculation / formula cell** |
| Orange | user-controlled scenario input, or a task-given constant | every hardcoded input, full stop |
| No fill | **calculation** | (not used as a meaningful state) |

Under House Style, a gray cell is something a human typed or sourced. Under Audit Standard, a gray cell is something Excel computed. There is no compromise reading. This is why the profile must be declared before a single fill is applied.

---

## Profile A — House Style (default)

Nine semantic classes, specified in full in `cell-classes.md` and `named-styles.md`. Summary:

| Role | Fill | Named style |
|---|---:|---|
| Source and assumption data | `#D0D0D0` | `SourceData` |
| User-controlled model input | `#FFCC99` | `Input` |
| Fixed / task-given constant | `#FABF8F` | `Constant` |
| Local calculation | none | — |
| External / advanced model calculation | none, marked in column B | — |
| Standard output | `#F2F2F2` | `Output` |
| Key result | `#FFFF00` | `Result` |
| Recommended / selected result | `#E2EFDA` | — |
| Note | `#FFFFCC` | `Note` |

The organizing idea: **fill marks what a human put in and what the model gives back. Calculations stay quiet.** A workbook under this profile reads as a small number of colored islands in a large unfilled sea; the islands are the interesting cells.

Use House Style when: building a new workbook, presenting to non-modelers, or the workbook has distinct scenario controls that must be visually separated from base data.

## Profile B — Audit Standard

The classic auditor's convention. Fill marks *provenance* rather than role, and font color carries a second signal.

**Background:**

| State | Fill |
|---|---:|
| Input / fixed hardcoded value (assumption) | orange `#FFCC99` |
| Calculation — any formula or cell reference | gray `#D0D0D0` |
| Work in progress | light yellow `#FFFF99` |
| Output worksheets, entire sheet | white |

**Font:**

| Content | Font color |
|---|---:|
| Pure formula, or pure fixed value | black `#000000` |
| **Mixed** — a formula containing an embedded hardcoded number | green `#008000` |

**Control cells:** green fill + dark green font for `OK`; red fill + dark red font for `DEVIATION`.

The organizing idea: **an auditor clicking through the sheet can tell input from calculation without reading the formula bar**, and the green font flags the single most dangerous cell type — a formula with a number baked into it.

Use Audit Standard when: the workbook already follows it coherently, an auditor or reviewer expects it, or the workbook is dense enough that unfilled calculation cells would leave nothing to look at.

---

## Mapping between profiles

If a conversion is genuinely requested (and only then):

| House Style class | Audit Standard equivalent |
|---|---|
| `SourceData` gray source data | orange fill, black font |
| `Input` orange user control | orange fill, black font (mark the control block with a header) |
| `Constant` constant | orange fill, black font |
| Local calculation (no fill) | gray fill, black font |
| External model calculation | gray fill, black font, helper marker kept |
| `Output` light gray | gray fill on a white output sheet |
| `Result` yellow | gray fill; move the emphasis to a bold border or a labeled result row |
| Recommended pale green | keep pale green — it does not collide with either profile |
| Checks | green/red control cells (identical in both profiles) |

The conversion is lossy in both directions. House Style -> Audit Standard collapses three input classes into one orange. Audit Standard -> House Style cannot recover which orange cells were scenario controls versus base data without reading the model. **Say so before converting**, and expect to ask the user which orange cells are controls.

---

## Profile-neutral rules

These apply under both profiles. They operate on font and on transient state, so they never collide with either fill scheme.

### Mixed-content cells get a green font

A cell whose formula contains an embedded literal — `=D7*1.19`, `=SUM(D7:D12)+50000` — is a **mixed cell**. It is a hardcode disguised as a calculation and it is the most common source of silent model breakage.

- Mark it: font color green `#008000`.
- Then fix it: move the literal to the shared inputs and reference it. The green font is a to-do marker, not a resting state.
- Structural constants are exempt: `12` for months, `365` or `360` for day count, `100` for percent conversion, `2` in an average. These are arithmetic, not assumptions. If a reader could plausibly want to change the number, it is an assumption.
- At delivery, a green-font cell must either be gone or be justified in Documentation.

### Work-in-progress cells get a transient fill

Light yellow `#FFFF99` marks a cell you are still working on. It is deliberately distinct from `Result` yellow `#FFFF00` and `Note` pale yellow `#FFFFCC`, and it exists only during construction.

**No delivered workbook contains a WIP fill.** Before delivery, every WIP cell is resolved to its true semantic class. The definition of done checks for this explicitly. If a value genuinely cannot be resolved — a missing input the user must supply — it becomes an `Input` cell with a `Note` explaining what is needed, not a leftover yellow smear.

### Checks are the same in both profiles

Green PASS, yellow/orange WARN, red FAIL, with dark text and the measured delta shown. Check colors sit outside the core input/output palette by design, so they read the same under either profile. Specified in `cell-classes.md`.

---

## Declaring the profile

On the Documentation sheet, in the methodology block:

```
Color convention: House Style (semantic classes)
  Gray  #D0D0D0  source data and assumptions the model consumes
  Orange #FFCC99 user-controlled scenario inputs
  Orange #FABF8F fixed constants given by the task
  No fill        calculations — do not overwrite
  Light gray #F2F2F2 outputs
  Yellow #FFFF00 key results
  Pale green #E2EFDA recommended option
  Green font     formula contains an embedded constant (to be fixed)
```

Then repeat the two rules the user actually needs wherever the editable inputs live, and on the Menu: **fill only the colored input cells; never type over an unfilled calculation cell.**

---

## Detecting the profile of an existing workbook

Sample a dozen cells you know are formulas (`=`-prefixed, ideally on a calculation sheet).

- Mostly gray-filled -> Audit Standard.
- Mostly unfilled, with gray appearing on typed values -> House Style.
- Both patterns present -> **the workbook is mixed**. This is a blocking audit finding. Report it before doing anything else; a mixed workbook actively misleads.
- No pattern at all -> no convention in force. Default to House Style for a restyle, after approval.
