# **Avoda — Your AI-Native Job Data API**

---

## 1 ▪ North-Star

|             | Statement                                                                                                                         |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Mission** | *Automate the grunt work of job discovery and pipeline tracking so humans can focus on storytelling, networking, and interviews.* |
| **Vision**  | *Make high-fidelity, always-fresh job data available to any product or internal tool with a single API call.*                     |
| **Tagline** | **“Feed your pipeline, not your spreadsheets.”**                                                                                  |

---

## 2 ▪ Problem Landscape

1. **Copy-paste chaos** — Job hunters waste hours transcribing titles, tech stacks, salaries, and links into personal trackers.
2. **Vanishing listings** — Postings disappear behind paywalls or “position closed” banners, leaving candidates without reference material.
3. **Stale status** — Human memory fails; follow-ups slip, interviews aren’t logged, and opportunities die quietly.
4. **DIY tooling gap** — Recruiters and career-tech startups reinvent scraping, parsing, reminders, and analytics instead of building differentiated UX.

---

## 3 ▪ Solution at a Glance

Avoda is a **pure API MicroSaaS** that ingests any public job-posting URL and returns a rich, versioned JSON object. Downstream consumers—browser extensions, career-tracking apps, talent CRMs, bootcamp dashboards—delegate **extraction, enrichment, lifecycle automations, and metrics** to Avoda while retaining full control of their UI.

---

## 4 ▪ Core Capabilities & Endpoints

| Capability             | Purpose                                                                                                                                   | Key Endpoints                |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| **Smart Scrape**       | Normalize HTML, archive a full-page image/PDF, and detect page language & encoding.                                                       | `POST /v1/scrape`            |
| **Field Extraction**   | Return canonical fields (title, employer, salary, geography, remote policy, duties\[], requirements\[], stack\[], posting\_date, source). | `GET /v1/jobs/{id}`          |
| **Fit Synopsis**       | Three-sentence, role-aware summary tuned to seniority and culture signals.                                                                | Included in `/jobs` payload  |
| **Lifecycle Tracker**  | Atomic status transitions with automatic timestamping (`LISTED → APPLIED → … → REJECTED`).                                                | `PATCH /v1/jobs/{id}/status` |
| **Reminder Hooks**     | Declarative triggers (e.g., “ping if 7 days idle in LISTED”) that fire webhooks or emails.                                                | `POST /v1/reminders`         |
| **Duplicate Watch**    | Embedding-based similarity search flags redundant listings.                                                                               | `GET /v1/jobs/similar`       |
| **Skill-Gap Diff**     | Compare job stack against a résumé JSON to surface missing skills with scores.                                                            | `POST /v1/skills/diff`       |
| **Analytics Snapshot** | Aggregates: application cadence, hit-rate, time-in-stage, salary band histograms.                                                         | `GET /v1/metrics`            |

> **Design choice:** every feature is **idempotent, stateless, and pay-per-call**, enabling granular metering and easy horizontal scaling.

---

## 5 ▪ Data Entities & Relationships

```
Job ⟶{many} Revision
Job ⟶{many} Reminder
User ⟵{many} Job
User ⟶{many} ResumeSkill
```

* **Job** — canonical record keyed by URL hash.
* **Revision** — immutable snapshots whenever the source page changes (diffs available).
* **Reminder** — declarative rule + next\_fire\_at timestamp.
* **ResumeSkill** — user-supplied skill tags with proficiency weights.

---

## 6 ▪ Intelligence Layer

| Model-Assisted Task     | How It Works                                                                                    | Why It Matters                                                  |
| ----------------------- | ----------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| **Extraction**          | Few-shot function calls plus deterministic post-processing.                                     | 95 %+ field accuracy across heterogeneous boards.               |
| **Summary**             | Structured prompt uses duties & stack to craft a three-line “Fit Synopsis.”                     | Users see at-a-glance relevance without reading 1 000-word ads. |
| **Duplicate Detection** | Embedding cosine similarity with threshold decay over time.                                     | Prevents noisy boards and accidental re-application.            |
| **Skill-Gap Analysis**  | Token overlap + vector diff between job stack and résumé embeddings.                            | Guides self-study and résumé tweaks.                            |
| **Status Nudges**       | Heuristic + ML model predicts likelihood of stage advancement; overdue items trigger reminders. | Cuts attrition caused by forgetting.                            |

---

## 7 ▪ High-Level Architecture

1. **Edge Collection Layer**

   * Lightweight fetchers execute in isolated sandboxes; cold starts avoided via pooling.
   * Documents streamed to central message bus for parsing.

2. **Parse & Enrichment Pipeline**

   * Fan-out workers perform language detection, boilerplate stripping, and LLM extraction.
   * Parsed payloads land in the **Operational Store**; embeddings stream to the **Vector Index**.

