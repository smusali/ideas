# Resonatr

**Elevate every product decision with a resonant understanding of customer sentiment-in-motion.**

---

## Vision

Resonatr aspires to become the **product org’s real-time conscience**, unifying fragmented voices of customers, prospects, and internal stakeholders into a single, continuously learning insight stream. By surfacing the *why* behind every piece of feedback, it empowers teams to invest engineering and design cycles where they will resonate most—maximizing adoption, retention, and Net Revenue Retention (NRR).

---

## Core Problem

| Pain Point                          | Current Reality                                                                                      | Negative Impact                                             |
| ----------------------------------- | ---------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| **Feedback fragmentation**          | Slack threads, Zendesk tickets, Gong calls, CRM notes, app reviews, social media, etc. live in silos | Low signal-to-noise ratio, missed patterns, duplicated work |
| **Manual triage & tagging**         | PMs manually label categories, severity, and priority                                                | Delayed insights, inconsistent taxonomy                     |
| **Limited context for engineering** | Jira tickets often lack customer verbatim, frequency, or revenue at risk                             | Re-work, mis-aligned solutions                              |
| **Reactive analytics**              | Monthly VOC reports; stale by the time they land                                                     | Missed opportunity windows, slower iteration loops          |
| **Inaccurate prioritization**       | Loudest internal voice ≠ biggest customer impact                                                     | Roadmap drift, customer churn                               |

---

## Solution Overview

Resonatr ingests multi-channel feedback in real time, **enriches** it with context (product usage, account revenue, market segment), and **routes** actionable insights to the right owner at the right moment—while maintaining a living knowledge graph searchable by anyone.

Key pillars:

1. **Omnichannel Capture Gateway**
   *Zero-friction ingestion from wherever dialogue happens.*

2. **Semantic Understanding Engine**
   *LLM-powered classification, deduplication, trend detection, and impact scoring.*

3. **Insight Router & Command Center**
   *Dynamic owner mapping, SLA alerts, and decision-ready dashboards.*

4. **Knowledge Graph & Query Hub**
   *Vectorized repository enabling natural-language exploration (“Which features are blocking onboarding for enterprise accounts?”).*

5. **Outcome Attribution Loop**
   *Connect shipped improvements back to originating feedback; quantify NRR lift.*

---

## Differentiating Features

| Resonatr Capability                 | How It Stands Out                                                                                                   |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Live “Pulseboard” leaderboards**  | Auto-ranks themes by *churn risk*, *ARR affected*, and *sentiment velocity*—updated every minute                    |
| **Contextual deep links**           | Each insight card links to original Slack thread / Zendesk ticket / Gong snippet, preserving conversation nuance    |
| **Feedback primitives abstraction** | Maps any input (emoji reaction, voice transcript, NPS verbatim) into a unified schema—future-proof for new channels |
| **“Spec Draft” generator**          | One-click to turn clustered feedback into a pre-populated PRD outline (problem → users → acceptance criteria)       |
| **Impact-weighted burndown**        | Visualizes how roadmap items extinguish weighted pain points over time                                              |
| **Privacy & compliance guardrails** | Field-level redaction, regional data residency options, SOC 2 & GDPR-ready from day one                             |

---

## Target Personas & Jobs-to-Be-Done

| Persona                   | Critical Jobs                                               | Resonatr Outcomes                                           |
| ------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| **Product Manager**       | Identify high-leverage features; justify roadmap trade-offs | Always-current “top 10 needs” with revenue context          |
| **Customer Success Lead** | Pre-empt churn; champion customer voice                     | Instant alerts when a VIP signals frustration               |
| **Engineering Manager**   | Plan sprints aligned with customer pain; avoid scope creep  | Auto-generated Jira issues scoped with acceptance tests     |
| **UX Researcher**         | Uncover usability blockers; validate hypotheses             | Semantic search of past verbatims; trend graphs             |
| **Executive / GM**        | Track NRR impact; ensure strategic alignment                | Board-ready metrics tying feedback themes to revenue growth |

