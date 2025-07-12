# **Ferota — *Travel, Intuitively***

> **Open-source, LLM-powered travel orchestration that turns the chaos of booking emails, PDFs, and confirmation pages into living knowledge — then helps you plan the *next* trip before you even think to ask.**

---

## 1 ▪ North-Star

|                      | Statement                                                                                                                         |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Mission**          | *Empower every traveler with a privacy-first AI companion that aggregates, understands, and optimizes their journeys end-to-end.* |
| **Vision**           | *Make travel management as seamless as music streaming: one account, every trip, zero friction, all personally curated by AI.*    |
| **Tagline / Domain** | **“Travel, Intuitively”** — `ferota.org` (placeholder)                                                                            |

---

## 2 ▪ Problem Landscape

1. **Scattered Sources** — flight e-tickets, hotel PDFs, rideshare receipts, and visa forms live in different silos.
2. **Zero Memory** — booking engines forget your preferences after checkout; loyalty data is under-leveraged.
3. **Manual Consolidation** — forwarding confirmation emails to generic “plan@” inboxes still forces users to label and sanity-check details.
4. **Opaque Carbon Costs** — eco-conscious travelers lack clear insight into the environmental impact of proposed itineraries.
5. **Static Itineraries** — once generated, an itinerary rarely adapts to delays, gate changes, or new opportunities.

---

## 3 ▪ Solution Overview

Ferota is a **privacy-first travel graph** that continuously ingests your booking artifacts (emails, PDFs, screenshots, direct links), interprets them with local or cloud LLMs, and stores the results as structured, queryable events.
From that knowledge base, it offers:

| Pillar                      | What it Delivers                                                                                           | Why it Matters                       |
| --------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| **Unification**             | Auto-extracted trips, segments, and tickets in one timeline                                                | Replaces spreadsheets & inbox search |
| **Personal DNA**            | Learns seat, hotel-brand, dietary & budget preferences                                                     | Removes repetitive form-filling      |
| **Contextual Nudges**       | Just-in-time reminders (check-in, visa, SIM card), plus “missed opportunity” alerts (unused lounge passes) | Prevents friction and waste          |
| **Sustainability Insights** | Carbon estimates & eco-alternative suggestions baked into each option                                      | Aligns trips with values             |
| **Real-time Adaptation**    | Live re-routing and re-booking advice when disruptions hit                                                 | Turns chaos into confidence          |

All core components live under an **open-source license**, enabling community audits, self-hosting, and rapid extension.

---

## 4 ▪ Unique Principles

1. **Inbox-Optional** – Users may grant OAuth mail access, upload documents, or paste URLs; the system never forces a single ingestion path.
2. **Edge-Compute Ready** – The extraction pipeline can run locally on laptops or private servers, keeping raw artifacts off Ferota’s cloud by default.
3. **Explainable AI** – Every suggestion links back to concrete data and rationale, debuggable via an inspector panel.
4. **Incremental Adoption** – Works as a passive “trip library” on day 1; advanced features (alerts, recommendations) layer on as trust grows.
5. **Community-Driven Roadmap** – Governance via an open steering council; major feature votes occur publicly.

---

## 5 ▪ Business Model (Open-Core)

| Tier             | Target User               | Price Model                      | Key Extras                                                     |
| ---------------- | ------------------------- | -------------------------------- | -------------------------------------------------------------- |
| **Community**    | Hackers, self-hosters     | Free (AGPL)                      | Full source, local pipelines, basic UI                         |
| **Pro**          | Frequent travelers & SMBs | Subscription per active traveler | Cloud sync, multi-device push, proactive disruption re-booking |
| **Enterprise**   | Corporations & TMCs       | SaaS or on-prem license          | SSO, policy engine, expense export, SLA support                |
| **Insights API** | Travel tech partners      | Usage-based                      | Anonymized trends & sustainability scores                      |

---

## 6 ▪ Stakeholder Map

| Stakeholder                   | Needs                                | Ferota Value                         |
| ----------------------------- | ------------------------------------ | ------------------------------------ |
| **Individual Travelers**      | Simplicity, personalization, control | One timeline + preference memory     |
| **Corporate Travel Managers** | Policy compliance, spend visibility  | Central dashboard & alerts           |
| **Sustainability Teams**      | Carbon reporting & reduction levers  | Built-in emissions ledger            |
| **Travel Agencies / OTAs**    | Differentiated UX, retention         | Embed Ferota widgets & API           |
| **Open-Source Community**     | Transparency, extensibility          | Modular plugins & permissive license |

---

## 7 ▪ Core Functional Stack (Conceptual)

