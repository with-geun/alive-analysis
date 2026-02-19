# Data: LOOK Stage

> Available when you reach the LOOK stage. Pull from CloudDash's data warehouse.
> Analysis window: 12 months of historical data. Current snapshot: 2,400 active accounts.

---

## Account Summary

| Metric | Value |
|--------|-------|
| Total active accounts | 2,400 |
| Churned last month | 149 (6.2%) |
| Monthly contracts | 1,680 (70%) |
| Annual contracts | 720 (30%) |
| Average ARPU | $85/month |
| Median account age | 14 months |

---

## Churn Definition Options

| Definition | Count Last Month | Rate | Notes |
|------------|-----------------|------|-------|
| Canceled subscription only | 112 | 4.7% | Misses accounts that go silent without canceling |
| Inactive 30+ days only | 67 | 2.8% | Misses accounts that cancel before going inactive |
| Canceled OR inactive 30+ days (union) | 149 | 6.2% | Some overlap (30 accounts did both) |

*The union definition captures the most complete picture. Of the 149 churners: 82 canceled only, 37 went inactive only, 30 did both.*

---

## Churn by Segment

| Segment | Accounts | Churned | Rate |
|---------|----------|---------|------|
| Monthly contract | 1,680 | 136 | **8.1%** |
| Annual contract | 720 | 13 | **1.8%** |
| Starter plan (1-5 seats) | 960 | 84 | 8.8% |
| Growth plan (6-20 seats) | 1,008 | 50 | 5.0% |
| Enterprise plan (21+ seats) | 432 | 15 | 3.5% |
| Account age < 6 months | 576 | 54 | 9.4% |
| Account age 6-18 months | 1,056 | 62 | 5.9% |
| Account age > 18 months | 768 | 33 | 4.3% |

*Monthly contracts churn at 4.5x the rate of annual. Newer and smaller accounts churn most.*

---

## Potential Features

| # | Feature | Source | Availability | Data Quality |
|---|---------|--------|-------------|-------------|
| 1 | Days since last login | Usage logs | All accounts | Clean |
| 2 | Login frequency (logins/week, trailing 30d) | Usage logs | All accounts | Clean |
| 3 | Login frequency trend (slope over 90d) | Usage logs | All accounts | Clean — requires calculation |
| 4 | DAU per account (daily active users within the account) | Usage logs | All accounts | Clean |
| 5 | Seat utilization ratio (active seats / purchased seats) | Usage + Billing | All accounts | Clean |
| 6 | Feature adoption score (% of core features used) | Usage logs | All accounts | Clean |
| 7 | Feature adoption trend (change over 90d) | Usage logs | All accounts | Clean — requires calculation |
| 8 | Dashboard views per week (trailing 30d) | Usage logs | All accounts | Clean |
| 9 | Support tickets (trailing 90d) | Support data | All accounts | Clean |
| 10 | Avg ticket severity (trailing 90d) | Support data | All accounts | Clean (1-5 scale) |
| 11 | NPS score (most recent) | Support data | **60% of accounts** | **40% missing** |
| 12 | Contract type (monthly/annual) | Billing | All accounts | Clean |
| 13 | Account age (months) | Account data | All accounts | Clean |
| 14 | Plan tier (Starter/Growth/Enterprise) | Billing | All accounts | Clean |
| 15 | Days until contract renewal | Billing | All accounts | Clean |
| 16 | Payment failures (trailing 6 months) | Billing | All accounts | Clean |
| 17 | Discount applied (yes/no, %) | Billing | All accounts | Clean |

---

## Feature Distributions (Selected)

### Days Since Last Login (all 2,400 accounts)

| Range | Active (not churned) | Churned |
|-------|---------------------|---------|
| 0-3 days | 1,620 (72.0%) | 46 (30.9%) |
| 4-7 days | 390 (17.3%) | 28 (18.8%) |
| 8-14 days | 168 (7.5%) | 31 (20.8%) |
| 15-30 days | 54 (2.4%) | 24 (16.1%) |
| 30+ days | 19 (0.8%) | 20 (13.4%) |

*Strong signal at the extremes, but notice: 30.9% of churners logged in within the last 3 days — these are the "hidden" churners.*

### Seat Utilization Ratio

| Range | Active | Churned |
|-------|--------|---------|
| >80% | 1,170 (52.0%) | 22 (14.8%) |
| 60-80% | 585 (26.0%) | 38 (25.5%) |
| 40-60% | 315 (14.0%) | 42 (28.2%) |
| 20-40% | 126 (5.6%) | 29 (19.5%) |
| <20% | 55 (2.4%) | 18 (12.1%) |

*Seat utilization below 60% is a strong churn indicator — accounts not using their purchased seats.*

### Support Tickets (trailing 90 days)

| Tickets | Active | Churned |
|---------|--------|---------|
| 0 | 900 (40.0%) | 45 (30.2%) |
| 1-2 | 810 (36.0%) | 32 (21.5%) |
| 3-4 | 360 (16.0%) | 24 (16.1%) |
| 5+ | 181 (8.0%) | 48 (32.2%) |

*Nonlinear relationship: both 0 tickets AND 5+ tickets are associated with higher churn. Zero-ticket accounts may be disengaged; 5+ ticket accounts are frustrated.*

---

## Data Quality Notes

| Issue | Details |
|-------|---------|
| NPS missing | 40% of accounts have never responded to NPS survey. Missing not at random — less engaged accounts are less likely to respond. |
| Usage tracking gap | 3 accounts had a logging outage for 5 days in month 8; usage features are incomplete for those accounts. |
| Churn label lag | Some accounts that "went inactive" were retroactively labeled as churned 30 days later. Feature snapshots must be taken BEFORE the prediction window to avoid leakage. |
| Survivorship bias | Only active accounts appear in current data. Accounts that churned >12 months ago have limited historical feature data. |
