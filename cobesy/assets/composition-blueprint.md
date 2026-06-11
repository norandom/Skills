# Composition Blueprint — {{piece title}}

The first-pass messaging skeleton from the Cognitive layer's composition
back-end. It gives the grid, headlines, bullets, emphasis, writing advice, style
guidance, audience-leading cues, and keywords to use. It does not draft the
article, paper, or slide prose unless the user explicitly asks for prose or a
full draft. Pick the format block that applies.

See `references/composition.md` for the frameworks behind each field.

---

## 0. Format
☐ Blog (technical)  ☐ Blog (financial)  ☐ Thesis / long-form  ☐ Slides  ☐ Academic journal article

---

## 1. The governing idea (Belcher + Minto)
- **One governing idea, in a single sentence:** _____
- **Where it is visible:** ☐ title ☐ abstract/intro ☐ every head ☐ conclusion
- **Argue, don't report — the claim, not the catalog:** _____

## 2. The four keys (Kolin)
- **Audience** (role, background, attitude to you): _____
- **Purpose** (what should change): _____
- **Message** (the one takeaway): _____
- **Style / tone** (how it should sound): _____
- **Action you want the reader to take:** _____

## 3. The opening (Cron)
- **Protagonist** (often the reader / a stand-in): _____
- **What's happening** (situation, big picture): _____
- **What's at stake** (a specific consequence): _____
- **Opening guidance, not prose by default:** _____
- **Words to avoid in the opening:** marketing language, vague transformation claims, generic urgency

## 4. Skeleton grid
TOC or slide-headline string. Each head names a claim; the heads in sequence
should read as the argument. Use bullets and emphasis notes, not drafted prose.

| # | Head / slide headline | Bullet points to cover | Emphasis / audience-leading cue | Keywords to use | Serves the governing idea? |
|---|---|---|---|---|---|
| 1 | _____ | _____ | _____ | _____ | ☐ |
| 2 | _____ | _____ | _____ | _____ | ☐ |
| 3 | _____ | _____ | _____ | _____ | ☐ |

- [ ] MECE: no overlap, nothing essential missing
- [ ] Post-outline done: each paragraph's topic sentence matches its head

## 5. Paragraph / slide moves (Graff & Birkenstein)
- **The "they say" you are responding to:** _____
- **The naysayer / strongest objection (bear case, failure mode):** _____
- **Your answer to it:** _____
- **The "so what" / stakes for the reader:** _____
- **Where to put emphasis for efficient message creation:** _____
- **Style guidance:** _____
- **Writing advice:** _____
- **Marketing-language ban:** no hype, no vague claims, no generic thought-leadership phrasing

## 6. Linter pass
| Malady | Grain | Hit? | Fix applied |
|---|---|---|---|
| First-paragraph drop-off | Opening | ☐ | _____ |
| Information overload / data dump | Macro | ☐ | _____ |
| Mismatched TOC | Macro | ☐ | _____ |
| Scope creep | Macro | ☐ | _____ |
| Flat exposition, no stakes | Meso | ☐ | _____ |
| Expert fog (nominalization, hidden actor) | Micro | ☐ | _____ |
| Sentence sprawl | Micro | ☐ | _____ |
| Reader mismatch | Opening | ☐ | _____ |
| AI slop / generic voice | Output | ☐ | _____ |

## 6a. Humanizer pass, only if prose was explicitly requested
- [ ] Removed significance inflation, vague authority, forced trios, and generic upbeat endings
- [ ] Removed chatbot phrasing and tutorial signposting
- [ ] Filtered AI-looking symbols: no em dashes, curly quotes, emoji decoration, emoticons, or decorative bold unless requested
- [ ] Varied sentence rhythm without making the prose cute or over-written
- [ ] Preserved the author's voice, reader level, and tolerance for detail
- [ ] Asked: "What still makes this sound AI-generated?" and fixed the answer

---

## 7. Format-specific checks

### Blog
- [ ] Title states the claim or payoff, not the topic
- [ ] One idea per post (a second idea is a second post)
- [ ] Subheads + topic sentences carry the argument for a skimmer
- [ ] Financial: thesis up front, then bear case, then evidence; claim ≠ data
- [ ] Technical: leads with the problem and consequence, not the tooling

### Thesis / long-form
- [ ] TOC reads as the argument, top to bottom
- [ ] Single idea traceable through title, abstract, intro, each chapter, conclusion
- [ ] Post-outlined per chapter
- [ ] Didactics: why-before-what, chunked to working memory, reference detail in appendices
- [ ] Scope fixed; off-thread material moved to future work

### Slides
- [ ] One message per slide; headline is the assertion, body is support
- [ ] Headline string read top to bottom = the SCQA argument
- [ ] One concrete stake or image per major slide (Elephant), not a bullet wall
- [ ] Tone matches the room; executives get the decision and the ask first
- [ ] Slide carries the claim; notes carry the prose

### Academic journal article
- [ ] One significant idea, stated as a contribution in title, abstract, and first paragraph
- [ ] Abstract is the argument in miniature (context, gap, claim, evidence, so-what), not a TOC
- [ ] Framed against the literature with they-say / I-say
- [ ] Strongest reviewer objection named and answered in the text (naysayer)
- [ ] Argue, don't report: evidence selected for the claim, not dumped
- [ ] Section heads carry claims; topic sentences post-outlined to match
- [ ] Sentence-level clarity passed (reviewers read fog as weak thinking)

---

## 8. Final output conditions
- [ ] A reader can state the governing idea after the first screen
- [ ] Every section, paragraph, or slide serves that idea
- [ ] The default output is a skeleton grid, not drafted prose
- [ ] Any prose was explicitly requested before drafting
- [ ] The final formatting does not look machine-generated: no decorative symbols, no emoticons, no mechanical bold labels, no em-dash habit
