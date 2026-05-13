# Use Cases — Standard Investigation Procedures

Each use case uses an identical structure: **Evidence Sources → Preceding Questions → Context Questions → Succeeding Questions → Disposition Criteria**. Keep that order and the exact question phrasings below so cross-analyst comparability is preserved.

---

## 1. Phishing & Mail Transaction Analysis

**Evidence Sources**
- Mail transaction logs (message IDs, senders, recipients, subjects, attachment types and sizes).
- Mail message headers (routing hosts, DMARC/DKIM/SPF results, X-headers such as X-Mailer).

**Preceding Questions**
- Has the sending domain or user ever sent messages to the recipient domain before?
- Does the `From` domain match the first `Received` server IP?

**Context Questions**
- Does the message have valid DMARC, DKIM, and SPF checks consistent with what the `From` domain publishes?
- Does the message contain attachment types typically associated with malware (Office documents, PDFs, executables)?

**Succeeding Questions**
- Has the recipient user opened the message?
- Did the user's system execute the attachment or resolve any domain embedded in the message?

**Disposition Criteria**
A message leans malicious (spoofed) when there are egregious mismatches between the reported domain and the received server, when SPF/DKIM/DMARC checks fail, or when the email client listed in X-headers is severely outdated or forged (e.g., Outlook Express 6).

---

## 2. Malware, Droppers & Suspicious File Execution

**Evidence Sources**
- Sysmon Event ID 1 (process creation with hashes and command-line options).
- Windows Security Event ID 4688.
- Windows Prefetch.
- Malware sandbox outputs (Any.run, VirusTotal).

**Preceding Questions**
- What parent process launched the file?
- Was this file downloaded from the internet?

**Context Questions**
- What directory was the file executed from?
- What command-line options were used with the executable?
- Does the file hash trigger any antivirus detections or yield malicious results from public sandboxes?

**Succeeding Questions**
- Were any other files executed shortly after this, or did the system download a secondary payload?
- Did the process delete shadow copies or encrypt files?

**Disposition Criteria**
Execution is malicious when the file runs from an obscured or unexpected path (e.g., `Temp`), when there are anomalous parent-child relationships (e.g., `cscript.exe` or `cmd.exe` launched from `winword.exe`), when generic file names trigger AV hits, or when the file has a "very recent birthday" indicative of an active campaign.

---

## 3. Web Proxy Log Analysis, C2 & Beaconing

**Evidence Sources**
- Web proxy logs (Squid, Cisco WSA).
- Zeek HTTP logs.
- Packet Capture (PCAP).
- Key fields: Source IP, URI, HTTP method, User-Agent, Referer, bytes transferred.

**Preceding Questions**
- Where was the user IP redirected from when they first visited?
- Do characteristics of the HTTP transaction indicate there should be a referring domain, but the Referer field is empty?

**Context Questions**
- Did the user or IP make a request with an atypical or suspicious User-Agent?
- Did the transaction occur over a non-standard web port?
- Is the domain algorithmically generated?

**Succeeding Questions**
- What did the user IP browse after visiting the destination?
- Did the user download any suspicious MIME types or unusually large files?

**Disposition Criteria**
Web traffic is malicious when it connects to DGA domains, communicates over non-standard web ports, uses spoofed or custom User-Agents, lacks a Referer on deep sub-URIs, or exhibits regular automated check-ins (beaconing) consistent with C2 infrastructure.

---

## 4. Lateral Movement & Windows Authentication Analysis

**Evidence Sources**
- Windows Security log, especially Event ID 4624 (Successful Logon) and Event ID 4688 (Process Creation).
- EDR platform.
- Evidence of administrative tools such as PSExec.

**Preceding Questions**
- Where has the username authenticated from previously to establish a normal baseline?

**Context Questions**
- Has the username ever authenticated to the computer name using this specific logon type before?
- Was `psexec` executed on the system?

**Succeeding Questions**
- What systems did the user authenticate to following the compromise?
- Were there internal authentication attempts from this host after the compromise?

**Disposition Criteria**
Lateral movement is identified through deviation from a user's logon-type baseline. A user who normally logs in interactively suddenly generating Logon Type 10 (RDP) or Logon Type 3 (network) events, or successive successful access to internal file servers / administrative shares, leans heavily malicious.

---

## 5. Insider Threats vs. Compromised Accounts

**Evidence Sources**
- Friendly Intelligence (HR data, org charts, job roles, working hours).
- Authentication logs (Event ID 4624).
- Application access logs.

**Preceding Questions**
- What jobs has the user held previously in the company?
- What hours does the user normally work?

**Context Questions**
- What is the user's current role within the organization?
- Are they in IT, or in a non-administrative department (Finance, Sales, HR)?

**Succeeding Questions**
- What programs are currently running under the user's context?
- Did the account execute anything anomalous afterwards?

**Disposition Criteria**
When investigating an internal user showing anomalous behavior, avoid the **Base Rate Fallacy**: actual insider threats are statistically rare, so a disgruntled non-IT user running admin tools is more likely a compromised account than a true insider. Always form and test the "credential compromise" hypothesis *before* concluding insider intent.

---

## 6. Data Exfiltration

**Evidence Sources**
- Network flow data (NetFlow, IPFIX).
- HTTP proxy logs.
- Behavioral metrics — especially the Producer Consumer Ratio (PCR).

**Preceding Questions**
- Does the IP address normally send or receive this specific volume of data?

**Context Questions**
- Did the user IP download or upload any large files?
- What host on our network transmitted the most bytes as a top talker?

**Succeeding Questions**
- Where was the data exfiltrated to?

**Disposition Criteria**
Exfiltration is commonly detected by profiling a host's behavioral change via PCR. When a system that normally consumes data suddenly becomes a heavy producer (PCR approaches +1 / pure push), or when there are unexpected large uploads to external or unverified domains, the disposition leans malicious.
