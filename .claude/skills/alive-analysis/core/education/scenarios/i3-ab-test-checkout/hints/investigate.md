# Hints: INVESTIGATE Stage

## Level 1: Direction
The SRM tells you the overall result is unreliable. But that does not mean there is no signal at all. Segment the results — are there subgroups where the test was cleaner? Also, check the guardrail metrics the PM did not mention. And look at the time series: did the lift stay constant across 3 weeks, or did it change?

## Level 2: Specific
Three deep-dives are required:
1. **Device segmentation**: Mobile conversion shows +22.3% lift (p=0.002, significant). Desktop shows +3.2% lift (p=0.41, NOT significant). The "8% aggregate lift" is driven almost entirely by mobile.
2. **Guardrail check**: Average order value dropped 10% in the Variant (68,000 KRW to 61,200 KRW, p=0.01). This is a significant guardrail violation. Users convert more but spend less — the 2-step flow may be rushing them through without cart review.
3. **Novelty effect**: Week 1 showed +15.6% lift, Week 2 showed +7.1%, Week 3 showed +0.6%. The lift is decaying rapidly. By Week 3, the variant is essentially no better than control.

## Level 3: Near-Answer
Complete investigation findings:
- **SRM root cause**: A caching bug in the experimentation platform reassigned some returning visitors from Control to Variant when their cookies expired. This enriched the Variant with returning visitors (58.3% returning vs 54.6% in Control). Since returning visitors have higher baseline conversion (~18% vs ~12% for new visitors), part of the observed lift is due to group composition, not the treatment.
- **Mobile signal is real but contextualized**: The +22.3% mobile lift is statistically significant and the device-level SRM is smaller. However, even the mobile result is subject to the novelty effect — the Week 3 mobile lift was substantially lower than Week 1.
- **AOV is a hard guardrail violation**: -10% AOV (p=0.01) means the Variant generates less revenue per order. Revenue per checkout entrant is actually -4.3% despite the higher conversion. Shipping this to 100% would likely reduce total revenue.
- **Novelty effect confirmed**: The steady decline from +18% on Day 1 to near-zero by Day 21 is a textbook novelty effect. The 3-week aggregate includes inflated early data. The Week 3 numbers are a better predictor of long-term performance.
