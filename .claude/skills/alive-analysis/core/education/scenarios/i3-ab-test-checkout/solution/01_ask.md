# ASK — Did the New Checkout Flow Actually Improve Conversion?
> ID: L-i3-ab-test-checkout | Mode: Learn | Stage: ASK | Difficulty: Intermediate | Created: 2026-02-10

> **Reference Solution** — This is the expected output for the ASK stage. Compare your own 01_ask.md against this after completing the stage.

## Background
ShopNow ran a 3-week A/B test (Jan 13 - Feb 2, 2026) comparing a 4-step checkout (Control) against a redesigned 2-step checkout (Variant). The PM claims "conversion is up 8%" and wants to ship to 100% of users before the spring sale campaign. Our task is to evaluate the experiment and make a recommendation.

## Framing
- **Type**: Experiment evaluation — "Is this A/B test result valid, and should we ship?"
- **Decision this informs**: Ship to 100%, ship to a segment, extend the test, or kill it
- **Cost of being wrong (ship a bad test)**: Revenue loss if conversion gains are illusory or come at the expense of AOV. Harder to roll back once it is live during the spring sale.
- **Cost of being wrong (kill a good test)**: Miss a real conversion improvement. Demoralize the product team. Competitors pull ahead with simpler checkout flows.

## Evaluation Framework
This is not a standard investigation — it is an experiment evaluation. Before looking at any outcome data, we must verify the test was properly run.

```
Experiment Evaluation
├── Test Validity
│   ├── Randomization — was the 50/50 split actually achieved?
│   ├── Sample size — did both groups meet the power analysis requirement?
│   ├── Runtime — was the test long enough (weekly cycles, novelty decay)?
│   └── SUTVA — are the groups independent (no spillover)?
├── Result Interpretation
│   ├── Primary metric — checkout conversion rate: is the lift significant?
│   ├── Guardrail metrics
│   │   ├── Average Order Value (AOV) — did order size change?
│   │   ├── Revenue per user — net business impact?
│   │   └── Checkout error rate — did quality degrade?
│   ├── Segmentation — does the result hold across devices, user types?
│   └── Temporal stability — is the lift consistent over 3 weeks (novelty)?
└── Decision
    ├── Launch — if valid, significant, guardrails OK, sustained
    ├── Kill — if invalid, not significant, guardrails violated
    ├── Extend — if promising but inconclusive (need more data)
    └── Iterate — if partial signal worth pursuing with modifications
```

## Success Criteria
- Determine whether the test is valid (randomization, sample size, runtime, SUTVA)
- Quantify the primary metric lift with statistical significance
- Check all guardrail metrics and flag any violations
- Assess temporal stability of the effect (novelty check)
- Deliver a clear launch/kill/extend/iterate recommendation with confidence levels
- Communicate the recommendation to PM, CFO, and Engineering in their respective terms

## Scope
- **In scope**: Experiment evaluation — validity, primary metric, guardrails, segmentation, novelty, decision
- **Out of scope**: Redesigning the checkout flow, deep UX research on why the flow works/fails
- **Timeline**: 2 days (product review is Wednesday)

## Data Sources
- **Primary**: Experimentation platform dashboard (aggregate results), BigQuery `shopnow.checkout_events` and `shopnow.orders` (event-level data)
- **Secondary**: Pre-test power analysis, daily assignment logs
- **Access**: BigQuery MCP + experimentation platform API

## Checklist — ASK
- [x] Have you accurately identified the requester's REAL goal? — PM wants a green light to ship; our goal is to determine if that is the right call
- [x] Is the question framed correctly? — Experiment evaluation, not investigation
- [x] Have you defined evaluation criteria beyond the primary metric? — Guardrails (AOV, revenue/user, error rate), validity checks, temporal stability
- [x] Is the question actionable? — Yes, determines ship/kill/extend/iterate decision
- [x] Have you confirmed data specification and access method? — BigQuery + experimentation platform + power analysis doc