---

## High-Level Architecture (Narrative)

1. **Ingestion Layer**

   * Event-driven microservices receive webhooks from Slack, Zendesk, Intercom, HubSpot, Gong, App Store, and public social APIs.
   * All events normalized into a *FeedbackEnvelope* object pushed to Kafka.

2. **Processing & Enrichment**

   * Streaming pipeline (Apache Flink) performs language detection, PII scrubbing, and vector embedding using a hosted model (e.g., OpenAI embeddings).
   * Metadata enrichment: pulls customer tier and ARR from CRM, feature flags from analytics, and usage metrics from Snowflake.

3. **Semantic Orchestrator**

   * Deduplication: cosine similarity on embeddings with temporal weighting.
   * Classification: fine-tuned LLM assigns category, sentiment, urgency.
   * Impact Scoring: Revenue × Sentiment × Frequency produces a 0-100 priority index.

4. **Graph Storage**

   * Neo4j for relational edges (Account → Feature → Feedback).
   * Weaviate or Pinecone for vector queries.
   * MongoDB for transactional feedback documents.

5. **Application Layer**

   * GraphQL Gateway (Apollo) exposes unified API.
   * Real-time websockets & Slack/Teams bot push notifications.

6. **Presentation**

   * Next.js dashboard on Vercel with server-side rendering for speed.
   * Component library built with Radix UI + Tailwind.

7. **Observability & Governance**

   * OpenTelemetry tracing, Prometheus metrics, Grafana dashboards.
   * Role-based access; field-level encryption; audit logs shipped to S3 Glacier.

---

## AI & Machine Learning Components

| Model Function                    | Approach                                                   | Rationale                                         |
| --------------------------------- | ---------------------------------------------------------- | ------------------------------------------------- |
| **Summarization of long threads** | Distil-LED or GPT-4o summarizer fine-tuned on support logs | Preserves nuance while reducing noise             |
| **Sentiment & emotion detection** | Multi-label transformer (e.g., RoBERTa-base-emotion)       | Captures frustration vs. curiosity                |
| **Root-cause inference**          | Chain-of-Thought prompting with domain knowledge base      | Suggests underlying workflow friction             |
| **Churn propensity**              | Gradient-boosted model on historical churn labeled by ARR  | Guides proactive CS outreach                      |
| **Feature clustering**            | HDBSCAN on embedding space with adaptive epsilon           | Auto-groups emergent themes without manual labels |

---

## Data Model (Conceptual)

* **FeedbackNode**: id, body, source, timestamp, sentiment, themeId, accountId, impactScore
* **Theme**: id, title, aggregatedScore, status (open / in-progress / shipped / won)
* **Account**: id, name, tier, ARR, CSM owner
* **Action**: id, feedbackId, assignee, targetSystem (Jira, Linear), resolutionState, linkedRelease

*(Note: schematic only; no actual schema code.)*

---

## Pricing & Packaging

| Tier           | Monthly Price | Limits                            | Key Extras                                     |
| -------------- | ------------- | --------------------------------- | ---------------------------------------------- |
| **Starter**    | \$99          | 1 workspace, 2k feedback items/mo | Slack & Zendesk only                           |
| **Growth**     | \$399         | 3 workspaces, 20k feedback/mo     | Custom NLP, Jira sync, Pulseboard              |
| **Scale**      | \$1,299       | Unlimited workspaces & volume     | Dedicated vector DB, SOC 2 report, on-call SLA |
| **Enterprise** | Custom        | Unlimited + HIPAA/GDPR options    | VPC deployment, SSO, success engineer          |

**Metered add-ons:** additional 10k feedback bundles, premium LLM usage, bespoke dashboards.

---

## Go-To-Market Strategy

1. **Bottom-Up Wedge**

   * List Resonatr on Slack App Directory & Zendesk Marketplace with generous free trial.
   * Built-in viral loops: “Invite engineering to view this insight.”

