# Data: INVESTIGATE Stage

> Available when you reach the INVESTIGATE stage. Model training and evaluation results from 12 months of historical data. Train/test split: months 1-9 training, months 10-12 holdout test.

---

## Feature Importance (Correlation with Churn Label)

| Rank | Feature | Pearson r | Notes |
|------|---------|-----------|-------|
| 1 | Days since last login | 0.72 | Strongest single predictor — but trivial |
| 2 | Login frequency trend (90d slope) | 0.58 | Declining logins over time |
| 3 | Seat utilization ratio | -0.54 | Lower utilization = higher churn |
| 4 | Feature adoption trend (90d) | -0.49 | Declining feature use |
| 5 | Dashboard views per week | -0.46 | Less viewing = higher churn |
| 6 | Support tickets (90d) | 0.31 | Nonlinear — both 0 and 5+ predict churn |
| 7 | Contract type (monthly=1) | 0.29 | Monthly contracts churn more |
| 8 | Account age | -0.24 | Newer accounts churn more |
| 9 | Plan tier (ordinal) | -0.22 | Smaller plans churn more |
| 10 | Feature adoption score | -0.21 | Less adoption = higher churn |
| 11 | Payment failures (6mo) | 0.18 | Involuntary churn signal |
| 12 | NPS score | -0.35 | Strong but **only available for 60% of accounts** |

*Correlation is linear; support tickets have a nonlinear (U-shaped) relationship that correlation understates.*

---

## Model Comparison (Holdout Test Set: 720 accounts, 45 churned)

### Model A: Rule-Based (3 rules)

**Rules**:
1. Days since last login > 14 → predict churn
2. Seat utilization < 40% AND login trend negative → predict churn
3. Support tickets >= 5 AND login frequency < 2/week → predict churn

| Metric | Value |
|--------|-------|
| Precision | 0.45 |
| Recall | 0.60 |
| F1 Score | **0.52** |
| Accuracy | 0.92 |

**Confusion Matrix** (720 accounts):

|  | Predicted: No Churn | Predicted: Churn |
|--|-------------------|-----------------|
| Actual: No Churn | 642 | 33 |
| Actual: Churn | 18 | 27 |

*Flags 60 accounts as at-risk. Of those, 27 actually churn (45% precision). Misses 18 of 45 churners (60% recall).*

---

### Model B: Logistic Regression (all features, NPS imputed with median)

| Metric | Value |
|--------|-------|
| Precision | 0.52 |
| Recall | 0.69 |
| F1 Score | **0.60** |
| Accuracy | 0.93 |

**Confusion Matrix** (720 accounts):

|  | Predicted: No Churn | Predicted: Churn |
|--|-------------------|-----------------|
| Actual: No Churn | 646 | 29 |
| Actual: Churn | 14 | 31 |

*Flags 60 accounts as at-risk. Of those, 31 actually churn (52% precision). Misses 14 of 45 churners (69% recall).*

---

### Model C: Gradient Boosted Trees (GBT, all features, NPS imputed with median)

| Metric | Value |
|--------|-------|
| Precision | 0.58 |
| Recall | 0.76 |
| F1 Score | **0.66** |
| Accuracy | 0.95 |

**Confusion Matrix** (720 accounts):

|  | Predicted: No Churn | Predicted: Churn |
|--|-------------------|-----------------|
| Actual: No Churn | 651 | 24 |
| Actual: Churn | 11 | 34 |

*Flags 58 accounts as at-risk. Of those, 34 actually churn (58% precision). Misses 11 of 45 churners (76% recall).*

---

## Precision@K Analysis (Top K accounts by predicted churn probability)

| K (accounts flagged) | Rule-Based Precision@K | Logistic Regression Precision@K | GBT Precision@K |
|----------------------|----------------------|-------------------------------|-----------------|
| Top 25 | 0.56 (14/25) | 0.64 (16/25) | 0.72 (18/25) |
| Top 50 | 0.48 (24/50) | 0.54 (27/50) | 0.62 (31/50) |
| **Top 100** | **0.33 (33/100)** | **0.38 (38/100)** | **0.42 (42/100)** |
| Top 150 | 0.27 (41/150) | 0.29 (43/150) | 0.30 (45/150) |

*At the CS capacity constraint (top 100), GBT identifies 42 of the 45 actual churners. Rule-based identifies 33. The gap is 9 additional at-risk accounts caught.*

---

## Class Imbalance Analysis

| Approach | Accuracy | Precision | Recall | F1 | Notes |
|----------|----------|-----------|--------|-----|-------|
| Naive baseline ("always predict no churn") | **93.8%** | 0.00 | 0.00 | 0.00 | Useless but "accurate" |
| GBT (default threshold 0.5) | 95.0% | 0.58 | 0.76 | 0.66 | Best model |
| GBT (threshold 0.3 — more aggressive) | 91.7% | 0.41 | 0.89 | 0.56 | Higher recall, lower precision |

*Accuracy is misleading for imbalanced classes. A model that predicts "no churn" for everyone gets 93.8% accuracy. F1 and Precision@K are the appropriate metrics.*

---

## Hidden Churner Analysis

Of the 149 churners last month:
- **103 (69%)** had not logged in for 7+ days before churning — **obvious churners**
- **46 (31%)** logged in within the last 7 days before churning — **hidden churners**

### Hidden Churner Profile (46 accounts)

| Feature | Hidden Churners (mean) | All Active Accounts (mean) |
|---------|----------------------|--------------------------|
| Days since last login | 2.8 | 3.1 |
| Login frequency (per week) | 3.4 | 4.1 |
| Login frequency trend (90d slope) | **-1.2 logins/week** | +0.1 logins/week |
| Seat utilization ratio | **38%** | 67% |
| Feature adoption trend (90d) | **-15%** | +2% |
| Support tickets (90d) | 3.8 | 2.1 |
| Dashboard views per week | 4.2 | 8.7 |

*Hidden churners look active on surface metrics (days since last login is normal) but show declining TRENDS: login frequency dropping, seat utilization low, feature adoption declining. Trend features are essential to catch them.*

### Model Detection of Hidden Churners (46 in test set scaled: ~15 hidden churners)

| Model | Hidden Churners Detected | Detection Rate |
|-------|------------------------|---------------|
| Rule-Based | 5 of 15 | 33% |
| Logistic Regression | 8 of 15 | 53% |
| GBT | 11 of 15 | **73%** |

*The ML models significantly outperform rules for hidden churners because they capture interaction effects between trend features that rules miss.*

---

## Feature Interaction: Support Tickets

| Ticket Count | Churn Rate | Interpretation |
|-------------|-----------|---------------|
| 0 | 5.0% | Possibly disengaged — not invested enough to complain |
| 1-2 | 3.9% | Healthy engagement — minor issues resolved |
| 3-4 | 6.7% | Moderate friction — still trying to make it work |
| 5+ | **26.5%** | Frustrated — high effort, unresolved problems |

*The U-shaped pattern means linear models underestimate the churn risk of zero-ticket accounts. GBT handles this naturally via tree splits.*
