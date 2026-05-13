# Documentation Reference — Notes, Timeline, Disposition, Report, Review

Documentation is not a chore — it is the substrate that lets peers validate conclusions and lets future analysts learn. Follow this spec literally.

## 1. Case notes (note-taking standard)

Case notes are informal descriptions of actions, findings, and ideas recorded during an investigation, typically stored in a case-management system such as The Hive. Write for a **technical audience**: brief and to the point.

Every case note entry follows this formula:

> *Investigation statement* + *Action statement*

- **Investigation statement** — describes the investigative process: the evidence you reviewed, why you reviewed it, and what you found.
- **Action statement** — describes the next steps taken: what you did and why you did it.

Always attach exported evidence directly to notes so other analysts can independently retrace the investigative steps.

See `../assets/case-notes-template.md` for the exact template.

## 2. Attack timeline construction

Investigations are documented temporally as an **attack timeline** — the sequence of events and relationships describing the attack.

Rules:
- The timeline is an **additive internal visualization**. Start from a blank slate; add a node whenever evidence answers a question.
- Nodes represent **computers, data, and processes**.
- Timelines are **attacker-centric** and include **functional boundaries** (Internet / DMZ / Internal / Endpoint) with a sense of physical direction ("into the network", "north/south/east/west").
- **Gaps** in the timeline are unanswered questions. Every gap must generate a new investigative question or a justified note saying why it will not be pursued.

Rendering as draw.io: use the *Attack Timeline with Functional Boundaries* skeleton in `diagram-standards.md`.

## 3. Evidence chain

A conclusion without evidence is just an opinion. Every conclusion in the case must be tied explicitly to evidence. The documentation must reflect the Diagnostic Inquiry process:

- The initial observation.
- Each investigative question asked.
- The answer-seeking strategy used (GAPSS technique + evidence source).
- The resulting conclusion and the specific evidence supporting it.

This is what allows peer review and independent validation.

## 4. Disposition — modified CJCSM 6510

A disposition is the status given to a case describing the nature of the conclusion and its urgency. Each investigation must be assigned exactly one disposition from the modified CJCSM 6510 scheme:

| # | Name | Description |
|---|---|---|
| 1 | Root Level Intrusion | Adversary has root/admin control on a system |
| 2 | User Level Intrusion | Adversary has user-level access |
| 3 | Denial of Service | Availability impact |
| 4 | Malicious Logic | Installed malicious code |
| 5 | Unsuccessful Activity Attempt | Attack attempted but failed |
| 6 | Non-Compliance Activity | Policy violation, not malicious |
| 7 | Reconnaissance | Scanning / enumeration |
| 8 | Investigating | Not yet concluded (only while open) |
| 9 | Explained Activity | False positive or benign activity |
| 0 | Training and Exercise | Training/exercise traffic |

Each disposition maps to a response category (Normal / Elevated / Critical / Emergent). See `tiers.md` §Response Categories.

## 5. Final report — the Once Upon a Time pattern

Technical writing on compromises is **persuasive writing**. Good reports are character-centric (attacker, users, defenders), include a setting, a plot, a **theme** (what outcome you want — new tools, processes, visibility) and a **conflict** (why you need it — visibility limitations, detection gaps).

Use this 7-beat plot outline — fill each beat with the case specifics:

1. **Once upon a time…** — the steady-state of the network before the incident.
2. **And every day…** — normal user and system behavior.
3. **Until one day…** — the triggering event (e.g., a user clicked a phishing link).
4. **And because of this…** — first-order consequences (compromise, execution).
5. **And because of this…** — second-order consequences (lateral movement, persistence).
6. **Until finally…** — detection, containment, eradication.
7. **And every day since that day…** — the hardened steady-state and lessons learned.

See `../assets/compromise-report-template.md`.

## 6. Peer review — Security M&M (Morbidity & Mortality)

For Tier 2 (informal) and Tier 3 (formal and mandatory), run a Security M&M conference. The investigating analyst presents the case **chronologically**:

1. Initial input.
2. Investigative questions asked.
3. Answer-seeking strategies used.
4. Conclusions.
5. Evidence supporting each conclusion.
6. Actions taken.

Peers play **devil's advocate**, attempt to **falsify** each conclusion, and run explicit **alternative analysis**:
- **Key Assumptions Check** — list every assumption, test each.
- **What-If Analysis** — assume the opposite is true, look for disconfirming evidence.

Document the M&M outcome as an appendix to the compromise report.

## 7. Standards and templates

- **Human-Centered Playbook Standard** — Metadata (Name, UUID, Description, Type & Mechanism, Related Playbooks, Contributors, Dates, Tags) + Investigative Questions blocks (Question, Context, Answer Sources, Range, Queries). See `../assets/playbook-template.md`.
- **Case Templates** — In tools like The Hive, transform playbooks into case templates that auto-populate tasks for specific scenarios.
- **Evidence Wiki** — Maintain an analyst wiki with: *data source reference* (how to access each log source, retention, fields), *most searched fields* mapped to available evidence sources, and an *evidence acquisition card* for each source. See `../assets/evidence-wiki-entry-template.md`.
