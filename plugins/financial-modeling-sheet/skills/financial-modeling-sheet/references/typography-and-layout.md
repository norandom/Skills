# Typography and layout

Fonts, sizes, row heights, column widths, borders, alignment. These are the settings that make a workbook feel deliberate rather than accumulated.

---

## Font families

Two families, with a division of labor:

- **Arial** — structure and body: titles, section headers, row labels, calculations, notes, key results.
- **Aptos Narrow** — semantic styles: hyperlinks, explanatory text, inputs, constants, outputs, chart titles.

Do not introduce a third family. The Arial/Aptos Narrow contrast is itself a signal: Aptos Narrow in a grid of Arial means *this cell carries a role*.

## Size hierarchy

| Element | Font |
|---|---|
| Main title | Arial 12 bold |
| Dashboard title | Arial 13 bold |
| Long automated-model title | Arial 10–12 bold, sized to fit |
| Section and table headers | Arial 9 bold |
| Body labels and calculations | Arial 10 |
| Semantic output / input styles | Aptos Narrow 11 |
| Notes | Arial 9–10 |
| Explanatory text | Aptos Narrow 11 italic |
| Chart titles | Aptos Narrow 12–14 bold |

Section headers are *smaller* than body text on purpose. They are structural markers, not headlines; the indigo fill already carries the emphasis, and a 9pt bold bar reads as a divider rather than competing with the content.

---

## Row heights

| Row type | Height |
|---|---|
| Standard body row | `15 pt` |
| Compact section / header row | `12.75 pt` |
| Main title row | `15.75 pt` |
| Dashboard title row | up to `22 pt` |
| Key output or recommendation row | ~`30 pt` |
| Multi-line model answer | ~`42 pt`, or autofit |

Do not inflate ordinary data rows. Generous row heights on a 40-row table make the sheet feel padded and push content below the fold; the whitespace that matters is the blank row *between* blocks, not inside them.

## Column widths

Practical starting widths, in points:

| Column role | Width |
|---|---|
| Margin columns A, B | ~`20 pt` (empty) |
| Method / status marker column | ~`60 pt` |
| Label columns | ~`90–117 pt` |
| Value columns | ~`60–100 pt` |
| Unit columns | ~`60 pt` |
| Menu sheet-name column (C) | ~`228 pt` |
| Menu swatch and description columns (D:F) | ~`60 pt` |

Rules:

- Widen or autofit **after** formulas and styles are populated, not before — autofit measures what is there.
- **Never leave a truncated title or label.** A clipped label is a defect, not a cosmetic issue: the reader cannot tell what the number means. `####` in a numeric cell is the same defect.
- Keep value columns in a table equal width; ragged columns read as accidental.

---

## Borders

Borders are the last resort, not the first tool. Fill hierarchy and whitespace carry the structure; borders mark the few cells that need a hard edge.

| Element | Border |
|---|---|
| Titles | none |
| Indigo section headers | none |
| Standard calculation cells | none |
| Output cells / output tables | thin `#3F3F3F` box |
| Assumption / driver inputs | thin `#7F7F7F` box |
| Fixed constants | thin `#7F7F7F` top border |
| Dashboard note cards | thin `#B2B2B2` box |
| Key results | minimal; thin `#B2B2B2` only where abutting a note card |
| Subtotal / check rows | a single top border is acceptable |

No heavy or double borders anywhere. No boxed grids around whole tables.

---

## Alignment

| Content | Alignment |
|---|---|
| Labels | left / General |
| Numbers | Excel default (right) — **do not** center numbers in a column |
| Menu main title | horizontally centered |
| Contents bar | vertically centered |
| Structural headers | left / General |
| Notes | left, top |
| Key metrics | centered where appropriate (a single headline figure, not a column) |
| Standard structural rows | vertically bottom |
| Dashboard key-result rows | vertically centered |

Numbers must stay right-aligned so decimal points line up. Centering a numeric column is the fastest way to make a table unreadable.

### Wrapping

Wrap text only for:

- Notes and note cards
- Long labels that would otherwise force an absurd column width
- Result descriptions and recommendation cells

Never wrap a numeric cell. Never rely on wrapping to fit a title — resize the column or shorten the title.

---

## Whitespace discipline

- Rows 1–2 blank; columns A–B blank. The margin is not wasted space; it is what stops the content touching the window edge.
- Blank row after every title.
- Blank row between major analytical sections.
- No blank columns *inside* a table — they break `SUM` ranges and chart series.
- No double blank rows to "add air". One is the unit.

---

## The merge rule, restated

**No merged cells** in menus, calculation areas, tables, titles, or section headers — which is to say, nowhere.

To span a title across `C3:F3`: apply the fill and font to the whole range, put the text in `C3`, leave `D3:F3` empty. Visually identical to a merge, and sorting, range references, arrow-key navigation, and programmatic reads all keep working.
