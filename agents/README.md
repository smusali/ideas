# `agents/`: Agentic SaaS Specifications

This directory defines **Long-Running, Event-Driven Autonomous Systems**: triggers (webhooks, schedules, queues), policy-bound actions, **Human-in-the-Loop** gates where stakes are high, and audit-friendly state. These are not “chat wrappers”; they are **Products** with install flows, pricing, data models, and measurable outcomes.

Use this folder when the value is **continuous** (“always watching, always resolving, always drafting”) rather than **on-demand** (“call this endpoint when I ask”).

Analysis and cross-portfolio tables: [`REPORT.md`](../REPORT.md) Section 8 and appendices. Index table: root [`README.md`](../README.md).

---

## What Belongs in `agents/`

| Criterion | Expectation |
|-----------|-------------|
| **Trigger Model** | Explicit list: webhooks, cron, email, message bus, polling, etc. |
| **Autonomy Boundary** | Clear where the agent acts alone vs. waits for human approval |
| **Persistence** | Runs, audits, decisions, and idempotency are part of the design |
| **Revenue** | Agent tier pricing (often higher than raw API) with a rationale |
| **MVP Horizon** | **7-day** table oriented to *deployable* agent (even if narrow) |
| **Safety** | Destructive actions (send email, spend money, merge code) gated by default |

---

## Relationship to `microsaas/` and `oss/`

```text
oss/          →  Optional funnel: CLI users become API users
microsaas/    →  On-demand API or app (building blocks the agent calls)
agents/       →  Orchestration layer: senses → plans → acts → reports
```

**Typical Evolution**

1. Ship **OSS** or **MicroSaaS** for a narrow job.
2. Add **triggers** when customers ask for “just handle it when X happens.”
3. Productize the loop as an **agent** with install, dashboard, and higher ARPU.

**Special Cases in This Repository**

| Case | Example | Note |
|------|---------|------|
| Agent + MicroSaaS + OSS | `configguard` | Full stack: [`confcheck`](../oss/confcheck.md) → API → agent |
| Agent + MicroSaaS (no OSS twin in-repo) | `fundos`, `mailcraft`, … | Many agents stand on APIs defined only in `microsaas/` |
| Agent **without** matching `microsaas/*.md` | [`applynt`](./applynt.md) | Agent spec exists; no parallel `microsaas/applynt.md` in this repository. Implement the API surface inside the agent product or add a MicroSaaS spec later. |

---

## Conventions

| Topic | Rule |
|-------|------|
| **File Names** | Match the product slug: `redactguard.md`, `fundos.md`. |
| **Title** | Use `{{Name}} Agent` or equivalent in the H1 for clarity. |
| **Template** | [`template.md`](./template.md) is the source of truth for section order. |
| **Diagrams** | Mermaid `sequenceDiagram` must show trigger → agent → optional human → outcome. |
| **Tier/Score Lines** | Older templates may show “Tier / Score”; new work should **omit numeric tiering** and describe readiness in prose (aligned with [`REPORT.md`](../REPORT.md) updates). |

---

## Catalog: Thirteen Agent Specs

Alphabetical by file name. **MicroSaaS** column links to the hosted product spec when present in this repo.

| Agent spec | Role (summary) | MicroSaaS twin | Related OSS |
|------------|----------------|----------------|-------------|
| [`applynt.md`](./applynt.md) | Temporal-backed job-application ops: alias inboxes, durable workflows, approval-gated sends | *Not in `microsaas/`* | N/A |
| [`configguard.md`](./configguard.md) | CI/CD config guardrails on repo events; PR feedback and optional auto-fix | [`configguard`](../microsaas/configguard.md) | [`confcheck`](../oss/confcheck.md) |
| [`contributehq.md`](./contributehq.md) | Maintainer-facing contributor onboarding and async Q&A grounded in repo context | [`contributehq`](../microsaas/contributehq.md) | [`forkco`](../oss/forkco.md) |
| [`depchain.md`](./depchain.md) | Deployment orchestration awareness: health, ordering, risk, rollback assistance | [`depchain`](../microsaas/depchain.md) | N/A |
| [`feedbackflow.md`](./feedbackflow.md) | VoC triage across channels; clustering and draft responses with human send gates | [`feedbackflow`](../microsaas/feedbackflow.md) | N/A |
| [`fundos.md`](./fundos.md) | Multi-squad VC deal flow: radar, intake, dossier, diligence, IC memo, portfolio touchpoints | [`fundos`](../microsaas/fundos.md) | N/A |
| [`insightify.md`](./insightify.md) | Proactive analytics: connectors, NL queries, anomalies, scheduled narratives | [`insightify`](../microsaas/insightify.md) | [`loglens`](../oss/loglens.md) |
| [`mailcraft.md`](./mailcraft.md) | Inbox automation: classify, draft, schedule, unsubscribe, with approval queues | [`mailcraft`](../microsaas/mailcraft.md) | N/A |
| [`orchestiq.md`](./orchestiq.md) | Event-driven workflow and sub-agent orchestration beyond manual API calls | [`orchestiq`](../microsaas/orchestiq.md) | [`mycelium`](../oss/mycelium.md) |
| [`postforge.md`](./postforge.md) | Brand calendar agent: trends, drafts, scheduling, light engagement loops | [`postforge`](../microsaas/postforge.md) | N/A |
| [`promptgrade.md`](./promptgrade.md) | Prompt regression and benchmark automation in CI/CD | [`promptgrade`](../microsaas/promptgrade.md) | [`promptco`](../oss/promptco.md) |
| [`redactguard.md`](./redactguard.md) | Transparent redaction proxy / pipeline for PII before model or vendor calls | [`redactguard`](../microsaas/redactguard.md) | N/A |
| [`stmtparse.md`](./stmtparse.md) | Financial monitoring: subscriptions, anomalies, alerts (partner APIs as needed) | [`stmtparse`](../microsaas/stmtparse.md) | N/A |

