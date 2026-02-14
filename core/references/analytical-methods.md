# Analytical Methods Reference

> Detailed reference for analytical methods used in the ALIVE loop.
> Extracted from the alive-analysis SKILL.md for readability.

---

## Metric Interpretation Guide

Before analyzing metrics, understand what you're actually measuring:

### Don't trust averages alone — check variability

- **Coefficient of Variation (CV) = σ / μ**: Measures how spread out the data is relative to its mean
- CV lets you compare variability across different scales (e.g., "Is revenue more volatile than user count?")
- High CV (>1) = very spread out, average is misleading → segment the data further
- Low CV (<0.3) = data is consistent, average is reliable
- Example: Two stores both averaging 100 orders/day, but Store A has CV=0.1 (steady) and Store B has CV=0.8 (wild swings). Very different stories.

### Deviation vs Error — know the difference

- **Deviation** = how far individual data points spread from the mean (individual vs group)
- **Error** = how far your estimate/prediction is from the true value (estimate vs truth)
- Standard deviation tells you about spread. Standard error tells you how reliable your estimate is.
- When reporting to stakeholders: deviation describes "how consistent is this?", error describes "how confident are we?"

### Metric Quality Check (STEDII — Microsoft Research)

Before trusting any metric in your analysis, verify it passes the STEDII test:
- **Sensitive**: Can it detect real changes? (If your experiment moves the needle but the metric doesn't budge, it's not sensitive enough)
- **Trustworthy**: Is the data accurate and aligned with what you think it measures? (Check for tracking bugs, definition drift)
- **Efficient**: Is it practical to compute? (A metric requiring 6 hours of data processing isn't useful for daily decisions)
- **Debuggable**: When it moves, can you decompose WHY? (A good metric can be broken down by segments, time, and sub-components)
- **Interpretable**: Does everyone on the team understand what it means and whether "up" is good? (If you need a 5-minute explanation, it's too complex)
- **Inclusive**: Does it fairly represent all user segments? (Metrics based only on power users miss the majority)

Quick practical test: "If this metric improved 10%, would the team know exactly what happened and what to do next?" If no → the metric needs redesign.

### Risk-adjusted metrics (Sharpe Ratio concept)

- Raw performance numbers can be misleading without considering risk/volatility
- **Sharpe Ratio idea**: (return - baseline) / volatility — "how much performance per unit of risk?"
- Apply this thinking: "Channel A has higher conversion but huge variance. Channel B is lower but stable. Which is actually better?"
- When comparing options: normalize by variability, not just average performance
- Especially useful for: campaign comparison, channel evaluation, pricing strategy assessment

### Trend Momentum — Don't Just Look at Levels, Look at Velocity

A metric can be "high" but falling fast, or "low" but rising rapidly. Looking only at current values misses the story.

**When reviewing time-series metrics, always ask:**
- "Is this metric accelerating, decelerating, or stable?"
- "How many consecutive periods has it been rising/falling?"
- "Is the rate of change increasing or slowing down?"

Practical approach (inspired by RSI — Relative Strength Index):
- Compare recent gains vs recent losses over a window (e.g., last 14 days or 4 weeks)
- If mostly gains → strong upward momentum → the trend is likely to continue
- If mostly losses → strong downward momentum → don't assume it will bounce back on its own
- Mixed signals → flat or transitional period → investigate what's changing

**Why this matters in practice:**
- A brand/product with high momentum but low absolute sales = **early opportunity** (catch rising stars)
- A brand/product with declining momentum but still high absolute sales = **early warning** (don't wait for the crash)
- Helps prioritize: "Which segments need attention NOW?" vs "Which are fine on autopilot?"

### Cohort Analysis Pitfalls

When looking at cohort data (retention, LTV curves), watch for these common traps:

**Age vs Period vs Cohort confusion:**
- **Age effect**: Users naturally become less active over time (normal decay curve)
- **Period effect**: Something happened in a specific month that affected ALL cohorts (holiday, outage, promotion)
- **Cohort effect**: A specific group of users was inherently different (acquired via different channel, onboarding changed)
- If you don't separate these three, you'll misattribute: "This cohort has bad retention" when really "December was bad for everyone" (period effect)

**How to disentangle (practical approach):**
1. First normalize by period: divide each cohort's metric by the overall monthly metric → removes calendar/promo effects
2. Then compare cohorts at the same Age → reveals true cohort quality differences
3. If a cohort looks bad → check: was there an onboarding change, channel shift, or different user mix?

**Censoring trap — recent cohorts always look worse:**
- The newest cohort hasn't had time to reach Month 6, so it LOOKS like retention is dropping
- Always compare cohorts at the same maximum Age they've all reached
- Don't panic about "declining retention" if you're comparing 12-month cohorts to 2-month cohorts

---

## Analytical Methods Toolkit

Choose the right method for the question. This is a practical decision guide, not a statistics textbook.

### "Which groups are different?" → Group Comparison

- 2 groups → t-test (or simple mean comparison with confidence intervals)
- 3+ groups → ANOVA (Analysis of Variance)
  - ANOVA answers: "Is at least one group meaningfully different from the others?"
  - If ANOVA is significant → post-hoc tests tell you WHICH groups differ
  - Example: "Do conversion rates differ across 5 acquisition channels?" → ANOVA
  - Caution: ANOVA assumes similar variance across groups and roughly normal distributions. For very skewed data (e.g., revenue), consider non-parametric alternatives or log-transformation.

### "Which users are similar?" → Segmentation / Clustering

- K-Means clustering: Groups users by similarity in multiple dimensions
  - Practical guide: Start with 3-5 clusters, increase until segments stop being interpretable
  - Critical: **Standardize variables first** — otherwise high-magnitude variables (revenue in ₩) dominate over low-magnitude ones (visit count)
  - Always validate clusters with domain sense: "Do these segments make business sense?"
  - Name the clusters with business language ("Price-sensitive bargain hunters", not "Cluster 3")

### "What tends to appear together?" → Association Rules

- Market basket analysis: "Users who did X also tend to do Y"
- Key metrics: Support (how common), Confidence (how reliable), Lift (how much more likely than random)
- **Lift > 1** = positive association, **Lift = 1** = no relationship, **Lift < 1** = negative association
- Use cases beyond shopping carts: feature usage patterns, content consumption sequences, error co-occurrence
- Caution: Association ≠ causation. "Users who buy A also buy B" doesn't mean A causes B purchases.

### "Can we predict a future outcome?" → Prediction Models

- **LTV (Lifetime Value) prediction**: Critical for acquisition and retention decisions
  - Simple approach: Average revenue × expected lifespan (good enough for many cases)
  - Better: Cohort-based LTV curves (track actual revenue by acquisition month)
  - Advanced: Probabilistic models (BG/NBD, Gamma-Gamma) when you have repeat transaction data
  - Key insight: **LTV by segment** is far more useful than overall LTV — combine with clustering
- **Forecasting**: Time series patterns (trend, seasonality, cyclical)
- When choosing model complexity: "Can I explain this to a stakeholder?" If not, simplify.

### "Is this A/B test result real?" → Experiment Analysis

- See the A/B Test Design Guide in SKILL.md for setup; here's the analysis part:
- Check: Was randomization successful? (compare pre-experiment metrics between groups)
- Check: Is the sample size sufficient? (see power analysis)
- Check: Are there novelty effects? (new feature excitement fades)
- Check: Are there segment-level effects hidden in the average? (overall flat, but huge for one segment)

### "How spread out / risky is this?" → Variability Analysis

- CV (Coefficient of Variation): Compare variability across different scales
- Sharpe Ratio adaptation: Compare performance options risk-adjusted (see LOOK stage)
- Percentile analysis: "What does the 90th percentile experience look like vs median?"

### A/B Test Design Guide

When the analysis involves designing or evaluating experiments:

**Sample Size Calculation (before running the test):**
- Required inputs: baseline conversion rate, minimum detectable effect (MDE), significance level (α, usually 0.05), power (1-β, usually 0.8)
- Rule of thumb: smaller effects need exponentially larger samples
- If the required sample size is too large for your traffic:
  - Option A: Accept a larger MDE ("we can only detect 5% improvement, not 2%")
  - Option B: Run longer (but watch for seasonality and novelty effects)
  - Option C: Target a high-traffic segment only
  - Option D: Use a more sensitive metric as primary (e.g., click rate instead of purchase rate)

**Traffic Split Ratio:**
- Default: 50/50 (maximum statistical power)
- When to deviate: business risk requires limiting exposure (e.g., 90/10 for risky changes)
- 90/10 split needs ~3.6x more total traffic than 50/50 for the same power
- The ratio is a business decision, not just a statistical one

**Common Pitfalls:**
- Peeking at results too early → inflated false positive rate
- Stopping early when results "look significant" → confirmation bias
- Not accounting for multiple comparisons (testing 5 metrics → ~23% chance of at least one false positive)
- Ignoring practical significance: "statistically significant but only 0.1% improvement" → not worth the engineering cost

**Experiment Trustworthiness Checklist (from Microsoft Research):**
- **Sample Ratio Mismatch (SRM)**: Are treatment/control groups properly balanced? If the split is 51/49 when it should be 50/50, something went wrong in randomization → results are unreliable
- **Novelty effects**: Did the metric spike initially then decay? Initial excitement about a new feature fades — wait for the "steady state" before drawing conclusions
- **Guardrail monitoring**: Set up automated alerts for guardrail metrics DURING the experiment, not just at the end. Auto-stop tests that cause egregious degradation.
- **Segment analysis**: The overall result can hide opposite effects in different segments (e.g., great for power users, terrible for new users). Always slice by key dimensions.
- **Metric holism**: Don't just track the primary metric. Use a metric taxonomy: data quality metrics → primary success metric → feature diagnostics → guardrails

**Contaminated Control — when the control group is also affected:**
Sometimes the control group isn't "clean" — they receive a baseline treatment (common coupon, existing feature) that overlaps with what you're testing. In this case:
- **Stratified analysis**: Split by whether the baseline treatment was received → compare A's effect within each stratum
- **Interaction modeling**: Include A, B, and A×B terms to see if the baseline treatment absorbs/amplifies A's effect
- **3-arm design** (when feasible): Create three groups (A only, B only, A+B) to directly measure each effect and their interaction
- Key question: "Is the additional treatment being cannibalized by the existing one, or do they create synergy?"

---

## Quasi-Experimental Methods

Real-world situations often prevent clean A/B tests (ethical constraints, company-wide promotions, external interference, too few users to randomize). When you need to prove causation without an experiment, consider these approaches.

**The AI should suggest the appropriate method based on the user's situation during conversation.**

### 1. Difference-in-Differences (DiD) — "Compare trends, not just levels"

- **When to suggest**: There's a clear before/after event AND a comparison group that wasn't affected
- **How it works**: Compare the change in the treatment group to the change in the control group → the difference-of-differences is the causal effect
- **Key assumption**: Both groups were trending similarly BEFORE the event (parallel trends)
- **Example prompt**: "We launched a new feature for Premium users only. Can we compare their retention change to Free users' retention change over the same period?"
- **Watch out for**: If the groups were already diverging before the event, DiD won't work

### 2. Regression Discontinuity (RDD) — "Use a threshold as a natural experiment"

- **When to suggest**: There's a clear cutoff/threshold that determines who gets treatment (score ≥ 70 → VIP, purchase ≥ ₩100K → coupon)
- **How it works**: Users just above and just below the threshold are essentially random → compare their outcomes
- **Key assumption**: Users can't manipulate their score to cross the threshold
- **Example prompt**: "Customers with loyalty score ≥ 500 get VIP benefits. Do the benefits actually increase their next-month spending? Let's compare users at 490-510."
- **Watch out for**: If users know the threshold and game it (e.g., intentionally spending more to qualify), the method breaks down

### 3. Propensity Score Matching (PSM) — "Find fair comparison pairs"

- **When to suggest**: You want to compare treated vs untreated, but the groups are inherently different (different demographics, behaviors)
- **How it works**: Calculate each user's probability of receiving treatment based on their characteristics → match similar users across groups → compare outcomes
- **Key assumption**: All important differences between groups are captured in the matching variables
- **Example prompt**: "Coupon recipients were our most active users. Can we find non-recipients with similar activity levels to fairly compare?"
- **Watch out for**: Hidden variables not captured in matching (unmeasured confounders)

### 4. Instrumental Variables (IV) — "Use an external lever"

- **When to suggest**: There's an external factor that affects treatment but NOT the outcome directly (hardest to find, use with caution)
- **How it works**: Find a variable (instrument) that influences whether someone gets treated, but only affects the outcome THROUGH the treatment
- **Example**: Ad time slot (random) → affects whether user sees the ad → but doesn't directly affect purchase intent
- **Practical note**: Good instruments are rare in marketing. DiD, RDD, and PSM are usually more practical for most business analyses.

### How to choose (conversational guide for the AI)

```
User wants to prove causation but can't do A/B test →

"Do you have a before/after + comparison group?"
  → YES → Suggest DiD

"Is there a clear threshold/cutoff?"
  → YES → Suggest RDD

"Can you find similar untreated users to compare?"
  → YES → Suggest PSM

"None of the above, but there's an external factor..."
  → MAYBE → Discuss IV (with caveats)

"None of these fit"
  → Be honest: "We can establish strong correlation with controls,
    but proving causation requires one of these structures.
    Let's document this as a limitation."
```

---

## Model Interpretability — When You Build a Prediction Model

If the analysis involves building a predictive model (churn prediction, LTV estimation, demand forecasting), always pair prediction with explanation.

**The "black box" trap**: A model that predicts well but can't explain WHY is dangerous for decision-making. Stakeholders need to know which levers to pull.

**During conversation, when a model is built, ask:**
- "Which features matter most for this prediction?" (feature importance)
- "For this specific case, what pushed the prediction up or down?" (individual explanation)
- "Do the important features match your domain intuition?" (sanity check)
- "Where does the model fail? Which segments does it get wrong?" (error analysis)

**SHAP concept (simplified for conversation):**
- Every prediction can be broken down into each feature's additive contribution (not percentages — actual units)
- "The model's base churn prediction is 20%. For this user: low login frequency pushed it up +12pp, no purchase in 30 days +8pp, but premium membership pulled it down -5pp → final prediction: 35%"
- SHAP values always add up: base value + all contributions = final prediction
- This turns "the model says they'll churn" into "HERE'S WHY the model thinks they'll churn — and here's what we might change"

**Business validation**: Always check — do the model's top factors match what domain experts believe? If the model says "color of profile picture" is the #1 churn predictor, something is wrong (likely a proxy or data leakage).
