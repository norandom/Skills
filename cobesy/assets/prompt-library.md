# Prompt Library

Ready-to-use prompts to drive the COBESY agent. Copy, fill the `{{braces}}`, send.

---

## Phase 0 — Intake
```
Act as the COBESY compiler. I want {{audience}} to {{target behavior}}.
The knowledge I'm starting from is {{doc/repo/decision}}.
Run Phase 0 intake: extract raw_knowledge, cultural_assumptions, and
network_topology, then give me the three one-liners (target behavior as an
action, one hidden assumption, one high-leverage anchor).
```

## Phase 1 — Systemic (framing_protocol)
```
Run the systemic layer. From these observations of {{team}}:
artifacts = {{what they do/reward/avoid}}; espoused values = {{what they say}}.
Name the basic underlying assumption that resolves the contradiction.
Place us on the Edmondson safety×accountability 2×2 and tell me whether to raise
safety first. Output a framing_protocol with a disproof condition.
```
```
Give me three diagnostic-contrast prompts (not icebreakers) to open the session
and surface this team's real survival rules.
```

## Phase 2 — Cognitive (agenda_structure)
```
Compress {{raw_knowledge}} into a Minto pyramid: SCQA opener, one governing
conclusion, a MECE key line of 3–5 points with support. Flag anything that
exceeds working-memory load and move look-up detail to a job aid. Identify where
to talk to the Elephant, not just the Rider.
```
```
This audience is senior/expert. Re-cut the agenda using Knowles andragogy: lead
with their problem, honor their experience, make it self-directed.
```

## Phase 3 — Behavioral (target_nodes)
```
Design the adoption plan for {{behavior}} across {{network}}. Classify simple vs
complex contagion. Pick eigenvector anchors, a seed cluster, and wide bridges.
Identify the top REDUCE barrier and the move to remove it. Give me the rollout
sequence that starts a positive cascade.
```

## Phase 4 — Assemble & facilitate
```
Assemble the change brief: framing_protocol + agenda_structure + target_nodes.
Recommend Gamestorming exercises for a live session, respecting open→explore→close,
and end with a Who/What/When accountability close.
```

## Phase 5 — Validate
```
Run the anti-cringe validation gate on this brief: MECE, working-memory load,
safety, disproof condition, cascade-not-broadcast, reactance/REDUCE. For each
failed check, tell me which layer to return to and what to fix.
```

---

## Composition back-end (composition_blueprint)

Use these when the deliverable is written or projected (blog, thesis, slides,
journal article), not a live session. See `references/composition.md`.

### Macro — governing idea + structure
```
Act as the COBESY composition back-end. Here is {{draft/notes/topic}}.
State the one governing idea in a single sentence. Then post-outline it: list
what each paragraph actually says and flag every paragraph that does not connect
to the governing idea. Check that topic sentences match their headings (Belcher).
```

### Opening — attention
```
Design the opening for {{piece}} for {{audience}} without drafting prose. Use
Cron: name the protagonist (likely the reader), the situation, and a specific
stake. Give opening guidance, words to use, words to avoid, and where to put
emphasis so the first sentences will put a ball in play, not define terms.
Confirm Kolin's four keys (audience, purpose, message, tone) and the action I
want the reader to take.
```

### Meso — paragraph moves
```
Turn this section into a message skeleton, not prose. Recast it as argument, not
report (Belcher). For the key paragraph or slide, provide the they-say / I-say
move, the strongest naysayer ({{bear case / failure mode}}), the answer, the "so
what" for the reader, emphasis notes, and keywords to use.
```

### Micro — sentence linter
```
Give sentence-level style guidance for these paragraphs. Apply Klinkenborg
(short sentences, cut the anxiety of sequence) and Williams & Bizup (subjects =
characters, verbs = actions, old info before new, un-nominalize, kill
actor-hiding passive). Show rewrite rules and examples only if I explicitly ask
for before/after prose.
```

### Full linter pass
```
Run the writing linter on this draft: first-paragraph drop-off, data dump,
mismatched TOC, scope creep, flat exposition, expert fog, sentence sprawl, reader
mismatch, and AI slop / generic voice. For each hit, name the grain and fix it.
If prose was explicitly requested, run the humanizer pass: ask what still makes
the prose sound AI-generated, name the remaining tells, and revise until the
piece sounds written by a person for this reader. Otherwise, return only fixes,
style guidance, emphasis notes, and output-symbol guardrails: no em dashes,
curly quotes, emoji decoration, emoticons, decorative bold, or chatbot-style
visual formatting unless I explicitly asked for them.
```

### Format adapters
```
Compile {{raw_knowledge}} into a composition_blueprint for {{blog (tech/finance)
| thesis | slides | academic journal article}}. Fill
assets/composition-blueprint.md as a first-pass skeleton grid with headlines,
bullets, emphasis notes, writing advice, style guidance, audience-leading cues,
and keywords to use. Avoid marketing language. Apply the format-specific checks
and output-symbol guardrails. Do not write article, paper, or slide prose unless
I explicitly ask for it.
```
