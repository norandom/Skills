# Spreadsheet conventions

Shared rules for every workbook this skill produces, whether through **Claude for Excel** or a generated **XLSX**. The asset specs in `assets/` assume these conventions — read this before building any model. Pair this with `auditability-and-math-rigor.md` whenever the workbook contains formulas or numeric conclusions.

Notes layer: personal notes about `02 3 Statements model.xlsx` and `Best practices in FM.pdf` from Bojan Radojicic / bojanfin.com materials. This is not original source text.

---

## Cell color coding

| Color | Meaning | Who edits |
|---|---|---|
| **Blue** | Starting amounts / opening balances (historical actuals) | User fills once |
| **Yellow** | Assumptions (growth %, rates, drivers) | User tunes |
| **No fill / black text** | Formula cells | **Never edit** — driven by blue + yellow |

The rule users must hear every time: **fill only blue and yellow cells; never type over a formula cell; never keep a hardcoded number inside a formula.**

---

## Layout rules

- **Separate sheets** for Instructions, Assumptions, and Summary — keep inputs away from calculations.
- Column pattern per sheet: **Baseline | Assumptions | period columns | Total | Instructions**.
- No blank columns between periods (breaks SUM ranges and charts).
- Keep SUM / AVERAGE ranges intact when extending periods.
- One unit and currency per block; state them in the header.
- Table of contents if the model exceeds ~15–20 sheets.
- Include an **Evidence & Audit Trail** sheet for material outputs.

---

## Evidence and formula trace

Every material output must be traceable and independently verified. At minimum, the Evidence & Audit Trail sheet should contain:

| Output | Sheet/cell | Source | Formula | Inputs/cells | Substitution | Step-by-step calculation | Result | Units | Check | Python verification | Mismatch status |
|---|---|---|---|---|---|---|---|---|---|---|---|

Use it for EBITDA, ratios, CCC, FCFF, WACC, terminal value, enterprise value, equity value, budget totals, and cash runway. If a number cannot be traced to source data or a named assumption, or if Python verification is incomplete or mismatched, do not present it as a result.

---

## Validation checks

Put an error/consistency check block at the **top or end of every sheet**. Minimum set:

| Check | Passes when |
|---|---|
| Balance Sheet balances | Assets − (Liabilities + Equity) = 0 |
| Cash ties out | Cash Flow "Cash end" = Balance Sheet Cash |
| Retained earnings roll | Equity = opening + Net Income − Dividends |
| No hardcodes | No constants embedded in formulas |
| Sign discipline | Outflows negative, inflows positive, consistently |
| Sensitivity present | Key drivers have a WACC×g or price×volume table |
| Evidence trace complete | Material outputs have source, formula, substitution, step-by-step calculation, result, units, and check |
| Python verification complete | Material outputs have independent Python recalculation and mismatch status |

A model that fails any of these is not ready to present — fix before delivering.

---

## Generation notes (Claude for Excel / XLSX)

- Build schedules first, statements last (mirror `modeling-best-practices.md` step order).
- Wire the three integration links (Cash from CF; Equity roll-forward; other CA/CL as ratios) — see `three-statement-model.md`.
- Label every assumption; never leave a magic number unexplained.
- Decompose long formulas into helper rows/sheets; avoid opaque formulas.
- Document formulas in the workbook and in the narrative output; never state a calculated number without its trace, step-by-step calculation, and Python verification.
- Where a template anchor exists (e.g. worked five-year cash flow), seed it so the user sees a working example to overwrite.

---

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
