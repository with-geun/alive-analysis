# LOOK — Did the New Checkout Flow Actually Improve Conversion?
> ID: L-i3-ab-test-checkout | Mode: Learn | Stage: LOOK | Difficulty: Intermediate | Updated: 2026-02-10

> **Reference Solution** — This is the expected output for the LOOK stage. Compare your own 02_look.md against this after completing the stage.

## Data Sources
- Experimentation platform dashboard: aggregate results, sample sizes, p-values
- BigQuery: `shopnow.checkout_events`, `shopnow.orders`
- Daily assignment logs from the experimentation platform
- Pre-test power analysis document

## Data Quality Review
- **Date range**: Jan 13 - Feb 2, 2026 (21 days, 3 full weeks)
- **Total users**: 100,000 (48,700 Control + 51,300 Variant)
- **Known issues**:
  - **Traffic split is NOT 50/50**: Observed 48.7%/51.3% instead of target 50%/50%
  - **PM's headline number is wrong**: PM claimed "8% lift" but actual aggregate relative lift is +6.4% (15.51% → 16.50%). The PM used a different denominator (unique visitors who saw checkout button, not checkout entries).
- **Conclusion on data quality**: The aggregate data exists and is complete, but the traffic split deviation requires immediate investigation before trusting any results.

## Sample Ratio Mismatch (SRM) Detection

| Group | Users Assigned | Expected (50/50) | Actual % |
|-------|---------------|-------------------|----------|
| Control | 48,700 | 50,000 | 48.7% |
| Variant | 51,300 | 50,000 | 51.3% |

**Quick check**: With 100,000 users, a 50/50 split should produce ~50,000 per group. We observe 48,700 vs 51,300 — a 2,600-user deviation. For a sample this large, even small percentage deviations can be statistically significant. A chi-square test (which the learner should compute) will confirm whether this is within random variation or a genuine mismatch.

**Assessment**: This deviation is suspicious and warrants formal testing. If confirmed as a Sample Ratio Mismatch (SRM), it means the groups may differ in composition — not just treatment — which would invalidate the aggregate conversion comparison.

## Daily Assignment Pattern

The SRM is not uniform across days:
- **Weekdays (Mon-Thu)**: Split is close to 50/50 (49.8% - 51.4% Variant)
- **Weekends (Fri-Sun)**: Variant receives 52-55% of traffic, with the strongest skew on Sat/Sun (54-55% Variant)
- **Pattern**: Weekend traffic has more returning visitors. This temporal pattern suggests the SRM may be related to user type, not random noise — a hypothesis to confirm in INVESTIGATE.

## Aggregate Results (with context)

| Metric | Control | Variant | Relative Lift | p-value |
|--------|---------|---------|---------------|---------|
| Checkout conversion rate | 15.51% | 16.50% | +6.4% | 0.018 |

The p-value (0.018) is below the 0.05 significance threshold. However, **a significant p-value is meaningless if the SRM has biased the groups**. The SRM means the Control and Variant groups may differ in composition (not just treatment), so the observed lift could be partially or fully driven by group composition differences rather than the checkout redesign.

## Power Analysis Check

| Parameter | Required | Actual | Status |
|-----------|----------|--------|--------|
| Sample size per group | 42,000 | 48,700 / 51,300 | Met |
| Minimum detectable effect | 3% relative | 6.4% observed | Exceeded |
| Runtime | 18-21 days | 21 days | Met |

The test met its power requirements. The issue is not insufficient data — it is biased data.

## Initial Observations
1. **SRM is the critical finding** — it must be explained before any conversion lift can be trusted
2. **PM's headline number (8%) does not match the data (6.4%)** — the denominator is different
3. **Weekend skew pattern** suggests the SRM is related to returning visitor behavior
4. **Sample size and runtime** requirements are satisfied — this is not an underpowered test
5. **The p-value is significant (0.018)** but this is unreliable in the presence of SRM

## Checklist — LOOK
- [x] Have you checked randomization (SRM)? — Yes, confirmed SRM (p < 0.001)
- [x] Have you verified the reported metrics? — PM's 8% does not match actual 6.4%
- [x] Have you checked sample sizes against power analysis? — Both groups exceed requirement
- [x] Have you identified patterns in the SRM? — Weekend skew, correlated with returning visitors
- [x] Have you assessed data quality? — Data is complete, but biased by SRM
