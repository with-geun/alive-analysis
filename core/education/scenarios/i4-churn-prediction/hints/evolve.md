# Hints: EVOLVE Stage

## Level 1: Direction
A prediction model is not a one-time deliverable — it degrades. Customer behavior changes, the product changes, and the model's accuracy drifts. Plan for how you will know when the model is no longer working, how CS feedback flows back into training data, and what seasonal patterns might affect model performance.

## Level 2: Specific
Three essential EVOLVE components:
1. **Drift monitoring**: Track Precision@100 monthly. If it drops below 0.30 (the breakeven threshold for 25% save rate), trigger retraining. Define what "drift" looks like: was it a product change? A shift in customer mix? A seasonal renewal cycle?
2. **Feedback loop**: CS must log the OUTCOME of every intervention — saved, not saved, unable to reach, already decided to leave. This outcome data becomes training data for the next model version. Without this loop, you cannot improve.
3. **Seasonal awareness**: B2B SaaS has annual renewal cycles. Churn may spike predictably at contract renewal dates. Budget season (Q4) may produce different churn patterns than Q1-Q3. The model should be re-evaluated after each full renewal cycle.

## Level 3: Near-Answer
Full EVOLVE plan:
- **Monthly precision review**: Track Precision@100 monthly. Target: >0.35. Warning: <0.30. Critical: <0.25 (trigger immediate retraining). Owner: Data team.
- **Drift detection**: If Precision@100 drops below 0.30, investigate: (a) feature distributions shifted? (b) new customer segment entering? (c) product change affecting usage patterns? Retrain with last 6 months of data.
- **CS feedback loop**: After each monthly intervention cycle, CS logs outcomes in CRM: {saved, churned_anyway, no_response, already_canceled}. These labels flow back as ground truth for model retraining. Review cycle: monthly.
- **Seasonal patterns**: Annual contracts renew in waves. Expect churn risk to spike 30-60 days before renewal clusters. Add "days until renewal" as a high-priority feature in v2. Budget season (Q4) may see higher churn in cost-sensitive segments.
- **Model card**: Document model version, training data range, feature list, performance metrics, known limitations, and retraining schedule. Update with each retraining.
- **v1 → v2 upgrade trigger**: After CS has completed 2 monthly cycles with v1 (rules), review: (a) Is the workflow working? (b) Is the 25% save rate holding? (c) Does CS want more accuracy or is rules sufficient? If yes to (a) and (b) and CS requests better detection, deploy GBT v2.
