# Hints: ASK Stage

## Level 1: Direction
Before building any model, you need to precisely define what you are predicting. "Churn" is not a single thing — some accounts cancel, some go silent, some downgrade. Define the target label, the prediction window, and the evaluation metric BEFORE touching data. Also think about who will consume the model output and what they can actually do with it.

## Level 2: Specific
Three critical decisions to make in ASK:
1. **Churn definition**: Canceled subscription OR inactive for 30+ days (union). This captures both voluntary and silent churn. Using only cancellations misses 37 silent churners per month.
2. **Prediction window**: Predict churn in the NEXT 30 days. Too short (7 days) gives CS no time to act. Too long (90 days) is too noisy.
3. **Evaluation metric**: Do NOT use accuracy — with 6.2% churn rate, a model that always says "no churn" gets 93.8% accuracy. Use Precision@100 because the CS team has exactly 100 intervention slots per month. Optimize for "of the top 100 accounts we flag, how many are actually going to churn?"

## Level 3: Near-Answer
Frame this as a Modeling problem (not Investigation — nothing is broken). Define:
- **Target**: Binary — will this account churn (cancel OR inactive 30+ days) in the next 30 days?
- **Prediction window**: 30 days rolling
- **Primary metric**: Precision@100 (matches CS capacity of 100 interventions/month)
- **Secondary metric**: F1 score (for overall model quality comparison)
- **Business constraint**: Model output must rank accounts by churn probability so CS can take the top 100 each week
- **Success criteria**: Precision@100 > 0.30 (at least 30 of the 100 flagged accounts are true churners, yielding ~7.5 saves/month at 25% save rate — above breakeven of 4.9)
- **Data leakage warning**: Feature snapshots must be taken BEFORE the prediction window starts. Do not include features that leak future information (e.g., "this account canceled" as a feature).
