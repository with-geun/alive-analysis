# ASK — Why did DAU drop 15%?
> ID: L-i1-dau-drop | Mode: Learn | Stage: ASK | Difficulty: Intermediate | Created: 2026-02-10

> **Reference Solution** — This is the expected output for the ASK stage. Compare your own 01_ask.md against this after completing the stage.

## Background
ShopFlow's DAU dropped 15% week-over-week (from 120K to 102K) starting Feb 3, 2026. The CEO flagged it in the weekly review. The product team wants to know: **Why did DAU drop, and should we be worried?**

## Framing
- **Type**: Causation — "Why did DAU drop 15% WoW?"
- **Decision this informs**: Whether to pause the current sprint and investigate, or treat as seasonal noise
- **Cost of being wrong**: If real and ignored, we lose users and revenue. If seasonal and we panic, we waste a sprint and damage team morale.

## Hypothesis Tree
```
Main question: "Why did DAU drop 15% WoW starting Feb 3?"
├── Internal factors
│   ├── App update v3.2 released Feb 2 (new navigation — UX regression?)
│   ├── Push notification system migration (Feb 1-3 — delivery broken?)
│   └── Loyalty program tier change (Jan 28 — downgraded users churned?)
├── External factors
│   ├── Lunar New Year holiday (Feb 1-4 — expected seasonal dip)
│   ├── Competitor "QuickBuy" launched same-day delivery (Feb 1 — user migration?)
│   └── Heavy snowstorm in Seoul metro area (Feb 3-4 — localized impact?)
└── Data artifacts
    ├── New bot filtering deployed Feb 3 (real sessions removed?)
    └── GA4 migration completed Feb 1 (tracking gap appearing as DAU drop?)
```

## Success Criteria
- State what % of the 15% drop each factor explains (contributions sum to ~100%)
- Assign confidence levels to each conclusion
- Provide a clear action recommendation with expected recovery timeline
- Confirm or rule out whether the current sprint needs to pause

## Scope
- **In scope**: DAU analysis by platform, channel, and user segment for Jan 20 - Feb 14
- **Out of scope**: Revenue impact (flagged as follow-up if push issue confirmed)
- **Timeline**: 3 days
- **Multi-lens plan**: Macro (holiday, competitor market), Meso (infra migration, app release), Micro (user segment behavior by push dependency)

## Data Sources
- **Primary**: BigQuery `shopflow.events` (event-level logs), `platform_eng.push_delivery` (FCM logs)
- **Secondary**: GA4 (traffic sources, channel attribution), App Store reviews (qualitative)
- **Access**: BigQuery MCP + GA4 export

## Checklist — ASK
- [x] Have you accurately identified the requester's REAL goal? — CEO wants a confidence call: seasonal noise vs actionable problem
- [x] Is the question framed as causal or correlational? — Causal
- [x] Have you built a hypothesis tree (not just one guess)? — 8 hypotheses across 3 categories
- [x] Is the question actionable? — Yes, determines sprint priority and infra response
- [x] Have you confirmed data specification and access method? — BigQuery + GA4 + push delivery logs
