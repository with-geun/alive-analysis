# ASK — Can We Predict Which Users Will Churn?
> ID: L-i4-churn-prediction | Mode: Learn | Stage: ASK | Difficulty: Intermediate | Created: 2026-02-19

> **Reference Solution** — This is the expected output for the ASK stage. Compare your own 01_ask.md against this after completing the stage.

## Background
CloudDash (B2B SaaS analytics dashboard, ~2,400 active accounts, $85 ARPU/month) has a 6.2% monthly churn rate. The Head of Customer Success wants a churn prediction model so her team of 5 reps (100 interventions/month capacity) can proactively reach at-risk accounts instead of reacting to cancellation requests.

## Framing
- **Type**: Modeling (Prediction) — "Which accounts will churn in the next 30 days?"
- **Decision this informs**: Which 100 accounts should CS contact this month?
- **Cost of being wrong**:
  - False positive (flag a healthy account): Wasted CS touch ($50) and possible customer annoyance — low cost
  - False negative (miss a churner): Lost account ($1,020 LTV) — high cost
  - Imbalanced costs suggest optimizing for recall within a fixed capacity budget

## Prediction Target Definition
- **Target variable**: Binary — will this account churn in the next 30 days?
- **Churn definition**: Canceled subscription OR inactive for 30+ days (union)
  - Why union: Using cancellation alone misses accounts that stop using the product without formally canceling. Using inactivity alone misses accounts that cancel while still technically active. The union captures both types — the most complete definition. Exact counts will be validated in LOOK.
- **Prediction window**: 30 days rolling
  - Why 30 days: Short enough for actionable prediction, long enough for CS to intervene. A 7-day window gives CS too little time; 90 days introduces too much noise.
- **Label construction**: For each account on day T, the label is 1 if the account churns in [T+1, T+30], else 0. Features must be computed using only data available on or before day T (no leakage).

## Evaluation Metrics
- **Primary metric**: Precision@100
  - Why: CS has exactly 100 intervention slots per month. The question is "of the 100 accounts we flag, how many are true churners?" This directly maps to the business constraint.
- **Secondary metric**: F1 score
  - Why: For overall model quality comparison across different approaches. Balances precision and recall.
- **Do NOT use**: Accuracy
  - Why: With 6.2% churn rate, a model that always predicts "no churn" gets 93.8% accuracy. Accuracy is meaningless for imbalanced classes.

## Success Criteria
- Precision@100 > 0.30 — at least 30 of the 100 flagged accounts are true churners
- At an assumed ~25% save rate, 30 true churners flagged = ~7-8 saves/month in retained revenue
- Breakeven estimate: intervention cost ($50 × 100 = $5,000/month) vs retained LTV ($1,020/save) — exact thresholds to be calculated in INVESTIGATE
- Model must provide a probability score for ranking, not just binary classification

## Scope
- **In scope**: Churn prediction model, feature exploration, model comparison (rule-based vs ML), deployment plan matched to CS capacity
- **Out of scope**: Revenue optimization model, upsell/cross-sell predictions, pricing strategy (flagged as potential follow-ups)
- **Timeline**: Prototype in 2 weeks, deploy in 4 weeks
- **Data leakage warning**: Feature snapshots must be taken BEFORE the prediction window starts. Exclude any features that encode future information (e.g., "account canceled" or "account inactive" as inputs).

## Data Sources
- **Primary**: Account data, usage logs (login frequency, feature adoption, seat utilization), billing data
- **Secondary**: Support data (tickets, NPS), churn records (12 months of historical labels)
- **Known limitations**: NPS is 40% missing (biased toward engaged accounts). Survivorship bias in historical data.

## Checklist — ASK
- [x] Have you accurately identified the requester's REAL goal? — Head of CS wants a prioritized list of at-risk accounts for proactive outreach, not just a model
- [x] Is the question framed as predictive or causal? — Predictive (which accounts will churn), not causal (why do they churn)
- [x] Have you defined the prediction target precisely? — Canceled OR inactive 30+ days, 30-day window, binary
- [x] Is the evaluation metric aligned with the business constraint? — Precision@100 matches CS capacity of 100 interventions/month
- [x] Have you confirmed data specification and access method? — Account data, usage logs, support data, billing data identified; NPS missing-data issue anticipated