3. **Core API Cluster**

   * Stateless containers behind an auto-scaling gateway; JWT-based tenant isolation.
   * Rate limit & billing middleware inject usage metadata.

4. **Automation Engine**

   * Cron-driven rule evaluator materialises reminder events and pushes them to outbound queues (email, webhook, calendar).

5. **Observability Mesh**

   * Distributed tracing, structured logs, anomaly alerts on extraction accuracy and latency.

*All components are cloud-agnostic and deployable in a single-region starter footprint or multi-region active-active for enterprise.*

---

## 8 ▪ Security & Compliance

| Concern                  | Approach                                                                                             |
| ------------------------ | ---------------------------------------------------------------------------------------------------- |
| **PII Protection**       | Field-level encryption at rest; client-side fetch option for teams with strict data-residency rules. |
| **Auth & Isolation**     | OAuth 2.0 + fine-grained scopes; per-tenant row-level ACLs.                                          |
| **Auditability**         | Immutable revision history and signed activity webhooks.                                             |
| **Regulatory Alignment** | GDPR, CCPA, and SOC-readiness baked into data-retention policies.                                    |

---

## 9 ▪ Pricing Model

| Tier           | Monthly Base | Call Allowance | Overages        | Target Users                       |
| -------------- | ------------ | -------------- | --------------- | ---------------------------------- |
| **Free**       | \$0          | 100 calls      | \$0.01 / call   | Indie devs prototyping extensions  |
| **Grow**       | \$29         | 5 000 calls    | \$0.005 / call  | Bootcamps, niche job-tracker apps  |
| **Scale**      | \$149        | 40 000 calls   | \$0.003 / call  | Recruiting platforms, HR analytics |
| **Enterprise** | Custom       | Unlimited      | Volume contract | Large ATS vendors & staffing firms |

*Unused calls roll over 1 month; reminders and webhook events count as 0.25 calls.*

---

## 10 ▪ Roll-Out Roadmap

| Month | Milestone                                                                                        |
| ----- | ------------------------------------------------------------------------------------------------ |
| **0** | Internal alpha: scrape + extract for top 20 job boards, manual QA feedback loop.                 |
| **1** | Public beta: self-serve dashboard for API keys, basic quota metering, single-endpoint docs.      |
| **2** | Webhook & reminder engine, duplicate detection, résumé diff, usage analytics.                    |
| **3** | Partner integrations (Zapier, Make, low-code platforms), official browser-extension starter kit. |
| **4** | Enterprise compliances, custom language models for non-English boards, regional data pods.       |

---

## 11 ▪ Competitive Edge

* **API-first purity** — zero front-end baggage; integrates into any stack in minutes.
* **LLM ensemble tuned for job text** — specialized prompts and guardrails slash hallucinations.
* **Revision history** — rescuing “dead” listings is a unique value prop for candidates and compliance teams.
* **Embeddable analytics** — drop-in JSON reports enable white-label dashboards without BI overhead.

---

## 12 ▪ Future Horizons

1. **Auto-Apply Endpoint** — structured JSON → form fill robots, gated behind strict compliance checks.
2. **Compensation Benchmark Feed** — anonymized, aggregated salary data surfaced via `/benchmarks`.
3. **Talent-Pool Matching** — inverse search: push résumés, receive ranked live postings.
4. **ATS Back-Fill Connector** — sync stage changes bi-directionally with major tracking systems.
5. **Market Pulse** — real-time Labour Market Intelligence (LMI) signals for economists and policy orgs.

---

## 13 ▪ Success Metrics

| KPI                            | North-Star Target        | Rationale                                                      |
| ------------------------------ | ------------------------ | -------------------------------------------------------------- |
| **Daily Parsed Jobs**          | 50 000 within 6 months   | Network effects: more data → better models → higher retention. |
| **Avg. Extraction Accuracy**   | ≥ 97 % on validation set | Maintains trust and reduces manual corrections.                |
| **Churn Rate (Grow tier)**     | < 3 % monthly            | Indicates durable developer adoption.                          |
| **Requests ↔ Reminders Ratio** | ≥ 1.4                    | Proof users leverage automations, not just raw scrape.         |

---

### **Why Avoda, Why Now?**

Remote-first hiring and AI-native tooling have exploded the **volume** and **velocity** of job postings. Candidates and career-platform builders alike crave *structured, actionable* vacancy data but lack the resources to build and maintain scraping, parsing, and enrichment pipelines. Avoda arrives as a **laser-focused utility**: battle-tested LLM workflows, ironclad revision storage, and pay-as-you-scale economics—*so every job seeker’s next move is always one API call away.*
