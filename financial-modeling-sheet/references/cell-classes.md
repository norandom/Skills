# Semantic cell classes

Nine classes plus checks. Classify first, format second. If you cannot name a block's class, you do not yet understand it well enough to color it.

Colors below are the **House Style** profile. Under Audit Standard, map through `palette-profiles.md` first.

---

## The classification test

Ask, in this order:

1. **Did a human put this number here?** -> class 1, 2, or 3.
   - Is it data from the world, filled once — a historical actual, an opening balance, an observed or imported value? -> **1. Source data** (blue `#BDD7EE`).
   - Is it an assumption or driver the reader tunes — a growth rate, a margin, a scenario knob? -> **2. Assumption / driver** (yellow `#FFFF00`).
   - Is it fixed by the task, policy, or methodology and not expected to change? -> **3. Constant** (gold `#FFD966`).
2. **Did Excel compute it from cells in this workbook?** -> **4. Local calculation** (no fill).
3. **Did something outside Excel compute it?** -> **5. External model** (no fill, marker in the marker column).
4. **Is it a value a reader consumes rather than a step?** -> 6, 7, or 8.
   - An ordinary result -> **6. Output** (`#F2F2F2`).
   - The number the decision turns on -> **7. Key result** (navy `#000080`, white bold).
   - The option actually chosen -> **8. Recommended** (`#E2EFDA`).
5. **Is it prose about the model?** -> **9. Note / explanatory text**.

Role beats mechanism. A cross-sheet formula such as `='Shared Inputs'!D12` sitting in a parameter block is class 1: its role is *this is the input this block consumes* — the knob itself stays yellow where it lives and is tuned, in the shared inputs; the surfaced copy is blue because nobody edits it here. **Do not color cross-sheet links green or treat them as calculations** just because they contain an `=`.

---

## 1. Source data, filled once — `SourceData`

Data from the world: historical actuals, opening balances, market or operational observations, sourced parameter values, values a block consumes from the shared inputs, and **Power Query output** — imported data is source data no matter which mechanism delivered it (`power-query-data-sheets.md`). The corporate-finance "blue cells": the user fills them once, and they change only when the world does.

- Fill `#BDD7EE` (blue), Arial 10, black, usually no border.
- Number aligned normally; units in the adjacent column.
- A note is required whenever the source, override, or basis is not obvious from the label.

This is the class that carries the model's epistemic risk. Every blue cell is a claim about the world that someone must be able to defend.

## 2. Assumptions and drivers — `Input`

Growth rates, margins, day counts, scenario controls, model switches, range limits, simulation parameters — anything the reader is *invited* to change and re-read the dashboard. The corporate-finance "yellow cells": the user tunes them.

- Fill `#FFFF00` (yellow), Aptos Narrow 11, font `#3F3F76`, thin `#7F7F7F` border on all sides.

The border matters: it makes the cell look like a form field. These must be unmistakably distinct from blue source data, because the instruction "change this and re-read the dashboard" applies to yellow and not to blue.

## 3. Fixed or task-given constants — `Constant`

Values given by the task, defined by policy or methodology, not expected to update with source data, but required as a constant for a calculation.

- Fill `#FFD966` (gold), Aptos Narrow 11 or Arial 10, black, thin `#7F7F7F` top border. Full thin box only where clarity demands it.
- Gold sits in the yellow family on purpose — a human entered it — but visibly muted: it is not an invitation to tune.
- The mathematical symbols and labels *accompanying* a constant use `ExplanatoryText` (gray italic), **not** the gold fill. Color the value, not its name.

## 4. Local calculations

Formulas computed entirely inside the workbook.

- **No fill.** Arial 10, black. No border unless the row is a subtotal or a check.
- Standard numeric alignment.

Calculations are the majority of cells and must stay visually quiet, or the inputs and outputs stop standing out. Resist the urge to decorate them.

Two hard rules:

- **No editable constants inside formulas.** `=D7*1.19` is a defect; the `1.19` belongs with the shared inputs. Mark any surviving instance with a green font (`palette-profiles.md`) and fix it.
- **Split long formulas into helper rows.** A formula nobody can read is a formula nobody can check.

## 5. External or advanced model calculations

Python or notebook functions, quantitative engines, APIs, optimizers, simulations, and advanced Excel functions returning arrays.

