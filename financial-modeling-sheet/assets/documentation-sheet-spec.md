# Asset: documentation sheet

Second tab. Tab color `#E8E8E8`. Written for a reader who did not build the workbook — including the author, six months later.

---

## Layout

| Row | Content | Style |
|---|---|---|
| 1–2 | *empty* | top margin |
| 3 | `Documentation — <workbook title>` (text in `C3`, bar to `H3`) | `Header` |
| 4 | *empty* | spacer |
| 5+ | ten sections, each an indigo bar followed by content | see below |

Columns A and B empty. Column C holds labels and section bars; D onward holds content. Wrap long prose in a `Note` card rather than letting it run across ten columns.

Section bars: `SectionHeader` — `#333399`, Arial 9 bold white. One blank row between sections.

---

## The ten sections

**1. Purpose and scope** — what question this workbook answers, for whom, as of when. Two or three sentences in a `Note` card.

**2. Methodology** — the approach, the formulas that carry the result, and why this method rather than the obvious alternative. Formulas as text, referencing the cells that implement them.

**3. Color convention** — the declared palette profile, spelled out. Reproduce the legend as actual formatted cells so the reader sees the colors, not a description of them:

```
   Legend
   [gray  #D0D0D0]  source data and inputs the workbook consumes
   [orange #FFCC99] user-controlled scenario inputs — change these
   [orange #FABF8F] fixed constants given by the task
   [no fill       ] calculations — do not overwrite
   [lt gray #F2F2F2] outputs
   [yellow #FFFF00] key results
   [pale green #E2EFDA] recommended option
   green font       formula contains an embedded constant (to be fixed)
```

**4. Sign and unit conventions** — what is negative, which currency, which scale, how negatives are displayed (leading minus, black).

**5. Technical dependencies** — Excel version, required functions, whether Python, an add-in, or an API is needed to recalculate, and what happens if it is missing. `ExplanatoryText`.

**6. External libraries** — name and version of anything the workbook calls, in prose. Never source code in cells.

**7. Data sources** — one row per input group: what, from where, retrieved when, by whom. URLs as `Hlink`. This is the only place besides a dedicated Sources block where external URLs belong.

**8. Limitations** — what the workbook does not model and where it should not be trusted. The most valuable section and the most often skipped. Be specific: "assumes constant volatility; unreliable beyond a 12-month horizon" beats "results are indicative".

**9. Operating instructions** — which cells to change, in what order, what to re-read afterwards. Lead with the one rule: *fill only the colored input cells; never type over an unfilled calculation cell.*

**10. Update requirements** — what must be refreshed, how often, by whom, and how to tell when it is stale.

---

## Also record here

- The sheet-naming pattern in use.
- Any sheet deliberately omitted from the menu, and why.
- Any surviving green-font mixed-content cell, and why it was kept.
- Any deviation from this standard that was a deliberate choice.

An undocumented deviation is indistinguishable from a mistake.

---

## Build checklist

- [ ] All ten sections present, or the missing ones explicitly marked not applicable.
- [ ] The color legend rendered as real formatted cells, not described in text.
- [ ] Palette profile named explicitly.
- [ ] Sources carry retrieval dates.
- [ ] Limitations are specific enough to act on.
- [ ] No source code in cells.
- [ ] Deliberate deviations from the standard recorded.
