# Cognitive Layer — Composition Back-End

**Input:** `raw_knowledge` (+ `framing_protocol` from Systemic) · **Output:** `composition_blueprint`
**Sources:** Cron *Wired for Story*; Klinkenborg *Several Short Sentences About
Writing*; Graff & Birkenstein *They Say / I Say*; Belcher *Writing Your Journal
Article in Twelve Weeks*; Kolin *Successful Writing at Work*; Williams & Bizup
*Style: Lessons in Clarity and Grace*.

The agenda back-end (`03-cognitive-layer.md`) compiles the Minto hierarchy into a
live session. This back-end structures the same hierarchy for a written or
projected artifact: a blog post, a thesis chapter, a journal article, or a slide
deck. Same governing conclusion, same MECE key line, same working-memory limit.
Different delivery. By default, produce the first-pass skeleton only: grid,
headlines, bullets, emphasis, writing advice, style guidance, audience-leading
cues, and keywords. Do not write article prose unless the user explicitly asks
for a draft, prose, final copy, or a full article.

The premise the user brought: the knowledge is already there. The skill of
getting it across is the bottleneck, and structure is the first thing that breaks
as knowledge grows. More facts pull the writing toward a data dump. This back-end
is the counter-pressure.

---

## The COBESY grain ladder

Six sources sort by resolution. This ladder is COBESY's adapter, not a named
framework from one author. Belcher separates large structural work from sentence
work; Williams & Bizup move from global coherence through sections and paragraphs
down to sentence clarity. COBESY uses that scale to decide where a draft is
broken. Work top-down: fix the governing idea before the opening, the opening
before the paragraph moves, the moves before the sentences. Polishing sentences
inside a broken structure wastes the effort.

| Grain | Question | Sources | Failure it prevents |
|---|---|---|---|
| **Macro** — governing idea + TOC | Is there one idea, and does the structure carry it? | Belcher, Minto | Scope creep, data dump, mismatched TOC |
| **Opening** — attention | Does the first screen earn the second? | Cron, Kolin | First-paragraph drop-off |
| **Meso** — paragraph as a move | Does each paragraph do a job in the argument? | Graff & Birkenstein | Flat exposition, no stakes |
| **Micro** — sentence | Does each sentence land clean? | Klinkenborg, Williams & Bizup | Sentence fog |

---

## Macro — the governing idea (Belcher + Minto)

One significant idea governs the whole piece. Belcher's term is not "red thread";
she asks for a single significant idea and tight linkage across the article. Her
metaphor is closer to a zipper: sentences, paragraphs, and sections should fasten
to each other. COBESY can still call the visible through-line a red thread, but do
not attribute that phrase to Belcher. If a paragraph does not connect to the
single significant idea, cut the paragraph or change the idea. This is the same
MECE discipline from the agenda layer, applied to prose.

**Argue, don't report.** Belcher's distinction: draft like a lawyer building a
case, not a detective laying out clues. A data-driven piece that catalogs
everything you know is unpublishable. An argument-driven piece selects evidence
for one claim. The expert's instinct is to show all the work; the reader needs
the verdict and the three reasons.

**Post-outline.** Outline *after* a draft exists, not only before. Read the draft
and write down what each paragraph actually says. The outline of the real text
exposes where the thread snaps, where two paragraphs say the same thing, where a
section wandered off scope. This is the structural-schema audit: topic sentences
must correspond to the heads above them.

