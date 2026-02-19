# Hints: LOOK Stage

## Level 1: Direction
You have 17 potential features. Not all are equally useful, and not all are equally clean. Before modeling, assess data quality and look at how churn varies across key segments. One feature will jump out as the "obvious" predictor — but be suspicious of features that are too good. Also look for missing data patterns: are they random or systematic?

## Level 2: Specific
Three things to flag in your LOOK stage:
1. **NPS is 40% missing** — and the missingness is NOT random. Less engaged accounts are less likely to respond. If you use NPS as-is, you introduce bias. Impute with median or create a "NPS missing" indicator feature.
2. **Monthly vs annual contracts**: Monthly churn is 8.1% vs annual 1.8%. Contract type is a strong segmentation variable. Consider whether the model should treat these differently.
3. **Point-in-time vs trend features**: "Days since last login" (point-in-time) is the strongest single predictor (r=0.72) but only catches obvious churners. TREND features — login frequency slope, feature adoption trend, seat utilization trend — reveal accounts that are still active but declining. These are the hidden churners.

## Level 3: Near-Answer
Key LOOK findings:
- **Data quality**: NPS is 40% missing, biased toward engaged accounts. Impute with median for modeling; add "NPS_responded" binary feature. Usage logging gap for 3 accounts — exclude or impute.
- **Segment analysis**: Monthly contracts 8.1% churn vs annual 1.8%. Starter plans 8.8% vs Enterprise 3.5%. New accounts (<6 months) at 9.4%. These segments should be features, not separate models (sample size too small for segment-specific models).
- **Feature quality**: "Days since last login" has r=0.72 but is trivially predictive — by the time an account hasn't logged in for 14+ days, CS intervention is likely too late. The real value is in TREND features: login frequency slope (r=0.58), seat utilization ratio (r=-0.54), feature adoption trend (r=-0.49). These catch the 31% of churners who are still logging in.
- **Support tickets**: Nonlinear U-shape — 0 tickets (5.0% churn, disengaged) and 5+ tickets (26.5% churn, frustrated) both predict churn. Linear correlation (r=0.31) understates the signal.
- **Seat utilization**: Below 60% is a strong churn indicator. Accounts not using their purchased seats are paying for value they don't perceive.
