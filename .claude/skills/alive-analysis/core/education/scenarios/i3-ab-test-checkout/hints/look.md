# Hints: LOOK Stage

## Level 1: Direction
The PM says "8% lift" and the sample sizes look big enough. But before you celebrate, look closely at the traffic split. Does the actual allocation match the intended 50/50? Even a small mismatch can signal a serious problem in randomization.

## Level 2: Specific
Compare the observed sample sizes: Control has 48,700 users and Variant has 51,300. That is a 48.7%/51.3% split. Run a chi-square goodness-of-fit test against the expected 50/50 to determine if this is random noise or a statistically significant mismatch. Also, look at the daily assignment counts — the imbalance is not uniform across all days. When does the skew get worse?

## Level 3: Near-Answer
Three critical findings at the LOOK stage:
1. **SRM detected**: The 48,700/51,300 split yields a chi-square statistic of 6.76 (p < 0.001). This is a confirmed Sample Ratio Mismatch — the deviation from 50/50 is far too large to be random chance. This means something is wrong with the randomization, and the overall result may be biased.
2. **Daily pattern**: The skew is concentrated on weekends (Fri-Sun), where the Variant receives 52-55% of traffic. Weekday splits are close to 50/50. Weekend traffic has more returning visitors — this is a clue about the SRM mechanism.
3. **PM's number is wrong**: The PM said "8% lift" but the actual aggregate relative lift is +6.4% (15.51% to 16.50%). The discrepancy comes from using a different denominator. Always verify headline claims against raw data.
4. **Power analysis**: Sample sizes (48,700 and 51,300) both exceed the required 42,000 per group. The MDE of 3% relative lift is below the observed 6.4%.
