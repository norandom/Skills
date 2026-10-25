# financial-modeling-sheet

House style for quantitative Excel workbooks. It governs how a workbook **looks and is organized**, not what it calculates. It is applied inside Excel through an assistant add-in — Claude for Excel or ChatGPT for Excel — driving the live workbook.

The goal is a file where a reader who has never opened it can tell, at a glance and without clicking a single cell, which numbers were typed, which were chosen, which were calculated, which came from an external engine, and which one is the answer.

## What it covers

- **Four modes** — CREATE a workbook, EXTEND one, AUDIT it against the standard (never writes), or RESTYLE it (writes, so it is gated behind approval, a backup, and a change log).
- **Two palette profiles** — House Style (default) and the classic Audit Standard. They contradict each other: fill marks *role* in one (blue source data, yellow assumptions, unfilled calculations) and *provenance* in the other (orange typed, gray computed). One profile per workbook, declared in Documentation, never mixed.
- **Nine semantic cell classes** — source data, assumptions and drivers, fixed constants, local calculations, external model calls, outputs, key results, recommended results, notes — plus PASS/WARN/FAIL checks.
- **A named style registry** with English canonical names and legacy aliases, so an existing workbook's styles get reused rather than duplicated.
- **A layout skeleton every sheet shares** — rows 1–2 blank, title on row 3, columns A and B empty, content anchored at column C.
- **Sheet architecture** — menu, documentation, dashboard, then task sheets named after the actual work; optional shared-input, engine, and support-calculation roles. Tab colors as a purpose code.
- **A menu built last**, generated from the actual tab order with swatches read from the actual tab colors.
- **Number formats and a negative-value convention** — leading minus, black, never red, never parentheses.
- **Power Query handling** — output moved to `Data <n> <short id>` sheets at the end, the built-in table style stripped and replaced by the house styles, a `PQ: <headline>` caption above the header row, types set in the query, formatting verified to survive a refresh, and the data referenced rather than copied.
- **Chart selection and styling**, and a deliberately restrictive policy on Excel tables, pivots, and conditional formatting.
- **Formula integrity** — no editable constants inside formulas, no hardcoded dashboard results, no unexplained error values.
- **A definition of done** that the workbook must pass before delivery, and that doubles as the AUDIT deliverable.

## Who this is for

Anyone producing a quantitative assessment that someone else has to read and trust. Financial models are the primary case, but the architecture is domain-neutral — risk registers, research result sets, operations dashboards, statistical workbenches, and engineering calculation sheets use the same frame.

## Naming and prescription

The skill prescribes **roles**, not sheet names. Only Menu, Documentation, and Dashboard are named; task sheets are named after the actual work under one consistent pattern. It also does not prescribe your numbers — it formats the model, it does not invent the inputs.

## Works with other skills

- **`reflect`** — resolve an ambiguous restyle request before touching a live workbook.
- **`premortem`** — stress-test a finished decision workbook for how it could mislead a reader.
- **`drawio`** — draw the sheet architecture and the data flow between modules.
- **`cobesy`** — get the convention actually adopted by a team.

## Sources

Synthesizes a house style observed in a multi-module quantitative assessment workbook with the standard financial-modeling color-coding convention (orange inputs, gray calculations, green font for mixed cells, green/red control checks) found across modeling handbooks and audit practice. The default House Style palette adopts the corporate-finance color coding — blue for starting amounts filled once, yellow for assumptions the user tunes, no fill for formulas — while the gray/orange scheme of the originally observed workbook survives as a recognized legacy palette for auditing and extending older files. The conventions predate this skill; the reconciliation of the conflicting palettes into named, non-mixable profiles is this skill's own.

## Layout

- `SKILL.md` — prime directives, mode lock, how-to, capability map, routing.
- `references/mode-map.md` — the four modes, preservation contract, approval gates, change log.
- `references/palette-profiles.md` — the two profiles, the fill conflict, the legacy palette, mapping, profile-neutral rules.
- `references/cell-classes.md` — the nine classes plus checks, with classification tests.
- `references/named-styles.md` — exact style specifications and the full color reference.
- `references/workbook-architecture.md` — sheet order, tab colors, view, layout skeleton.
- `references/menu-and-navigation.md` — menu geometry, swatches, hyperlink syntax and escaping.
- `references/sheet-standards.md` — dashboard, documentation, task sheets, shared inputs, engine, support calculations.
- `references/typography-and-layout.md` — fonts, heights, widths, borders, alignment.
- `references/number-formats.md` — formats, precision, units, negatives.
- `references/power-query-data-sheets.md` — Power Query position, naming, table-style replacement, `PQ:` caption, types, refresh survival.
- `references/charts-and-tables.md` — chart selection and styling; tables/pivots/conditional-formatting policy.
- `references/integrity-and-checks.md` — formula integrity, check blocks, legacy normalization.
- `references/audit-checklist.md` — workflow, definition of done, audit report format.
- `references/implementation-excel-addin.md` — driving Claude for Excel / ChatGPT for Excel, and the add-in failure modes.
- `assets/` — menu, dashboard, documentation, input-block, task-sheet, data-sheet, and audit-report specs.
- `evals/evals.json` — regression scenarios.