- Put `Py`, `Model`, `API`, `Solver`, `PQ`, or an equivalent marker in the **marker column to the right of the block** (columns A and B stay empty), or as an `ExplanatoryText` line directly above the block.
- Where the call returns a spilled table, the model-call formula may live in the first cell of the block's dark-indigo output header.
- Standard results from the call use `Output`. Decision-critical ones use `Result`.
- Intermediate steps of the call stay unfilled, like local calculations.
- **Never write source code into worksheet cells.** A cell holds a call or a value, not a program. Code lives in Documentation as a description, or in an external file referenced from Documentation.

The reader must always be able to tell that a number did not come from visible Excel arithmetic — otherwise they will try to trace precedents and find nothing.

## 6. Standard outputs — `Output`

Calculated results, model-comparison values, output grids, linked dashboard metrics.

- Fill `#F2F2F2`, Aptos Narrow 11 bold, font `#3F3F3F`, thin `#3F3F3F` border on all sides for discrete output cells and output tables.

The light fill plus dark border reads as "this is a finished number", distinct from the unfilled work that produced it.

## 7. Key results — `Result`

The important answers: decision-critical outputs, the headline values, the primary analytical conclusions.

- Fill `#000080` (navy), Arial 10 bold, white `#FFFFFF`, minimal borders. A thin `#B2B2B2` edge is acceptable where the result abuts a note card.

The idiomatic "headline total" of a financial model. **Do not use navy for ordinary calculations.** Navy is a scarce resource. A sheet with three navy cells communicates; a sheet with thirty communicates nothing. If you find yourself navy-filling a column, those are `Output` cells and one of them is the `Result`.

## 8. Recommended or selected result

The selected scenario, the best-ranked alternative, the winning strategy, the preferred model output.

- Fill `#E2EFDA`, Arial 11 bold, font `#375623`, wrap text where needed, vertically centered.

Distinct from `Result` on purpose: navy says *this is the number*, pale green says *this is the choice*. A comparison table of five options has five `Output` rows, one of them pale green.

## 9. Notes and explanatory text

Two related classes:

- **`Note`** — fill `#FFFFCC`, Arial 9–10, black or dark gray, left and top aligned, wrapped. Thin `#B2B2B2` border for dashboard note cards; narrative notes inside model sheets may be borderless. Use for methodology remarks, caveats, instructions, source explanations.
- **`ExplanatoryText`** — Aptos Narrow 11, italic, `#7F7F7F`, no fill, no border. Use for mathematical symbols, abbreviations, units commentary, menu descriptions, short technical explanations, and model markers where a full note card would be too heavy.

Rule of thumb: a `Note` is a paragraph the reader stops to read; `ExplanatoryText` is a gloss they absorb in passing.

---

## Checks and warnings

Not a fill class so much as a state machine. When a workbook has integrity checks, each check cell shows a status **and** the measured delta.

| State | Fill | Font | Shows |
|---|---:|---:|---|
| PASS | pale green `#C6EFCE` | dark green `#006100` | `OK` + delta (`0.00`) |
| WARN | pale yellow / orange `#FFEB9C` | dark amber `#9C5700` | the tolerance breached + delta |
| FAIL | pale red `#FFC7CE` | dark red `#9C0006` | `DEVIATION` + delta + the affected cell reference |

Rules:

- **Never reuse the input or output colors for checks.** A check must not be mistakable for a value.
- **Never rely on PASS/FAIL text alone**, and never on color alone — show the number. `OK` with no delta is unfalsifiable; a colorblind reader needs the text; a printed sheet needs both.
- Put the check block at the top or the end of each sheet that has one, and mirror the workbook-level checks onto the Dashboard.

Check colors are identical under both palette profiles.

---

## Anti-patterns

| Anti-pattern | Why it fails |
|---|---|
| Formatting the entire used range one way | Asserts every cell has the same role; destroys the code |
| Coloring cross-sheet links as a separate class | Confuses mechanism with role; a surfaced input is still an input |
| Yellow on a calculated number | Yellow claims "tune me"; a calculation is not tunable — and typing over it destroys the formula |
| Navy on every output row | Kills the signal that marks the actual answer |
| Gold fill on the label next to a constant | Colors the name instead of the value |
| Bordered grids everywhere | Fill hierarchy plus whitespace already carries the structure |
| Coloring a cell before knowing its class | Formatting is a claim; an unclassified claim is a guess |
