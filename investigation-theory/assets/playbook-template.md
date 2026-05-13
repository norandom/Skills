# Playbook Template — Human-Centered Playbook Standard

## Metadata

- **Name**: `<human-readable title, or exact signature name for detection-linked playbooks>`
- **UUID**: `<UUID v4, or SID for detection-linked playbooks>`
- **Description**: `<long-form explanation of the playbook's value and when it should be leveraged>`
- **Type**: `<attack phase | technique | tool | other>`
- **Mechanism**: `<detection engine, e.g. Suricata, Sigma, EDR rule; blank if not detection-linked>`
- **Related Playbooks**: `<list of linked playbooks with UUIDs>`
- **Contributors**: `<names>`
- **Created**: `<YYYY-MM-DD>`
- **Modified**: `<YYYY-MM-DD>`
- **Tags**: `<ATT&CK IDs, categories, arbitrary org tags>`

## Investigative questions

Repeat one block per question. Order them **Preceding → Context → Succeeding**, then capability-matching, then utility.

### Question `<n>`: `<question type>`

- **Question**: `<specific, relevant, answerable query>`
- **Context**: `<why this question is useful / how to interpret the results>` (optional)
- **Answer Sources**: `<evidence source(s) where the answer can be found>`
- **Range**: `<relative time range anchored to the triggering event, e.g. "-10m to +1h">` (optional)
- **Queries**:
  - Splunk: `<search string>` (optional)
  - Kibana: `<KQL>` (optional)
  - Zeek/other: `<query>` (optional)
