# Rubric: i4-churn-prediction — "Can we predict which users will churn?"

> **Total**: 100 points | **Difficulty**: Intermediate | **Format**: Full (5 files)
>
> Intermediate-level expectations: prediction target is precisely defined, evaluation metrics match business constraints, model comparison is grounded in operational reality, and monitoring plans include drift detection. Vague definitions or single-model answers will not reach passing score.

---

## ASK (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Churn definition | 5 | Churn defined as canceled OR inactive 30+ days (union). Explains why both components are needed (cancellation alone misses 37 silent churners; inactivity alone misses 82 explicit cancellations). |
| Prediction window | 5 | 30-day rolling window selected with reasoning (short enough for actionable prediction, long enough for CS intervention). Data leakage risk identified — features must use data from BEFORE the prediction window. |
| CS capacity constraint | 5 | The 100 interventions/month constraint is explicitly identified as a modeling constraint. Model output must rank accounts (probability scores), not just classify. |
| Evaluation metric | 5 | Precision@100 selected as primary metric (matches CS capacity). Accuracy explicitly rejected as misleading for imbalanced classes (93.8% naive baseline). F1 as secondary for model comparison. |

**Common mistakes at Intermediate level**:
- Defining churn as only cancellation (missing silent churners)
- Using a 7-day or 90-day window without reasoning about CS intervention timing
- Defaulting to accuracy or AUC without connecting to the CS operational constraint
- Not identifying data leakage risk from churn label lag

---

## LOOK (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Data quality assessment | 5 | NPS 40% missing flagged as non-random (biased toward engaged accounts). Imputation strategy stated (median + missingness indicator). Logging gap and survivorship bias acknowledged. |
| Segment analysis | 5 | Monthly vs annual (8.1% vs 1.8%), plan tier (Starter 8.8% vs Enterprise 3.5%), account age (<6mo: 9.4% vs >18mo: 4.3%) all examined. Contract type identified as strongest segment predictor. |
| Feature exploration | 5 | At least 10 features assessed. "Days since last login" identified as strongest single predictor (r=0.72) but flagged as trivially predictive. Support ticket nonlinearity (U-shape) identified. |
| Trend features identified | 5 | Distinction between point-in-time and trend features explicitly made. Login frequency slope, feature adoption trend, and seat utilization ratio identified as essential for detecting hidden churners. |

**Common mistakes at Intermediate level**:
- Treating NPS missing data as random (it is biased toward engaged accounts)
- Not segmenting by contract type (the single strongest predictor)
- Accepting "days since last login" as sufficient without questioning what it misses
- Not recognizing the support ticket U-shape (0 tickets AND 5+ tickets both predict churn)

---

## INVESTIGATE (25 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Model comparison | 7 | At least 2 models compared (rule-based vs ML). Metrics for each: F1, Precision@100, confusion matrices. Rule-based F1=0.52 vs GBT F1=0.66 with reasoning about the gap. |
| Precision-recall at CS capacity | 6 | Precision@100 analysis: rule-based=0.33, GBT=0.42. Translation to expected saves: 8.3 vs 10.5/month. Incremental value quantified ($26,928/year). |
| Hidden churner analysis | 6 | 31% of churners are hidden (active within 7 days of churn). Profile documented (declining trends despite normal surface metrics). Detection rates: rules 33% vs GBT 73%. Explanation of WHY rules miss them. |
| Rule-based vs ML tradeoff | 6 | "80% rule" articulated — rules achieve 79% of GBT F1 but only 45% of hidden churner detection. Phased deployment recommended with explicit rationale (trust, workflow validation, outcome data). |

**Common mistakes at Intermediate level**:
- Using accuracy to compare models (misleading for 6.2% churn rate)
- Recommending the "best" model without considering deployment complexity and CS trust
- Missing the hidden churner segment (the highest-value CS targets)
- Not connecting model output to CS capacity (Precision@100 is the decision metric)
- Over-engineering with ML when the analysis should start with what works and iterate

---

