# Case Notes — Example (filled-out)

A worked example showing the *investigation statement + action statement* formula in practice. Same shape as `case-notes-template.md`, populated for the phishing scenario from `SKILL.md`. Use it as a tone and granularity reference.

Case ID: `HIVE-7421`
Analyst: `j.lin`
Tier: `2` (escalated from 1 during cycle 1)
Playbook: `PHISH-001 / 7d2f9c4a-1bde-4a01-9b6f-9e6a4f3b1a02`
Initial Observation: `IDS rule MAIL-DOCM-NEWDOMAIN fired 2026-05-13 09:14:21 UTC on inbound mail from accounts-billing.co to jane.doe@corp, attachment Invoice_42.docm`

---

## Entry 2026-05-13 09:32 UTC

**Investigation statement**
> Reviewed mail headers for the triggering message (export `mail-7421-hdr.eml`). Pulled them because the IDS rule keys on novel sender domains and macro-enabled attachments; I needed to know whether SPF / DKIM / DMARC would have caught this. Found: SPF softfail (`accounts-billing.co` does not list the originating IP `185.x.x.x` in its SPF record), no DKIM signature, no DMARC record published by the sender. First `Received` header IP does not match the `From` domain's published MX.

**Action statement**
> Did not close the alert. Created a Hive case (HIVE-7421), opened the Phishing playbook PHISH-001, and moved to Tier 2 because the novelty cue (first-time sender domain) combined with failed authenticity checks means I cannot falsify the alert in a single loop. Next step: confirm whether Jane opened the message and whether the attachment executed.

**Evidence attached**: `mail-7421-hdr.eml`, `ids-7421-alert.json`
**Diagnostic Inquiry stage**: `2 Interpreting → 4 Questions → 5 Answer Seeking`
**Question type asked**: `Context`
**GAPSS technique used**: `Search`

---

## Entry 2026-05-13 09:48 UTC

**Investigation statement**
> Pivoted from the mail gateway delivery log (export `mg-7421-delivery.csv`) to Sysmon on JANE-LAPTOP (export `sysmon-7421-eid1.csv`). Mail gateway confirms delivery at 09:14:38 UTC, Outlook read receipt at 09:21:02 UTC. Sysmon EID 1 shows the parent-child chain `winword.exe (PID 4812) → cmd.exe (PID 5104) → powershell.exe (PID 5188)` starting 09:22:11 UTC. The PowerShell command line is base64-encoded; decoded (see `decode-7421.txt`) it issues an HTTPS GET to `https://cdn.accounts-billing.co:8443/u`.

**Action statement**
> Added timeline node `t1: macro→cmd→powershell on JANE-LAPTOP`. Requested EDR network history for JANE-LAPTOP for the 09:22–09:35 window to confirm the outbound. Did not isolate the host yet — IR lead wants live telemetry first. Set a 30-minute watch on internal authentication logs in case the PowerShell pivots laterally.

**Evidence attached**: `mg-7421-delivery.csv`, `sysmon-7421-eid1.csv`, `decode-7421.txt`
**Diagnostic Inquiry stage**: `1 Observation → 5 Answer Seeking`
**Question type asked**: `Succeeding` (did the recipient execute the attachment?)
**GAPSS technique used**: `Pivot`

---

## Entry 2026-05-13 10:05 UTC

**Investigation statement**
> Proxy logs (export `proxy-7421.csv`) confirm a single outbound HTTPS connection from JANE-LAPTOP to `cdn.accounts-billing.co` on TCP/8443 at 09:22:14 UTC; 412 KB pulled, MIME `application/octet-stream`, filename `update.bin`. No referer. Endpoint search returns one new file at `C:\Users\jane.doe\AppData\Local\Temp\update.bin` with the matching SHA256 `b1f3…a07c`. VirusTotal hit: 41/72 engines, family `Latrodectus`. EDR network history corroborates the proxy log.

**Action statement**
> Updated timeline with `t2: C2 callback`, `t3: update.bin staged in Temp`. Marked working disposition as **4 — Malicious Logic** on JANE-LAPTOP. Requested host isolation via EDR (approved by IR lead 10:08 UTC). Submitted `update.bin` SHA256 to MISP and asked the threat-intel team for known Latrodectus second-stage indicators (registry persistence keys, scheduled-task names, common C2 domains). Added a gap entry: lateral movement and credential exposure on JANE-LAPTOP are still unverified.

**Evidence attached**: `proxy-7421.csv`, `vt-b1f3a07c.json`, `edr-7421-network.json`
**Diagnostic Inquiry stage**: `5 Answer Seeking → 6 Conclusion (interim)`
**Question type asked**: `Succeeding` + `Capability-Matching (external, threat intel)`
**GAPSS technique used**: `Search expansion`, `Pivot`

---

## Running disposition

- Current working disposition: `4 — Malicious Logic` (host JANE-LAPTOP only)
- Response category: `Elevated` (single user asset, no admin assets touched yet)
- Outstanding gaps / open questions:
  - [ ] Did `update.bin` (Latrodectus) execute a second stage? Check Sysmon for child processes of `powershell.exe` PID 5188 after 09:22.
  - [ ] Any lateral movement attempts from JANE-LAPTOP after 09:22? Check Windows Security 4624 on neighbouring hosts.
  - [ ] Credential exposure on JANE-LAPTOP — LSASS access, browser credential store reads?
  - [ ] Are there other users in the same delivery wave? Query mail gateway for sender `accounts-billing.co` across the last 24 hours.

## Timeline updates

- `t0:` IDS alert on inbound mail — evidence: `ids-7421-alert.json`
- `t1:` macro→cmd→powershell on JANE-LAPTOP at 09:22:11 — evidence: `sysmon-7421-eid1.csv`
- `t2:` C2 callback to cdn.accounts-billing.co:8443 at 09:22:14 — evidence: `proxy-7421.csv`
- `t3:` `update.bin` staged in `%TEMP%` (Latrodectus, 41/72 VT) — evidence: `vt-b1f3a07c.json`
