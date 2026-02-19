# VOICE — Can We Predict Which Users Will Churn?
> ID: L-i4-churn-prediction | Mode: Learn | Stage: VOICE | Difficulty: Intermediate | Updated: 2026-02-19

> **Reference Solution** — This is the expected output for the VOICE stage. Compare your own 04_voice.md against this after completing the stage.

## Key Findings

### Finding 1: A churn prediction model is viable and ROI-positive
**So What**: With 2,400 accounts and a 6.2% monthly churn rate, we can predict which accounts are most likely to churn in the next 30 days. Even a simple rule-based model identifies 33 of the 45 monthly churners in the top 100 flagged accounts. At a 25% save rate, this saves ~8 accounts/month, retaining $101K/year in LTV against $60K/year in CS intervention cost.

**Now What**:
- **Option A** (Recommended): Deploy rule-based v1 in week 1-2, upgrade to GBT v2 in month 2
- **Option B**: Deploy GBT directly (faster time-to-value but higher risk of CS distrust and workflow mismatch)

**Confidence**: High — based on 12 months of historical data, holdout test set validation, and conservative save rate assumptions

---

### Finding 2: 31% of churners are "hidden" — still active but declining
**So What**: Nearly one-third of churners logged in within the last 7 days before canceling. They look healthy on surface metrics but show declining login trends, low seat utilization, and fading feature adoption. These are the highest-value CS targets because they are still reachable and their decision is not yet final.

**Now What**: Trend features (login frequency slope, feature adoption trend, seat utilization ratio) are essential for catching hidden churners. The rule-based model catches only 33% of them; GBT catches 73%. This is the primary justification for upgrading to ML in Phase 2.

**Confidence**: High — hidden churner profile is consistent across multiple months of data

---

### Finding 3: A 3-rule model achieves 80% of the ML model's F1 — but the gap matters
**So What**: The rule-based model's F1 is 79% of GBT's, which seems "close enough." But the gap is concentrated in hidden churner detection (33% vs 73%) and translates to 2.2 fewer saves per month, or $26,928/year in lost retention opportunity. The question is whether this gap justifies the additional complexity of ML infrastructure.

**Now What**: Start with rules to validate the CS workflow and build trust. Upgrade to ML once the workflow is proven, using Phase 1 outcome data to improve Phase 2 accuracy.

**Confidence**: Medium — the incremental value estimate depends on the assumed 25% save rate holding for hidden churners (untested)

---

## Deployment Recommendation: Phased Approach

### Phase 1: Rule-Based v1 (Weeks 1-2)
- **What**: SQL query generating a weekly ranked list of top 100 at-risk accounts
- **Rules**: (1) Days since last login > 14, (2) Seat utilization < 40% AND login trend negative, (3) Support tickets >= 5 AND login frequency < 2/week
- **Delivery**: Monday morning email to CS team lead with ranked list + flag reason
- **CS workflow**: 20 accounts per rep per week. Each outreach logged in CRM with outcome: {saved, churned_anyway, no_response, already_canceled}
- **Engineering cost**: ~1 week (SQL + scheduler + email integration)
- **Expected value**: 8.3 saves/month, $101K/year LTV retained, net $41K/year after intervention cost

### Phase 2: GBT v2 (Month 2+)
- **Trigger**: CS has completed 2 monthly cycles, workflow adoption confirmed, outcome data available
- **What**: Gradient Boosted Trees model with SHAP-based per-account explanations
- **Delivery**: Same weekly list format, now with probability scores and SHAP explanation ("This account is flagged because login frequency declined 40% and seat utilization is at 35%")
- **Engineering cost**: ~4 weeks (feature pipeline + model service + SHAP integration + monitoring)
- **Expected value**: 10.5 saves/month, $128K/year LTV retained, net $68K/year

---

## ROI Summary

