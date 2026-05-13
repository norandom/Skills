# investigation-theory

A shared workflow for SOC triage, log analysis, digital forensics, and incident response. The skill operationalizes the *Investigation Theory* curriculum: every analyst follows the same Diagnostic Inquiry loop, the same question taxonomy, the same disposition codes, and the same draw.io diagrams. The point is comparability: two analysts on different cases produce artifacts a reviewer can read side by side without translation.

Based on *Applied Network Defense* (2024) Sanders et. al. Also based on course notes and personal research. CJCSM 6510 disposition codes are from the US DoD Joint Chiefs of Staff incident-handling manual; the *Once Upon a Time* report pattern, Security M&M peer review, GAPSS, and the question taxonomy itself come from the Sanders curriculum.

Pair it with **intana-viz** when a case needs a structured analytic technique (ACH, Key Assumptions Check, Pre-Mortem, Devil's Advocacy) that goes past the five standard diagrams here.

## When the skill fires

Triggers on alert triage, log analysis (proxy, mail, Windows, Sysmon, EDR, NetFlow), phishing, lateral movement, C2/beaconing, data exfiltration, malware, insider threat, case-note writing, playbook authoring, attack-timeline construction, disposition assignment, compromise reports, and M&M peer reviews. Also fires on generic prompts like "help me investigate this alert" or "build me a playbook for X".

It does *not* fire on detection engineering (rule writing, SIEM tuning) or red-team / offensive work.

## The Diagnostic Inquiry loop

Every case runs the same six-stage loop, repeating until the attack timeline is complete enough to close.

1. **Initial Observation** — the triggering alert, hunt hit, or notification.
2. **Interpreting Meaning** — read the observation for *relational*, *dispositional*, and *novelty* cues.
3. **Forecasting & Hypothesis** — what could have produced this?
4. **Investigative Questions** — turn the hypothesis into specific, relevant, answerable queries.
5. **Seeking Answers** — retrieve and manipulate evidence (GAPSS).
6. **Reaching a Conclusion** — assign a disposition (CJCSM 6510).

Skipping a stage is allowed, but the case notes must say which stage was skipped and why. A conclusion without supporting evidence is just an opinion.

## Question taxonomy

| Family | Type | What it does |
| --- | --- | --- |
| Event-relative | Preceding | What led up to / caused the event |
| Event-relative | Succeeding | What followed / resulted from it |
| Event-relative | Context | The specifics of the event itself |
| Event-relative | Proximate | Everything in a time window around it |
| Event-relative | Causal vs General | Direct cause vs any anomaly in the window |
| Capability matching | Internally sourced | Built from a capability already seen on the network |
| Capability matching | Externally sourced | Built from threat intel on a capability not yet seen |
| Capability matching | Prior experience | Built from analyst memory of past cases |
| Utility | Utility | Collect missing data needed by another question |

## GAPSS — answer-seeking moves

Pick one or more in the *Seeking Answers* stage:

- **G**raphs — line/bar charts to surface spikes and aggregations.
- **A**ggregations — group unique values, sort to surface rare or common.
- **P**ivots — use a value from one source to query another.
- **S**earch — expansions (widen) and reductions (narrow).
- **S**tatistics — metrics like the Producer Consumer Ratio.

## Triage strategies

| Strategy | Group by | Assume | Sort by | Best for |
| --- | --- | --- | --- | --- |
| Threat-Centric | Signature | Every alert is false | Estimated Time to Falsify (low first) | Clearing noisy detections |
| Risk-Centric | Host | Every alert is true | Impact / business risk (high first) | Active incidents, known bad |
| Hybrid | Mixed | — | Threat-Centric first, then Risk-Centric on survivors | Default for Tier 2 |

## Tiers and ceremony

| | Tier 1 — Simple | Tier 2 — Standard | Tier 3 — Crisis |
| --- | --- | --- | --- |
| Analysts | 1 | 1–2 | Multi-analyst + IR lead |
| Triage | Threat-Centric | Hybrid | Risk-Centric first |
| Typical duration | Minutes | Hours → days | Days → weeks |
| Disposition range | 5, 6, 7, 9 (mostly 9) | 1–7 | 1–4 |
| Playbook | Optional | Required (name + UUID) | Required + custom extensions |
| Attack timeline | Not required | Required | Required + diagram |
| Peer review | None | Informal | Formal Security M&M |
| Final report | Case notes only | Short technical write-up | Full compromise report |
| Diagrams | None | Loop + Attack Timeline | All five |
| Response category | Normal | Elevated | Critical / Emergent |

Tier 1 → 2 escalates on any of: alert can't be falsified in one loop, novelty cue, >1 host or user, positive capability match, utility question pointing into AD / EDR / DLP / email gateway.

Tier 2 → 3 escalates on any of: confirmed malicious disposition across hosts, admin/service credential compromise, lateral-movement signals, exfil signals, ransomware behavior, executive/legal/regulatory exposure.

## Disposition codes — modified CJCSM 6510

Exactly one per case.

| # | Name | Response category |
| --- | --- | --- |
| 1 | Root Level Intrusion | Elevated / Critical / Emergent |
| 2 | User Level Intrusion | Elevated / Critical |
| 3 | Denial of Service | Elevated |
| 4 | Malicious Logic | Elevated / Critical / Emergent |
| 5 | Unsuccessful Activity Attempt | Normal |
| 6 | Non-Compliance Activity | Normal |
| 7 | Reconnaissance | Normal |
| 8 | Investigating | (open cases only) |
| 9 | Explained Activity | Normal |
| 0 | Training and Exercise | — |

## Use cases shipped with the skill

Each one follows the same shape: **Evidence Sources → Preceding → Context → Succeeding → Disposition Criteria**. Cross-analyst comparability comes from keeping that order.

- Phishing & Mail Transaction Analysis (mail logs, headers, DMARC/DKIM/SPF, X-headers)
- Malware, Droppers & Suspicious File Execution (Sysmon EID 1, Windows 4688, Prefetch, sandboxes)
- Web Proxy Log Analysis, C2 & Beaconing (Squid/WSA, Zeek HTTP, PCAP)
- Lateral Movement & Windows Authentication (4624 logon types, 4688, PSExec, EDR)
- Insider Threats vs Compromised Accounts (HR data, 4624, application access — mind the Base Rate Fallacy)
- Data Exfiltration (NetFlow/IPFIX, HTTP proxy, Producer Consumer Ratio)

Full per-use-case content in `references/use-cases.md`.

## Documentation outputs

- **Case notes** — *investigation statement* + *action statement* per entry, exported evidence attached. Template at `assets/case-notes-template.md`.
- **Playbook** — Human-Centered Playbook Standard (metadata + investigative-question blocks). Template at `assets/playbook-template.md`.
- **Attack timeline** — attacker-centric, additive; nodes are computers, data, processes; edges cross functional boundaries (Internet / DMZ / Internal / Endpoint); gaps in the timeline generate the next question.
- **Compromise report** — *Once Upon a Time* seven-beat plot, signed off only after eradication, M&M, and lessons-learned. Template at `assets/compromise-report-template.md`.
- **Evidence wiki entry** — per-source: how to access, retention, fields, mapped questions, acquisition card. Template at `assets/evidence-wiki-entry-template.md`.
- **Security M&M** — peer review with Key Assumptions Check, What-If Analysis, devil's advocate. Mandatory at Tier 3.

## Standard diagrams (draw.io)

Five fixed types, all rendered via `mcp__drawio__open_drawio_xml`. The style palette, fonts, and node sizes are locked so a reader recognizes the artifact type at a glance. Full specs and XML skeletons in `references/diagram-standards.md`.

1. **Diagnostic Inquiry Loop** — six-node circle of the loop stages.
2. **Attack Timeline with Functional Boundaries** — horizontal swimlanes (Internet / DMZ / Internal / Endpoint), events chronological left to right, evidence cylinders below, gaps as dashed rectangles.
3. **Triage Decision (Green / Yellow / Red)** — three-queue sort, Threat-Centric or Risk-Centric variant.
4. **Playbook Question Flow** — Preceding → Context → Succeeding columns, questions as rhombuses with evidence cylinders below.
5. **Tier Escalation Flow** — Tier 1 → 2 → 3 lanes with the response category at the end of each.

If a case calls for a diagram outside this set (an ACH matrix, a Pre-Mortem hub, a Cultural Web), route through the **intana-viz** skill instead. This one stays on its five.

## Fixed style palette

| Role | Fill | Stroke | Font | Shape |
| --- | --- | --- | --- | --- |
| Start / Observation | `#1F4E79` | `#0B2A44` | `#FFFFFF` | rounded rect |
| Process / Action | `#2E75B6` | `#1F4E79` | `#FFFFFF` | rounded rect |
| Decision / Question | `#ED7D31` | `#9C4A10` | `#FFFFFF` | rhombus |
| Evidence Source | `#70AD47` | `#375623` | `#FFFFFF` | cylinder3 |
| Conclusion / Disposition | `#7030A0` | `#3B1760` | `#FFFFFF` | rounded rect |
| Malicious outcome | `#C00000` | `#7F0000` | `#FFFFFF` | rounded rect |
| Benign / Explained | `#548235` | `#375623` | `#FFFFFF` | rounded rect |
| Inconclusive / Gap | `#BFBFBF` | `#7F7F7F` | `#000000` | rounded rect, dashed |
| Boundary swimlane | `#F5F7FA` | `#8C8C8C` | `#000000` | swimlane |
| Default edge | — | `#595959` | — | orthogonal, 2px |

## Files in this skill

- `SKILL.md` — operating contract loaded by the model.
- `references/methods.md` — Diagnostic Inquiry, question taxonomy, GAPSS, triage strategies, bias controls.
- `references/tiers.md` — full tier matrix, escalation and exit criteria.
- `references/use-cases.md` — per-use-case evidence sources, questions, disposition criteria.
- `references/documentation.md` — case notes, timeline, evidence chain, disposition, report, peer review.
- `references/diagram-standards.md` — locked palette, node sizes, fonts, and XML skeletons.
- `assets/case-notes-template.md`
- `assets/playbook-template.md`
- `assets/compromise-report-template.md`
- `assets/evidence-wiki-entry-template.md`
