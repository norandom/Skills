# Intent map — the ontology

This skill is organized by **action intent**, not by topic. A topic (EBITDA, ratios, DCF…) is just a node that different intents touch differently. Classify the request into one of four intents, then pull the **explanation layer** (concept reference), the **template layer** (asset spec), and the **audit layer** (`auditability-and-math-rigor.md`) listed for it.

```
                 ┌─────────────────────────────────────────────┐
                 │                  REQUEST                      │
                 └───────────────────────┬─────────────────────┘
                                         │ classify verb
        ┌──────────────┬─────────────────┼─────────────────┬──────────────┐
        ▼              ▼                 ▼                 ▼
   MODEL/BUILD    ANALYZE/DIAGNOSE   ADVISE/CONSULT      REFLECT
   "build,make"   "why,interpret"    "should I,better"  "check,is this right"
        │              │                 │                 │
   explanation +   explanation       explanation        explanation
   TEMPLATE        (read it)         (trade-offs)        (integrity rules)
        │              │                 │                 │
   XLSX workbook   findings          recommendation     critique + fixes
```

## Verb → intent cheatsheet

| User says… | Intent |
|------------|--------|
| build, make, create, forecast, project, draft, set up a model/budget | **MODEL** |
| analyze, interpret, why is, how is, read, what does this mean, benchmark | **ANALYZE** |
| should I, which is better, how do I improve, what method, recommend | **ADVISE** |
| check, review, is this right, sanity-check, critique, validate | **REFLECT** |

If a request mixes intents (common: "build a DCF **and** tell me if my assumptions are sane"), run MODEL then REFLECT in sequence. Do not switch workflows until the current intent has produced its output and passed its evidence/formula checks.

---

## MODEL / BUILD

Produce a spreadsheet. Always pair the concept reference with an asset spec and the build conventions.

| Topic | Explanation layer | Template layer (asset) |
|-------|-------------------|------------------------|
| Full operating model | `three-statement-model.md` | `assets/three-statement-model.md` |
| Budget | `budgeting.md` | `assets/budget-model.md` |
| Cash forecast | `cash-flow-working-capital.md` | `assets/thirteen-week-cashflow.md` |
| Valuation | `valuation-dcf-wacc.md` | `assets/dcf-wacc.md` |
| KPI / ratio dashboard | `ratios-and-analysis.md` | `assets/ratio-dashboard.md` |
| EBITDA bridge | `ebitda.md` | `assets/ebitda-kpis.md` |

Always also read `spreadsheet-conventions.md`, `auditability-and-math-rigor.md`, and follow the 20-step order in `modeling-best-practices.md`.

## ANALYZE / DIAGNOSE

Read existing numbers and explain them. No new template; produce findings.

- Statement structure / composition → common-size (vertical) in `ratios-and-analysis.md`.
- Trend over time / vs budget → horizontal analysis in `ratios-and-analysis.md`.
- Health check → ratio set + 6-step workflow + diagnostic reading in `ratios-and-analysis.md`.
- Operating profitability → `ebitda.md` (KPIs + applications).
- Cash position → `cash-flow-working-capital.md` (CCC, NWC).

Diagnostic anchors: EBITDA margin healthy but net margin weak → look below the operating line (interest + tax). ROA falling YoY → assets growing faster than profit (red flag unless early-growth). Falling CCC → improving cash efficiency.

Every ratio or diagnostic claim must show the source data, formula, substitution, result, units, and comparison basis. If the source data is absent, call it an information gap rather than inventing a result.

## ADVISE / CONSULT

Recommend a process or method with trade-offs.

- Improve EBITDA → improvement levers in `ebitda.md`.
- Improve cash → DSO/DPO/DIO levers in `cash-flow-working-capital.md`.
- Choose a budgeting method → method comparison in `budgeting.md`.
- Choose a valuation method → method-selection table in `valuation-dcf-wacc.md`.
- Improve a modeling process → `modeling-best-practices.md`.

Recommendations backed by numbers must cite the formula trace or the assumption behind the number. Recommendations not backed by evidence must be labeled judgment calls.

## REFLECT

Check integrity before the number is trusted. Run these gates:

| Check | Topic | Fail action |
|-------|-------|-------------|
| Is EBITDA being treated as cash flow? | `ebitda.md` | flag: ignores CAPEX & working capital |
| Is "Adjusted EBITDA" flattering results? | `ebitda.md` | list each add-back, justify vs arm's length |
| Is terminal value ~99% of EV? | `valuation-dcf-wacc.md` | extend explicit forecast / lower g |
| Does g exceed GDP / risk-free / history? | `valuation-dcf-wacc.md` | cap g |
| Story consistent (growth vs reinvestment vs risk)? | `valuation-dcf-wacc.md` | Damodaran 3-dimension check |
| Sensitivity run on WACC × g and price × volume? | `valuation-dcf-wacc.md`, `modeling-best-practices.md` | build the 2-way table |
| Any hardcoded values in formula cells? | `spreadsheet-conventions.md` | move to assumptions sheet |
| Do validation checks pass on every sheet? | `spreadsheet-conventions.md` | fix before delivery |
| Does every stated number have source, formula, substitution, result, units, and check? | `auditability-and-math-rigor.md` | add trace or remove/downgrade the number |
| Is the workflow drifting into another intent before the current output is checked? | `auditability-and-math-rigor.md` | finish the current intent, then start the next |

For a deeper assumption critique, hand the assumptions to the `reflect` skill; for failure-mode analysis, hand the finished model to `premortem`.