2. **Community & Content**

   * Publish monthly “State of Product Feedback” benchmark reports.
   * Host *ResonateConf*—a virtual micro-summit for PMs and CS leaders.

3. **Product-Led Sales Assist**

   * Usage-based PQL scoring feeds HubSpot; SDR alerted when account crosses 500 insights ingested or engages Pulseboard daily.

4. **Channel Partnerships**

   * Integrations bundled in consultancy partner offerings (e.g., product-strategy firms, RevOps agencies).

---

## Success Metrics (North Star & Satellites)

| Metric                            | Why It Matters                              | Target @ 12 mo                              |
| --------------------------------- | ------------------------------------------- | ------------------------------------------- |
| **Insights Acted Upon**           | Measures actual product improvements driven | 30% of ingested feedback leads to an action |
| **Insight-to-Action Time**        | Speed of feedback loop                      | Median < 48 h                               |
| **ARR Influenced**                | Quantifies revenue tied to resolved themes  | \$1 M cumulative across customer base       |
| **Net Promoter Score (Platform)** | User delight among PMs/CSMs                 | 70+                                         |
| **Viral Coefficient**             | Organic expansion within orgs               | > 1.3                                       |

---

## Competitive Landscape

| Competitor            | Strengths                      | Gaps Resonatr Exploits                                |
| --------------------- | ------------------------------ | ----------------------------------------------------- |
| Productboard          | Mature roadmap workflows       | High friction multi-channel ingestion; less real-time |
| Dovetail              | Excellent research repository  | Limited ARR context; manual tagging                   |
| Canny                 | Lightweight changelog & voting | No semantic grouping; minimal CS integration          |
| Segment profiles + BI | Data richness                  | Requires analyst resources; slow insight loops        |

Resonatr positions itself as **real-time, context-rich, and automation-first**, bridging VOC and product development without analyst overhead.

---

## Roadmap Highlights

| Quarter | Milestone                                                      | Outcome                               |
| ------- | -------------------------------------------------------------- | ------------------------------------- |
| **Q1**  | Private Beta with Slack & Zendesk ingestion                    | Validate ingestion + Pulseboard UX    |
| **Q2**  | Launch Semantic Orchestrator v1; Jira & Linear push workflows  | Shorten feedback-to-issue loop        |
| **Q3**  | Integrate Gong call transcripts; ship Outcome Attribution Loop | Connect shipped features to NRR lift  |
| **Q4**  | Enterprise VPC offering; SOC 2 Type II                         | Unlock FinTech & HealthTech verticals |

Future expansions: **voice-of-sales** (CRM call notes), **in-app widgets**, **auto-generated changelogs**, **predictive feature ROI simulator**.

---

## Potential Risks & Mitigations

| Risk                            | Likelihood | Impact | Mitigation                                          |
| ------------------------------- | ---------- | ------ | --------------------------------------------------- |
| Data privacy concerns           | Medium     | High   | Field-level encryption, on-prem option              |
| LLM API cost spikes             | Medium     | Medium | Caching embeddings; fallback open-source models     |
| Marketplace policy changes      | Low        | Medium | Diversify ingestion channels; maintain direct OAuth |
| Over-automation alienates users | Low        | Medium | Human-in-the-loop review checkpoints                |

---

## Funding & Unit Economics Snapshot

* **CAC (paid + sales)**: \~\$1,200
* **Year-1 Gross Margin**: 80% (serverless + usage-based LLM pass-through)
* **Payback Period**: < 4 months in Growth tier
* **Target Net Dollar Retention**: 135% by cohort month 18

---

## The Resonatr Promise

“**Make every customer voice count—within minutes, not months.**”
By orchestrating feedback into decisive, revenue-driving action, Resonatr transforms the age-old chore of feedback management into an engine of continuous resonance between what you *build* and what users *need*.
