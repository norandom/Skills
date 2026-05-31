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
