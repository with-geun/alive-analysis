# ASK — DAU Drop Investigation

> Analysis ID: F-2026-0210-001
> Type: Investigation
> Status: Archived
> Created: 2026-02-10

## Background
ShopFlow's DAU dropped 15% week-over-week (from 120K to 102K) starting Feb 3, 2026. The CEO flagged it in the weekly review. The product team wants to know: **Why did DAU drop, and should we be worried?**

## Framing
- **Type**: Causation — "Why did DAU drop?"
- **Decision this informs**: Whether to pause the current sprint and investigate, or treat it as seasonal noise
- **Cost of being wrong**: If it's a real issue and we ignore it, we lose users. If it's seasonal and we panic, we waste a sprint.

## Hypothesis Tree
```
Main question: "Why did DAU drop 15% WoW?"
├── Internal factors
│   ├── App update v3.2 released Feb 2 (new navigation)
│   ├── Push notification system migration (Feb 1-3)
│   └── Loyalty program tier change (Jan 28)
├── External factors
│   ├── Lunar New Year holiday (Feb 1-4)
│   ├── Competitor "QuickBuy" launched same-day delivery
│   └── Heavy snowstorm in Seoul metro area
└── Data artifacts
    ├── New bot filtering deployed Feb 3
    └── GA4 migration completed Feb 1
```

## Scope
- **In scope**: DAU analysis by platform, channel, and user segment for Jan 20 - Feb 10
- **Out of scope**: Revenue impact (separate analysis if needed)
- **Timeline**: 3 days
- **Data sources**: BigQuery (event logs), GA4 (traffic), Internal dashboard

## Checklist — ASK
- [x] Have you accurately identified the requester's REAL goal? — CEO wants confidence call: seasonal or real
- [x] Is the question framed as causal or correlational? — Causal
- [x] Have you built a hypothesis tree (not just one guess)? — 8 hypotheses across 3 categories
- [x] Is the question actionable? — Yes, determines sprint priority
- [x] Have you confirmed the data specification and access method? — BigQuery + GA4
