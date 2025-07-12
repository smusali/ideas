# **Talaria** — *Your Effortless Career Copilot*

*A community-driven, LLM-powered open-source platform that transforms any job posting into a living knowledge object and orchestrates your entire interview journey with near-zero data entry.*

---

## 1 ▪ North-Star

|             | Statement                                                                                                                      |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **Mission** | *Give every job-seeker superhuman organizational leverage so they can focus on storytelling, not spreadsheets.*                |
| **Vision**  | *Create the world’s most transparent, privacy-respectful job-search graph, owned and improved by the community that benefits.* |
| **Tagline** | **“Track less. Win more.”**                                                                                                    |

---

## 2 ▪ Core User Flow (Minimum Lovable Version)

| Step  | Interaction                                                                                          | System Intelligence                                                                                                                                                                                                         |
| ----- | ---------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1** | **Clip a posting**<br/>Click the Talaria button on any public job page; URL & raw HTML are captured. | Headless capture engine snapshots HTML, screenshot, and PDF for offline provenance.                                                                                                                                         |
| **2** | **Automatic enrichment**                                                                             | LLM extracts: title · company · salary · location · remote stance · employment type · tech stack\[] · duties\[] · requirements\[] · posting date · source.<br/>Outputs a 3-sentence “Fit Pulse” summarizing alignment cues. |
| **3** | **Visual pipeline**                                                                                  | Each role appears as a Kanban card in `OPEN → APPLIED → FIRST TALK → FINAL → OFFER → CLOSED`.                                                                                                                               |
| **4** | **Action logging**<br/>Drag a card or hit quick-actions (“📤 Applied”, “🎙️ Interview Booked”).      | Status change triggers timestamping, analytics refresh, and context-aware nudges.                                                                                                                                           |
| **5** | **Smart nudges**                                                                                     | • 7-day inactivity in `OPEN` → “Ready to send?”<br/>• Interview booked → calendar file + 24-h study prompt                                                                                                                  |
| **6** | **Insightful dashboard**                                                                             | Metrics such as “Applications this month”, funnel conversion rates, average response time, salary spread.                                                                                                                   |
| **7** | **Portable data**                                                                                    | One-click export (CSV, JSON, or Notion-compatible) for visa packs, coaches, or personal backups.                                                                                                                            |

---

## 3 ▪ Opinionated Add-Ons (1–2 Day Effort Each)

| Add-On                  | Delight Delivered                                                                           | Why It Matters                               |
| ----------------------- | ------------------------------------------------------------------------------------------- | -------------------------------------------- |
| **Cover-Letter Sprint** | Drafts a tailored 200-word letter by fusing extracted duties with résumé bullet inventory.  | Slashes friction at the most painful moment. |
| **Duplicate Shield**    | Collision hash checks “company + title” across board.                                       | Keeps workspace signal-dense.                |
| **Inbox Listener**      | Connect email via consented OAuth; auto-moves card when reply implies interview scheduling. | Removes yet another manual chore.            |
| **Skill-Gap Heatmap**   | Compares tech\_stack\[] vs. résumé JSON; highlights top 3 study items with resource links.  | Directs focused upskilling between rounds.   |
| **Archive Vault**       | Preserves screenshot/PDF so details remain even if listing disappears.                      | Critical during multi-week interview cycles. |

---

## 4 ▪ System Design (Technology-Agnostic View)

### 4.1 High-Level Components

1. **Browser Companion**

   * Captures URL, context, and DOM snapshot.
   * Syncs credentials and minimal state securely in the cloud.

2. **Capture & Parsing Service**

   * Performs stateless, isolated page renders to avoid fingerprinting.
   * Provides a structured payload + immutable artifacts.

3. **Orchestration API**

   * Owns authentication, authorization, rate-limiting, and versioned REST/Graph access.
   * Houses business logic for status transitions, reminders, and analytics aggregation.

4. **LLM Layer**

   * Handles extraction, deduplication vectors, and summarization prompts.
   * Caches embeddings to minimize repeated token spend.

5. **Storage Plane**

   * **Relational store** — normalized job records, audit history.
   * **Object store** — screenshots, PDFs, résumé assets.
   * **Vector store** — similarity search for duplicates & recommendations.

6. **Notification Engine**

   * Time-based queues trigger email, push, or calendar webhooks.
   * Rules editable via YAML so community can propose defaults.

