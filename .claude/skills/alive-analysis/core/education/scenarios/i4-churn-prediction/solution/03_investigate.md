# INVESTIGATE — Can We Predict Which Users Will Churn?
> ID: L-i4-churn-prediction | Mode: Learn | Stage: INVESTIGATE | Difficulty: Intermediate | Updated: 2026-02-19

> **Reference Solution** — This is the expected output for the INVESTIGATE stage. Compare your own 03_investigate.md against this after completing the stage.

## Model Comparison

### Model A: Rule-Based (3 Rules)

**Rules**:
1. Days since last login > 14 → predict churn
2. Seat utilization < 40% AND login frequency trend negative → predict churn
3. Support tickets >= 5 AND login frequency < 2/week → predict churn

| Metric | Value |
|--------|-------|
| Precision | 0.45 |
| Recall | 0.60 |
| F1 Score | **0.52** |
| Precision@100 | **0.33** |

**Strengths**: Fully transparent — CS team can see exactly why an account was flagged. Deployable as a SQL query in 1 week. No ML infrastructure required.

**Weaknesses**: Misses hidden churners (only 33% detection rate). Rules are threshold-based snapshots that cannot capture gradual decline patterns. The zero-ticket disengaged pattern is not covered.

---

### Model B: Logistic Regression

| Metric | Value |
|--------|-------|
| Precision | 0.52 |
| Recall | 0.69 |
| F1 Score | **0.60** |
| Precision@100 | **0.38** |

**Strengths**: Coefficients are interpretable. Can provide probability scores for ranking. Better at hidden churners (53% detection rate) than rules because it weights trend features.

**Weaknesses**: Assumes linear relationships — misses the U-shaped support ticket pattern. Requires a Python scoring service. NPS imputation introduces noise.

---

### Model C: Gradient Boosted Trees (GBT)

| Metric | Value |
|--------|-------|
| Precision | 0.58 |
| Recall | 0.76 |
| F1 Score | **0.66** |
| Precision@100 | **0.42** |

**Strengths**: Best overall performance. Captures nonlinear patterns (support ticket U-shape) and feature interactions. Strongest hidden churner detection (73%). Provides probability scores for ranking.

**Weaknesses**: Less interpretable — requires SHAP values for per-account explanations. Needs ML infrastructure (feature pipeline, model registry, retraining). Higher maintenance burden.

---

## Head-to-Head: The "80% Rule"

| Metric | Rule-Based | GBT | Rule-Based as % of GBT |
|--------|-----------|-----|----------------------|
| F1 | 0.52 | 0.66 | 79% |
| Precision@100 | 0.33 | 0.42 | 79% |
| Hidden churner detection | 33% | 73% | 45% |

**The rule-based model achieves ~80% of GBT's F1 and Precision@100.** At first glance, this suggests rules are "good enough." However, the gap is concentrated in hidden churner detection — rules catch 33% of hidden churners while GBT catches 73%. Hidden churners are the highest-value CS targets because they are still active and responsive to outreach.

---

## Precision@K Deep Dive (The CS Capacity Constraint)

| K (accounts flagged) | Rule-Based | Logistic Regression | GBT |
|----------------------|-----------|-------------------|-----|
| Top 25 | 14 churners (56%) | 16 (64%) | 18 (72%) |
| Top 50 | 24 (48%) | 27 (54%) | 31 (62%) |
| **Top 100** | **33 (33%)** | **38 (38%)** | **42 (42%)** |
| Top 150 | 41 (27%) | 43 (29%) | 45 (30%) |

At the operational constraint of 100 interventions:
- Rule-based: 33 true churners flagged. At 25% save rate → **8.3 saves/month**
- GBT: 42 true churners flagged. At 25% save rate → **10.5 saves/month**
- **Incremental value of GBT: 2.2 additional saves/month = $2,244/month = $26,928/year**

---

## Class Imbalance Analysis

