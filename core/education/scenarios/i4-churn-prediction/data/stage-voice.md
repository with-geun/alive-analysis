# Data: VOICE Stage

> Additional context available when preparing stakeholder communication and deployment recommendation.

---

## CS Team Operational Constraints

| Parameter | Value |
|-----------|-------|
| CS reps | 5 |
| Interventions per rep per month | 20 |
| **Total monthly capacity** | **100 interventions** |
| Historical save rate (when CS contacts at-risk customer) | ~25% |
| Average intervention cost (rep time + tooling + discount offers) | ~$50 per touch |
| Current approach | React to cancellation requests (reactive, low save rate) |

---

## ROI Modeling Inputs

| Parameter | Value | Source |
|-----------|-------|--------|
| Average account ARPU | $85/month | Billing data |
| Average remaining lifetime (saved account) | 12 months | Historical (saved accounts stay avg 12 more months) |
| Average LTV of saved account | $1,020 | $85 x 12 months |
| Intervention cost per touch | $50 | CS team estimate |
| Monthly intervention budget (100 touches) | $5,000 | $50 x 100 |
| Current monthly churn loss | $12,665 | 149 accounts x $85 |

---

## Model Performance at CS Capacity (Top 100 Accounts)

| Model | Churners in Top 100 | Precision@100 | Expected Saves (25% rate) | Monthly Revenue Retained |
|-------|--------------------|--------------|--------------------------|-----------------------|
| Rule-Based | 33 | 0.33 | 8.3 | $706/mo ($8,466/yr) |
| Logistic Regression | 38 | 0.38 | 9.5 | $808/mo ($9,690/yr) |
| **GBT** | **42** | **0.42** | **10.5** | **$893/mo ($10,710/yr)** |

*Revenue retained = Expected saves x $85/month ARPU. Does not include LTV extension value.*

---

## Full ROI Comparison (Annual Projection)

| Metric | Rule-Based | Logistic Regression | GBT |
|--------|-----------|-------------------|-----|
| Expected saves per month | 8.3 | 9.5 | 10.5 |
| Monthly revenue retained | $706 | $808 | $893 |
| Annual revenue retained | $8,466 | $9,690 | $10,710 |
| Annual LTV value (saved accounts x $1,020) | $101,592 | $116,280 | $128,520 |
| Annual intervention cost | $60,000 | $60,000 | $60,000 |
| **Net annual value** | **$41,592** | **$56,280** | **$68,520** |
| ROI | 69% | 94% | 114% |
| Incremental value of GBT over rules | — | +$14,688/yr | +$26,928/yr |

*The incremental value of GBT over the rule-based model is ~$26,928/year. Is this worth the added complexity of maintaining an ML pipeline?*

---

## Deployment Complexity Comparison

| Factor | Rule-Based | Logistic Regression | GBT |
|--------|-----------|-------------------|-----|
| Implementation time | 1 week | 2 weeks | 3 weeks |
| Infrastructure needed | SQL query + scheduler | Python service + scheduler | Python service + model registry + scheduler |
| Interpretability | Full (3 explicit rules) | High (coefficients) | Moderate (SHAP values needed) |
| CS team trust | High (rules are transparent) | Moderate | Lower (black box concern) |
| Maintenance burden | Low (manual rule updates) | Moderate (periodic retraining) | Higher (feature pipeline + retraining + monitoring) |
| Time to deploy | 1 week | 3 weeks | 4 weeks |

---

## Stakeholder Context Notes

**Head of Customer Success** — Wants a workflow she can operationalize. Needs a weekly list of at-risk accounts. Cares about trust and interpretability. Will push back on a black box. Her top question: "Why is this account flagged?"

**CFO** — Wants ROI justification. Needs annual cost vs retained revenue. Skeptical of ML investment without proven payback. Will ask: "What's the minimum save rate to break even?"

**VP Engineering** — Needs to allocate eng resources. Concerned about maintenance burden and pipeline reliability. Will ask: "What's the ongoing engineering cost?" and "What happens when the model degrades?"

---

## Breakeven Analysis

| Model | Annual Cost | Breakeven Saves/Month | Breakeven Save Rate |
|-------|-----------|---------------------|-------------------|
| Rule-Based | $60,000 | 4.9 | 14.8% (of 33 flagged churners) |
| Logistic Regression | $60,000 | 4.9 | 12.9% (of 38 flagged churners) |
| GBT | $60,000 | 4.9 | 11.7% (of 42 flagged churners) |

*All three models are ROI-positive as long as the save rate exceeds ~12-15%. The current 25% save rate is well above breakeven.*
