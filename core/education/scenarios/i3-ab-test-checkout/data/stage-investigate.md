# Data: INVESTIGATE Stage

> Available when you reach the INVESTIGATE stage. Deeper segmented data, guardrail metrics, SRM analysis, and time-series trends from BigQuery.

---

## Segmented Results by Device Type

### Mobile Users (65% of total traffic)

| Metric | Control | Variant | Relative Lift | p-value |
|--------|---------|---------|---------------|---------|
| Users | 31,655 | 33,345 | — | — |
| Checkout entries | 12,662 | 13,338 | — | — |
| Completed checkouts | 1,532 | 1,974 | — | — |
| Checkout conversion rate | 12.10% | 14.80% | **+22.3%** | **0.002** |

*Statistically significant. Large effect size on mobile.*

### Desktop Users (35% of total traffic)

| Metric | Control | Variant | Relative Lift | p-value |
|--------|---------|---------|---------------|---------|
| Users | 17,045 | 17,955 | — | — |
| Checkout entries | 6,818 | 7,182 | — | — |
| Completed checkouts | 1,248 | 1,357 | — | — |
| Checkout conversion rate | 18.30% | 18.89% | **+3.2%** | **0.41** |

*NOT statistically significant. Desktop conversion was already higher at baseline and barely moved.*

---

## Guardrail Metrics

| Metric | Control | Variant | Change | p-value | Status |
|--------|---------|---------|--------|---------|--------|
| Average Order Value (AOV) | 68,000 KRW | 61,200 KRW | **-10.0%** | **0.01** | **VIOLATION** |
| Revenue per user (checkout entrants) | 8,840 KRW | 8,770 KRW | -0.8% | 0.72 | OK |
| Checkout error rate | 1.2% | 1.1% | -0.1 pp | 0.83 | OK |
| Cart abandonment rate (pre-checkout) | 62.0% | 61.5% | -0.5 pp | 0.68 | OK |
| Payment failure rate | 2.1% | 2.3% | +0.2 pp | 0.55 | OK |

*AOV dropped significantly. Users in the variant are converting more but spending less per order. The 2-step flow may be pushing users to complete checkout faster without reviewing their cart as carefully, leading to smaller orders.*

*Revenue per user is nearly flat because the higher conversion rate offsets the lower AOV — but the AOV drop is a red flag.*

---

## SRM (Sample Ratio Mismatch) Analysis

### Chi-Square Test

| Test | Expected | Observed | Chi-Square | p-value |
|------|----------|----------|------------|---------|
| Control vs Variant split | 50,000 / 50,000 | 48,700 / 51,300 | 6.76 | **< 0.001** |

*The split is NOT within normal random variation. A chi-square goodness-of-fit test rejects the null hypothesis (50/50) at p < 0.001. This is a confirmed Sample Ratio Mismatch.*

### Root Cause Investigation

After inspecting the assignment logs and engineering tickets:

- **Root cause identified**: ShopNow's experimentation platform uses a hash-based assignment (`user_id % 100`). For returning visitors, the platform caches the variant assignment in a browser cookie. A caching bug in v2.1 caused some returning visitors whose hash mapped to Control to be reassigned to Variant when their cookie expired and was regenerated during a session.
- **Impact pattern**: The bug only affects returning visitors whose cookies expire. This happens more frequently on weekends (longer gaps between sessions). This explains the daily assignment data showing heavier Variant skew on Sat/Sun (54-55% Variant).
- **Consequence**: The Variant group is enriched with returning visitors compared to Control. Returning visitors typically have higher baseline conversion rates than first-time visitors — this means part of the observed lift may be due to group composition, not the treatment.

---

## Day-by-Day Conversion Trend (Variant vs Control)

| Week | Period | Control CVR | Variant CVR | Relative Lift |
|------|--------|-------------|-------------|---------------|
| Week 1 | Jan 13-19 | 15.4% | 17.8% | +15.6% |
| Week 2 | Jan 20-26 | 15.5% | 16.6% | +7.1% |
| Week 3 | Jan 27-Feb 2 | 15.6% | 15.7% | +0.6% |

*The variant's lift was highest in Week 1 and declined steadily. By Week 3, the lift was virtually zero. This is a classic novelty effect pattern — users initially engaged more with the new flow because it was different, not necessarily because it was better.*

### Daily Detail (Variant relative lift %)

| Date | Variant Lift (%) |
|------|-----------------|
| Jan 13 | +18.2% |
| Jan 14 | +16.5% |
| Jan 15 | +15.1% |
| Jan 16 | +14.3% |
| Jan 17 | +12.8% |
| Jan 18 | +11.2% |
| Jan 19 | +10.5% |
| Jan 20 | +9.1% |
| Jan 21 | +8.2% |
| Jan 22 | +7.0% |
| Jan 23 | +6.4% |
| Jan 24 | +5.5% |
| Jan 25 | +4.8% |
| Jan 26 | +3.9% |
| Jan 27 | +2.5% |
| Jan 28 | +1.8% |
| Jan 29 | +1.0% |
| Jan 30 | +0.5% |
| Jan 31 | +0.2% |
| Feb 1 | +0.3% |
| Feb 2 | +0.1% |

*Steady decline from +18% on Day 1 to near-zero by Week 3.*

---

## Returning vs New Visitor Breakdown by Group

| Visitor Type | Control | Variant | Note |
|-------------|---------|---------|------|
| New visitors | 22,100 (45.4%) | 21,400 (41.7%) | Balanced |
| Returning visitors | 26,600 (54.6%) | 29,900 (58.3%) | **Variant has more returning visitors** |

*This composition difference is caused by the caching bug identified in the SRM analysis. Returning visitors have a higher baseline conversion rate (~18%) compared to new visitors (~12%), so the Variant group has a structural advantage.*

---

## SUTVA (Stable Unit Treatment Value Assumption) Check

| Check | Result | Note |
|-------|--------|------|
| Network effects | Low risk | Checkout is an individual activity; one user's checkout does not affect another's |
| Shared accounts | Minor risk | ~3% of users share accounts (family devices). Assignment is by user_id, so shared devices may see both flows |
| Interference via customer support | Low risk | No evidence of CS ticket volume change between groups |

*SUTVA is largely satisfied. Shared accounts are a minor concern but affect <3% of the sample.*
