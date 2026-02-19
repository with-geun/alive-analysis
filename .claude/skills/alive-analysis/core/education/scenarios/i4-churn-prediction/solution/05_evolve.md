# EVOLVE — Can We Predict Which Users Will Churn?
> ID: L-i4-churn-prediction | Mode: Learn | Stage: EVOLVE | Difficulty: Intermediate | Updated: 2026-02-19

> **Reference Solution** — This is the expected output for the EVOLVE stage. Compare your own 05_evolve.md against this after completing the stage.

## Conclusion Robustness Check
- **What would disprove our conclusion?** If Precision@100 in production is consistently below 0.25 (below breakeven), the model is not viable. This would mean churn behavior is less predictable than historical data suggests, or our feature set is missing a critical signal.
- **Unverified assumption**: The 25% save rate will hold for proactive outreach. Reactive saves (responding to cancellation requests) may have different dynamics than proactive saves (reaching out before the customer decides to leave). Proactive outreach could be more effective (catching customers earlier) or less effective (customers who haven't complained may not be receptive).
- **Weakest point**: Hidden churner save rate. We assume it equals the overall 25% rate, but hidden churners have a different profile — they are still active but declining. They might be more receptive to intervention (still engaged) or less receptive (their decline may be driven by factors CS cannot address, like budget cuts or a strategic shift away from the product).
- **What would make us say "we were wrong" in 6 months?** If the CS team is saving fewer than 5 accounts per month consistently (below breakeven), or if CS adoption of the weekly list drops below 50% (workflow rejection).

## Reflection
- **What went well**: Defining Precision@100 as the primary metric immediately aligned the analysis with the CS team's operational reality. Framing the problem as "which 100 accounts should we contact" rather than "build the most accurate model" kept the analysis grounded.
- **What could be improved**: We should test whether the 25% save rate differs between hidden and obvious churners before Phase 2 launches. A small A/B test (50 proactive interventions vs 50 no-intervention controls) would validate the save rate assumption.
- **What surprised us**: The support ticket U-shape — zero-ticket accounts having 5.0% churn (higher than 1-2 ticket accounts at 3.9%) was not obvious. "No complaints" does not mean "happy customer"; it can mean "already checked out."

## Monitoring Plan

| Metric | Target | Warning | Critical | Cadence | Owner |
|--------|--------|---------|----------|---------|-------|
| Precision@100 (monthly) | >0.35 | <0.30 | <0.25 | Monthly | Data team |
| CS save rate (from intervention logs) | >20% | <15% | <10% | Monthly | CS team lead |
| CS list adoption (% of flagged accounts contacted) | >80% | <60% | <50% | Weekly | CS team lead |
| Feature distribution drift (PSI) | <0.10 | >0.15 | >0.25 | Monthly | Data team |
| Churn rate (overall monthly) | <6.5% | >7.0% | >8.0% | Monthly | Data team |

### Drift Detection Protocol
When Precision@100 drops below 0.30 (warning threshold):
1. Check feature distributions — has a key feature shifted? (e.g., product change affected login patterns)
2. Check churn base rate — has overall churn changed? (e.g., economic downturn increasing churn)
3. Check data pipeline — are features computing correctly? (e.g., logging change broke seat utilization)
4. If drift is confirmed: retrain with the most recent 6 months of data
5. If drift persists after retraining: revisit feature engineering (new features may be needed)

---

## Feedback Loop Design

### CS Outcome Logging
After each intervention, CS reps log the outcome in the CRM:

| Outcome | Description | Training Label |
|---------|-------------|---------------|
| Saved | Customer confirmed they were considering leaving; intervention retained them | True Positive (valuable) |
| Churned Anyway | Intervention was made but customer still churned | True Positive (intervention insufficient) |
| No Response | Customer did not respond to outreach | Ambiguous (exclude from training or label as false positive) |
| Already Canceled | Customer had already submitted cancellation before CS outreach | True Positive (intervention too late) |
| Not At Risk | Customer was surprised to be contacted — they were happy | False Positive |

### Data Flow
1. **Week 0**: Model scores all accounts → top 100 delivered to CS
2. **Weeks 1-4**: CS contacts accounts, logs outcomes
3. **Month-end**: Data team collects outcomes, computes Precision@100, save rate
4. **Quarterly**: Retrain model incorporating CS outcome data as enriched labels

### Key Principle
CS outcome data is the highest-quality signal in the system. It provides ground truth that usage data alone cannot: whether a customer was genuinely at risk, and whether intervention changed the outcome. Protecting the quality of this data (training CS on consistent logging, auditing outcomes quarterly) is as important as model accuracy.

---

## Seasonal Patterns

### Annual Contract Renewal Cycles
- Annual contracts (30% of accounts) renew in waves — CloudDash onboards in Q1 and Q3 cohorts
- Churn risk spikes 30-60 days before renewal clusters
- **Action**: Add "days until contract renewal" as a high-priority feature in v2
- **Action**: Pre-generate renewal risk reports 60 days before each renewal wave

### Budget Season Effects
- B2B customers often review SaaS subscriptions during Q4 budget planning
- Expect churn risk to increase for cost-sensitive segments (Starter plan, lower seat utilization) in Oct-Dec
- **Action**: Increase CS capacity during Q4 if budget allows, or prioritize higher-LTV accounts in the top 100 during this period

### Onboarding Cohort Effects
- New accounts (< 6 months) churn at 9.4% — nearly double the overall rate
- First 90 days are the critical activation window
- **Action**: Consider a separate "activation risk" model for new accounts, distinct from the general churn model

---

## Model Card (Template for v1)

| Field | Value |
|-------|-------|
| Model name | CloudDash Churn Prediction v1 (Rule-Based) |
| Model type | Rule-based classifier (3 rules) |
| Training data | 12 months, 2,400 accounts |
| Test data | Months 10-12 holdout (720 accounts) |
| Primary metric | Precision@100 = 0.33 |
| Secondary metric | F1 = 0.52 |
| Features used | Days since last login, seat utilization ratio, login frequency trend, support tickets, login frequency |
| Known limitations | Misses 67% of hidden churners. Does not capture nonlinear support ticket pattern. NPS not used (40% missing). |
| Retraining schedule | Quarterly (or when Precision@100 < 0.30) |
| Owner | Data team |
| Last updated | 2026-02-19 |

---

## Follow-up Questions
1. Does the 25% save rate differ between hidden and obvious churners? → A/B test in month 1
2. Can NPS response rate be improved above 60%? Higher coverage would improve model accuracy.
3. Should annual contract accounts get a separate model tuned to renewal cycle timing?
4. What is the long-term LTV impact of proactive outreach on saved accounts — do they stay longer than organically retained accounts?
5. Can CS outreach be segmented by churn reason (disengaged vs frustrated) for more targeted messaging?

## Follow-up Analysis Proposals
- [ ] Save rate A/B test: 50 proactive interventions vs 50 no-intervention controls to validate the 25% assumption — (proposed for Month 1)
- [ ] Hidden churner deep dive: Interview 10 hidden churners post-save to understand their decision journey — (proposed for Month 2)
- [ ] Renewal cycle model: Separate annual-contract churn model with "days to renewal" as the primary feature — (proposed for Month 3)

## Impact Tracking

| # | Recommendation | Decision | Owner | Status | Outcome |
|---|---------------|----------|-------|--------|---------|
| 1 | Deploy rule-based v1 churn prediction | Pending | Data team + CS | — | — |
| 2 | CS logs outcomes for all 100 weekly interventions | Pending | CS team lead | — | — |
| 3 | Monthly Precision@100 review (Data team + CS) | Pending | Data team | — | — |
| 4 | Evaluate GBT v2 upgrade after 2 monthly cycles | Pending | Data team | — | — |
| 5 | Validate save rate with A/B test in month 1 | Pending | Data team | — | — |

- **Analysis influenced a decision?** Pending — recommendation delivered to Head of CS
- **Decision date**: Expected within 1 week of presentation
- **Outcome check date**: 60 days post-deployment (Phase 1 review) and 120 days (Phase 2 review)

## Reusable Knowledge
- **Precision@K is the right metric when operational capacity is fixed**: Whenever a team has a fixed number of actions they can take (CS interventions, manual reviews, campaigns), evaluate models on Precision@K where K = capacity. Do not use accuracy for imbalanced classes.
- **Point-in-time features catch obvious cases; trend features catch hidden ones**: For any behavioral prediction, always engineer trend features (slopes, rolling averages, deltas) alongside snapshots. The highest-value targets are often those that look normal now but are declining.
- **Rule-based v1 → ML v2 is a deployment pattern, not a compromise**: Starting with rules validates the workflow, builds stakeholder trust, and generates labeled outcome data. ML upgrades have higher ROI when built on validated workflows.
- **Zero-ticket customers may be at risk**: In SaaS, absence of complaints can signal disengagement, not satisfaction. Always check if low-interaction accounts have elevated churn.
- **Model ROI depends on save rate, not model accuracy**: The breakeven calculation is more important than F1 optimization. A less accurate model with a validated save rate is worth more than a more accurate model with an untested intervention process.

## One-Sentence Insight
"A rule-based churn model deployed in 2 weeks captures 80% of the ML model's predictive value and is ROI-positive from month 1, but the 31% of 'hidden churners' who look active but are declining represent the highest-value CS targets and justify upgrading to ML in month 2."

## Checklist — EVOLVE
- [x] Have you stress-tested the conclusion? — Identified disproving conditions, weakest assumptions, and 6-month failure scenario
- [x] Have you set up monitoring? — 5 metrics with specific thresholds, cadences, and owners; drift detection protocol defined
- [x] Have you designed a feedback loop? — CS outcome logging with 5 categories, quarterly retraining cycle
- [x] Are follow-up questions defined? — 5 questions, 3 formal analysis proposals with timelines
- [x] Have you captured reusable knowledge? — 5 generalizable patterns documented for the team