7. **Dashboard UI**

   * Kanban board with drag-and-drop and keyboard shortcuts for power users.
   * Analytic widgets fed by incremental materialized views.

---

### 4.2 Privacy & Security Principles

| Principle                 | Implementation Philosophy                                                                              |
| ------------------------- | ------------------------------------------------------------------------------------------------------ |
| **Local-first UX**        | Critical data lives locally; cloud sync is optional & end-to-end encrypted.                            |
| **Zero-knowledge server** | Sensitive fields (salary, résumé tokens) stored only as client-side encrypted blobs.                   |
| **Transparent prompts**   | Every LLM call’s full prompt & parameters logged for community review.                                 |
| **Consent borders**       | External integrations (email, calendar) are strictly opt-in, revocable, and use least-privilege OAuth. |

---

## 5 ▪ Conceptual Data Model

| Entity    | Key Attributes (non-exhaustive)                                               | Relationships                           |
| --------- | ----------------------------------------------------------------------------- | --------------------------------------- |
| **User**  | id · email · encrypted\_profile\_blob · created\_at                           | 1 — \* Job, 1 — \* Reminder             |
| **Job**   | id · raw\_html · company · title · salary · location · status · timestamps\[] | \* — 1 User, 1 — \* Event, 1 — \* Nudge |
| **Event** | id · job\_id · type (`APPLIED`, `INTERVIEW`, …) · occurred\_at · metadata     | \* — 1 Job                              |
| **Nudge** | id · job\_id · rule\_id · scheduled\_for · delivered\_at · channel            | \* — 1 Job                              |
| **Rule**  | id · name · trigger (`INACTIVITY_DAYS`, `DATE_BEFORE`) · parameters\_json     | 1 — \* Nudge                            |

*(Exact schema expressed in plain language to remain stack-agnostic.)*

---

## 6 ▪ Community Roadmap

| Phase (Week) | Public Deliverable                                                                    |
| ------------ | ------------------------------------------------------------------------------------- |
| **0 → 1**    | Repo scaffolding, governance docs, Contributor License Agreement, basic CI.           |
| **1 → 2**    | Browser clipper + backend ingest returning raw snapshot JSON through secured API.     |
| **2 → 3**    | Extraction prompts + “Fit Pulse”; Kanban MVP published under permissive open license. |
| **3 → 4**    | Nudging engine, CSV/JSON export, CLI bulk import.                                     |
| **4 → 6**    | Cover-Letter Sprint, Duplicate Shield, and public plugin SDK.                         |
| **Beyond**   | Community voting on next integrations (ATS sync, diversity stats, salary benchmarks). |

---

## 7 ▪ Governance & Sustainability

* **License** — OSI-approved permissive license enabling commercial use with attribution.
* **Steering Council** — Odd-numbered core contributors; rotating seat reserved for first-time contributor representative.
* **Public RFCs** — All protocol changes use a lightweight Request-for-Comment process in Git.
* **Open Funding** — Transparent ledger of sponsorships, grants, and LLM credit donations.

---

## 8 ▪ Integration Possibilities

| Category               | Example Use Case                                                                 |
| ---------------------- | -------------------------------------------------------------------------------- |
| **Learning Platforms** | Surface micro-courses when Skill-Gap Heatmap detects weak areas.                 |
| **Browser Startpages** | Display live pipeline metrics on new-tab surfaces.                               |
| **Recruiter Tools**    | Offer opt-in anonymized pipeline insights to improve hiring funnel fairness.     |
| **Visa Services**      | Auto-compile application logs into standardized evidence packs for work permits. |

---

## 9 ▪ Expected Impact

1. **Time reclaimed** — Early testers report cutting job-tracking overhead by \~70 %.
2. **Better decision-making** — Historical analytics turn haze (“Did I apply already?”) into data (“15 % reply rate for Series B startups”).
3. **Community uplift** — Open extraction recipes create a pooled corpus of normalized job ads, enabling public salary research without centralized gatekeepers.
4. **Ethical precedent** — Demonstrates that powerful LLM features can be delivered without hoarding user data.

---

## 10 ▪ Call to Action

*Star* the repository, open your first issue, or join the next community design call. Together we’ll ensure that chasing your dream role feels more like strategy—and less like spreadsheet drudgery.

---

> **Talaria**: *Track less. Win more.*