| Metric | Phase 1 (Rules) | Phase 2 (GBT) |
|--------|-----------------|---------------|
| Expected saves/month | 8.3 | 10.5 |
| Annual LTV retained | $101,592 | $128,520 |
| Annual intervention cost | $60,000 | $60,000 |
| **Net annual value** | **$41,592** | **$68,520** |
| Breakeven save rate | 14.8% | 11.7% |
| Current save rate | 25% | 25% |
| Safety margin above breakeven | 10.2 pp | 13.3 pp |

*Both phases are comfortably above breakeven. The investment is ROI-positive even if the save rate drops to 15%.*

---

## Counter-metric Check
- **False positive impact**: CS contacts some healthy accounts — low cost ($50/touch), minor customer annoyance. At 33% precision (Phase 1), 67 of 100 flagged accounts are false positives. CS reps will learn to filter these quickly.
- **CS team bandwidth**: 100 interventions/month fully utilizes the 5-rep team. If false positive rate is too high, CS may experience fatigue. Monitor CS feedback weekly.
- **Churn rate change**: If the model successfully reduces churn, the base rate drops, affecting future model precision. This is a positive feedback loop — retrain quarterly.

---

## Audience-Specific Messages

### For Head of Customer Success
"Starting next Monday, your team will receive a weekly ranked list of the 100 accounts most likely to churn in the next 30 days. Each account includes a reason — for example, 'login frequency dropped 40% over the past 3 months' or 'seat utilization at 35% with 5+ support tickets.' Assign 20 per rep. We start with a transparent rule-based system so your team can see exactly why each account is flagged. After two months, we upgrade to a more accurate model that's especially better at catching accounts that look healthy on the surface but are quietly disengaging. Your team logs the outcome of each outreach in the CRM — that data makes the model smarter over time."

### For CFO
"We can deploy a churn prediction system that, conservatively, retains $100K/year in customer LTV at a cost of $60K/year in CS interventions — a 69% ROI. Phase 1 (rule-based, deployed in 2 weeks) breaks even at a 15% save rate; our historical rate is 25%. Phase 2 (ML model, month 2) increases net value to $69K/year. The investment is protected: if the save rate disappoints, we stop at Phase 1 with a simple SQL query — no sunk ML infrastructure cost. Worst-case downside is $60K in CS time; best-case upside is $128K in retained revenue."

### For VP Engineering
"Phase 1 needs no ML infrastructure — it's a SQL query on a weekly cron job plus an email integration. Total eng time: ~1 week. Phase 2 requires a Python scoring service, a feature pipeline (17 features from 4 data sources), monthly retraining, and SHAP-based explanations. Total eng time: ~4 weeks for initial build, ~4 hours/month ongoing maintenance. Drift monitoring (Precision@100 < 0.30 triggers retrain alert) is the only ongoing data engineering commitment. We can use the existing scheduler and model registry — no new infrastructure."

---

## Limitations and Caveats
- The 25% save rate is a historical average from reactive interventions. Proactive outreach may achieve a higher or lower rate — this is untested.
- Hidden churner save rate is assumed to be 25% (same as overall), but hidden churners may respond differently to intervention since they are still active.
- Model performance assumes stable product and market conditions. A major product change, pricing change, or competitor action could shift churn patterns and degrade predictions.
- NPS imputation introduces noise for 40% of accounts. Improving NPS response rates would directly improve model accuracy.
- The 12-month training window may not capture seasonal patterns in annual contract renewals.

## Checklist — VOICE
- [x] Have you applied "So What → Now What" for each finding? — 3 findings with phased options
- [x] Have you tagged confidence levels? — High for viability and hidden churners, Medium for incremental ML value
- [x] Have you included trade-off analysis? — Rules vs ML, Phase 1 vs Phase 2, precision vs recall
- [x] Have you checked counter-metrics? — False positive impact, CS fatigue, churn rate feedback loop
- [x] Have you tailored messages for each audience? — Head of CS (workflow), CFO (ROI), VP Engineering (infrastructure)