**Surface the structure.** Make the skeleton visible to the reader:
- Descriptive subheads that name the content, not "Background" / "Discussion".
- Topic sentence first in each paragraph; it should echo the subhead.
- Preview and summary statements at section seams ("tell them what you'll say,
  say it, tell them what you said").
- Transition sentences that carry the thread across the seam.

---

## Opening — attention (Cron + Kolin)

### Cron — a ball already in play
The brain reads story as survival rehearsal. It stays for anticipated
consequence, not for description. The first screen must answer three questions:

1. **Whose story is it?** Name the protagonist. In technical and financial
   writing the protagonist is usually the reader, or a stand-in for them: the
   on-call engineer, the portfolio manager, the team that inherited the system.
2. **What's happening here?** A glimpse of the big picture, enough to orient.
3. **What's at stake?** A specific consequence, not a general one. Not "latency
   matters" but "the checkout call times out and the cart is abandoned".

Open on a concrete conflict with consequences already in motion, not on a
definition or a literature tour. In Cron's terms, the story question is the
external goal: will the protagonist get what they want? The focus of the story is
larger: it combines that goal with the protagonist's internal issue and the theme.

### Kolin — the four keys, set before you draft
Effective writing is decided before the first sentence. Four interrelated keys:

| Key | Question |
|---|---|
| **Audience** | Who reads this? Role, background, why they are reading, their attitude to you |
| **Purpose** | Why are you writing? What should change |
| **Message** | What is the one thing they must take away |
| **Style / tone** | How should it sound for this reader |

Add the action question: what do you want the reader to *do* after reading. That
single answer governs every cut. This is the writing-grain version of COBESY's
"target behavior as an observable action" from Phase 0.

---

## Meso — the paragraph as a move (Graff & Birkenstein)

A paragraph is not a container for facts. It is a move in a conversation. The
core template: present your point ("I say") as a response to what others think or
assume ("they say"). Without the "they say", the reader does not know why you are
talking.

**The template of templates** maps the argument move by move: name the
view in play, concede what holds, state your position, give the evidence, say why
it matters. The "so what / who cares" close is the stakes for the reader, the
Elephant from the agenda layer.

**Plant a naysayer.** Anticipate the strongest objection and name it
("Although a reader might object that..."), then answer it. This buys credibility,
reads as broad-minded rather than defensive, and generates text when you are
stuck: the objection tells you what to write next. For financial writing the
naysayer is the bear case; for technical writing it is the failure mode or the
"why not just use X" question.

---

## Micro — the sentence (Klinkenborg + Williams & Bizup)

### Klinkenborg — short sentences
Each sentence takes the stage, says one thing, and leaves. Make most sentences
short. The benefit is not style, it is control: you can see whether a short
sentence is true. A long one hides its own faults.

- Treat every word as optional until it proves it belongs.
- Cut the "anxiety of sequence": the clunky connective tissue ("Furthermore",
  "It is also important to note that") that exists to paper over a gap. If the
  order is right, the joins are quiet.
- Klinkenborg's drill is strict: discard relative-pronoun chains, stacked
  subordinate clauses, prepositional chains, passive constructions, and dependent
  phrases. If the idea cannot survive in shorter sentences, the idea is not clear
  yet.

### Williams & Bizup — clarity and cohesion
A sentence reads clearly when its grammar matches its story:

- **Subjects name the characters.** Whoever acts is the grammatical subject.
- **Verbs name the actions.** The action is the verb, not a noun. "We decided"
  beats "a decision was made"; "the function validates" beats "validation is
  performed by the function".
- **Old before new.** Open a sentence with information the reader already has;
  put the new, complex, or heavy material at the end.
- **Topic strings.** Sentences in a paragraph should share consistent subjects,
  so the reader tracks one thread instead of re-orienting each line.
- Get to the main verb early; push sprawl to the end; then cut.

Nominalization (action hidden in a noun) and passive that hides the actor are the
two faults that produce most "expert fog". They read as authoritative and convey
little. Klinkenborg cuts the sentence down; Williams & Bizup rebuilds it around
character and action.

---

## The writing linter

The writing-grain analog of the Phase 5 anti-cringe gate. Each malady has a grain
and a fix. Run it on a draft; for any hit, drop to that grain and repair before
moving up.

| Malady | Grain | Fix |
|---|---|---|
| First-paragraph drop-off | Opening | Lead with a concrete conflict and stakes (Cron) in short declarative sentences (Klinkenborg). Cut the definitional throat-clearing. |
| Information overload / data dump | Macro | Enforce the Minto hierarchy. Remove any line with no direct link to the one governing idea (Belcher). |
| Mismatched table of contents | Macro | Structural-schema audit (Belcher post-outline): every paragraph's topic sentence must match its heading. |
| Scope creep | Macro | Restate the single significant idea; delete sections that do not serve it. |
| Flat exposition, no stakes | Meso | Recast the paragraph as a "they say / I say" move; add the naysayer; answer "so what". |
| Expert fog | Micro | Subjects = characters, verbs = actions; un-nominalize; kill actor-hiding passive (Williams & Bizup). |
| Sentence sprawl | Micro | Split into short sentences; one claim each (Klinkenborg). |
| Reader mismatch | Opening | Re-run Kolin's four keys; rewrite for the actual reader's role and the action you want. |
| AI slop / generic voice | Output | Run the humanizer pass: remove significance inflation, vague authority, forced trios, generic upbeat endings, chatbot phrasing, AI-looking symbols, and emoticons. Keep the reader's voice and tolerance for detail in view. |

---

## Format adapters

Same blueprint, different deliveries. The macro and micro grains do not change;
the opening and packaging do.

### Blog (technical and financial)
- Title states the claim or the payoff, not the topic.
- First screen is the Cron hook: protagonist (the reader), situation, stakes.
- One idea per post. A second idea is a second post.
- Subheads are scannable and descriptive; a skimmer should get the argument from
  heads and topic sentences alone.
- Financial writing: state the thesis up front, then the naysayer (bear case),
  then evidence. Distinguish claim from data. Flag uncertainty rather than hiding
  it.
- Technical writing: lead with the problem and its consequence, not the tooling.
  Code and config are evidence for a claim, not the claim.

### Thesis / long-form
- TOC is the visible through-line: heads in sequence should read as the argument.
- One significant idea, traceable through title, abstract, intro, each chapter,
  conclusion. Use COBESY's red-thread language here as an internal aid, not as a
  Belcher citation.
- Post-outline every chapter: confirm each paragraph leads to the next and topic
  sentences match heads.
- Didactics (Knowles + Dirksen): tell the reader why before what; respect prior
  knowledge; chunk to working memory; move reference detail to appendices so the
  argument stays light.
- Keep scope fixed. New material that does not serve the idea goes to future work,
  not the body.

### Academic journal article
Belcher's source is written for exactly this target. The argument is the unit of
publication, not the results.
- One significant idea, stated as a contribution: what the field did not know
  before this paper. It must appear in the title, the abstract, and the first
  paragraph of the introduction.
- The abstract is the pyramid in miniature: context, the gap, the claim, the
  evidence, the "so what". Write it as argument, not as a table of contents.
- Frame against the literature with they-say / I-say (Graff & Birkenstein): the
  existing position, then your move against it. The reviewers are the naysayer;
  name the strongest objection and answer it in the text, not in the rebuttal
  letter.
- Argue, don't report (Belcher): select evidence for the claim. A results dump
  reads like notes from the project, not a contribution.
- Structure to the venue's expected sections, but make each section head carry a
  claim, and keep topic sentences matched to it (post-outline).
- Conciseness and clarity at the sentence (Klinkenborg, Williams & Bizup):
  reviewers read fog as weak thinking.

### Slides
- One message per slide; the headline is the assertion, the body is the support
  (Minto applied to the slide).
- The deck's headline string, read top to bottom, is the SCQA argument.
- Talk to the Elephant: a concrete stake or image per major slide, not a wall of
  bullets.
- Tone and business acumen (Kolin): match the room. For an executive audience
  lead with the decision and the ask; detail is backup. Honor a senior audience's
  experience (Knowles); do not narrate what they already know.
- Notes carry the prose; the slide carries the claim.

---

## Output: `composition_blueprint`

Produce, for the chosen format:
- **The one governing idea** in a single sentence (the through-line).
- **Kolin's four keys**: audience, purpose, message, style/tone, plus the action.
- **The opening**: protagonist, situation, stakes (Cron), plus guidance for how
  the opening should work. Do not draft the first sentences by default.
- **The skeleton grid**: TOC or slide-headline string, each head matched to its
  claim, marked MECE, with bullet points, emphasis notes, audience-leading cues,
  and keywords to use.
- **Paragraph / slide moves**: where the naysayer sits, where the stakes land,
  where to put emphasis, and how to guide the reader efficiently.
- **Style guardrails**: tone, vocabulary, keywords to use, and words or marketing
  claims to avoid.
- **Linter pass**: maladies checked, hits and fixes noted.
- **Humanizer pass, only if prose was explicitly requested**: AI-writing tells
  checked, output symbols filtered, remaining tells named, final prose revised
  until it sounds like a person writing for this reader.
- For a thesis: the didactic plan (why-before-what, chunking, what moves to
  appendices).
