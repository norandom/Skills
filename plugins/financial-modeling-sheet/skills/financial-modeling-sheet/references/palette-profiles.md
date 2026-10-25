# Palette profiles: two conventions, never mixed

Two color conventions exist for quantitative workbooks. They are individually coherent and mutually contradictory: **the same fill means different things in each one.** A workbook that mixes them is worse than a workbook with no convention at all, because the reader believes the colors and is wrong.

Pick one profile per workbook. Declare it on the Documentation sheet. Never mix.

---

## The conflict, stated plainly

| Fill | House Style says | Audit Standard says |
|---|---|---|
| Yellow | **assumption / driver the user tunes** | pale yellow `#FFFF99` = work in progress |
| Orange | (transient WIP only, never delivered) | **every hardcoded input, full stop** |
| Gray | light gray `#F2F2F2` = output | gray `#D0D0D0` = **calculation / formula cell** |
| Blue | **source data filled once** (historicals, opening balances) | (not used as a meaningful state) |
| No fill | **calculation** | (not used as a meaningful state) |

Under House Style, a filled cell is something a human put in or the model gives back, and calculations stay quiet. Under Audit Standard, fill marks *provenance* — orange typed, gray computed. There is no compromise reading. This is why the profile must be declared before a single fill is applied.

---

## Profile A — House Style (default)

The corporate-finance color coding — **blue = starting amounts filled once, yellow = assumptions the user tunes, no fill = formulas** — extended with the output, result, and note classes that convention leaves undefined. Nine semantic classes, specified in full in `cell-classes.md` and `named-styles.md`. Summary:

| Role | Fill | Named style |
|---|---:|---|
| Source data — historicals, opening balances, imported data; filled once | `#BDD7EE` | `SourceData` |
| Assumption / driver / scenario control the user tunes | `#FFFF00` | `Input` |
| Fixed / task-given constant | `#FFD966` | `Constant` |
| Local calculation | none | — |
| External / advanced model calculation | none, marked in the marker column | — |
| Standard output | `#F2F2F2` | `Output` |
| Key result | `#000080` fill, white bold font | `Result` |
| Recommended / selected result | `#E2EFDA` | `Recommended` |
| Note | `#FFFFCC` | `Note` |

The organizing idea: **blue is what the world supplied, yellow is what the user controls, unfilled is what Excel computed, and navy is the answer.** The rule the user must hear every time: *fill only the blue and yellow cells; never type over an unfilled calculation cell; never keep a hardcoded number inside a formula.*

A workbook under this profile reads as a small number of colored islands in a large unfilled sea; the islands are the interesting cells.

Use House Style when: building a new workbook, presenting to non-modelers, or the workbook has distinct assumptions that must be visually separated from base data.

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

## Legacy house palette (recognition only)

Earlier house workbooks used a third scheme: gray `#D0D0D0` source and assumption data, orange `#FFCC99` user controls, `#FABF8F` constants, unfilled calculations, and yellow `#FFFF00` **key results**. Note the trap: under the legacy palette yellow marks the *answer*; under the current House Style yellow marks an *input*. Never assume which reading a workbook uses — detect it (below).

- In **AUDIT**, report the legacy palette as what it is: a coherent legacy convention, not a defect and not a mix.
- In **EXTEND**, match it. Introducing current-palette fills into a legacy workbook creates a mixed workbook.
- Migrating a legacy workbook to the current House Style is a **RESTYLE** with approval, using this mapping: `#D0D0D0` source/assumption cells split into blue `#BDD7EE` (filled-once data) and yellow `#FFFF00` (tuned assumptions) — this split needs human judgment or a read of the model; `#FFCC99` controls → yellow `#FFFF00`; `#FABF8F` constants → gold `#FFD966`; yellow `#FFFF00` results → navy `#000080` white bold.

---

## Mapping between profiles

If a conversion is genuinely requested (and only then):

| House Style class | Audit Standard equivalent |
|---|---|
| `SourceData` blue filled-once data | orange fill, black font |
| `Input` yellow assumption / driver | orange fill, black font (mark the assumption block with a header) |
| `Constant` gold constant | orange fill, black font |
| Local calculation (no fill) | gray fill, black font |
| External model calculation | gray fill, black font, helper marker kept |
| `Output` light gray | gray fill on a white output sheet |
| `Result` navy / white bold | gray fill; move the emphasis to a bold border or a labeled result row |
| Recommended pale green | keep pale green — it does not collide with either profile |
| Checks | green/red control cells (identical in both profiles) |

The conversion is lossy in both directions. House Style -> Audit Standard collapses three input classes into one orange. Audit Standard -> House Style cannot recover which orange cells were filled-once data versus tuned assumptions without reading the model. **Say so before converting**, and expect to ask the user which orange cells are assumptions.

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

A WIP fill marks a cell you are still working on, and it exists only during construction. The fill is per-profile, chosen to stay clear of that profile's meaningful colors:

- **House Style:** light orange `#F8CBAD` — orange means nothing in this profile, so it is unmistakably "unfinished".
- **Audit Standard:** light yellow `#FFFF99`, the classic auditor's WIP — deliberately distinct from input orange and calculation gray.

**No delivered workbook contains a WIP fill.** Before delivery, every WIP cell is resolved to its true semantic class. The definition of done checks for this explicitly. If a value genuinely cannot be resolved — a missing input the user must supply — it becomes an `Input` cell with a `Note` explaining what is needed, not a leftover colored smear.

### Checks are the same in both profiles

Green PASS, yellow/orange WARN, red FAIL, with dark text and the measured delta shown. Check colors sit outside the core input/output palette by design, so they read the same under either profile. Specified in `cell-classes.md`.

---

## Declaring the profile

On the Documentation sheet, in the methodology block:

```
Color convention: House Style (semantic classes)
  Blue   #BDD7EE  source data filled once — historicals, opening balances, imported data
  Yellow #FFFF00  assumptions and drivers the user tunes
  Gold   #FFD966  fixed constants given by the task
  No fill         calculations — do not overwrite
  Light gray #F2F2F2 outputs
  Navy   #000080  key results (white bold font)
  Pale green #E2EFDA recommended option
  Green font      formula contains an embedded constant (to be fixed)
```

Then repeat the two rules the user actually needs wherever the editable inputs live, and on the Menu: **fill only the blue and yellow cells; never type over an unfilled calculation cell.**

---

## Detecting the profile of an existing workbook

Sample a dozen cells you know are formulas (`=`-prefixed, ideally on a calculation sheet), and a dozen you know are typed values.

- Formulas mostly gray-filled -> Audit Standard.
- Formulas mostly unfilled, typed values blue and yellow -> House Style (current).
- Formulas mostly unfilled, typed values gray with orange controls -> **legacy house palette**. Treat as its own coherent convention; see above.
- Both gray-formula and unfilled-formula patterns present -> **the workbook is mixed**. This is a blocking audit finding. Report it before doing anything else; a mixed workbook actively misleads.
- No pattern at all -> no convention in force. Default to House Style for a restyle, after approval.
