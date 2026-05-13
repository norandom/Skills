# Investigation Tiers

Tiers define **depth**, **ceremony**, and **required artifacts**. They do not change the Diagnostic Inquiry loop — the loop is the same at every tier. What changes is how many cycles you run, how many evidence sources you pivot across, how formal the documentation is, and how many people are involved.

## Tier matrix

| Dimension | Tier 1 — Simple | Tier 2 — Standard | Tier 3 — Crisis |
|---|---|---|---|
| Analysts | 1 | 1–2 | Multi-analyst + IR lead |
| Triage strategy | Threat-Centric | Hybrid | Risk-Centric first |
| Typical duration | Minutes | Hours → days | Days → weeks |
| Question types | Context + 1 preceding/succeeding | Full event-relative + capability-matching | All types incl. externally sourced intel |
| Evidence sources touched | 1 | 2–5 | 5+ |
| Disposition range | 5, 6, 7, 9 (mostly 9) | 1–7 | 1–4 |
| Playbook use | Optional | Required (by name + UUID) | Required + custom extensions |
| Attack timeline | Not required | Required | Required + diagram |
| Case management ticket | Optional | Required | Required (with IR channel) |
| Peer review | None | Informal | Formal Security M&M |
| Final report | Case notes only | Short technical write-up | Full compromise report (Once Upon a Time pattern) |
| Required diagrams | None | Diagnostic Inquiry Loop + Attack Timeline | All 5 standard diagrams |
| Response category | Normal | Elevated | Critical / Emergent |

## Escalation triggers (Tier 1 → Tier 2)

Escalate to Tier 2 the moment any of these is true:

- The alert cannot be falsified in the first cycle of Diagnostic Inquiry.
- A *novelty cue* appears (first-time-seen binary, domain, user, etc.).
- The evidence touches more than one host or more than one user.
- Any capability-matching question comes back positive.
- A utility question leads into a high-value evidence source (AD, EDR, DLP, email gateway).

## Escalation triggers (Tier 2 → Tier 3)

Escalate to Tier 3 the moment any of these is true:

- Confirmed malicious disposition on a Tier 2 investigation touching >1 host.
- Credential compromise suspected for an admin/service account.
- Signs of lateral movement (unexpected logon type 3/10, PSExec, WMI, RDP chains).
- Signs of data exfiltration (PCR shift, large uploads to unverified domains).
- Ransomware behavior (shadow-copy deletion, mass file writes).
- Executive, legal, or regulatory visibility is triggered.

## Exit criteria (closing a tier)

- **Tier 1** closes when a disposition is recorded and the alert is falsified or explained. Case notes must show the investigation statement + action statement at minimum.
- **Tier 2** closes when the attack timeline has no remaining gaps the analyst considers material, a disposition is recorded, and the case-management ticket is complete with attached evidence.
- **Tier 3** closes only after: (a) eradication and recovery are confirmed, (b) the Security M&M peer review has been held and documented, (c) the compromise report is signed off, and (d) response category lessons-learned have been captured in the evidence wiki.

## Response categories (from CJCSM 6510 mapping)

- **Normal** — Disposition 5/6/7/9. Standard SOC handling.
- **Elevated** — Disposition 1/2/4 on a single user asset. IR on-call engaged.
- **Critical** — Disposition 1/2/4 on admin assets or multiple hosts. IR lead engaged, comms plan activated.
- **Emergent** — Disposition 1 or 4 with business impact. Full IR team + executive comms + possible external notification.
