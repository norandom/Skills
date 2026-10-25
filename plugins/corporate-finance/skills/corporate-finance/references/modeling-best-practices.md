# Financial modeling best practices

How a model is built determines whether anyone can trust it. This reference holds the 20-step build order, Bojan's best-practice checklist, and the do/don't pairs. Apply these whenever the intent is MODEL/BUILD, and use them as the checklist when the intent is REFLECT. Pair with `auditability-and-math-rigor.md` for the required evidence and formula trace.

Notes layer: personal notes about `20 STEPS to create finance model.pdf`, `Best practices in FM.pdf`, and `Do and don'ts in finance modeling.pdf` from Bojan Radojicic / bojanfin.com materials. This is not original source text.

---

## The 20-step build order

1. Data collection
2. Departmental inputs
3. Model objectives
4. Model layout (schedules, formatting, error checks)
5. Operating plan
6. Revenue projections (volume × price, seasonality, acquisition / retention)
7. Cost projections (fixed / variable, inflation)
8. Cost detail
9. CAPEX (timing)
10. Tax planning
11. Tax expense
12. Financing assumptions (sources / rates / repayment)
13. Working capital (AR / AP / inventory turnover)
14. **Scenario analysis** (optimistic / pessimistic / base)
15. **Sensitivity analysis** (key assumptions, robustness)
16–17. Build 3 statements + review / validation
18. Documentation
19. Dashboard / visualization
20. Sensitivity testing

Do not move to another intent until the current build has an Evidence & Audit Trail sheet, validation checks, and formula traces for material outputs.

---

## Best-practice checklist (Bojan 2024)

- Document assumptions explicitly.
- Automate where possible (ERP + FP&A integration).
- **Separate sheets** for assumptions, inputs, and summary.
- Error & consistency checks at the **top of every page**.
- Tell a story with the numbers (storytelling).
- Add a table of contents if the model exceeds ~15–20 sheets.
- Consistent formatting throughout.
- Keep formulas simple.
- **No hardcoded values** inside formulas.
- Clean three statements — **no formulas on projection (schedule) sheets bleeding into statements**.
- Benchmark vs industry.
- Handle tax adjustments (temporary / permanent differences, incentives, deferred).
- No blank columns between periods.
- Use lookups.
- Analyze sales sensitivity to **price and quantity** separately.
- Document the source, formula, substitution, result, units, and check for every material output.

---

## Do / don't

| Do | Don't |
|---|---|
| Understand the business model, revenue streams, segments | Model before you understand the business |
| Put instructions + assumptions pages up front | Bury or omit assumptions |
| Run scenario + sensitivity on key drivers | Neglect tax / deferred taxes |
| Keep formulas simple and traceable | Hardcode values or build complex circularity |
| Drive everything from named assumptions | Over-granularize beyond decision usefulness |

---

## Calculation ledger

Every model should have a calculation ledger, either as an Evidence & Audit Trail sheet or as a visible block in the narrative output.

| Field | Meaning |
|---|---|
| Output | metric or model line being reported |
| Source | source document, user input, or source sheet/cell |
| Formula | plain-language formula and Excel formula where applicable |
| Inputs | named assumptions and source cells |
| Substitution | formula with actual numbers inserted |
| Result | calculated value |
| Units | currency, scale, period, %, days, or multiple |
| Check | tie-out, reasonableness check, sensitivity, or validation status |

Use helper rows/sheets instead of long opaque formulas. If the ledger cannot be completed, label the value as an assumption or open item.

---

## Scenario vs sensitivity

- **Scenario analysis** = coherent bundles of assumptions (base / optimistic / pessimistic) changed together.
- **Sensitivity analysis** = flex one or two key variables (e.g. WACC × growth, price × volume) to test robustness. A 2% WACC change can halve a DCF — never ship a valuation without it.

---

*Based on personal notes from Bojan Radojicic / bojanfin.com materials; not an original-source excerpt.*
