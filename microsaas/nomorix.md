# **Nomorix** — *“Your Travel Data, Unified.”*

> **API-only MicroSaaS** that lets any product ingest, cleanse, enrich, and analyze raw travel-booking artifacts (emails, PDFs, screenshots, calendar invites) with a single call—turning unstructured chaos into actionable JSON in seconds.

---

## 1 ▪ Executive Summary

Nomorix targets the hidden *plumbing problem* of travel-tech: every itinerary, ticket, or voucher arrives in a different format, making downstream personalization painful.
The service offers a **privacy-respecting, drop-in API** that:

1. **Collects** artifacts from inboxes, uploads, webhooks, or direct scraping links.
2. **Normalizes** them into a unified schema (segments, legs, travelers, ancillaries, prices, loyalty, carbon data).
3. **Enriches** the payload with LLM-generated summaries, predictions, and recommendations.
4. **Streams** structured updates back in real time (webhooks / websockets) as travel plans evolve.

---

## 2 ▪ North-Star

|                 | Statement                                                                                              |
| --------------- | ------------------------------------------------------------------------------------------------------ |
| **Mission**     | *Democratize access to clean, enriched travel data so every app can deliver concierge-level journeys.* |
| **Vision**      | *Become the invisible backbone powering frictionless travel experiences across the globe.*             |
| **Primary KPI** | *Monthly Parsed Segments (MPS)* — the count of flight/hotel/ground segments successfully normalized.   |

---

## 3 ▪ Problem Landscape

1. **Fragmented Sources** – Bookings arrive via dozens of OTAs, airline emails, PDFs, and loyalty apps; field names and layouts differ dramatically.
2. **Manual Workarounds** – Developers build brittle regex pipelines or ask users to forward emails; maintenance balloons with each vendor change.
3. **Missed Personalization** – Without tidy data, recommendations, dynamic pricing, and carbon-impact calculators under-perform.
4. **Privacy & Compliance** – Rolling your own parsing often fails security reviews and regional data-residency requirements.

---

## 4 ▪ Solution Highlights

| Pillar                    | Description                                                                                                                |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Universal Ingestion**   | Accepts emails (OAuth inbox connect), direct file uploads (PDF/EML/HTML), or fetch-by-URL scraping.                        |
| **Adaptive LLM Parsing**  | Proprietary prompt-chaining auto-detects template type, then extracts fields with self-validation loops for 95%+ accuracy. |
| **Contextual Enrichment** | Adds loyalty points, carbon footprint, weather window, seat-map insights, and rebooking tips via partner data layers.      |
| **Event-Driven Updates**  | Webhooks/websockets push changes (delay alerts, gate swaps) so clients stay in sync without polling.                       |
| **Privacy by Design**     | No artifacts stored beyond configurable TTL; supports regional processing zones and brings-your-own-key encryption.        |

---

## 5 ▪ Core API Endpoints (v0.9)

| Endpoint                  | Method | Purpose                                                        | Typical Response                             |
| ------------------------- | ------ | -------------------------------------------------------------- | -------------------------------------------- |
| `/ingest/email`           | `POST` | Forward raw EML / RFC-822 content for parsing.                 | `ingestion_id`, status                       |
| `/ingest/document`        | `POST` | Upload PDF, image, or HTML page.                               | `ingestion_id`, status                       |
| `/ingest/url`             | `POST` | Provide booking-confirmation URL; Nomorix fetches & snapshots. | `ingestion_id`, status                       |
| `/consume/{ingestion_id}` | `GET`  | Retrieve normalized itinerary JSON when ready.                 | Nested `trip`, `traveler`, `segment` objects |
| `/webhook/register`       | `POST` | Subscribe to realtime changes for a user/org.                  | `webhook_id`, secrets                        |
| `/recommendations`        | `POST` | Feed normalized itinerary; receive LLM travel tips & upsells.  | Array of `suggestion` objects                |

*Authentication*: bearer tokens with granular scopes; optional org-level API keys.
*Rate Limits*: tiered SLA (Basic = 50 requests/min, Pro = 500, Enterprise = custom).

---

## 6 ▪ Key Features & Benefits

1. **Zero-Setup Parsing** – Plug-and-play endpoint eliminates months of brittle per-vendor screen scraping.
2. **Insight-Ready Schema** – Consistent JSON lets downstream analytics, NDC offers, and chatbots read instantly.
3. **LLM-Driven Summaries** – Auto-generate plain-language itineraries, policy flags, and “next-best-action” guidance.
4. **Privacy Controls** – Regional processing, short-lived storage, and signed URL retrieval tick enterprise checklists.
5. **Developer Delight** – Interactive Swagger / Postman collections, clear pagination, and versioned contracts reduce churn.

---

## 7 ▪ MVP Roadmap