> *No vendor names — only neutral capabilities.*

1. **Ingestion Layer**
   *Email adapters, file parsers, browser extensions, mobile share-sheet.*
2. **Semantic Extraction Engine**
   *LLM prompts + rules to detect PNRs, dates, passenger names, loyalty IDs.*
3. **Travel Graph Store**
   *Immutable timeline of `Trip → Segment → Leg → Service` nodes.*
4. **Preference & Profile Manager**
   *Recursive embeddings + explicit settings.*
5. **Recommendation Orchestrator**
   *Multi-objective ranking (price, time, comfort, carbon).*
6. **Notification Hub**
   *Channel-agnostic push, email, SMS, webhook.*
7. **Insight & Reporting Suite**
   *Visual dashboards, exportable datasets.*

---

## 8 ▪ MVP Cut

| Capability                    | Why in v0                         | Acceptance Test                                               |
| ----------------------------- | --------------------------------- | ------------------------------------------------------------- |
| **Email & PDF Auto-Parse**    | Highest painkiller; instant wow   | Ingest 5 airlines + 3 hotel brands with > 95 % field accuracy |
| **Interactive Trip Timeline** | Foundation for all UX             | User can drill from yearly heat-map → single boarding pass    |
| **Preference Learning Seed**  | Enables immediate personalization | System correctly proposes aisle seat for next booking         |
| **Carbon Estimator**          | Differentiator vs incumbents      | Displays CO₂/kg for every flight leg with source citation     |
| **Self-host Docker Compose**  | Aligns with open-source ethos     | New contributor stands up local Ferota in < 10 min            |

---

## 9 ▪ 12-Month Roadmap

| Q      | Milestone                 | Key Deliverables                                            |
| ------ | ------------------------- | ----------------------------------------------------------- |
| **Q1** | **Public Alpha**          | Core parsers, local storage, basic UI, contributor guide    |
| **Q2** | **Cloud Sync Beta**       | End-to-end encryption, push notifications, mobile PWA       |
| **Q3** | **Adaptive Re-booking**   | Real-time delay detection, automated option surfacing       |
| **Q4** | **Marketplace & Plugins** | Carbon-offset checkout, visa checker, lounge-finder modules |

---

## 10 ▪ Governance & Community

* **Steering Council** – Elected maintainers oversee vision, ensure code-of-conduct compliance.
* **RFC Process** – Major changes proposed via public discussions, time-boxed for consensus.
* **Bounties & Grants** – Sponsored issues for new parsers (e.g., rail, ferry, ride-hailing).
* **Diversity Pledge** – Outreach programs to include underrepresented groups in travel tech.

---

## 11 ▪ Risks & Mitigations

| Risk                               | Impact                 | Mitigation                                                     |
| ---------------------------------- | ---------------------- | -------------------------------------------------------------- |
| **Data-Privacy Breach**            | Loss of trust          | End-to-end encryption, local-first default, third-party audits |
| **Supplier API Changes**           | Parse failures         | Fallback to document OCR, community hot-fix releases           |
| **Model Hallucination**            | Incorrect suggestions  | RAG with ground-truth itinerary data, confidence scoring       |
| **Open-Core Skepticism**           | Forks dilute ecosystem | Dual licensing for brand assets, vibrant plugin marketplace    |
| **Regulatory Shifts (GDPR, CPRA)** | Compliance overhead    | Design-time privacy controls, data-minimization ethos          |

---

## 12 ▪ Success Metrics

| Dimension          | KPI                         | Year-1 Target |
| ------------------ | --------------------------- | ------------- |
| **Adoption**       | GitHub ⭐️                   | 5 k           |
| **Accuracy**       | Parsed fields per artifact  | ≥ 97 %        |
| **Engagement**     | Monthly active travelers    | 20 k          |
| **Sustainability** | Avg. CO₂ reduction per user | 8 %           |
| **Community**      | External PRs merged         | 250           |

---

## 13 ▪ Call to Action

Ferota is *just* beginning its journey. We’re looking for:

* **Alpha Testers** – help battle-test parsers with your live travel data (anonymized).
* **Parser Ninjas** – build connectors for trains, ferries, low-cost carriers, and buses.
* **Design Thinkers** – craft delightful experiences for non-tech travelers.
* **Sustainability Experts** – refine emissions models and offset integrations.

Join the discussion at `github.com/ferota/ferota` (placeholder) and shape the future of intelligent travel.

---

> Ferota reimagines trip management as a *conversation* between you and your travel history — respectful of privacy, fuelled by open innovation, and relentlessly focused on making every journey smoother than the last.
