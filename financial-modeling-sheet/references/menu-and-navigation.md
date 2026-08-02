# Menu and navigation

The menu sheet is the workbook's table of contents and its legend at the same time. It is built **last**, generated from the actual tab order and the actual tab colors — never from memory or from the plan.

---

## Geometry

The menu lives in columns `C:F`, following the standard skeleton: rows 1–2 blank, columns A and B empty, title on row 3.

| Element | Range | Contents |
|---|---|---|
| Main title | `C3:F3` | workbook or assessment title, text in `C3` |
| Spacer | row 4 | blank |
| Contents bar | `C5:F5` | `Inhaltsverzeichnis` / `Contents`, text in `C5` |
| Table header | `C6:F6` | `Sheet` \| `Farbe/Color` \| `Anmerkung/Note` |
| Navigation rows | row 7 onward | one row per sheet, in tab order |

### Dimensions

| Element | Size |
|---|---|
| Columns A, B | ~`20 pt` (empty margin) |
| Column C | ~`228 pt` |
| Columns D:F | ~`60 pt` each |
| Main title row | ~`15.75 pt` |
| Section / header rows | ~`12.75 pt` |
| Navigation rows | ~`15 pt` |

---

## Formatting, element by element

**Main title `C3:F3`** — fill `#000080`, Arial 12 bold white, horizontally **centered** (the only centered title in the workbook), no merge, no border. Format the full `C3:F3` range; put the text in `C3`.

**Contents bar `C5:F5`** — fill `#000080`, Arial 10 bold white, vertically centered, no merge.

**Table header `C6:F6`** — fill `#333399`, Arial 9 bold, font `#FFFF00`, no heavy border. (This is `RowTitle`.)

**Navigation rows, row 7 onward:**

| Column | Contents | Format |
|---|---|---|
| C | internal hyperlink to the sheet | `Hlink` — Aptos Narrow 11, `#467886`, single underline |
| D | solid swatch matching the **actual** tab color | fill only, no text |
| E:F | brief purpose description | `ExplanatoryText` — Aptos Narrow 11 italic `#7F7F7F` |

Row height ~`15 pt`.

---

## Hyperlinks

Use the `HYPERLINK` formula targeting cell `A1` of the destination sheet. Landing on `A1` puts the reader at the top-left of the standard skeleton, where the title on row 3 is immediately visible.

Plain sheet name:

```excel
=HYPERLINK("#Dashboard!A1","Dashboard")
```

Sheet name containing spaces or special characters — wrap the sheet name in single quotes:

```excel
=HYPERLINK("#'Task 3'!A1","Task 3")
```

Sheet name containing an apostrophe — double the apostrophe inside the quoted name:

```excel
=HYPERLINK("#'Bob''s Model'!A1","Bob's Model")
```

Rules:

- Always include the leading `#`. Without it Excel treats the target as an external file.
- Quote the sheet name whenever it contains a space, an apostrophe, a hyphen, or begins with a digit. Quoting a name that does not need it is harmless — when in doubt, quote.
- The display name should be the sheet name, or a slightly more readable version of it. Do not invent a display name that no tab matches; the reader has to find the tab afterwards.
- **Verify every link resolves** before delivery. A renamed sheet leaves a link that fails silently until someone clicks it.
- `HYPERLINK` navigates but does not change the destination sheet's scroll position beyond `A1`; that is intended.

Alternative: an inserted hyperlink object instead of the formula. Prefer the formula — it survives copy/paste and is visible in the formula bar, which makes it auditable.

---

## What goes in the menu

- **Every user-facing sheet, in exact tab order.** The menu is not a curated list; a reader uses it to confirm what exists.
- **Data sheets**, in tab order at the end. Unlike support calculations these carry the workbook's provenance, and a reader auditing a figure needs to find its source.
- **Not** purely technical support-calculation sheets, unless users need direct access to them. Their absence is deliberate and should be stated once in the note column of the last listed sheet, or in Documentation.
- **Not** hidden sheets.

### Generating the rows

1. Freeze the tab order.
2. Read the actual tab color of each sheet out of the workbook — do not retype from the architecture table; a sheet may legitimately carry a different level color.
3. Emit one row per sheet in order: hyperlink, swatch, description.
4. Re-read the menu against the tab strip afterwards. Order mismatch and swatch mismatch are the two most common defects in this standard, and both are invisible until someone notices the colors disagree.

### Legacy defects not to reproduce

- A menu whose row order does not match the tab order, because it was written from the plan rather than from the workbook. **The menu follows the tabs**, always.
- A menu swatch that is *nearly* the tab color. Near is wrong. Copy the exact value.

---

## Descriptions

Keep the note column short and functional — what the sheet is for, not what it contains.

| Sheet | Good description | Bad description |
|---|---|---|
| Shared inputs | `all editable inputs — change values here` | `Inputs` |
| Auto | `Python-driven engine — outputs feed Dashboard` | `automated stuff` |
| Support Calculations | `helper schedules; not required for reading results` | `misc` |
| `Data 1 fx_rates` | `Power Query load — ECB daily rates; refresh before use` | `data` |

The menu is also the right place for the one instruction every reader needs:

> Fill only the colored input cells. Never type over an unfilled calculation cell.

Put it as `ExplanatoryText` below the last navigation row, after a blank row.