| Phase                          | Duration | Scope                                                                       | Validation Metric                                         |
| ------------------------------ | -------- | --------------------------------------------------------------------------- | --------------------------------------------------------- |
| **α – Email & PDF Parsing**    | 6 weeks  | Ingest + normalize flights & hotels from top 10 OTAs; polling retrieval.    | ≥ 90% field extraction accuracy on 500 sample itineraries |
| **β – Realtime Webhooks**      | 4 weeks  | Add push architecture, idempotent retries, signed payloads.                 | 1s median delivery latency                                |
| **GA – Enrichment & Insights** | 8 weeks  | LLM summaries, carbon & loyalty calculators, basic recommendation endpoint. | ≥ 30% CTR on suggestion tests with pilot customers        |

---

## 8 ▪ Business Model Canvas

| Block                      | Detail                                                                                      |
| -------------------------- | ------------------------------------------------------------------------------------------- |
| **Key Partners**           | GDS & NDC aggregators • Global weather & carbon APIs • Loyalty program data brokers         |
| **Key Activities**         | Template discovery & labeling • Model fine-tuning • Compliance & regional hosting           |
| **Key Resources**          | Proprietary training corpus of booking layouts • Annotation pipeline • DevRel program       |
| **Value Propositions**     | *Parse once, use everywhere* • Enterprise-grade privacy • Fastest time-to-insight           |
| **Customer Relationships** | Self-serve docs • Slack workspace • Dedicated CSM for ≥ Enterprise tier                     |
| **Channels**               | Developer marketing (Product Hunt, API marketplaces) • Partnerships with OTA white-labelers |
| **Customer Segments**      | Travel-tech startups • Expense-management SaaS • Corporate TMCs • Loyalty apps              |
| **Cost Structure**         | GPU inference infra • Compliance & audits • Partner data licensing • Support                |
| **Revenue Streams**        | Usage-based API calls • Premium enrichment add-ons • Embedded upsell commissions            |

---

## 9 ▪ Pricing Strategy

| Plan           | Monthly Platform Fee | Included Parse Credits | Overages            | Extras                                   |
| -------------- | -------------------- | ---------------------- | ------------------- | ---------------------------------------- |
| **Sandbox**    | \$0                  | 250                    | \$1.20/100 segments | N/A                                      |
| **Growth**     | \$99                 | 5 000                  | \$0.75/100 segments | Carbon & loyalty enrichment bundle +\$49 |
| **Pro**        | \$499                | 50 000                 | \$0.40/100 segments | SLA 99.9% + dedicated Slack              |
| **Enterprise** | Custom               | Unlimited BYOC region  | Volume discounts    | On-prem / VPC deployment option          |

---

## 10 ▪ Competitive Snapshot

| Player          | Parsing Accuracy | Realtime Updates | LLM Summaries | Privacy Controls | API-only? |
| --------------- | ---------------- | ---------------- | ------------- | ---------------- | --------- |
| **Nomorix**     | **95%**          | **Yes**          | **Yes**       | **Granular**     | **Yes**   |
| Duffel Data     | 85%              | No               | No            | Limited          | Partial   |
| Concur TripLink | 70%              | Yes              | No            | Moderate         | No        |
| TripIt API      | 80%              | No               | Limited       | Basic            | Mixed     |

*Strategic Moat*: continuously-growing proprietary template corpus + hybrid rule/LLM engine that self-heals when vendor layouts shift.

---

## 11 ▪ Go-To-Market Plan

1. **Launch Week** – Target Product Hunt, Call for Beta on /r/travel and Dev.to.
2. **Integration Showcases** – Publish sample repo: “Build a Slack travel bot in 30 min.”
3. **Partnerships** – Offer rev-share to expense-management tools that embed Nomorix enrichment.
4. **Thought Leadership** – Quarterly “State of Travel Data” report using aggregated anonymized stats.
5. **Enterprise Foot-in-Door** – Free POC credits for top 25 corporate TMCs, bundled with compliance whitepaper.

---

## 12 ▪ Future Horizons

* **Ground & Cruise Modules** – Extend schema to trains, buses, ferries, cruises.
* **Rebooking Automation** – Trigger one-click reissues during IRROPS via partner NDC.
* **Embedded Carbon Offsets** – Offer optional projects checkout API for travelers to neutralize emissions.
* **GenAI Concierge Toolkit** – Server-less function that assembles PNR, loyalty, team calendars into proactive trip planning conversations.

---

## 13 ▪ Risks & Mitigations

| Risk                              | Impact                    | Mitigation                                                                                   |
| --------------------------------- | ------------------------- | -------------------------------------------------------------------------------------------- |
| Vendor layout drift               | Parsing failure           | Continuous template monitoring; active-learning model retrains nightly                       |
| Data-privacy regulations          | Fines, lost trust         | Regional processing clusters; third-party audits; privacy shield certifications              |
| LLM hallucinations                | Incorrect recommendations | Ensemble validation & confidence scoring; fallback to rule-based suggestions above threshold |
| Dependency on external data feeds | Service disruption        | Redundant providers; graceful degradation modes                                              |

---

### **Final Takeaway**

Nomorix positions itself as the *invisible API layer* that finally standardizes every chaotic travel artifact into one clean, enriched stream—unlocking a new wave of hyper-personalized, eco-aware, and hassle-free travel experiences across the industry.