## VOICE (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Deployment recommendation | 6 | Phased approach: rule-based v1 (weeks 1-2) → GBT v2 (month 2+). Weekly ranked list of top 100 accounts → CS dashboard. Specific workflow described (20 per rep, outcome logging). |
| ROI calculation | 5 | Annual LTV retained vs intervention cost. Net annual value stated ($41K for rules, $68K for GBT). Breakeven save rate calculated (~15%). Current 25% rate shown as safely above breakeven. |
| Stakeholder communication | 5 | Three distinct messages: Head of CS (workflow and trust), CFO (ROI and downside protection), VP Engineering (infrastructure and maintenance cost). Messages differ in content, not just length. |
| Capacity matching | 4 | Model output explicitly matched to CS capacity (top 100 accounts). False positive impact assessed. CS fatigue risk acknowledged. |

**Common mistakes at Intermediate level**:
- Recommending "deploy the best model" without a phased approach
- ROI calculation that ignores intervention cost or uses only monthly (not annual) numbers
- Writing one generic recommendation instead of audience-tailored messages
- Not matching model output to the 100 interventions/month constraint

---

## EVOLVE (15 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Monitoring plan | 5 | Precision@100 tracked monthly with specific thresholds (target >0.35, warning <0.30, critical <0.25). CS save rate and list adoption rate also monitored. Owner and cadence specified for each metric. |
| Drift detection | 5 | Drift triggers defined (Precision@100 < 0.30). Investigation protocol: check feature distributions, churn base rate, data pipeline. Retraining plan (6-month rolling window). |
| Feedback loop | 5 | CS outcome logging designed (5 categories: saved, churned_anyway, no_response, already_canceled, not_at_risk). Outcome data flows back to model retraining. Quarterly retraining cadence. |

**Common mistakes at Intermediate level**:
- Monitoring plan without specific thresholds or owners
- No drift detection protocol (what happens when the model degrades?)
- Missing the feedback loop (CS outcome data is the most valuable training signal)
- No seasonal awareness (annual renewal cycles, budget season effects)

---

## Most Common Mistakes at Intermediate Level

1. **Using accuracy for imbalanced classes**: With 93.8% of accounts NOT churning, a model that always predicts "no churn" gets 93.8% accuracy. Accuracy is meaningless. Use Precision@K or F1.

2. **Ignoring CS capacity constraint**: The CS team can contact 100 accounts per month. A model that flags 500 accounts is not useful. Precision@100 is the metric that matches the operational constraint.

3. **Missing hidden churners**: 31% of churners are still active before they leave. Point-in-time features (days since last login) miss them entirely. Trend features (login slope, adoption trend) are essential.

4. **Over-engineering with ML when rules work 80% as well**: The rule-based model achieves 79% of GBT's F1 score. Starting with rules is not a compromise — it is a deployment pattern that validates the workflow, builds trust, and generates outcome data for ML improvement.

5. **No drift monitoring plan**: Prediction models degrade. Customer behavior changes, the product changes, and market conditions shift. Without a monitoring plan (specific thresholds, retraining triggers, feedback loops), the model silently becomes useless.

---

## Score Interpretation

| Score | Level | Meaning |
|-------|-------|---------|
| 90-100 | Excellent | Ready for Advanced scenarios. Analysis is thorough, operationally grounded, and well-communicated. |
| 75-89 | Proficient | Solid Intermediate work. Review missed criteria and retry one stage. |
| 60-74 | Developing | Key gaps in target definition, model comparison, or deployment planning. Re-read hints Level 2 and retry. |
| Below 60 | Needs work | Consider revisiting b1/b2 Beginner scenarios and i1-dau-drop first. |

---

## Self-Assessment Checklist

Before scoring yourself, confirm:
- [ ] My churn definition is a union (canceled OR inactive 30+ days) with reasoning
- [ ] I used Precision@100 (not accuracy) as the primary metric
- [ ] I compared at least a rule-based model against an ML model
- [ ] I identified hidden churners (31% still active before churning) and their trend-based profile
- [ ] I recommended a phased deployment (rules v1 → ML v2)
- [ ] I calculated ROI including intervention cost and breakeven save rate
- [ ] I wrote three distinct stakeholder messages (CS, CFO, Engineering)
- [ ] I defined a monitoring plan with specific thresholds and drift triggers
- [ ] I designed a CS feedback loop for outcome data collection
