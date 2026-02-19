# Data: LOOK Stage

> Available when you reach the LOOK stage. Pull from the experimentation platform dashboard, daily assignment logs, and pre-test power analysis.
> Test period: Jan 13 - Feb 2, 2026 (3 weeks).

---

## Test Configuration Summary

| Field | Value |
|-------|-------|
| Test Name | checkout-redesign-v2 |
| Hypothesis | Reducing checkout from 4 steps to 2 steps will increase checkout conversion rate |
| Start Date | Jan 13, 2026 |
| End Date | Feb 2, 2026 |
| Duration | 21 days (3 weeks) |
| Traffic Allocation Target | 50% Control / 50% Variant |
| Randomization Unit | User ID (cookie-based) |
| Primary Metric | Checkout conversion rate (users who completed checkout / users who entered checkout) |
| Platform | Experimentation Platform v2.1 (internally built) |

---

## Aggregate Results (from experimentation platform dashboard)

| Metric | Control (4-step) | Variant (2-step) | Relative Lift | p-value |
|--------|------------------|-------------------|---------------|---------|
| Users in group | 48,700 | 51,300 | — | — |
| Checkout entries | 19,480 | 20,520 | — | — |
| Completed checkouts | 3,021 | 3,386 | — | — |
| Checkout conversion rate | 15.51% | 16.50% | **+6.4%** | 0.018 |

*The PM's dashboard showed "+8% conversion lift." The actual aggregate lift is +6.4% relative (15.51% → 16.50%, a 0.99 percentage point increase). The discrepancy is because the PM calculated lift on a different denominator (unique visitors who saw checkout button, not checkout entries).*

---

## Sample Sizes and Traffic Split

| Group | Users Assigned | Expected (50/50) | Actual % | Deviation |
|-------|---------------|-------------------|----------|-----------|
| Control | 48,700 | 50,000 | 48.7% | -1.3 pp |
| Variant | 51,300 | 50,000 | 51.3% | +1.3 pp |
| **Total** | **100,000** | **100,000** | — | — |

*The split is 48.7% / 51.3% instead of the target 50% / 50%. Is this within normal random variation?*

---

## Daily Assignment Counts

| Date | Control | Variant | Total | Variant % |
|------|---------|---------|-------|-----------|
| Jan 13 (Mon) | 2,410 | 2,390 | 4,800 | 49.8% |
| Jan 14 (Tue) | 2,380 | 2,420 | 4,800 | 50.4% |
| Jan 15 (Wed) | 2,350 | 2,450 | 4,800 | 51.0% |
| Jan 16 (Thu) | 2,290 | 2,310 | 4,600 | 50.2% |
| Jan 17 (Fri) | 2,200 | 2,400 | 4,600 | 52.2% |
| Jan 18 (Sat) | 2,100 | 2,500 | 4,600 | 54.3% |
| Jan 19 (Sun) | 2,050 | 2,550 | 4,600 | 55.4% |
| Jan 20 (Mon) | 2,400 | 2,500 | 4,900 | 51.0% |
| Jan 21 (Tue) | 2,380 | 2,520 | 4,900 | 51.4% |
| Jan 22 (Wed) | 2,350 | 2,450 | 4,800 | 51.0% |
| Jan 23 (Thu) | 2,300 | 2,400 | 4,700 | 51.1% |
| Jan 24 (Fri) | 2,250 | 2,450 | 4,700 | 52.1% |
| Jan 25 (Sat) | 2,100 | 2,500 | 4,600 | 54.3% |
| Jan 26 (Sun) | 2,050 | 2,550 | 4,600 | 55.4% |
| Jan 27 (Mon) | 2,400 | 2,400 | 4,800 | 50.0% |
| Jan 28 (Tue) | 2,380 | 2,420 | 4,800 | 50.4% |
| Jan 29 (Wed) | 2,350 | 2,450 | 4,800 | 51.0% |
| Jan 30 (Thu) | 2,310 | 2,390 | 4,700 | 50.9% |
| Jan 31 (Fri) | 2,250 | 2,450 | 4,700 | 52.1% |
| Feb 1 (Sat) | 2,100 | 2,500 | 4,600 | 54.3% |
| Feb 2 (Sun) | 2,050 | 2,550 | 4,600 | 55.4% |

*Note: On weekdays (Mon-Thu) the split is close to 50/50. On Fri-Sun the variant receives a disproportionately higher share of traffic (52-55%). Weekend traffic is enriched with returning visitors.*

---

## Pre-Test Power Analysis

| Parameter | Value |
|-----------|-------|
| Baseline checkout conversion rate | 15.5% |
| Minimum Detectable Effect (MDE) | 3% relative lift (~0.47 pp absolute) |
| Statistical significance level (alpha) | 0.05 (two-tailed) |
| Statistical power (1 - beta) | 80% |
| Required sample size per group | ~42,000 users |
| Estimated test duration at current traffic | 18-21 days |

*The test met the minimum sample size requirement (48,700 and 51,300 both exceed 42,000). The observed +6.4% relative lift exceeds the 3% MDE.*