**Supporting File:** [`template.md`](./template.md).

---

## Coverage Matrix: Agent ↔ MicroSaaS ↔ OSS

| Agent | `microsaas/` | `oss/` |
|-------|--------------|--------|
| `applynt` | N/A | N/A |
| `configguard` | yes | `confcheck` |
| `contributehq` | yes | `forkco` |
| `depchain` | yes | N/A |
| `feedbackflow` | yes | N/A |
| `fundos` | yes | N/A |
| `insightify` | yes | `loglens` |
| `mailcraft` | yes | N/A |
| `orchestiq` | yes | `mycelium` |
| `postforge` | yes | N/A |
| `promptgrade` | yes | `promptco` |
| `redactguard` | yes | N/A |
| `stmtparse` | yes | N/A |

**MicroSaaS Without Agent Spec In-Repo:** [`microtutor`](../microsaas/microtutor.md) (add `agents/microtutor.md` when you define the autonomous tutoring-ops story).

---

## Specification Anatomy

Sections follow [`template.md`](./template.md). Typical flow:

| Section | Purpose |
|---------|---------|
| **Title + Positioning** | Agent name, domain, market |
| **Agentic Opportunity** | Continuous value: what runs without polling |
| **Problem Statement** | Why one-shot APIs are insufficient |
| **Interaction Sequence** | Mermaid + **Event Triggers** list + **Human-in-the-Loop** summary |
| **7-Day Agentic MVP** | Deployable slice: webhook receiver, one workflow, one dashboard row |
| **Simple Data Model** | Runs, approvals, audit events |
| **Revenue Model** | Higher tiers for autonomy, seats, or audit exports |
| **Stack** | Always-on server, queue, LLM, DB (whatever the spec asserts) |
| **Success Metrics** | Adoption + quality + safety metrics |

---

## Design Principles for Agent Specs

1. **Idempotency:** Same webhook twice must not double-charge or double-send.
2. **Progressive Autonomy:** v1 ships with approvals; tighten automation as trust grows.
3. **Observable Runs:** Every autonomous action links to a run ID and timestamp.
4. **Least Privilege:** OAuth scopes and API keys scoped to the smallest surface.
5. **Kill Switch:** User or org can pause the agent without deleting data.
6. **Honest Humans:** If a step needs judgment (IC memo, outbound email), say so upfront.

---

## Adding a New Agent Spec

1. Copy [`template.md`](./template.md) → `name.md` (slug matches product).
2. Enumerate **every trigger** the agent cares about in one place.
3. Draw the **sequence diagram** before writing prose; fix awkward flows early.
4. Align **pricing** with extra compute, storage, and support load agents incur.
5. Link **MicroSaaS** and **OSS** specs if they exist; use **N/A** when they do not.
6. Update root [`README.md`](../README.md) and [`REPORT.md`](../REPORT.md) if this is a portfolio addition.

---

## Pre-Ship Review Checklist

- [ ] Triggers cover real customer environments (not only “happy GitHub”).
- [ ] Human gates are tied to **irreversible** or **compliance** actions.
- [ ] Data retention and deletion are mentioned for PII-heavy agents.
- [ ] Cost model acknowledges LLM token use per run.
- [ ] Failure modes documented: API down, rate limit, partial success.
- [ ] Day-7 deliverable is **installable** (Marketplace, OAuth app, or clear self-host).

---

*For library and CLI specs see [`../oss/README.md`](../oss/README.md). For API-first products see [`../microsaas/README.md`](../microsaas/README.md).*
