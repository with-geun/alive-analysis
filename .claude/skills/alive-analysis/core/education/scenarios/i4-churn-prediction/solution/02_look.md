# LOOK — Can We Predict Which Users Will Churn?
> ID: L-i4-churn-prediction | Mode: Learn | Stage: LOOK | Difficulty: Intermediate | Updated: 2026-02-19

> **Reference Solution** — This is the expected output for the LOOK stage. Compare your own 02_look.md against this after completing the stage.

## Data Sources
- Account data: 2,400 active accounts, 12 months of churn labels
- Usage logs: Login frequency, feature adoption, dashboard views, seat utilization
- Support data: Ticket volume, ticket severity, NPS (60% coverage)
- Billing data: Contract type, plan tier, payment history, discounts

## Data Quality Review
- **Dataset size**: 2,400 active accounts with 12 months of labeled history. 149 churned last month (6.2%).
- **Class distribution**: 93.8% non-churn / 6.2% churn — heavily imbalanced.
- **Known issues**:
  - NPS is 40% missing. Missingness is **not random** — less engaged accounts are less likely to respond to NPS surveys. Using NPS as-is introduces selection bias. **Decision**: Impute with median (6.5) and add a binary "NPS_responded" indicator feature to capture the signal in the missingness itself.
  - Usage logging gap for 3 accounts in month 8 (5 days). **Decision**: Exclude these 3 accounts from training data for that month.
  - Churn label lag: Accounts that "go inactive" are labeled as churned 30 days later. Feature snapshots must use data from BEFORE the prediction window to avoid leakage.
  - Survivorship bias: Accounts that churned >12 months ago have incomplete historical data. Training is limited to 12-month window.

## Segmented Findings

### By Contract Type
| Contract | Accounts | Churned | Rate |
|----------|----------|---------|------|
| Monthly | 1,680 | 136 | **8.1%** |
| Annual | 720 | 13 | **1.8%** |

**Key insight**: Monthly contracts churn at 4.5x the rate of annual. This is the single strongest segment-level predictor. Annual contracts have a built-in switching barrier (contract commitment), so their churn concentrates around renewal dates.

### By Plan Tier
| Plan | Accounts | Churned | Rate |
|------|----------|---------|------|
| Starter (1-5 seats) | 960 | 84 | 8.8% |
| Growth (6-20 seats) | 1,008 | 50 | 5.0% |
| Enterprise (21+ seats) | 432 | 15 | 3.5% |

**Key insight**: Smaller plans churn most. Enterprise accounts have higher switching costs (integrations, training, multi-user adoption), providing natural retention.

### By Account Age
| Age | Accounts | Churned | Rate |
|-----|----------|---------|------|
| < 6 months | 576 | 54 | 9.4% |
| 6-18 months | 1,056 | 62 | 5.9% |
| > 18 months | 768 | 33 | 4.3% |

**Key insight**: New accounts churn most — typical SaaS pattern. Accounts that survive the first 6 months are increasingly likely to stay.

## Feature Assessment

### Promising Features (from distribution analysis)

Based on examining the churn rate distributions in the data, these features show the clearest separation between churned and active accounts:

| Feature | Type | Initial Assessment |
|---------|------|--------------------|
| Days since last login | Point-in-time | **Clearest separation** — churned accounts have much higher values. But this is trivially obvious and catches only accounts that have already disengaged. |
| Login frequency (weekly) | Behavioral | Churned accounts average fewer logins — but there's overlap with active low-usage accounts. |
| Seat utilization ratio | Point-in-time | Low utilization (paying for unused seats) is common among churned accounts. |
| Feature adoption score | Behavioral | Lower scores among churned accounts — but hard to tell from distributions alone whether this is predictive or just correlated with account age. |
| Support tickets (90d) | Behavioral | Nonlinear — see below. |
| NPS score | Survey | Appears predictive but 40% missing (biased sample). |

**Note**: Formal feature importance rankings (correlation coefficients, model-based importance) will be computed in INVESTIGATE. The above is based on visual inspection of distributions.

### Critical Distinction: Point-in-Time vs Trend Features
- **Point-in-time features** (days since last login, seat utilization) capture the current state. "Days since last login > 14" is the easiest churn signal but identifies accounts that have already disengaged — often too late for CS intervention.
- **Trend features** (login frequency slope, feature adoption trend) capture the direction of change. A declining login trend catches accounts that are STILL ACTIVE but heading toward churn — the "hidden churners." These are the highest-value CS targets because intervention can still change the outcome.

### Support Tickets: Nonlinear Pattern
| Tickets (90d) | Churn Rate | Interpretation |
|---------------|-----------|---------------|
| 0 | 5.0% | Disengaged — not invested enough to seek help |
| 1-2 | 3.9% | Healthy engagement — minor issues, resolved |
| 3-4 | 6.7% | Moderate friction — struggling but trying |
| 5+ | **26.5%** | Frustrated — high effort, unresolved problems |

**Key insight**: The U-shaped pattern means linear correlation (r=0.31) understates the signal. Both zero-ticket accounts (disengaged) and 5+ ticket accounts (frustrated) are at risk. Tree-based models handle this nonlinearity naturally; linear models and simple rules may miss the zero-ticket signal.

## Hidden Churner Question

The "days since last login" distribution shows that ~31% of churners logged in within the last 3 days before churning. This raises a critical question: **if these accounts were recently active, why did they churn?** Point-in-time features like "days since last login" will miss these accounts entirely. The answer likely lies in *trend* features — declining engagement over time, even if the account is still logging in. This hypothesis will be tested in INVESTIGATE.

## Initial Observations
1. Class imbalance (6.2% churn) means accuracy is meaningless — must use Precision@K or F1
2. "Days since last login" shows the clearest churn signal but likely catches only obvious cases
3. Trend features (login frequency slope, feature adoption over time) may be needed for "hidden churners" — to be validated in INVESTIGATE
4. NPS is potentially valuable but 40% missing — imputation + missingness indicator is the recommended approach
5. Support tickets have a nonlinear U-shaped pattern (both 0 tickets and 5+ tickets predict churn)
6. Contract type and account age are strong segment-level predictors (monthly 8.1% vs annual 1.8%)

## Checklist — LOOK
- [x] Have you segmented the data before drawing conclusions? — By contract type, plan tier, account age
- [x] Have you checked for confounding variables? — NPS missingness is biased (not random)
- [x] Have you considered data quality issues? — NPS 40% missing, logging gap, label lag, survivorship bias
- [x] Have you checked variability? — Support tickets show nonlinear U-shaped pattern
- [x] Have you checked for data errors? — Logging gap for 3 accounts flagged, churn label leakage risk identified
