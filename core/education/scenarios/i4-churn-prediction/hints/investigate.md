# Hints: INVESTIGATE Stage

## Level 1: Direction
You need to compare at least a rule-based model against an ML model. Do not evaluate models on accuracy — with 93.8% of accounts NOT churning, accuracy is meaningless. Focus on metrics that reflect the CS team's operational reality: they can contact 100 accounts per month. How many of those 100 are actually going to churn? Also investigate who your model misses — the "hidden churners" who are still active but declining.

## Level 2: Specific
Three key analyses:
1. **Model comparison**: Rule-based (3 rules) gets F1=0.52. Logistic Regression gets F1=0.60. GBT gets F1=0.66. The rule-based model achieves 79% of GBT's F1 — is the added complexity worth 9 additional correctly flagged churners per month?
2. **Precision@100 is the decision metric**: At CS capacity (top 100), GBT catches 42 churners, rules catch 33. That's 9 additional true positives, translating to ~2.3 additional saves/month at a 25% save rate.
3. **Hidden churners (31% of all churners)**: These accounts logged in within the last 7 days before churning. Rules catch only 33% of them; GBT catches 73%. The ML advantage is concentrated in hidden churner detection — the highest-value targets for CS.

## Level 3: Near-Answer
Full analysis:
- **Rule-based model**: 3 transparent rules — "days since last login > 14", "seat utilization < 40% AND login trend negative", "tickets >= 5 AND login frequency < 2/week". F1=0.52, Precision@100=0.33. Catches obvious churners well but misses hidden ones.
- **GBT model**: Uses all 17 features. F1=0.66, Precision@100=0.42. Strongest at detecting hidden churners (73% detection rate vs 33% for rules). Captures nonlinear support ticket pattern and feature interaction effects.
- **Class imbalance**: Naive "always predict no churn" = 93.8% accuracy. This is why accuracy must NOT be used. F1 and Precision@K are the right metrics.
- **Hidden churner insight**: 31% of churners logged in within 7 days of churning. Their distinguishing features are TRENDS: login frequency slope of -1.2/week (vs +0.1 for active accounts), seat utilization at 38% (vs 67%), feature adoption trend -15% (vs +2%). Rules miss these because they rely on threshold-based snapshots.
- **Support tickets (nonlinear)**: Both 0 tickets (disengaged) and 5+ tickets (frustrated) predict churn. The U-shape is captured by GBT tree splits but missed by linear models and simple rules. Consider adding a "zero tickets" indicator feature.
- **Recommendation preview**: Rule-based v1 for immediate deployment (interpretable, fast, CS trusts it), GBT v2 in month 2 after validating the CS workflow and building trust.
