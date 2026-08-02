# Named style registry

Every recurring format is a **named style**, not an ad-hoc fill. Named styles make a restyle a one-line change instead of a thousand-cell sweep, and they make conformance auditable.

Rules:

- Style names are **English**, and stable across workbooks, so a reader moving between files finds the same vocabulary.
- Several house styles were historically named in other languages. Those legacy names are listed below as **aliases**. If a workbook already defines a style under its alias, **reuse it** — do not create an English duplicate. Never create `Input2`, `Header_new`, or `Output copy`.
- Apply the style, then apply only *additional* number formats. Do not override a style's fill or font locally — if you need a variant, it is either a different class or a new style.

---

## Structural styles

### `Header` — main title
*Legacy alias: `Überschrift Fin Mod`*

| Property | Value |
|---|---|
| Fill | `#000080` (navy) |
| Font | Arial 12, bold, white `#FFFFFF` |
| Dashboard variant | Arial 13 |
| Long model titles | Arial 10–12 as needed to fit |
| Alignment | left (menu title: centered) |
| Row height | `15.75–22 pt` |
| Border | none |

Applied across the full logical title range (e.g. `C3:F3`) **without merging** — format the range, put the text in `C3` only.

### `SectionHeader` — section and table header
*Legacy alias: `JCF-Titre ligne`*

| Property | Value |
|---|---|
| Fill | `#333399` (indigo) |
| Font | Arial 9, bold, white `#FFFFFF` |
| Border | none (no heavy border) |

The workhorse divider — it is what makes a long sheet parseable.

### `RowTitle` — emphasized section or row title
*Legacy alias: `JCF-RowTitle`*

| Property | Value |
|---|---|
| Fill | `#333399` (indigo) |
| Font | Arial 9, bold |
| Font color | `#FFFF00` (yellow) |
| Border | none |

Major block captions, rank columns, emphasized output labels, secondary header rows. Yellow-on-indigo outranks white-on-indigo: it marks the row the reader should look at first.

### `ExplanatoryText` — glosses

| Property | Value |
|---|---|
| Font | Aptos Narrow 11, italic |
| Font color | `#7F7F7F` |
| Fill | none |
| Border | none |

Mathematical symbols, abbreviations, units commentary, menu descriptions, short technical explanations, lightweight model markers.

### `Note` — note cards

| Property | Value |
|---|---|
| Fill | `#FFFFCC` |
| Font | Arial 9–10, black or dark gray |
| Alignment | left, top, **wrap text** |
| Border | thin `#B2B2B2` for dashboard note cards; none for narrative notes inside model sheets |

### `Hlink` — hyperlinks

| Property | Value |
|---|---|
| Font | Aptos Narrow 11 |
| Font color | `#467886` |
| Underline | single |
| Fill | none |
| Border | none |

Use the built-in `Hlink` style where the workbook has it. Hyperlinks belong in the menu and in Documentation, not scattered through calculation grids.

---

## Semantic cell styles (House Style profile)

### `SourceData` — source data and assumptions
*Legacy alias: `Annahme`*

| Property | Value |
|---|---|
| Fill | `#D0D0D0` |
| Font | Arial 10, black |
| Border | none (usually) |
| Alignment | default (numbers right) |

### `Input` — user-controlled model inputs

| Property | Value |
|---|---|
| Fill | `#FFCC99` |
| Font | Aptos Narrow 11 |
| Font color | `#3F3F76` |
| Border | thin `#7F7F7F`, all four sides |

### `Constant` — fixed / task-given constants
*Legacy alias: `MBA_Input`*

| Property | Value |
|---|---|
| Fill | `#FABF8F` |
| Font | Aptos Narrow 11 or Arial 10, black |
| Border | thin `#7F7F7F` **top** border; full thin box only where clarity requires it |

### `Output` — standard outputs

| Property | Value |
|---|---|
| Fill | `#F2F2F2` |
| Font | Aptos Narrow 11, **bold** |
| Font color | `#3F3F3F` |
| Border | thin `#3F3F3F`, all four sides |

### `Result` — key results

| Property | Value |
|---|---|
| Fill | `#FFFF00` |
| Font | Arial 10, bold, black |
| Border | minimal; thin `#B2B2B2` where it abuts a note card |

### `Recommended` — recommended / selected result

| Property | Value |
|---|---|
| Fill | `#E2EFDA` |
| Font | Arial 11, bold |
| Font color | `#375623` |
| Alignment | vertically centered, wrap text where needed |

### `CheckPass` / `CheckWarn` / `CheckFail`

| Style | Fill | Font color |
|---|---:|---:|
| `CheckPass` | `#C6EFCE` | `#006100` |
| `CheckWarn` | `#FFEB9C` | `#9C5700` |
| `CheckFail` | `#FFC7CE` | `#9C0006` |

---

## Style name summary

| Canonical name | Legacy alias | Class |
|---|---|---|
| `Header` | `Überschrift Fin Mod` | main title |
| `SectionHeader` | `JCF-Titre ligne` | section / table header |
| `RowTitle` | `JCF-RowTitle` | emphasized header |
| `ExplanatoryText` | — | gloss |
| `Note` | — | note card |
| `Hlink` | — | hyperlink |
| `SourceData` | `Annahme` | 1. source / assumption |
| `Input` | — | 2. user control |
| `Constant` | `MBA_Input` | 3. fixed constant |
| *(no style — no fill)* | — | 4. local calculation |
| *(no style — no fill + marker)* | — | 5. external model call |
| `Output` | — | 6. standard output |
| `Result` | — | 7. key result |
| `Recommended` | — | 8. selected result |
| `CheckPass` / `CheckWarn` / `CheckFail` | — | checks |

---

## Color reference

Every color this standard uses, in one place.

| Hex | Used for |
|---|---|
| `#000000` | menu tab; body font |
| `#000080` | main title fill (navy) |
| `#333399` | section header fill (indigo) |
| `#FFFF00` | key result fill; `RowTitle` font |
| `#FFFFCC` | note card fill |
| `#FFFF99` | **transient** work-in-progress fill only |
| `#D0D0D0` | source data / assumption fill |
| `#F2F2F2` | standard output fill |
| `#E8E8E8` | documentation tab |
| `#BFBFBF` | Power Query data tab |
| `#FFCC99` | user-control input fill |
| `#FABF8F` | fixed constant fill |
| `#3F3F76` | input font |
| `#3F3F3F` | output font and border |
| `#7F7F7F` | input/constant border; explanatory-text font |
| `#B2B2B2` | note card border |
| `#E2EFDA` | recommended result fill |
| `#375623` | recommended result font |
| `#467886` | hyperlink font |
| `#595959` | chart title font |
| `#008000` | mixed-content (embedded constant) font marker |
| `#7030A0` | dashboard tab |
| `#FFC000` | shared-inputs tab |
| `#51154A` | model / engine tab |
| `#94DCF8` | foundational module tab |
| `#61CBF3` | transition module tab |
| `#0C769E` | intermediate module tab |
| `#074F69` | advanced module tab |
| `#C6EFCE` / `#006100` | check PASS fill / font |
| `#FFEB9C` / `#9C5700` | check WARN fill / font |
| `#FFC7CE` / `#9C0006` | check FAIL fill / font |

---

## Fonts

- **Arial** carries structure and body: titles, section headers, labels, calculations, notes, key results.
- **Aptos Narrow** carries the semantic styles: hyperlinks, explanatory text, inputs, constants, outputs, chart titles.

That split is itself a signal — Aptos Narrow appearing in a grid of Arial means *this cell has a role*. Do not introduce a third font family.