| Approach | Accuracy | F1 | Notes |
|----------|----------|-----|-------|
| Naive ("always no churn") | **93.8%** | 0.00 | Useless — proves accuracy is the wrong metric |
| Rule-based | 92.0% | 0.52 | Lower accuracy than naive, but actually useful |
| GBT (threshold 0.5) | 95.0% | 0.66 | Best model — accuracy is coincidentally high |
| GBT (threshold 0.3) | 91.7% | 0.56 | More aggressive — higher recall, more false positives |

**Lesson**: The naive baseline's 93.8% accuracy demonstrates why accuracy must NOT be used for evaluation. A model with 92% accuracy (rule-based) is vastly more useful than one with 93.8% (naive) because it actually identifies churners.

---

## Hidden Churner Deep Dive

### Who Are They?
Of the 149 churners last month, 46 (31%) logged in within the last 7 days before churning. They look "active" on surface metrics but are declining underneath:

| Feature | Hidden Churners | Active Accounts | Gap |
|---------|----------------|-----------------|-----|
| Days since last login | 2.8 days | 3.1 days | Negligible (invisible on this metric) |
| Login frequency trend (90d) | **-1.2/week** | +0.1/week | **Large divergence** |
| Seat utilization | **38%** | 67% | **29 pp gap** |
| Feature adoption trend | **-15%** | +2% | **17 pp gap** |
| Dashboard views/week | 4.2 | 8.7 | Half the engagement |
| Support tickets (90d) | 3.8 | 2.1 | Elevated but not extreme |

### Why Rules Miss Them
Rule 1 ("days since last login > 14") does not trigger because they logged in recently. Rules 2 and 3 catch some, but the AND conditions are too restrictive. Hidden churners show a combination of moderate declines across multiple features — a pattern that rules cannot express but ML models capture through weighted feature combinations.

### Why They Are High-Value Targets
- They are still engaged enough to respond to CS outreach
- Their churn is not yet "decided" — intervention can change the trajectory
- They represent ~$46,920/month in at-risk revenue (46 x $85 x 12 months LTV)
- CS save rate for hidden churners may be HIGHER than 25% because they are still active

---

## Feature Interaction: Support Tickets (Nonlinear)

| Tickets (90d) | Churn Rate | Model Capture |
|---------------|-----------|---------------|
| 0 | 5.0% | Rules: missed. LR: partially captured. GBT: captured via tree split. |
| 1-2 | 3.9% | All models: correctly identified as low risk |
| 3-4 | 6.7% | All models: moderate risk |
| 5+ | 26.5% | Rules: Rule 3 catches most. LR/GBT: fully captured. |

**Key insight**: The zero-ticket risk is a subtle signal. These accounts are not complaining because they have already mentally checked out. GBT captures this with a tree split at "tickets = 0", which the rule-based model does not include.

---

## Recommendation: Phased Deployment

**Phase 1 (Weeks 1-2): Deploy Rule-Based v1**
- Rationale: Transparent, fast to deploy, CS trusts it, achieves 80% of ML value
- CS workflow: Weekly ranked list → 20 accounts per rep → log outcomes
- Expected saves: 8.3/month = $8,466/year retained

**Phase 2 (Month 2+): Upgrade to GBT v2**
- Trigger: After CS has completed 2 monthly cycles with v1 and workflow is validated
- Added value: +2.2 saves/month, +$26,928/year, better hidden churner detection
- Requires: Feature pipeline, model registry, SHAP-based explanations

**Why not ML immediately?**
1. CS team needs to trust the system before acting on it — rules are transparent
2. The intervention workflow (weekly list → outreach → outcome logging) must be validated
3. Phase 1 outcome data becomes training signal for Phase 2 model improvement
4. If save rate or workflow adoption is lower than expected, the $60K investment is protected

## Checklist — INVESTIGATE
- [x] Have you tested MULTIPLE approaches? — 3 models: rule-based, logistic regression, GBT
- [x] Have you used the right evaluation metric? — Precision@100 (not accuracy) aligned with CS capacity
- [x] Have you analyzed the hidden churner segment? — 31% of churners are hidden, ML detects 73% vs rules 33%
- [x] Have you quantified the tradeoff? — Rule-based achieves 80% of GBT F1 but only 45% of hidden churner detection
- [x] Have you recommended a phased approach? — Rules v1 first, GBT v2 after workflow validation
