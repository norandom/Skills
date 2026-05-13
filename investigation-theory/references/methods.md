# Methods Reference — Diagnostic Inquiry, Questions, GAPSS, Triage

This is the canonical reference for the cognitive and data-manipulation methods an analyst uses inside the Diagnostic Inquiry loop. Follow this vocabulary literally so peer review and cross-analyst comparison work.

## 1. The Diagnostic Inquiry Loop

Six stages, repeated until the attack timeline is complete enough to assign a disposition.

1. **Initial Observation** — The triggering event (IDS alert, hunt hit, third-party notification). Record the exact triggering evidence and time.
2. **Interpreting Meaning** — Read the observation for three cue types:
   - *Relational cues* — relationships between entities (host → user, user → file).
   - *Dispositional cues* — indicators that the event is anomalous (rare user-agent, odd parent process).
   - *Novelty cues* — first-time-seen values that compel further action.
3. **Forecasting & Hypothesis Formation** — Forecast possible event chains that could have produced the observation. Pick the most plausible as your hypothesis.
4. **Forming Investigative Questions** — Turn the hypothesis into questions that are *specific*, *relevant*, and *answerable*.
5. **Seeking Answers** — Retrieve / filter / manipulate evidence to answer the question. This is where GAPSS (below) is applied.
6. **Reaching a Conclusion** — When sufficient evidence is gathered, assign a disposition from CJCSM 6510 (see `documentation.md`).

The loop is *additive*: each completed cycle adds nodes and edges to the attack timeline. Gaps in the timeline generate new questions and restart the loop.

## 2. Question Taxonomy

### 2.1 Event-Relative Questions
Questions oriented around a specific event on the attack timeline.

- **Preceding (Leading) Questions** — What led up to / caused the known event?
- **Succeeding (Trailing) Questions** — What followed / resulted from the known event?
- **Context Questions** — What are the specific characteristics of the event itself?
- **Proximate Questions** — Combine preceding + succeeding: what happened in a specific time frame around the event?
- **Causal vs. General Questions** — Causal looks for direct cause-and-effect; general looks for any anomalous activity in the same window.

### 2.2 Capability-Matching Questions
Questions that try to confirm or refute the presence of a known threat capability.

- **Internally Sourced** — Built from a capability already observed on your own network.
- **Externally Sourced** — Built from threat-intel research on a capability not yet observed here.
- **Prior Investigation Experience** — Built from behavior the analyst recalls from past investigations.

### 2.3 Utility Questions
Questions that collect missing data needed to answer a subsequent investigative question (e.g., "what's the username?" before pivoting to mail logs). Utility questions are *means*, not *ends* — they do not produce conclusions on their own.

## 3. GAPSS — Data Manipulation Model

When in the *Seeking Answers* stage, pick one or more GAPSS techniques:

- **Graphs** — Visualize trends (line charts for spikes, bar charts for aggregations).
- **Aggregations** — Group unique values (stacking, frequency analysis), sort to surface rare or common values.
- **Pivots** — Use a value from one evidence source to search a different evidence source.
- **Search** — Extract data via *expansions* (broaden by time or criteria) and *reductions* (narrow scope).
- **Statistics** — Calculate metrics such as the *Producer Consumer Ratio (PCR)* to profile host behavior.

## 4. Triage Strategies

Alert queues are sorted into three bins: **Green** / **Yellow** / **Red**.

### 4.1 Threat-Centric Triage
- Group alerts by **signature**.
- Assume every alert is **false**.
- Sort by **Estimated Time to Falsify**:
  - Green = Low effort (start here, clear noise fast)
  - Yellow = Medium effort
  - Red = High effort
- Best for clearing out noisy signatures quickly.

### 4.2 Risk-Centric Triage
- Group alerts by **host**.
- Assume every alert is **true**.
- Sort by **Impact / Business Risk**:
  - Red = High risk (start here)
  - Yellow = Medium risk
  - Green = Low risk
- Best when you already believe something is wrong and need to prioritize damage.

### 4.3 Hybrid Triage
- First run **Threat-Centric** to clear Green/Yellow false positives.
- Then re-sort the surviving alerts by host under **Risk-Centric**.
- This is the default for Tier 2 investigations.

## 5. Analysis Techniques

- **Discrete Analysis** — Interpret the meaning of a single event, relationship, or characteristic on its own.
- **Holistic Analysis** — Interpret an event relative to other known events on the attack timeline. Constantly change "altitude": zoom in on one event, then zoom out to the whole chain.

Most investigative errors come from getting stuck in discrete mode. Force a holistic pass after every 3–5 answered questions.

## 6. Cognitive Bias Controls

- **Base Rate Fallacy** — Actual insider threats are extremely rare in absolute terms (single-digit annual cases across most enterprises), while credential compromise via phishing, infostealers, and password reuse is orders of magnitude more common. When an internal user appears to misbehave (admin-tool execution from a non-IT account, off-hours access, anomalous data egress), the prior probability that the account is *compromised* is far higher than the prior that the user is a *malicious insider*. The skill rule: **form and test the credential-compromise hypothesis first.** Falsify it with evidence (impossible-travel logon, fresh token from an unfamiliar UA / IP, no matching endpoint activity) before reframing the case as insider intent. Failing to do this is the most common Tier-2 misdisposition.
- **Key Assumptions Check** — Explicitly list each assumption your hypothesis depends on. Ask: "what if this assumption is wrong?"
- **What-If Analysis** — Imagine the opposite conclusion is true; what evidence would you expect to find?
- **Devil's Advocate** — A peer deliberately tries to falsify your conclusion.

All four controls are mandatory in the Tier-3 Security M&M review. The Base Rate Fallacy check is also mandatory in any Tier-2 case where the working hypothesis is "malicious insider".
