# Ottera Health — *Bridge the Care*

---

## 1 ▪ North-Star

|                      | Statement                                                                                                                            | Source |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ | ------ |
| **Mission**          | *Create a world where AI and mental-health professionals work hand-in-hand so every patient receives personalised, continuous care.* |        |
| **Vision**           | *Enhance mental-health care by uniting AI and human professionals, delivering better support together than either could alone.*      |        |
| **Tagline / Domain** | **“Bridge the Care”** — [https://ottera.health](https://ottera.health)                                                               |        |

---

## 2 ▪ Problem Landscape

1. **Between-session void** — patients may go 7–14 days without structured help, risking relapse or crisis.
2. **Therapist admin drag** — 23-30 % of clinician time is lost to notes, scheduling and follow-up admin.
3. **Unaffordable AI tools** — existing “ambient-scribe” platforms cost \$200 +/mo and target enterprise clinics, freezing out 180 k + solo therapists.

---

## 3 ▪ Solution Overview

Ottera Health is a **therapist-first AI co-pilot** that embeds before, during and after every session:

| Therapy Phase        | What Ottera Does                                                                                           | Core Modules & Docs                                   |
| -------------------- | ---------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| **Between sessions** | • Secure AI chat check-ins driven by therapist-set prompts<br>• Real-time risk detection & alerts          | **AI Chatbot Engine**, **Emergency Detection System** |
| **In session**       | • Toggle “Start AI Analysis” for live note drafting<br>• Capture emotional & behavioural cues              | **Ongoing Session UI**                                |
| **Post session**     | • Probable diagnoses (DSM-5 checklist), treatment-plan suggestions, follow-up-prompt wizard                | **Session Analysis Pipeline**                         |
| **Administration**   | • Natural-language commands (“Cancel Friday”, “Add sertraline 25 mg note”) automate calendar & EHR updates | **AI Chat-bot Admin Skills**                          |

---

## 4 ▪ Feature Deep-Dive

### 4.1 AI-Assisted Personalised Support

*Daily or on-demand conversational check-ins, custom tone/frequency, mood tracking and journaling; summaries routed to therapist dashboard.*

### 4.2 Progress Monitoring & Insights

*Automated, schedulable reports highlighting trends, engagement drops and emergent risks; searchable patient history via natural-language.*

### 4.3 AI Session Analysis

*Real-time transcription → structured notes → DSM-5-aligned diagnosis probabilities; explain-ability pane (“Why?”).*

### 4.4 Risk Detection Engine

*Low / moderate / high-risk tiers with configurable thresholds; instant 988/hotline hand-off and therapist notification controls.*

### 4.5 Therapist Productivity Toolkit

*Universal search, appointment NLP, resource library injection, contextual suggestions, and session feedback on therapist technique.*

---

## 5 ▪ User Experience at a Glance

| User          | Key Surfaces                                                                            | Highlights                                                        |
| ------------- | --------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| **Therapist** | **Sidebar** (Home, AI Check-in, Appointments, Emergency, Directory, Library, Settings)  | One-click “Start Session”, no-show logging, live emergency queue  |
|               | **Top Nav**                                                                             | Predictive global search & granular notifications                 |
|               | **AI Chat-bot**                                                                         | “Ask anything” about any patient; NLP admin commands              |
|               | **Session Flow**                                                                        | Toggle AI analysis, view real-time notes, accept/adjust diagnosis |
| **Patient**   | **Home / Tasks**                                                                        | Medication & exercise reminders auto-synced from plan             |
|               | **Chat**                                                                                | Therapist-guided AI support, 24 / 7                               |
|               | **Appointments**                                                                        | Self-serve reschedule flow                                        |
|               | **Profile & Permissions**                                                               | Fine-grained opt-in/out for every AI feature                      |

---

## 6 ▪ System & Data Architecture

*High-level component map*:

```
Therapist Web App ─┐
                   │  API Gateway ─ Auth ─ Session Svc ─ AI Orchestrator ─ LLM API
Patient Mobile App ─┘                       ├─ Emergency Engine
                                            └─ Follow-up Engine
```



### 6.1 Database Snapshot

Comprehensive ERD covering patients, sessions, AI notes, diagnoses, treatment plans, permissions and alerts.

### 6.2 Security & Compliance

*HIPAA + GDPR encryption, MFA, role-based access, audit logging, data-anonymisation.*

---

## 7 ▪ Business & Market

| Aspect                      | Detail                                                                                                                 | Source |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------ |
| **Primary model**           | B2B SaaS — \$50-\$150 / therapist / month                                                                              |        |
| **Enterprise licence**      | \$50 k-\$500 k / year for hospitals & insurers                                                                         |        |
| **Future revenue**          | Premium patient features, anonymised research datasets                                                                 |        |
| **TAM**                     | Global digital mental-health market \$28 B (2023) growing 18-20 % CAGR                                                 |        |
| **Competitive white-space** | Solo / small-group therapists underserved by pricey ambient-scribe tools; Ottera slots mid-market at \$600-\$1 800 ARR |        |

---

## 8 ▪ Execution Roadmap (Solo CTO – 6 months)

| Phase                | Weeks | Milestones                                                                    | Doc |
| -------------------- | ----- | ----------------------------------------------------------------------------- | --- |
| **0 Foundation**     | 0-1   | Monorepo, CI/CD, HIPAA envs, OAuth + MFA                                      |     |
| **1 Pre-MVP**        | 1-6   | Therapist dashboard, AI chatbot POC, post-session pipeline, basic patient app |     |
| **2 MVP Launch**     | 7-12  | Permission matrix, emergency detection, notifications, internal HIPAA audit   |     |
| **3 Post-MVP Scale** | 13-20 | Session feedback loop, cohort analytics, early EHR gateway                    |     |
| **4 Pre-Seed Prep**  | 21-27 | ≥ 20 therapists, (≥ 100 patients), enterprise dashboard, pitch-deck metrics   |     |

---

## 9 ▪ Regulatory & Ethical Guard-Rails

* End-to-end encryption, PHI scoped least-privilege access
* AI acts as **decision-support**; human therapist always confirms diagnoses/treatment (avoids SaMD)
* Transparent patient consent toggles for every AI capability

---

## 10 ▪ Competitive Advantage Recap

1. **Continuous Care Loop** — AI check-ins + therapist review closes the notorious between-session gap that marketplaces and scribe-only tools ignore.
2. **Affordability for Independents** — priced an order of magnitude below Eleos-class enterprise tools.
3. **All-in-one Workflow** — search, scheduling, documentation and risk alerts in a single pane.
4. **Explainable AI** — DSM-5 criteria links and “Why?” buttons build clinician trust.
5. **Granular Privacy Controls** — unmatched patient-side toggle matrix.

---

## 11 ▪ Long-Range Horizon

| Timeframe   | Planned Expansion                                                                                                        |
| ----------- | ------------------------------------------------------------------------------------------------------------------------ |
| **12-24 m** | Multilingual models, advanced differential-diagnosis graph, platform APIs for third-party digital therapeutics           |
| **24-36 m** | Smart triage & specialist routing, federated learning on anonymised therapy outcomes, payer-integrated ROI dashboards    |
| **36 m +**  | Strategic alignment for acquisition by tele-mental-health leaders, ambient-scribe vendors, or practice-management giants |

---

> **Ottera Health** weaves *empathy-first design* with *reg-grade AI* to give every therapist the super-powers of a clinical team and every patient a safety net that never sleeps.
