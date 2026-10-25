# Auditability and math rigor

Finance outputs are only useful when the math can be inspected and independently verified. This reference is the cross-cutting rule for every intent: the workflow must stay grounded in the selected task, every number must be auditable, and every material result from the initial pass must be recalculated with Python before delivery.

Notes layer: personal notes about `Textbook_Financial_Modeling.pdf` and `Financial Modeling Macmillan.pdf` from the MBA collection, plus personal notes about the Bojan modeling conventions referenced by this skill. This is not original source text.

---

## Non-negotiable rule

No numeric result may be stated as a fact unless it has a visible trace and a Python verification check:

| Trace field | Required content |
|---|---|
| Source | source document, workbook sheet/cell, user input, or explicitly labeled assumption |
| Formula | formula written in plain text and, for XLSX, as the cell formula |
| Inputs | source cells or named assumptions used by the formula |
| Substitution | the formula with actual input values inserted |
| Step-by-step calculation | arithmetic sequence from substitution to result, with intermediate values when useful |
| Result | calculated output |
| Units | currency, scale, period, percentage, days, or multiple |
| Check | tie-out, reasonableness check, sensitivity, or validation status |
| Python verification | independently recalculated Python result and comparison to the initial result |
| Mismatch status | match, resolved mismatch, or open item with the value withheld/downgraded |

If any field is missing, do **not** present the value as a concluded result. Label it as an assumption, estimate, placeholder, or open item. Never show a number without trace. Never skip the step-by-step calculation for material outputs.

---

## Workflow lock

After classifying the intent, stay in that workflow until its output and checks are complete.

| Intent | Must finish before switching |
|---|---|
| MODEL / BUILD | workbook structure, formulas, evidence/audit trail, validation checks, Python verification |
| ANALYZE / DIAGNOSE | formula-backed ratios, comparisons, interpretation, risk/action note, Python verification |
| ADVISE / CONSULT | method choice, evidence, trade-offs, limits, next action, Python verification for supporting numbers |
| REFLECT | issue list, formula/source failures, precision failures, Python-verification failures, fix list |

If the user asks for a mixed task, run the intents in sequence. Example: build a DCF, then REFLECT on the DCF. Do not blend the phases so tightly that the audit trail disappears.

---

## Evidence / audit trail sheet

Every generated workbook should include an **Evidence & Audit Trail** sheet. Minimum columns:

| Output | Sheet/cell | Source | Formula | Inputs/cells | Substitution | Step-by-step calculation | Result | Units | Check | Python verification | Mismatch status |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Example: EBITDA margin | KPI!B12 | IS!B5, IS!B1 | EBITDA / Revenue | EBITDA=IS!B5; Revenue=IS!B1 | 1,200 / 10,000 | 1,200 / 10,000 = 0.12; 0.12 x 100 = 12.0 | 12.0% | % | ties to IS | Python: 1200 / 10000 = 0.12 = 12.0% | match |

Use this sheet for material outputs: EBITDA, margins, CCC, FCFF, WACC, terminal value, enterprise value, equity value, budget totals, cash runway, and any recommendation supported by numbers.

---

## Formula discipline

- Keep assumptions in the **Assumptions** sheet, not hidden inside formulas.
- Mark input cells separately from calculation/output cells.
- Avoid formulas that mix hardcoded constants with cell references. Move constants to named assumptions.
- Break long formulas into helper rows or helper sheets.
- Prefer one formula type per row across periods.
- In Excel, use trace precedents/dependents and Evaluate Formula for material outputs.
- Outside Excel, show the same sequence in prose: source, formula, substitution, result, units, check.

---

## Python verification pass

After the initial pass, independently recalculate every material output in Python using the same inputs. The Python pass is a check against the initial artifact, not a replacement for the visible finance trace.

Minimum process:

1. Extract the source inputs used by the initial pass.
2. Recreate each formula in Python with named variables.
3. Print or record the Python result next to the initial result.
4. Compare using an explicit tolerance only when rounding, percentages, or currency display require it.
5. For any mismatch, check source values, signs, scale, units, period alignment, formula logic, and rounding.
6. Correct the initial artifact or mark the value as an open item. Do not present an unresolved mismatch as fact.

The final output must include either the Python verification result for each material number or a statement that the number is withheld/downgraded because verification is incomplete.

---

## Precision discipline

Do not create false precision.

- Valuation outputs should be ranges when value drivers are volatile.
- Do not report valuation to the last cent or exact share price unless the use case requires it and the source supports it.
- Pair DCF point values with a WACC x growth sensitivity table.
- State the assumptions behind every range.

---

## Audit gates

| Gate | Passes when | Fail action |
|---|---|---|
| Evidence exists | every material number has a source or is labeled assumption | add source or downgrade claim |
| Formula visible | every material output has formula + substitution | write the trace before presenting |
| Units clear | currency, scale, period, %/days/multiple shown | add units/header |
| Step-by-step math shown | arithmetic path from inputs to result is visible | write the calculation before presenting |
| Python verification complete | material outputs recalculated in Python against initial results | run Python check before delivery |
| Mismatches resolved | Python and initial results match, or differences are explained and corrected | investigate, correct, or withhold number |
| No hidden assumptions | constants are in Assumptions, not formulas | move constant to yellow cell |
| Formula decomposed | long formulas split into helper lines | add helper rows/sheets |
| Validation passed | checks tie out or exceptions are explained | fix or disclose exception |
| Precision justified | output rounded/ranged appropriately | replace point value with range |

*Based on personal notes from the MBA collection (`Textbook_Financial_Modeling.pdf`, `Financial Modeling Macmillan.pdf`) and Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
