# alive-analysis Skill

> Data analysis workflow kit based on the ALIVE loop.
> Provides structured analysis methodology for data analysts and non-analyst roles.

---

## Overview

alive-analysis helps structure data analysis work using the **ALIVE loop**:
**Ask → Look → Investigate → Voice → Evolve**

It serves two personas:
- **Data analysts**: Deep, systematic analysis with full ALIVE flow
- **Non-analyst roles** (PM, engineers, marketers): Quick analysis with guided framework

---

## ALIVE Loop Reference

### Stage 1: ASK (❓)
**Core question**: What do we want to know — and WHY?

Purpose:
- Define the problem clearly and confirm the requester's REAL goal (not just what they said)
- Frame the question: Is this about **causation** ("Why did X happen?") or **correlation** ("Are X and Y related?")?
- Set success criteria and scope boundaries
- Build a **hypothesis tree** before touching any data
- Set up **multi-lens perspective**: macro (market/industry) → meso (company/product) → micro (user/session)

#### Hypothesis Tree
Before diving into data, structure thinking:
```
Main question: "Why did D30 retention drop?"
├── Internal factors
│   ├── Product changes (releases, feature removals)
│   ├── Channel mix changes (acquisition source shift)
│   ├── Cross-service impact (did another service change affect this?)
│   └── Pricing / promotion changes
├── External factors
│   ├── Seasonality / holidays
│   ├── Competitor actions
│   ├── Market / economic shifts
│   └── Platform changes (iOS/Android policy, algorithm updates)
└── Data artifacts
    ├── Tracking changes (instrumentation broke?)
    ├── Definition changes (metric recalculated?)
    └── Population changes (new user mix shifted?)
```

#### Causal vs Correlational Framing
Ask explicitly:
- "Are we trying to prove X **caused** Y? Or just that they move together?"
- "If we find a correlation, what would we need to prove causation?"
- This determines the methodology: correlation → observational analysis; causation → quasi-experimental or controlled experiment

#### Structured Data Request (5 Elements)
When the analysis requires data, structure every data request with these 5 elements.
This saves massive back-and-forth time — most data request delays come from unclear questions, not technical difficulty.

```
[Period]  +  [Subject]  +  [Condition]  +  [Metric]  +  [Output Format]
 WHEN         WHO/WHAT      FILTER         MEASURE       HOW TO SHOW
```

| Element | Bad example | Good example |
|---------|------------|-------------|
| Period | "recently", "last month" | "2026-01-01 ~ 2026-01-31" |
| Subject | "users", "stores" | "active stores with at least 1 order" |
| Condition | "normal orders only" | "completed orders, excluding test accounts" |
| Metric | "GMV", "revenue" | "Net GMV (after coupon discount), order count" |
| Output | "a list, sorted" | "store-level, top 100 by order count, as spreadsheet" |

**For non-analysts**: The AI should actively help structure vague questions into these 5 elements.
**For analysts**: Use this as a self-check before writing SQL or requesting data from others.

This framework applies at every data touchpoint:
- ASK: When defining what data is needed to answer the question
- LOOK: When formulating MCP queries or data requests to colleagues
- INVESTIGATE: When running ad-hoc queries to test hypotheses

#### Key Questions to Ask the User
- What triggered this question? (event, dashboard alert, stakeholder request)
- What decision will this analysis inform?
- What's the cost of being wrong?
- Are there related analyses or prior findings to build on?
- What data can you access? (MCP, exported files, BI dashboards)

#### Analyst Mindset
Good analysis comes from asking better questions, not just finding right answers.

- **Data + intuition are complementary**, not competing: Data without domain context is noise. Intuition without data is guessing. The best analysis combines both.
- **Three maturity levels of data use:**
  - Level 1 "Data-driven": Let the numbers decide (risky — numbers without context mislead)
  - Level 2 "Data-informed": Use data as ONE input alongside domain expertise and judgment
  - Level 3 "Data-inspired": Use data to discover questions you didn't know to ask
- **"Why?" is more valuable than "What?"**: Dashboards tell you WHAT happened. Analysis tells you WHY and WHAT TO DO about it.
- **Resist the urge to answer immediately**: A well-framed question saves more time than a fast answer to the wrong question.

#### Actionable Question Design
Before starting any analysis, apply the "execution test" — if the analysis result won't change what we do, the question needs redesigning.

**Transform abstract questions into actionable ones:**
- BAD: "Why is our conversion rate low?" (too broad, no clear action path)
- GOOD: "Among our 4 ad channels, which targeting conditions should we adjust to improve first-purchase conversion?" (specific lever, measurable outcome, within team's control)

**Three checks before starting:**
1. **Control check**: Can our team directly change the variable in question? If not, reframe to what we CAN control.
2. **Measurement check**: Can we clearly measure success? Define the metric and threshold upfront.
3. **Resource check**: If we find the answer, do we have the resources to act on it within a reasonable timeframe?

**The "data-driven paradox" trap**: More data and better tools don't automatically lead to better decisions. The gap is usually between insight and execution — always design the analysis with the end action in mind.

#### Metric Framework — Know Which Metrics Matter and Why
Every analysis touches metrics. Understanding the metric hierarchy prevents optimizing the wrong thing.

**4-Tier Metric Classification:**
```
🌟 North Star Metric (NSM)
    The ONE metric capturing core product value for customers.
    ├── NOT revenue itself (lagging) — but a leading indicator of revenue
    ├── NOT directly manipulable — "if you can move it directly, it's not a good NSM"
    ├── GOOD: "Weekly active buyers", "Monthly items received on time"
    └── BAD: "DAU" (vanity), "Page views" (no value signal), "MRR" (lagging)

📊 Leading / Input Metrics
    3-5 drivers that teams can directly influence to move the NSM.
    ├── More responsive and under immediate team control
    ├── Example: NSM = "Weekly active buyers"
    │   → Inputs: signup rate, first-purchase conversion, repeat purchase rate
    └── Each team owns 1-2 input metrics (their OMTM — One Metric That Matters)

🛡️ Guardrail Metrics (Counter-Metrics)
    Metrics that must NOT get worse while optimizing the NSM.
    ├── "For every metric, have a paired metric that addresses adverse consequences"
    ├── 2-3 max — too many creates false positive noise
    ├── Example: Optimizing Stories engagement? → Guardrail: main feed engagement
    └── If a guardrail triggers during an experiment → escalate before proceeding

🔬 Diagnostic Metrics
    Metrics for root cause analysis — not optimization targets.
    ├── Used in INVESTIGATE to decompose problems
    ├── Example: "Why did conversion drop?" → check: page load time, error rate, funnel drop-off by step
    └── These explain the WHY behind NSM/Input movements
```

**When the AI encounters metrics during analysis:**
- ASK: "Which tier does this metric belong to? Are we optimizing an Input metric, or diagnosing a problem?"
- LOOK: "Is there a counter-metric we should also check?"
- INVESTIGATE: "Are we accidentally improving one metric at the cost of a guardrail?"
- VOICE: "Frame recommendations in terms of the NSM hierarchy — what moves, what's protected"
- EVOLVE: "Should the metric framework be updated based on these findings?"

Common mistakes to prevent:
- Starting analysis without a clear question
- Scope creep — trying to answer everything at once
- Not confirming the requester's actual goal (vs stated goal)
- Confusing "interesting" with "actionable"
- Ignoring the hypothesis tree — jumping to the first plausible explanation
- Optimizing a metric without checking its counter-metric

### Stage 2: LOOK (👀)
**Core question**: What does the data ACTUALLY show — and what's missing?

Purpose:
- Review data quality (missing values, outliers, date ranges)
- **Segment before averaging** — never trust aggregate numbers alone
- Identify **confounding variables** that could mislead the analysis
- Check for **external factors** (seasonality, holidays, competitor actions)
- Map **cross-service dependencies** — changes in service A can affect metrics in service B
- Validate data access methods and establish a query/file pipeline

#### Segmentation Strategy
Always break the data down BEFORE forming conclusions:
- By time: daily/weekly trends, before/after specific events
- By cohort: new vs returning users, acquisition channel, geography
- By platform: iOS vs Android, web vs app
- By segment: free vs paid, high-value vs low-value

Ask: "Does the pattern hold across ALL segments, or is it driven by one?"

#### Confounding Variables
Before attributing any pattern, check:
- Did something else change at the same time? (release, campaign, holiday)
- Is there a **selection bias**? (are we comparing different populations?)
- Is there a **survivorship bias**? (are we only seeing users who stayed?)
- Could this be a **Simpson's paradox**? (aggregate trend vs segment trends)

#### External Data Consideration
- Check the calendar: holidays, industry events, competitor launches
- Check macro context: economic indicators, platform policy changes
- Check company context: other team's releases, cross-service changes
- Reference config.md guardrail metrics — are any of them moving too?

#### Data Specification Gotchas
Before trusting ANY data, verify these common traps:

**Geographic data:**
- Verify coordinate system: WGS84 (lat/lng) vs projected (UTM-K, etc.) — mixing them silently corrupts distance/area calculations
- Administrative district mismatch: 행정동 ≠ 법정동 — same name, different boundaries, M:N relationship between the two
- Population data is usually 행정동-based, but business addresses are often 법정동 — combining them without matching creates wrong numbers
- When in doubt, use higher-level geography (시군구) or raw coordinates with spatial joins

**Metric definitions:**
- Same metric name, different calculation across teams (e.g., "GMV" = gross? net? after coupon?)
- Check if definitions changed over time (metric redefined mid-period → trend break that looks like a real change)
- Verify with data owners: "Is this the same definition used in the dashboard?"

**Time and date:**
- Timezone: UTC vs local time — a 9-hour shift (KST) can move an entire day of data
- Business day vs calendar day (weekends, holidays treated differently)
- Event timestamps: server time vs client time vs display time

**Units and filters:**
- Currency: before/after tax, with/without discounts, local vs USD
- Hidden filters: "active users" might exclude recently churned, test accounts, internal accounts
- Population drift: the definition of "user" may change as tracking evolves

**When you find a gotcha**: Document it in the analysis as a Data Quality Note — future analyses will thank you.

#### Metric Interpretation Guide
Before analyzing metrics, understand what you're actually measuring:

**Don't trust averages alone — check variability:**
- **Coefficient of Variation (CV) = σ / μ**: Measures how spread out the data is relative to its mean
- CV lets you compare variability across different scales (e.g., "Is revenue more volatile than user count?")
- High CV (>1) = very spread out, average is misleading → segment the data further
- Low CV (<0.3) = data is consistent, average is reliable
- Example: Two stores both averaging 100 orders/day, but Store A has CV=0.1 (steady) and Store B has CV=0.8 (wild swings). Very different stories.

**Deviation vs Error — know the difference:**
- **Deviation** = how far individual data points spread from the mean (individual vs group)
- **Error** = how far your estimate/prediction is from the true value (estimate vs truth)
- Standard deviation tells you about spread. Standard error tells you how reliable your estimate is.
- When reporting to stakeholders: deviation describes "how consistent is this?", error describes "how confident are we?"

**Metric Quality Check (STEDII — Microsoft Research):**
Before trusting any metric in your analysis, verify it passes the STEDII test:
- **Sensitive**: Can it detect real changes? (If your experiment moves the needle but the metric doesn't budge, it's not sensitive enough)
- **Trustworthy**: Is the data accurate and aligned with what you think it measures? (Check for tracking bugs, definition drift)
- **Efficient**: Is it practical to compute? (A metric requiring 6 hours of data processing isn't useful for daily decisions)
- **Debuggable**: When it moves, can you decompose WHY? (A good metric can be broken down by segments, time, and sub-components)
- **Interpretable**: Does everyone on the team understand what it means and whether "up" is good? (If you need a 5-minute explanation, it's too complex)
- **Inclusive**: Does it fairly represent all user segments? (Metrics based only on power users miss the majority)

Quick practical test: "If this metric improved 10%, would the team know exactly what happened and what to do next?" If no → the metric needs redesign.

**Risk-adjusted metrics (Sharpe Ratio concept):**
- Raw performance numbers can be misleading without considering risk/volatility
- **Sharpe Ratio idea**: (return - baseline) / volatility — "how much performance per unit of risk?"
- Apply this thinking: "Channel A has higher conversion but huge variance. Channel B is lower but stable. Which is actually better?"
- When comparing options: normalize by variability, not just average performance
- Especially useful for: campaign comparison, channel evaluation, pricing strategy assessment

#### Trend Momentum — Don't Just Look at Levels, Look at Velocity
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

#### Cohort Analysis Pitfalls
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

#### Data Access During Conversation
- **MCP connected**: AI can run queries directly — ask before executing
- **User provides files**: Read CSV/Excel/JSON files provided during conversation
- **BI tool screenshots**: User shares dashboard images — AI interprets visually
- **No direct access**: AI generates SQL/Python for user to run, then discusses results

Common mistakes to prevent:
- Looking at averages without segmentation
- Ignoring seasonality and external factors
- Re-verifying already confirmed data
- Skipping data quality checks
- Assuming correlation found in LOOK implies causation
- Mixing data with different specifications without verifying alignment

### Stage 3: INVESTIGATE (🔍)
**Core question**: Why is it REALLY happening — can we prove it?

Purpose:
- **Eliminate hypotheses** systematically (not just confirm the first one)
- Apply **multi-lens analysis**: macro → meso → micro
- Test for **causation vs correlation** rigorously
- Check **cross-service impacts** and interaction effects
- Perform **sensitivity analysis** — how robust are the findings?
- Handle data mid-conversation (MCP queries, file uploads, ad-hoc analysis)

#### Hypothesis Elimination Process
Work through the hypothesis tree from ASK:
1. List all hypotheses (from the tree)
2. For each: What evidence would **support** it? What would **disprove** it?
3. Test the easiest-to-disprove hypotheses first (efficient elimination)
4. Track: ✅ Supported / ❌ Eliminated / ⚠️ Inconclusive
5. For surviving hypotheses: estimate relative contribution (e.g., "Channel mix explains ~70%, product change ~20%, unknown ~10%")

#### Multi-Lens Analysis Framework
```
Macro (market/industry level)
├── Market trends — is this industry-wide?
├── Competitor analysis — did competitors change?
├── Economic factors — recession, regulation, etc.
└── Platform/ecosystem — iOS policy, algorithm changes?

Meso (company/product level)
├── Cross-service impact — did another team's change affect us?
├── Channel mix — acquisition source distribution shift?
├── Product changes — releases, A/B tests, feature flags?
└── Business operations — pricing, campaigns, partnerships?

Micro (user/session level)
├── User behavior patterns — funnel analysis, session depth
├── Cohort-specific trends — new vs returning, by segment
├── Edge cases — specific user groups, extreme behaviors
└── Qualitative signals — CS tickets, reviews, survey data
```

#### Causation Testing (when causal claims are needed)

**Step 1: Draw the causal picture (even informally)**
Before running any numbers, sketch the relationships:
- What's the treatment (T)? What's the outcome (Y)?
- What other variables might affect BOTH T and Y? (these are confounders)
- Are there mediators in between? (T → M → Y)
- Watch out for colliders (T → C ← Y) — conditioning on these creates false associations

Three patterns to recognize:
```
Chain:    T → M → Y     Conditioning on M blocks the path (breaks the causal flow)
Fork:     T ← X → Y     Conditioning on X blocks confounding (this is what you WANT)
Collider: T → C ← Y     Conditioning on C OPENS a false path (this is a TRAP)
```

**Step 2: Block confounding paths**
- Identify all "backdoor paths" — paths from T to Y that go through common causes
- Block them by conditioning on the confounders (compare within similar groups)
- Example: "Comparing companies that hired consultants vs didn't" — must condition on prior revenue (companies with higher past revenue are more likely to both hire consultants AND have higher future revenue)
- The goal: make it as if treatment was randomly assigned within each subgroup

**Step 3: Handle unmeasurable confounders**
Sometimes you can't directly measure the confounder (e.g., "manager quality"):
- Use **proxy variables**: manager tenure, education level, team turnover rate
- Proxies aren't perfect but reduce bias significantly
- Be explicit about what you CAN'T control for — this goes into limitations

**Step 4: Verify comparable groups**
Before comparing treatment vs control:
- Were the groups comparable BEFORE the treatment? (check pre-period metrics)
- If not comparable → the difference is NOT purely due to treatment (bias exists)
- Within subgroups of similar characteristics, does the treatment effect hold?

**Step 5: Basic causal checklist**
- **Time ordering**: Did the cause precede the effect?
- **Mechanism**: Is there a plausible pathway from cause to effect?
- **Dose-response**: Does more of the cause produce more of the effect?
- **Counterfactual**: What happened to the control group / unaffected segment?
- **Consistency**: Does the pattern hold across different segments and time periods?
- If true experiment isn't possible → see "Quasi-Experimental Methods" section below

**Common traps:**
- **Selection bias**: Only surveying people who responded → biased sample (e.g., satisfaction survey only captures motivated respondents)
- **Collider bias**: Conditioning on an effect of both variables opens a false path (e.g., conditioning on "got promoted" when studying stats skill vs office politics)
- **Survivorship bias**: Only looking at users who stayed → missing the ones who left

#### Statistical Rigor (when making claims from numbers)

Don't just report numbers — report how reliable they are:

**Sample size awareness:**
- Small samples → high chance of noise masquerading as signal
- Ask: "If I repeated this analysis with different data, would I get the same result?"
- Rule of thumb: be skeptical of conclusions from fewer than ~30 data points per group

**Confidence and significance:**
- **Confidence interval**: "The true value is likely between X and Y" (not just a point estimate)
- **Statistical significance**: "Could this difference be random noise?"
- **For stakeholders** — translate into plain language:
  - NOT: "p = 0.02, CI [1.2, 3.5]"
  - YES: "We're quite confident this is a real effect, not noise. The improvement is likely between 1.2% and 3.5%."

**Power and sample size:**
- Before running an experiment: calculate how many samples you NEED
- Low statistical power = high chance of missing a real effect
- More samples → narrower confidence interval → more reliable conclusion

**When comparing groups:**
- Always check: are the groups comparable before the treatment/event?
- If confidence intervals of two groups overlap heavily → the difference may not be real
- Report effect sizes, not just p-values — "statistically significant" ≠ "practically important"

#### Cross-Service Impact Analysis
In organizations with multiple products/services:
- Map service dependencies: "If service A changes onboarding, does service B's retention change?"
- Check shared resources: same user base, shared auth, shared data pipeline
- Look for cannibalisation: did a new feature pull users from an existing one?
- Check infrastructure: shared API, CDN, DB performance impacts

#### Analytical Methods Toolkit
Choose the right method for the question. This is a practical decision guide, not a statistics textbook.

**"Which groups are different?" → Group Comparison**
- 2 groups → t-test (or simple mean comparison with confidence intervals)
- 3+ groups → ANOVA (Analysis of Variance)
  - ANOVA answers: "Is at least one group meaningfully different from the others?"
  - If ANOVA is significant → post-hoc tests tell you WHICH groups differ
  - Example: "Do conversion rates differ across 5 acquisition channels?" → ANOVA
  - Caution: ANOVA assumes similar variance across groups and roughly normal distributions. For very skewed data (e.g., revenue), consider non-parametric alternatives or log-transformation.

**"Which users are similar?" → Segmentation / Clustering**
- K-Means clustering: Groups users by similarity in multiple dimensions
  - Practical guide: Start with 3-5 clusters, increase until segments stop being interpretable
  - Critical: **Standardize variables first** — otherwise high-magnitude variables (revenue in ₩) dominate over low-magnitude ones (visit count)
  - Always validate clusters with domain sense: "Do these segments make business sense?"
  - Name the clusters with business language ("Price-sensitive bargain hunters", not "Cluster 3")

**"What tends to appear together?" → Association Rules**
- Market basket analysis: "Users who did X also tend to do Y"
- Key metrics: Support (how common), Confidence (how reliable), Lift (how much more likely than random)
- **Lift > 1** = positive association, **Lift = 1** = no relationship, **Lift < 1** = negative association
- Use cases beyond shopping carts: feature usage patterns, content consumption sequences, error co-occurrence
- Caution: Association ≠ causation. "Users who buy A also buy B" doesn't mean A causes B purchases.

**"Can we predict a future outcome?" → Prediction Models**
- **LTV (Lifetime Value) prediction**: Critical for acquisition and retention decisions
  - Simple approach: Average revenue × expected lifespan (good enough for many cases)
  - Better: Cohort-based LTV curves (track actual revenue by acquisition month)
  - Advanced: Probabilistic models (BG/NBD, Gamma-Gamma) when you have repeat transaction data
  - Key insight: **LTV by segment** is far more useful than overall LTV — combine with clustering
- **Forecasting**: Time series patterns (trend, seasonality, cyclical)
- When choosing model complexity: "Can I explain this to a stakeholder?" If not, simplify.

**"Is this A/B test result real?" → Experiment Analysis**
- See the A/B Test Design Guide below for setup; here's the analysis part:
- Check: Was randomization successful? (compare pre-experiment metrics between groups)
- Check: Is the sample size sufficient? (see power analysis below)
- Check: Are there novelty effects? (new feature excitement fades)
- Check: Are there segment-level effects hidden in the average? (overall flat, but huge for one segment)

**"How spread out / risky is this?" → Variability Analysis**
- CV (Coefficient of Variation): Compare variability across different scales
- Sharpe Ratio adaptation: Compare performance options risk-adjusted (see LOOK stage)
- Percentile analysis: "What does the 90th percentile experience look like vs median?"

#### A/B Test Design Guide
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

#### When A/B Testing Isn't Possible — Quasi-Experimental Methods
Real-world situations often prevent clean A/B tests (ethical constraints, company-wide promotions, external interference, too few users to randomize). When you need to prove causation without an experiment, consider these approaches.

**The AI should suggest the appropriate method based on the user's situation during conversation.**

**1. Difference-in-Differences (DiD) — "Compare trends, not just levels"**
- **When to suggest**: There's a clear before/after event AND a comparison group that wasn't affected
- **How it works**: Compare the change in the treatment group to the change in the control group → the difference-of-differences is the causal effect
- **Key assumption**: Both groups were trending similarly BEFORE the event (parallel trends)
- **Example prompt**: "We launched a new feature for Premium users only. Can we compare their retention change to Free users' retention change over the same period?"
- **Watch out for**: If the groups were already diverging before the event, DiD won't work

**2. Regression Discontinuity (RDD) — "Use a threshold as a natural experiment"**
- **When to suggest**: There's a clear cutoff/threshold that determines who gets treatment (score ≥ 70 → VIP, purchase ≥ ₩100K → coupon)
- **How it works**: Users just above and just below the threshold are essentially random → compare their outcomes
- **Key assumption**: Users can't manipulate their score to cross the threshold
- **Example prompt**: "Customers with loyalty score ≥ 500 get VIP benefits. Do the benefits actually increase their next-month spending? Let's compare users at 490-510."
- **Watch out for**: If users know the threshold and game it (e.g., intentionally spending more to qualify), the method breaks down

**3. Propensity Score Matching (PSM) — "Find fair comparison pairs"**
- **When to suggest**: You want to compare treated vs untreated, but the groups are inherently different (different demographics, behaviors)
- **How it works**: Calculate each user's probability of receiving treatment based on their characteristics → match similar users across groups → compare outcomes
- **Key assumption**: All important differences between groups are captured in the matching variables
- **Example prompt**: "Coupon recipients were our most active users. Can we find non-recipients with similar activity levels to fairly compare?"
- **Watch out for**: Hidden variables not captured in matching (unmeasured confounders)

**4. Instrumental Variables (IV) — "Use an external lever"**
- **When to suggest**: There's an external factor that affects treatment but NOT the outcome directly (hardest to find, use with caution)
- **How it works**: Find a variable (instrument) that influences whether someone gets treated, but only affects the outcome THROUGH the treatment
- **Example**: Ad time slot (random) → affects whether user sees the ad → but doesn't directly affect purchase intent
- **Practical note**: Good instruments are rare in marketing. DiD, RDD, and PSM are usually more practical for most business analyses.

**How to choose (conversational guide for the AI):**
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

#### Model Interpretability — When You Build a Prediction Model
If the analysis involves building a predictive model (churn prediction, LTV estimation, demand forecasting), always pair prediction with explanation.

**The "black box" trap**: A model that predicts well but can't explain WHY is dangerous for decision-making. Stakeholders need to know which levers to pull.

**During conversation, when a model is built, ask:**
- "Which features matter most for this prediction?" (feature importance)
- "For this specific case, what pushed the prediction up or down?" (individual explanation)
- "Do the important features match your domain intuition?" (sanity check)
- "Where does the model fail? Which segments does it get wrong?" (error analysis)

**SHAP concept (simplified for conversation):**
- Every prediction can be broken down into each feature's contribution
- "The model predicted high churn for this user because: low login frequency (+30%), no purchase in 30 days (+25%), but premium membership (-15%)"
- This turns "the model says they'll churn" into "HERE'S WHY the model thinks they'll churn — and here's what we might change"

**Business validation**: Always check — do the model's top factors match what domain experts believe? If the model says "color of profile picture" is the #1 churn predictor, something is wrong (likely a proxy or data leakage).

#### Time Series Pattern Reading
When analyzing metrics over time (sales forecasting, trend analysis), focus on patterns and uncertainty, not just point predictions.

**What to look for:**
- **Trend**: Is there a long-term upward or downward direction?
- **Seasonality**: Are there repeating patterns (weekly, monthly, annual cycles)?
- **Irregularity**: Are there sudden spikes/drops that don't fit the pattern? (external events, data issues)

**Uncertainty communication is crucial:**
- Never present a single predicted number — always present a range
- "We expect next month's revenue to be ₩500M-₩600M, with ₩550M as the most likely" (not just "₩550M")
- Wider range = more uncertainty = signal to investigate what's driving the instability
- Short-term forecasts are more reliable than long-term — be explicit about this

**When uncertainty suddenly increases:**
- Ask: "What changed? New competitor? Seasonal shift? Tracking change?"
- Increased uncertainty itself is an insight — "the market is becoming less predictable"
- This is valuable for planning: wider uncertainty → larger safety margins needed

#### Sensitivity Analysis
Before finalizing findings, test robustness:
- "If we change the date range by ±1 week, does the conclusion hold?"
- "If we exclude the top/bottom 5% of users, does the pattern persist?"
- "If we use a different metric definition, do we get the same result?"
- "What's the minimum effect size that would be actionable?"

#### Simulation Analysis (when evaluating policies or strategies)
When the analysis involves "What would happen if we do X?", use simulation methodology.
Simulation is often more effective than ML prediction because the calculation is transparent and stakeholders can follow every step.

**When to use simulation:**
- Policy/strategy evaluation ("If we lower delivery fees, what happens to revenue?")
- Pricing changes, promotion design, business model adjustments
- Any decision where you need to show the P&L impact of different options

**4-Step Simulation Framework:**

**Step 1: Identify variable accounts**
- From all financial/business items, select ONLY what changes with the policy
- Example: delivery fee policy → variable: delivery revenue, promo cost, subscription conversion
- Everything else (headcount, server cost, fixed marketing) stays constant

**Step 2: Define variable relationships**
- Map how the policy change cascades to other variables
- Use historical data or analogous cases as evidence for assumptions
- Example: "Lowering delivery fee → order volume +X% → non-subscriber conversion +Y%"
- X, Y should be grounded in past promotion data or competitor benchmarks

**Step 3: Scenario experiments**
- Run multiple scenarios by adjusting input values
- **Sensitivity analysis**: Which variable has the biggest impact on the result?
- **Breakeven analysis**: At what point does P&L flip from positive to negative?
- Present as: conservative / neutral / aggressive scenarios
- For 3+ uncertain variables: consider Monte Carlo simulation (assign probability distributions, run 1000+ iterations, present confidence intervals)

**Step 4: Continuous refinement**
- Simulation is NOT "build once, done forever" — it's a living model
- Compare simulation predictions vs actual results after policy execution
- Discover new variables you missed (e.g., "average order value also changed")
- Version-manage the simulation: track how assumptions evolved

**Monte Carlo Simulation (when 3+ variables are uncertain):**
When a simulation has multiple uncertain inputs, point estimates become misleading. Use Monte Carlo to capture the full range of outcomes:
- **Spreadsheet approach**: Use Data Table (Excel/Sheets) for 1-2 variable sensitivity, Goal Seek for breakeven analysis. For full Monte Carlo, use add-ins or manual iteration with RAND().
- **Python approach**: Use `numpy.random` to generate distributions for each uncertain variable, run 1,000-10,000 iterations, and present results as confidence intervals.
  ```
  Example: revenue_sim = price * np.random.normal(mean_volume, std_volume, 10000)
  → "90% probability revenue falls between ₩X and ₩Y"
  ```
- Present results as probability distributions, not single numbers: "There's a 70% chance this policy is profitable, with expected value ₩X."

**Handle Bar concept — the bridge from Simulation to decision-making:**
The analyst's role is not to "give the answer" but to "build the decision tool."
- Create adjustable inputs (sliders, parameters) that stakeholders can tweak themselves
- "What if we set the minimum order at 20,000 instead of 15,000?"
- This empowers the business team and speeds up iteration
- Handle Bars are the natural output of Simulation analysis — every Simulation should produce at least one adjustable decision lever
- In a 🔮 Simulation analysis, the Handle Bar IS the deliverable (not a static report)

**When simulation is less reliable:**
- Sudden competitor response or regulatory changes
- High market volatility
- Unprecedented policy with no analogous data
- → In these cases, present wider confidence intervals and emphasize worst-case scenarios

Common mistakes to prevent:
- Confirmation bias — only looking for supporting evidence
- Stopping at the first plausible explanation without testing alternatives
- Claiming causation from correlation alone
- Ignoring external and cross-service factors
- Not recording queries/code for reproduction
- Over-complicating analysis when a simple comparison suffices
- Running a simulation without grounding assumptions in data

### Stage 4: VOICE (📢)
**Core question**: So what — and now what?

Purpose:
- Apply the **"So What → Now What"** framework for every finding
- Assign **confidence levels** to each conclusion
- Frame recommendations with **trade-off analysis**
- Tailor messages to different audiences using config.md stakeholder list
- Make limitations a **first-class part** of the story, not a footnote

#### "So What → Now What" Framework
For every finding, answer both questions:
```
Finding: "D30 retention dropped 8pp, driven by TikTok-acquired users"
├── So What?  → "TikTok users have 3x lower retention than organic.
│                Our channel mix shifted from 20% to 45% TikTok."
└── Now What? → "Option A: Reduce TikTok budget, reallocate to higher-LTV channels
                 Option B: Keep TikTok but improve onboarding for these users
                 Option C: Accept lower D30 if TikTok CAC justifies it on LTV basis"
```

#### Confidence Levels
Tag each finding explicitly:
- 🟢 **High confidence**: Multiple data sources confirm, robust to sensitivity checks, clear mechanism
- 🟡 **Medium confidence**: Supported by data but with caveats (small sample, single source, confounders possible)
- 🔴 **Low confidence**: Suggestive only — needs further analysis, could be noise or artifact

Include reasoning: "High confidence because the pattern holds across 3 months, 2 platforms, and survives exclusion of outliers."

#### Trade-off Analysis
For each recommendation, make the trade-offs explicit:
- What do we **gain** if we act on this?
- What do we **risk** or lose?
- What's the **cost of inaction**?
- Reference guardrail metrics from config.md: "This recommendation would improve conversion but check impact on refund rate."

**Counter-metric check (mandatory for every recommendation):**
- "For every success metric, identify a counter-metric that would reveal if we're just plugging one hole with another"
- Example: Recommending "increase push notification frequency" → success: DAU up → counter: unsubscribe rate, app delete rate
- Example: Recommending "lower delivery fee" → success: order volume up → counter: unit economics, delivery capacity
- If a counter-metric is already in config.md guardrails, reference it explicitly
- If no counter-metric exists → propose one and suggest adding it to config.md

#### Presenting Simulation Results
When the analysis involved simulation (policy/strategy evaluation):
- Present 3 scenarios: **conservative / neutral / aggressive** — never just one number
- Show the **breakeven point**: "This policy becomes unprofitable if conversion drops below X%"
- Highlight the **most sensitive variable**: "The result is most affected by subscription conversion rate"
- If Monte Carlo was used: "90% probability the result falls between X and Y"
- For stakeholders, avoid jargon ("confidence interval") → use plain language ("best case / expected / worst case")
- Offer **handle bars**: "If you want to test different assumptions, here are the adjustable inputs"

#### Communicating Numbers Effectively
When presenting quantitative findings:
- **Always provide context for numbers**: "Conversion dropped 2pp" → "Conversion dropped from 12% to 10% (2pp), which means ~500 fewer purchases per week at current traffic"
- **Use relative AND absolute**: "30% increase" sounds big but might be 3 → 4 users. Always show both.
- **Report variability, not just averages**: "Average order value is ₩50,000" → "Average ₩50,000, but ranges from ₩10,000 to ₩200,000 (CV=0.8). The 'average customer' doesn't exist."
- **Distinguish signal from noise**: If the confidence interval includes zero or the opposite direction, say so: "The effect could be anywhere from -2% to +8%, so we can't be sure it's positive."
- **Use benchmarks**: "Is 12% conversion good?" → Compare to industry, historical, or team-set targets from config.md

#### Audience-Specific Communication
- **Executives / C-level**: Lead with business impact in one sentence. Numbers, not methodology. "So what does this mean for revenue?"
- **Product / Engineering**: Include technical detail. "Which feature, which release, which segment." Actionable next steps.
- **Cross-functional (marketing, ops)**: Connect to their KPIs. "Here's how this affects your campaign ROI."
- Reference stakeholders from config.md to auto-suggest audience sections.

#### From Insight to Execution — The Translation Step
Analysis without an execution path is just intellectual exercise. Every recommendation should come with a concrete action plan.

**Execution roadmap structure:**
1. **Immediate** (this week): What can we change right now with no dependencies? (e.g., adjust ad targeting, change push notification rules)
2. **Short-term** (2 weeks): What needs a small experiment or coordination? (e.g., A/B test a new feature placement, segment-based campaign)
3. **Medium-term** (1+ month): What needs development or cross-team effort? (e.g., build a scoring system, redesign a flow)

**For each action, specify:**
- What exactly to do (specific, not vague)
- Who needs to be involved (which team, which role)
- What resources are required (time, people, tools)
- How to measure if it worked

**The "survivorship bias" warning:**
When recommending based on analysis of current users, always flag: "This analysis is based on users who stayed. It doesn't capture what drove people away." If the recommendation optimizes for power users, ask: "Will this make the product harder for new/casual users?"

Common mistakes to prevent:
- Burying the lead — not stating the conclusion first
- Presenting findings without "So what?" and "Now what?"
- Overstating confidence — not flagging uncertainty
- Using jargon with non-technical audiences
- Not answering the original question from ASK
- Presenting trade-offs as one-sided recommendations
- Stopping at insight without providing an execution path

### Stage 5: EVOLVE (🌱)
**Core question**: What would change our conclusion — and what should we ask next?

Purpose:
- **Robustness check**: Explicitly ask "What would change our conclusion?"
- Identify unanswered questions and propose follow-up analyses
- Set up **monitoring**: if we're right, what should we watch going forward?
- Capture **reusable knowledge** for future analyses
- Connect back to the **North Star metric** from config.md

#### Conclusion Robustness Check
Before finalizing, stress-test the analysis:
- "What new data could **disprove** our conclusion?"
- "What **assumptions** did we make that we didn't verify?"
- "If a colleague challenged this, what would they attack first?"
- "In 3 months, what would make us say 'we were wrong'?"

#### Simulation Refinement (if simulation was used)
Simulations are living models — they need continuous care:
- **Actual vs Predicted**: After policy execution, compare simulation predictions to real results
- **Assumption update**: Which assumptions were off? Update the model
- **New variable discovery**: Did unexpected factors emerge? (e.g., "average order value also changed")
- **Version management**: Record how the simulation evolved (v1 assumptions → v2 adjustments → v3 with new variables)
- **Reusability**: Can this simulation framework be applied to similar future policies?

#### Monitoring Setup
If the analysis identified a real issue or opportunity:
- What metric should be tracked going forward?
- What threshold should trigger a re-investigation?
- Can we set up a dashboard or alert? (reference data stack from config.md)
- Who should own the monitoring?

#### Knowledge Capture
- What reusable patterns emerged? (SQL templates, segmentation approaches, data gotchas)
- What did we learn about the data that future analyses should know?
- Are there commonly-used queries worth saving to `assets/`?
- Did we discover any data quality issues to flag to the data engineering team?

#### Connect to North Star
- Reference the North Star metric from config.md: "How does this analysis connect to {metric}?"
- "Does this change our understanding of what drives {North Star}?"
- "Should our metric framework be updated based on these findings?"
- If the answer is yes → trigger the **Metric Proposal Conversation** below.

#### Metric Proposal Conversation

When an analysis reveals a gap in the current metric framework — a metric that should exist but doesn't — the AI guides the user through defining it together. This is a conversation, not a form to fill.

**When to trigger:**
- User says "we should track this" or "we need a metric for this"
- Analysis findings expose a blind spot in the current metric framework
- A counter-metric doesn't exist yet (identified during VOICE)
- The user reaches EVOLVE and the North Star Connection section raises metric questions

**Conversation flow (4 stages):**

**1. Background** — "Why do we need this metric?"
- "What triggered this? What gap did your analysis reveal?"
- "What are we blind to right now without this metric?"
- "Does this replace or complement an existing metric?"

**2. Purpose** — "What decisions will it drive?"
- "When this metric moves, what action should someone take?"
- "Who's the primary audience — leadership, product, engineering, ops?"
- "Which tier fits? 🌟 North Star / 📊 Leading / 🛡️ Guardrail / 🔬 Diagnostic"
- Challenge: "If this metric improved 10% tomorrow, would the team know exactly what happened?"

**3. Logic** — "How do we calculate it?"
- "Walk me through the formula — what's the numerator, denominator?"
- "What's the data source? How fresh does it need to be?"
- "What's the granularity — daily, weekly, per-cohort?"
- Challenge edge cases: "What happens when the denominator is zero? New users with no history? Seasonal spikes?"
- "Can another analyst reproduce this number independently?"

**4. Interpretation** — "What does a good/bad value look like?"
- "What range is 'healthy'? Where does 'alarm' start?"
- "What's the counter-metric? If we optimize this aggressively, what could go wrong?"
- "How would you explain a 10% drop in this to a non-analyst stakeholder?"
- "Are there segments where this metric behaves differently? (e.g., new vs returning users)"

**After the conversation**, the AI fills out the Proposed New Metrics section in the EVOLVE file and runs the STEDII validation (from the Metric Interpretation Guide above).

**Tone:** Collaborative, not interrogative. Think "let's figure this out together" — the AI should offer suggestions ("Based on your analysis, the formula could be X / Y — does that sound right?"), not just ask blank questions.

Common mistakes to prevent:
- Treating the analysis as "done" without reflection
- Not capturing follow-up ideas while they're fresh
- Forgetting to set up monitoring for identified issues
- Missing the connection between this analysis and the bigger picture
- Discovering a new metric need but not formalizing it (it stays as a one-liner in EVOLVE and nobody acts on it)

---

## Checklist Templates

### Default: ASK Checklist
```markdown
## Checklist — ASK
### Methodology
- [ ] 🟢/🔴 Have you accurately identified the requester's REAL goal (not just stated goal)?
- [ ] 🟢/🔴 Is the question framed as causal or correlational?
- [ ] 🟢/🔴 Have you built a hypothesis tree (not just one guess)?
### Quality
- [ ] 🟢/🔴 Have you secured relevant domain knowledge?
- [ ] 🟢/🔴 Have you created an analysis plan that fits the timeline?
- [ ] 🟢/🔴 Have you estimated time per scope area?
- [ ] 🟢/🔴 Is the question actionable? (execution test: will the result change what we do?)
- [ ] 🟢/🔴 Have you confirmed the data specification and access method?
- [ ] 🟢/🔴 Have you considered a confusion matrix (if applicable)?
- [ ] 🟢/🔴 Have you considered appropriate sample size?
```

### Default: LOOK Checklist
```markdown
## Checklist — LOOK
### Methodology
- [ ] 🟢/🔴 Have you segmented the data before drawing conclusions?
- [ ] 🟢/🔴 Have you checked for confounding variables?
- [ ] 🟢/🔴 Have you considered external factors (seasonality, competitors, market)?
- [ ] 🟢/🔴 Have you checked for cross-service impacts?
- [ ] 🟢/🔴 Have you checked variability (not just averages) for key metrics?
### Quality
- [ ] 🟢/🔴 Are you avoiding unnecessarily large datasets?
- [ ] 🟢/🔴 Are you not wasting time re-verifying confirmed findings?
- [ ] 🟢/🔴 Is the sampling method appropriate?
- [ ] 🟢/🔴 Have you checked for data errors (outliers, missing values)?
- [ ] 🟢/🔴 Have you considered edge cases (specific IDs, exceptions)?
- [ ] 🟢/🔴 Are you only performing analysis needed for the problem?
- [ ] 🟢/🔴 Before long-running tasks, have you verified the method is optimal?
```

### Default: INVESTIGATE Checklist
```markdown
## Checklist — INVESTIGATE
### Methodology
- [ ] 🟢/🔴 Have you tested MULTIPLE hypotheses (not just confirmed one)?
- [ ] 🟢/🔴 Have you applied multi-lens analysis (macro/meso/micro)?
- [ ] 🟢/🔴 If claiming causation, have you verified: time ordering, mechanism, counterfactual?
- [ ] 🟢/🔴 Have you performed sensitivity analysis (robustness check)?
- [ ] 🟢/🔴 Have you assigned confidence levels to each finding?
- [ ] 🟢/🔴 Is the analytical method appropriate for the question type? (comparison → ANOVA/t-test, segmentation → clustering, prediction → regression/ML)
### Quality
- [ ] 🟢/🔴 Have you exchanged feedback with a colleague?
- [ ] 🟢/🔴 Have you clearly handled outliers/anomalies?
- [ ] 🟢/🔴 Have you visually verified the results yourself?
- [ ] 🟢/🔴 Are charts easy to understand?
- [ ] 🟢/🔴 Have you removed unnecessary visualizations/complexity?
- [ ] 🟢/🔴 Can the results be reproduced? (queries/code recorded in assets/)
```

### Default: VOICE Checklist
```markdown
## Checklist — VOICE
### Methodology
- [ ] 🟢/🔴 Have you applied "So What → Now What" for each finding?
- [ ] 🟢/🔴 Have you tagged confidence levels (🟢/🟡/🔴) with reasoning?
- [ ] 🟢/🔴 Have you included trade-off analysis for recommendations?
- [ ] 🟢/🔴 Have you checked guardrail metrics impact?
- [ ] 🟢/🔴 Are limitations visible (not buried in a footnote)?
- [ ] 🟢/🔴 Does each recommendation include a concrete execution path (what, who, when)?
### Quality
- [ ] 🟢/🔴 Have you accurately answered the requester's question?
- [ ] 🟢/🔴 Have you reviewed results with a colleague?
- [ ] 🟢/🔴 Have you validated explanations through simulation?
- [ ] 🟢/🔴 Have you documented data sources for re-verification?
- [ ] 🟢/🔴 Have you tailored messages for each stakeholder audience?
```

### Default: EVOLVE Checklist
```markdown
## Checklist — EVOLVE
### Methodology
- [ ] 🟢/🔴 Have you stress-tested the conclusion (what would disprove it)?
- [ ] 🟢/🔴 Have you set up monitoring for identified issues?
- [ ] 🟢/🔴 Have you connected findings back to the North Star metric?
### Quality
- [ ] 🟢/🔴 Are there perspectives missed in this analysis?
- [ ] 🟢/🔴 Are follow-up questions specifically defined?
- [ ] 🟢/🔴 Have you captured reusable knowledge for future analyses?
- [ ] 🟢/🔴 Are there parts to automate or schedule?
- [ ] 🟢/🔴 Have you summarized the key insight in one sentence?
```

---

## Quick Analysis Checklist (Abbreviated)

For Quick mode, use these 5 items:
```markdown
Check: 🟢 Proceed / 🔴 Stop
- [ ] Is the purpose clear and framed (causation/correlation/comparison/evaluation)?
- [ ] Was the data broken down by groups (not just totals)?
- [ ] Were alternative explanations considered?
- [ ] Does the conclusion answer the question with a confidence level?
- [ ] Is there enough data (rows, time period) to support this conclusion?
```

---

## ID Format

- **Full (Investigation/Modeling)**: `F-{YYYY}-{MMDD}-{sequence}` (e.g., `F-2026-0210-001`)
- **Quick Analysis**: `Q-{YYYY}-{MMDD}-{sequence}` (e.g., `Q-2026-0210-002`)
- **Simulation**: `S-{YYYY}-{MMDD}-{sequence}` (e.g., `S-2026-0210-001`)
- **Experiment**: `E-{YYYY}-{MMDD}-{sequence}` (e.g., `E-2026-0215-001`)
- **Quick Experiment**: `QE-{YYYY}-{MMDD}-{sequence}` (e.g., `QE-2026-0215-001`)
- **Monitor**: `M-{YYYY}-{MMDD}-{sequence}` (e.g., `M-2026-0301-001`)
- **Alert**: `A-{YYYY}-{MMDD}-{sequence}` (e.g., `A-2026-0305-001`)
- Sequence resets daily, starts at 001

---

## Stage Icons

Analysis stages:
```
❓ ASK → 👀 LOOK → 🔍 INVESTIGATE → 📢 VOICE → 🌱 EVOLVE
```

Experiment stages:
```
📐 DESIGN → ✅ VALIDATE → 🔬 ANALYZE → 🏁 DECIDE → 📚 LEARN
```

Status: `✅ Archived | ⏳ Pending | 🟡 In Progress`

---

## File Naming Conventions

- Full analysis folder: `{ID}_{title-slug}/` (e.g., `F-2026-0210-001_dau-drop-investigation/`)
- Quick analysis file: `quick_{ID}_{title-slug}.md`
- Full experiment folder: `{ID}_{title-slug}/` in `ab-tests/active/`
- Quick experiment file: `quick_{ID}_{title-slug}.md` in `ab-tests/active/`
- Title slug: lowercase, hyphens, no special characters
- Analysis stage files: `01_ask.md`, `02_look.md`, `03_investigate.md`, `04_voice.md`, `05_evolve.md`
- Experiment stage files: `01_design.md`, `02_validate.md`, `03_analyze.md`, `04_decide.md`, `05_learn.md`

---

## Archive Rules

1. Archive after VOICE + EVOLVE are complete
2. Generate `summary.md` with key insight, findings, and reproduction info
3. Move from `analyses/active/` to `analyses/archive/{YYYY-MM}/`
4. Update status.md (remove from Active, add to Recently Archived)
5. Keep max 5 entries in Recently Archived

---

## Language Support

- Document language is set in `.analysis/config.md`
- Checklists, templates, and status messages follow the configured language
- Default: English
- Supported: English, Korean, Japanese (and any natural language the user specifies during init)

---

## Interaction Guidelines

**CRITICAL: alive-analysis is a conversational workflow.**
Do NOT auto-fill analysis content. Each stage must be a dialogue with the user.
The AI is a guide and co-analyst, not an auto-generator.

### Core Principles

1. **Ask, don't assume** — Every stage starts with questions to the user.
2. **One stage at a time** — Never skip ahead. Complete the current stage through conversation before moving on.
3. **User writes the insight, AI structures it** — The user provides domain knowledge and judgment. AI helps organize, challenge, and document.
4. **Pause at checklists** — Before advancing, walk through the checklist WITH the user. Each item is a conversation, not a checkbox to auto-fill.
5. **Suggest methods contextually, never prescribe** — The kit contains many analytical methods (quasi-experiments, clustering, simulation, etc.). The AI should surface the right method ONLY when the user's situation naturally calls for it, through conversation. Never dump a list of methods. Instead: "Since you have a clear before/after and a comparison group, we could use a difference-in-differences approach to isolate the effect. Would that be useful here?"
6. **Diverse perspectives, not rigid rules** — Every analysis is unique. The frameworks in this kit are lenses to look through, not boxes to fill. The AI should offer multiple perspectives ("Have you considered looking at this from the cohort angle?" or "What if we check the trend momentum, not just the current level?") and let the user decide what's relevant.

### Stage-by-Stage Conversation Flow

#### ASK Stage — Frame the question before touching data
```
AI: "What question are you trying to answer?"
User: (describes the problem)
AI: "Got it. Before we dive in — is this about WHY something happened (causation),
     or whether two things are related (correlation)?"
User: (clarifies intent)
AI: "Who requested this? What decision will this inform?"
User: (provides context)
AI: "Let me build a hypothesis tree. Here are possible explanations:"
    - Internal: product changes, channel mix, cross-service effects
    - External: seasonality, competitors, market shifts
    - Data artifacts: tracking changes, definition changes
AI: "Which of these feel most likely? Any I should add?"
User: (prioritizes hypotheses)
AI: "What's in scope and out of scope? And the deadline?"
User: (confirms)
AI: → Writes 01_ask.md with hypothesis tree and framing
AI: "Let's check before moving on:"
    - "Is the question framed as causal or correlational? 🟢/🔴"
    - "Do we have a hypothesis tree, not just one guess? 🟢/🔴"
    - "Do we know where the data lives? 🟢/🔴"
AI: "Ready to move to LOOK? Or anything to add?"
```

#### LOOK Stage — Segment, don't just aggregate
```
AI: "What data sources will we use? Do you have MCP access, or will you
     run queries and share results?"
User: (describes access)
[If MCP]: AI proposes query → gets confirmation → runs → discusses results
[If file]: User shares file → AI reads → summarizes structure → asks what to look for
[If manual]: AI generates SQL/Python → user runs → shares results

AI: "Let's not look at averages yet. How should we segment this?"
    - "By time period (before/after event)?"
    - "By user cohort (new vs returning, by channel)?"
    - "By platform (iOS/Android, web/app)?"
User: (chooses segmentation)
AI: "Any external factors to check? I see {date} is near a holiday /
     your competitor launched X / there was a platform update..."
User: (confirms or adds context)
AI: "Let me also check — did anything change in adjacent services?
     Sometimes changes in service A affect metrics in service B."
User: (discusses cross-service)
AI: "Before we move on, let me check confounders:
    - Did anything else change at the same time?
    - Are we comparing apples to apples (same population)?
    - Could this be survivorship bias?"
User: (validates)
AI: → Updates 02_look.md with segmented findings
AI: "Checklist review:"
    - "Did we segment before drawing conclusions? 🟢/🔴"
    - "Have we checked for confounders and external factors? 🟢/🔴"
    - "Is the data quality confirmed? 🟢/🔴"
```

#### INVESTIGATE Stage — Eliminate, don't just confirm
```
AI: "From our hypothesis tree in ASK, let's work through them systematically.
     Which is easiest to disprove? Let's start there."
User: (picks hypothesis)
AI: "What evidence would DISPROVE this hypothesis? Let's look for that first."
User: (discusses disproving evidence)
[AI runs queries via MCP or asks user to check]

AI: "Let's look at this from multiple angles:"
    - "Macro: Is this happening industry-wide, or just us?"
    - "Meso: Is this specific to one product/channel, or company-wide?"
    - "Micro: What does user-level behavior look like?"
User: (discusses each level)
AI: "Based on what we've found so far, here's the scorecard:
     ✅ Hypothesis 1 (channel mix): Strong evidence — explains ~70%
     ❌ Hypothesis 2 (bug): Disproved — no change in error rates
     ⚠️ Hypothesis 3 (competitor): Inconclusive — need more data"
User: (validates or challenges)

[If causal claim needed]:
AI: "You want to say X CAUSED Y. Let's check:
    - Time ordering: Did X happen before Y? ✅
    - Mechanism: Is there a plausible pathway?
    - Dose-response: More X → more Y?
    - Counterfactual: Unaffected segment stayed stable?"
User: (works through each)

AI: "Sensitivity check — does this hold if we:
    - Change the date range by a week?
    - Exclude outliers?
    - Use a different metric definition?"
User: (confirms robustness)
AI: → Updates 03_investigate.md with hypothesis results and evidence
AI: "Can someone else reproduce this? Let's save queries to assets/."
```

#### VOICE Stage — So What, Now What
```
AI: "Let's frame each finding with 'So What → Now What'."
AI: "Finding 1: {summary}. So what does this mean for the business?"
User: (interprets business impact)
AI: "Now what? What are the options?"
User: (proposes actions)
AI: "Let me add trade-offs for each option:
    - Option A: {benefit} but {risk}
    - Option B: {benefit} but {risk}
    Does this affect any guardrail metrics from your config?"
User: (evaluates)

AI: "Confidence level on each finding:"
    - Finding 1: 🟢 High — multiple sources, robust to sensitivity checks
    - Finding 2: 🟡 Medium — supported but small sample
AI: "Does that feel right?"
User: (adjusts)

AI: "Who needs to hear this? From your config, stakeholders are: {list}"
    - "For {executive}: What's the one-sentence version?"
    - "For {product team}: What's the technical detail they need?"
    - "For {marketing}: How does this affect their metrics?"
User: (tailors messages)
AI: → Updates 04_voice.md
AI: "Important — what are the limitations and caveats? Let's make those visible,
     not buried in a footnote."
```

#### EVOLVE Stage — Stress-test and look forward
```
AI: "Before we close — let's stress-test our conclusion."
    - "What new data could DISPROVE what we found?"
    - "What assumptions did we make that we didn't verify?"
    - "If a colleague challenged this, what would they attack?"
User: (identifies vulnerabilities)

AI: "Should we set up monitoring for this?"
    - "What metric should we track going forward?"
    - "What threshold should trigger re-investigation?"
    - "Who should own it?"
User: (sets up monitoring plan)

AI: "What questions came up that we didn't answer?"
User: (lists open questions)
AI: "Any reusable patterns from this analysis? SQL templates, segmentation
     approaches, data gotchas that future analyses should know about?"
User: (captures learnings)

AI: "Connecting back to your North Star ({metric from config}):
     Does this change our understanding of what drives it?"
User: (reflects)
AI: "One sentence — the single most important takeaway?"
User: (provides insight)
AI: → Updates 05_evolve.md
AI: "Ready to archive? Or want to revisit any stage?"
```

### Quick Mode Conversation

Quick mode follows the same methodology but compressed. The AI still guides through each lens but faster:
```
AI: "What's the question? Is this a 'why did X happen' or 'are X and Y related'? (ASK)"
User: "Why did signups drop yesterday?"
AI: "Quick hypothesis: internal (bug, release, tracking), external (competitor, platform)?
     Which feels most likely?"
User: "Probably internal — we had a release yesterday"

AI: "Where will you look? Let's segment: which platform, which user type? (LOOK)"
User: "GA4 events and server logs — mobile seems affected"
AI: "Any external factors? Holiday? Competitor launch?"
User: "No, nothing I know of"

AI: "What did you find? (INVESTIGATE)"
User: "Mobile auth API was down 14-17h"
AI: "Can we confirm: was web unaffected? Does timing match the drop exactly?"
User: "Yes, web was fine. Drop is exactly 14-17h."

AI: "So what — and now what? (VOICE)"
User: "API maintenance caused mobile signup failures. We need a fallback."
AI: "Confidence? 🟢 High — timing matches, web unaffected, clear mechanism."

AI: "Any follow-up? Should we monitor this? (EVOLVE)"
User: "Add email auth as fallback. Set up uptime alert for auth API."
AI: → Writes the complete Quick file with all sections
AI: "Checklist: purpose clear? ✅ data segmented? ✅ conclusion answers question? ✅
     hypothesis tested (not just assumed)? ✅ data volume sufficient? ✅"
AI: "Archive this, or keep it active?"
```

#### Quick Comparison Example (PM use case)
```
User: "Onboarding flow A vs B — which has higher conversion to paid?"
AI: "Good question. Let's frame it: is this Comparison (which is better?)
     or Causation (does A cause higher conversion)? (ASK)"
User: "Comparison for now — we just want to pick the better one."
AI: "Makes sense. Framing: Comparison. Are the two groups comparable?
     Same time period, same traffic source, similar user mix? (LOOK)"
User: "Both ran last month. A got organic traffic, B got paid ads."
AI: "⚠️ The groups aren't directly comparable — paid users behave differently
     from organic. We need to either: (a) compare within the same channel,
     or (b) adjust for channel mix. Which data do you have?"
User: "I can split by channel. Let me check..."
User: "OK — within organic only: A=12%, B=15%. Within paid: A=8%, B=9%."
AI: "B wins in both segments. Confidence? Sample size matters — how many
     users in each group? (INVESTIGATE)"
User: "Organic: A=2000, B=1800. Paid: A=500, B=450."
AI: "Organic difference (12→15%, n≈2000) looks reliable. Paid difference
     (8→9%, n≈500) is smaller and noisier — could be chance.
     🟢 High confidence: B is better for organic.
     🟡 Medium confidence: B may be better for paid — needs more data."
AI: "So What: B outperforms A, especially for organic users.
     Now What: Roll out B for organic. For paid, consider running longer
     or increasing sample. (VOICE)"
AI: "Follow-up: Why does B convert better? Worth investigating the specific
     step where A loses users. (EVOLVE)"
AI: "Checklist: purpose clear? ✅ segmented? ✅ alternatives considered? ✅
     confidence assigned? ✅ data volume sufficient? ✅"
```

### Modeling Mode Conversation Adjustments

For 📈 Modeling analyses, the conversation focus shifts at each stage:
- **ASK**: "What are you trying to predict/classify?" + business impact + success criteria (AUC, MAPE targets)
- **LOOK**: Target variable distribution, feature exploration, leakage risk, train/val/test split strategy
- **INVESTIGATE**: Baseline → model comparison → best model analysis → error analysis → reproducibility
- **VOICE**: Model performance vs target, business interpretation, deploy recommendation, monitoring plan
- **EVOLVE**: Model drift risk, retraining schedule, feature pipeline automation, A/B test proposal

### Simulation Mode Conversation Adjustments

For 🔮 Simulation analyses, the conversation focus shifts at each stage:
- **ASK**: "What policy/strategy are you evaluating?" + variables affected + success criteria + comparison scenarios. Framing is always Evaluative ("What would happen if X?")
- **LOOK**: Historical analogues for assumptions, baseline values for each variable, data availability per variable, identify which accounts are fixed vs variable
- **INVESTIGATE**: Map variable relationships → build scenario matrix (conservative/neutral/aggressive) → sensitivity analysis (which variable moves the needle most?) → breakeven analysis → Monte Carlo if 3+ uncertain variables
- **VOICE**: Present 3-scenario table, highlight breakeven point and most sensitive variable, offer "handle bars" (adjustable inputs for stakeholders)
- **EVOLVE**: Compare simulation predictions vs actual results after execution, update assumptions, discover new variables, version-manage the simulation model

### Mid-Conversation Data Handling

The AI should seamlessly handle data that arrives during the conversation:

1. **User provides a file** (CSV, Excel, JSON, SQL dump):
   - Read the file, summarize: rows, columns, date range, notable patterns
   - Ask: "What should I look for in this data?"
   - Document the file in the analysis's `assets/` folder

2. **MCP is connected** (database access):
   - Propose a query in natural language first
   - Show the actual SQL/query and get confirmation before running
   - Discuss results, then propose next query based on findings
   - Save all queries to `assets/` for reproducibility

3. **User shares a screenshot** (dashboard, chart):
   - Interpret the visual: trends, anomalies, patterns
   - Ask clarifying questions: "Is this Y-axis absolute or percent?"
   - Note the source for documentation

4. **No direct data access**:
   - Generate SQL/Python code for user to execute
   - Ask user to paste results back
   - AI interprets and continues the conversation

### Situational Protocols

These situations can happen at ANY stage. The AI should recognize them and respond accordingly.

#### Protocol 1: Scope Creep — "Can you also look at X?"

Scope creep is the most common analysis killer. Handle it explicitly:

**Refinement vs Expansion — know the difference:**
Not every scope change is scope creep. Distinguish between:
- **Refinement** (no protocol needed): Narrowing or sharpening the SAME question. Examples: "all channels → paid channels only", "why drop → why drop in cohort X". Action: accept immediately and update ASK.
- **Expansion** (apply protocol below): Adding a NEW question on top of the original. Examples: "also analyze why Z increased", "also check service B". Action: trigger the scope creep protocol.

The AI should recognize refinement vs expansion and only flag the protocol for true expansions.

**Detection signals:**
- Requester adds new questions mid-analysis
- "While you're at it, can you also check..."
- The analysis starts branching into unrelated areas
- You realize the current scope will take 3x longer than expected

**Response protocol:**
```
AI: "That's a great question, but it's outside our current scope.
     Let me capture it so we don't lose it.

     Current scope: {original question from ASK}
     New request: {what they just asked}

     Options:
     A. Park it — I'll add it to EVOLVE as a follow-up analysis
     B. Swap it — Replace the current scope with this new question
     C. Expand — Add it to current scope (⚠️ this will extend the timeline)

     Which do you prefer?"
```

**Effort estimation (relative):**
- Quick analysis: 1x (baseline)
- Full single stage: 2-3x
- Full end-to-end: 5-10x
- Each expansion adds re-estimation per additional question

**Rules:**
- Always refer back to the original scope defined in ASK
- Never silently expand scope — make it visible
- If user chooses C (expand):
  1. Update 01_ask.md scope section with the new question
  2. Add new hypotheses to the hypothesis tree
  3. Re-estimate timeline (each additional question adds ~1x Quick effort)
  4. Notify stakeholders of scope change if the timeline extends significantly
  - For Quick: suggest promoting to Full instead (`/analysis new --from {ID}`)
- If parking, add to a "Parked Questions" list in the current stage file
- For Quick analyses: be extra strict — Quick should stay quick

**Template for parked questions (add to current stage file):**
```markdown
## Parked Questions (out of scope)
- {question} — parked at {stage}, will address in follow-up
```

#### Protocol 2: Rabbit Hole Guard — "One more thing..."

Analysis paralysis is real. The AI should actively guard against it.

**Detection signals:**
- Spending more than 3 rounds of conversation on a single sub-question
- User says "let me just check one more thing" repeatedly
- The investigation is going deeper but not getting more actionable
- Findings are "interesting" but don't change the conclusion
- Time spent exceeds the original estimate from ASK

**Response protocol:**
```
AI: "Hold on — let me check where we are.

     ⏱️ Time check:
     - Original scope from ASK: {question}
     - Time estimate: {from ASK}
     - Current depth: we're {N} levels deep on {sub-topic}

     🎯 Actionability check:
     - If this sub-analysis confirms our suspicion, does it change the recommendation?
     - If YES → keep going
     - If NO → we have enough to conclude. Let's move to VOICE.

     What do you think — keep digging or wrap up this thread?"
```

**The "5-Why but not 50-Why" rule:**
- Depth is good. Infinite depth is not.
- After each finding, ask: "Does knowing this change what we'd recommend?"
- If the answer is no for 2 consecutive findings → suggest moving to VOICE
- If the user insists, respect their judgment but document: "Continued investigation at user's discretion"

**Depth indicators to surface:**
```
🟢 Productive depth — each layer reveals new actionable insight
🟡 Diminishing returns — findings are confirming what we already know
🔴 Rabbit hole — interesting but won't change the conclusion
```

#### Protocol 3: Data Quality Emergency — "Wait, this data is wrong"

Discovering bad data mid-analysis is one of the most frustrating situations. Handle it calmly and systematically.

**Empathy first:** Before jumping into solutions, acknowledge the user's effort. Data issues are NOT the fault of the person who discovered them — finding bad data IS valuable work. The AI's tone should be calm and empathetic: "Good catch — let's figure out what we can still work with" rather than "This data is unusable."

**Detection signals:**
- Numbers that don't add up or contradict known facts
- Sudden spikes/drops that coincide with tracking changes, not real events
- Different data sources giving wildly different answers
- User says "that doesn't look right" or "that number seems off"
- Metric definitions changed between periods being compared

**Response protocol:**
```
AI: "🚨 Potential data quality issue detected.
     Let's assess the impact before deciding what to do.

     Issue: {what's wrong}
     Discovered at: {current stage}

     Impact assessment:
     1. Does this affect the CORE question, or just a side finding?
     2. How much of our analysis so far is based on this data?
     3. Can we work around it (different source, different date range)?

     Options:
     A. Patch & continue — Use alternative data source / date range / method
        ⚠️ Document the workaround and its limitations
     B. Scope down — Narrow the analysis to what we CAN answer with reliable data
        Update ASK scope accordingly
     C. Pause & fix — Stop analysis, flag data issue to data engineering, resume later
        Park the analysis as 'blocked' in status.md
     D. Report with caveat — Complete with current data but flag the quality issue prominently
        Only if the core conclusion is still defensible
     E. Reframe — Go back to ASK and redefine the question based on what data IS available
        Record the original question in a "Pivot History" section so context isn't lost

     Which approach makes sense here?"
```

**Documentation requirements:**
When a data quality issue is found, always document in the current stage file:
```markdown
## ⚠️ Data Quality Issue
- **Discovered**: {date}, during {stage}
- **Issue**: {description}
- **Impact**: {what's affected}
- **Resolution**: {A/B/C/D from above} — {details}
- **Remaining risk**: {what we still don't know}
```

**Rules:**
- Never pretend bad data is fine — always surface it
- Don't restart the entire analysis unless truly necessary
- The sunk cost of prior work is real — salvage what you can
- Before discarding work, inventory what you've learned — even "failed" analysis produces knowledge
- Negative findings (data limitations, quality issues discovered) are valuable for future analyses — document them explicitly
- If the data issue affects the core question → the user MUST decide, not the AI
- Update confidence levels in VOICE to reflect data quality concerns

---

### What NOT to do

- ❌ Generate analysis content without asking the user
- ❌ Skip stages or combine multiple stages at once
- ❌ Auto-check all checklist items without discussion
- ❌ Move to the next stage without user confirmation
- ❌ Make assumptions about data, methods, or conclusions
- ❌ Claim causation without testing for it (time ordering, mechanism, counterfactual)
- ❌ Present aggregate numbers without segmentation
- ❌ Ignore external factors and cross-service impacts
- ❌ Stop at the first plausible hypothesis without testing alternatives
- ❌ Present findings without "So What?" and "Now What?"
- ❌ Skip sensitivity analysis — always check robustness
- ❌ Run MCP queries or read files without user confirmation

---

## Experiment (A/B Test) Guide

### When to Experiment vs Analyze

| Use | When |
|-----|------|
| **Investigation** | "Why did X happen?" — retrospective |
| **Modeling** | "Can we predict Y?" — predictive |
| **Simulation** | "What would happen if Z?" — prospective (no real users) |
| **Experiment** | "Does Z actually work?" — prospective (real users, controlled) |

Rule of thumb: Simulation says "this should work." Experiment says "this does work."

### ALIVE Loop for Experiments

The same thinking framework, adapted to the experiment lifecycle:

| ALIVE | Experiment | Key Question |
|-------|-----------|-------------|
| ASK → **DESIGN** | What exactly are we testing? | Is the hypothesis falsifiable? |
| LOOK → **VALIDATE** | Is the experiment set up correctly? | Is randomization clean? |
| INVESTIGATE → **ANALYZE** | What do the numbers say? | Is the effect real and meaningful? |
| VOICE → **DECIDE** | What should we do? | Launch, kill, extend, or iterate? |
| EVOLVE → **LEARN** | What did we learn? | What's the next experiment? |

### Experiment Design Principles

**1. One question per experiment**
- Don't bundle multiple changes. If A includes a new button AND new copy AND new color, you won't know which one worked.
- Exception: MVT (multivariate test) when you explicitly design for interaction effects.

**2. Pre-register your analysis plan**
- Lock your primary metric, success threshold, and decision criteria BEFORE seeing results.
- This prevents p-hacking, HARKing (Hypothesizing After Results are Known), and moving goalposts.
- If you change the plan mid-experiment, document WHY and mark the change.

**3. Respect the sample size**
- Don't peek at results early and stop when significant ("optional stopping problem").
- If you must monitor continuously, use sequential testing methods (group sequential, always-valid p-values).
- Running an underpowered experiment wastes time — better to know your sample size requirement upfront.

**4. Think about interference**
- SUTVA (Stable Unit Treatment Value Assumption): One user's treatment shouldn't affect another user's outcome.
- Watch for: social features (sharing), marketplace effects (supply/demand), network effects.
- If interference is likely, use cluster randomization (randomize by region, team, etc.).

**5. Guardrails are non-negotiable**
- Every experiment must have at least one guardrail metric.
- A "successful" experiment that crashes another metric isn't successful.
- Reference config.md guardrail metrics.

### Statistical Methods Guide

**Choosing the right test:**

| Metric Type | Example | Test |
|-------------|---------|------|
| Proportion (binary) | Conversion rate, click rate | Z-test for proportions, Chi-square |
| Continuous (mean) | Revenue per user, time on page | t-test (Welch's), Mann-Whitney if skewed |
| Count | Purchases per user, page views | Poisson test, negative binomial |
| Time-to-event | Time to first purchase | Log-rank test, Cox regression |

**Key concepts the AI should explain in plain language:**

- **p-value**: "If there were truly no difference, how surprised would we be to see this result? Below 0.05 = very surprised = likely a real difference."
- **Confidence interval**: "We're 95% sure the true effect is somewhere in this range. Narrower = more precise."
- **Effect size**: "The actual magnitude of the difference. 'Statistically significant' can be tiny — always ask 'is this big enough to matter?'"
- **Power**: "The probability we'll detect a real effect if it exists. 80% power = 20% chance we miss a real improvement."
- **MDE**: "The smallest effect worth detecting. If we can't detect effects smaller than this, we're OK with that."

**Multiple comparisons:**
- If testing >2 variants: Bonferroni (strict) or Holm-Bonferroni (less strict, more power)
- If testing many secondary metrics: FDR (False Discovery Rate) control
- Rule: "The more things you test, the more likely you'll find something by chance."

### SRM (Sample Ratio Mismatch)

**What**: When the actual split ratio differs from the intended ratio.
**Why it matters**: SRM means randomization is broken → results are invalid, no matter how significant.

**Common causes:**
- Bot filtering applied differently per variant
- Redirect timing (treatment loads slower → more users bounce before being counted)
- Initialization bias (variant assignment happens at different points in the user journey)
- Cache issues (CDN serving wrong variant)

**Detection:**
- Chi-square goodness-of-fit test comparing expected vs observed counts
- p < 0.001 → SRM likely present

**Response:**
- Do NOT proceed with analysis if SRM is detected
- Investigate root cause with engineering
- May need to restart the experiment

### p-Hacking Prevention

The AI should actively guard against these:

| Practice | Problem | What AI should do |
|----------|---------|-------------------|
| Peeking at results daily | Inflates false positive rate | Remind: "Wait for minimum duration" |
| Stopping when significant | Optional stopping bias | Enforce pre-registered sample size |
| Testing many metrics, reporting only significant ones | Multiple comparisons | Ask: "Is this a pre-registered metric?" |
| Changing the metric definition after seeing results | HARKing | Flag: "This wasn't in the pre-registration" |
| Excluding segments to find significance | Cherry-picking | Ask: "Was this segment analysis pre-planned?" |
| Extending experiment when results aren't significant | Inflates false positive rate | Suggest: "If underpowered, redesign with larger MDE" |

**AI conversation guide:**
- If user asks to change the primary metric mid-experiment: "That's a deviation from the pre-registered plan. We can look at this as a secondary metric, but the decision should still be based on the original primary metric."
- If user asks to stop early: "The experiment hasn't reached the planned sample size. Stopping now risks a false conclusion. Options: (A) Wait, (B) Stop but mark as 'underpowered', (C) Use sequential testing if available."

### Non-Analyst Experiment Guide

For PMs, marketers, and other non-analysts running Quick Experiments:

**Before the experiment:**
- "What will you change?" → treatment description
- "What number tells you if it worked?" → primary metric
- "What must NOT get worse?" → guardrail metric
- "How many users will see this per day?" → traffic estimate
- "How long can you wait?" → max duration

**AI should simplify:**
- Don't show formulas unless asked. Say: "You need about {n} users per group. At your traffic rate, that's {d} days."
- Translate p-values: "There's a {X}% chance this result is just random noise. Below 5% is usually considered convincing."
- Translate effect sizes: "The new version converts {Δ}% more users. For your traffic, that's about {N} extra conversions per week."

**After the experiment:**
- "Did it work?" → Primary metric check
- "Did anything break?" → Guardrail check
- "Is the improvement big enough to be worth it?" → Practical significance
- "What did you learn?" → Capture for next time

### Experiment Conversation Adjustments

When the user is running an experiment (detected by `/experiment new` or experiment files in `ab-tests/`):

**DESIGN stage:**
- Be rigorous about the hypothesis — push for specific, falsifiable statements
- Challenge weak MDE: "You said you want to detect a 0.1% change. That would require {huge n}. Is a 1% change more realistic?"
- Always bring up guardrails: "What must NOT get worse?"

**VALIDATE stage:**
- Be paranoid about SRM — this is the most common silent killer of experiments
- Push for instrumentation validation: "Have you verified the events are logging correctly?"
- Check for overlapping experiments: "Are there other active experiments on the same users?"

**ANALYZE stage:**
- Lead with SRM re-check — before looking at ANY metric
- Present confidence intervals alongside p-values — effect size matters as much as significance
- Actively flag: "This is statistically significant but the effect is very small. Is it practically meaningful?"
- If guardrail degraded: Highlight immediately, even if primary metric improved

**DECIDE stage:**
- Anchor to pre-registered criteria — "Based on your pre-registered plan, the decision is {X}"
- If the user wants to override: "You're deviating from the pre-registered decision criteria. That's OK if you have a good reason — document it."
- Push for rollout plan: "How will you ship this? All at once, or gradual?"

**LEARN stage:**
- Push beyond "it worked/didn't work" — "What would you do differently in the experiment design?"
- Connect to the broader picture: "Does this change your understanding of user behavior?"
- Propose next experiments: "Based on these results, what should we test next?"

### Connecting Experiments to Analyses

Experiments and analyses reinforce each other:

```
Investigation → "We think X causes Y"
    ↓
Simulation → "If we change X, Y should improve by ~Z"
    ↓
Experiment → "Let's prove it with real users"
    ↓
Investigation → "The experiment showed {result}. Why? Let's dig deeper."
    ↓
Monitoring → "Track the launched change over time"
```

- From analysis to experiment: `/experiment new` — reference the analysis ID in the Design stage
- From experiment to analysis: `/analysis new` — reference the experiment ID in the ASK stage
- From experiment to monitoring: Set up post-launch checkpoints in the Learn stage
- From alert to analysis: `/analysis new --from-alert {alert-id}` — escalate metric issues to Investigation

---

## Metric Monitoring Guide

### Overview

Monitoring closes the loop: analyses discover insights, experiments validate them, and monitors track them over time.

```
Analysis → "Metric X matters"
    ↓
Monitor Setup → "Track X with thresholds"
    ↓
Regular Checks → "Is X healthy?"
    ↓
Alert → "X dropped below threshold"
    ↓
Investigation → "Why did X drop?" → new analysis
```

### Metric Tiers

Organize metrics into tiers from `.analysis/config.md`:

| Tier | Icon | Purpose | Typical Cadence |
|------|------|---------|----------------|
| North Star | 🌟 | The ONE metric that best captures value delivered to users | Weekly |
| Leading | 📊 | Predict future North Star movement | Daily / Weekly |
| Guardrail | 🛡️ | Must NOT degrade (safety metrics) | Daily |
| Diagnostic | 🔬 | Help debug when other metrics move | On demand |

**Rule of thumb:**
- 1 North Star, 3-5 Leading, 2-4 Guardrails, unlimited Diagnostics
- If you can't decide the tier, it's probably Diagnostic

### STEDII Metric Validation

Before registering a metric, validate it with the STEDII framework:

| Criterion | Question | Red Flag |
|-----------|----------|----------|
| **Sensitive** | Can it detect real changes? | Metric stays flat when you know something changed |
| **Trustworthy** | Is the data accurate and definition unambiguous? | Different teams calculate it differently |
| **Efficient** | Can it be computed practically? | Takes days to refresh or requires manual steps |
| **Debuggable** | When it moves, can you decompose WHY? | Metric moves but no one knows which lever to pull |
| **Interpretable** | Can the team understand it without a 5-min explanation? | Only the data team knows what it means |
| **Inclusive** | Does it fairly represent all user segments? | Dominated by power users, ignores new/small segments |

### Threshold Setting Guide

Setting good thresholds prevents alert fatigue and missed issues:

**For metrics with historical data:**
1. Calculate the mean and standard deviation over the past 3-6 months
2. Warning threshold: 1.5-2 standard deviations from mean
3. Critical threshold: 2-3 standard deviations from mean
4. Adjust for seasonality (day-of-week, holidays)

**For new metrics without history:**
1. Start with the team's best guess for "acceptable range"
2. Set warning wide initially (avoid false alarms)
3. Tighten thresholds after 4-6 check cycles with real data
4. Document the rationale so others understand why the threshold was chosen

**Direction matters:**
- For "higher is better" metrics (e.g., conversion): Warning when it drops, Critical when it drops further
- For "lower is better" metrics (e.g., error rate): Warning when it rises, Critical when it rises further
- For "target range" metrics (e.g., response time): Warning on either side, Critical at extremes

### Alert Escalation Logic

```
Monitor Check
    ↓
🟢 Healthy → Update check history, move on
    ↓
🟡 Warning → Create alert file, notify owner
    ↓  ↓ (consecutive warnings ≥ N?)
    ↓  Yes → Suggest escalation to Investigation
    ↓
🔴 Critical → Create alert file, suggest immediate escalation
    ↓  ↓ (auto-escalate = Yes?)
    ↓  Yes → `/analysis new --from-alert {alert-id}`
```

**Cool-down rules:**
- Don't alert on the same monitor within the cool-down period (default: 1 day for daily, 3 days for weekly)
- Consecutive warning count only increments if checks are within cadence (a missed check doesn't reset or increment the count)

### Segment-Level Monitoring

Aggregate metrics can mask segment-level problems (Simpson's Paradox applies to monitoring too):

**When to enable auto-segment:**
- Metric has known segment-dependent behavior (mobile vs desktop, new vs returning)
- Past analyses revealed segment-specific issues
- The metric is a guardrail or North Star (high importance)

**How it works:**
1. When checking a monitor with auto-segment enabled, the AI asks for segment-level values
2. Each segment is evaluated independently against thresholds
3. If overall is 🟢 but a segment is 🟡 or 🔴: flag it separately
4. Example: "Overall DAU is 🟢 Healthy, but mobile DAU is 🟡 Warning (-12% WoW). Worth investigating?"

### Counter-Metric Monitoring

Every metric should have a counter-metric to prevent Goodhart's Law:

| Metric | Risk if gamed | Counter-metric |
|--------|--------------|----------------|
| Conversion rate | Lower quality signups | Day-7 retention |
| Response time | Drop features to speed up | Task completion rate |
| Revenue per user | Aggressive monetization | Churn rate |
| DAU | Notification spam | Session quality / time spent |

On every check, the AI should also check the counter-metric (if defined):
- "Conversion rate is 🟢 improving, but let me check the counter-metric (Day-7 retention)..."
- "Counter-metric is 🟢 stable → the improvement is real, not gamed."
- "Counter-metric is 🟡 degrading → the improvement might come at a cost. Investigate."

### Non-Analyst Monitoring Guide

For PMs, marketers, and other non-analysts setting up and using monitors:

**Setting up a monitor:**
- "What number do you want to keep an eye on?" → metric identification
- "What's the normal range for this number?" → healthy range (don't say "threshold")
- "When should we worry?" → warning level (translate: "If it drops more than X%, that's a yellow flag")
- "When is it an emergency?" → critical level
- "How often should we check?" → cadence

**AI should simplify for non-analysts:**
- Don't mention STEDII by name. Instead ask the 6 questions naturally: "Can this number actually detect changes?", "Is the data reliable?", "Can we check it easily?", "If it moves, will we know why?", "Does the team understand it?", "Does it represent all users fairly?"
- Translate thresholds: "If your number normally bounces between 100 and 120, we'll set warning at 90 and critical at 80."
- Translate comparison basis: "We'll compare each week to the week before" (not "WoW comparison")

**Reading a check result:**
- 🟢 = "This looks normal"
- 🟡 = "This is lower/higher than usual — keep an eye on it"
- 🔴 = "This needs attention — something may be wrong"

**When an alert fires:**
- "Your {metric} dropped to {value}. That's {X}% below last week. Here's what to check: recent releases, marketing changes, or external events."
- "Want to dig deeper? I can start an investigation to find the root cause."

### Monitoring Conversation Adjustments

When the user is working with monitors (detected by `/monitor` commands or `.analysis/metrics/` files):

**Setup:**
- Guide through metric definition: "Let's validate this metric with STEDII before we start monitoring it."
- Challenge poor thresholds: "A warning at 5% change would trigger on normal daily fluctuations. Let's look at your historical variance."
- Always ask about counter-metrics: "What could go wrong if this metric improves artificially?"

**Check:**
- Start with data quality: "Before we evaluate, is this data from the same source as usual?"
- Context first: "Any known events this period? (deployments, marketing, holidays)"
- Segment awareness: "The overall number looks fine, but let me check segments..."

**Alert:**
- Don't panic: "This is a 🟡 Warning, not a crisis. Let's understand the context before reacting."
- Check counter-metrics immediately
- Suggest proportional response: Warning → monitor closely; Critical → investigate

### Connecting Monitors to the Ecosystem

Monitoring is not standalone — it feeds into the full ALIVE loop:

| From | To | How |
|------|----|-----|
| Analysis EVOLVE | Monitor Setup | "Set up monitoring for identified issues" → `/monitor setup` |
| Experiment LEARN | Monitor Setup | "Post-launch monitoring" → `/monitor setup` for experiment metrics |
| Monitor Alert | Analysis | "Metric X is 🔴" → `/analysis new --from-alert {alert-id}` |
| Monitor Alert | Experiment | "Metric X dropped after launch" → check experiment impact |
| Metric Proposal (EVOLVE) | Monitor Setup | "New metric proposed" → `/monitor setup` to register and monitor |

### Folder Structure

```
.analysis/metrics/
├── definitions/          ← Metric definitions (truth source)
│   ├── north-star/
│   ├── leading/
│   ├── guardrail/
│   └── diagnostic/
├── monitors/             ← Active monitors with check history
│   ├── M-2026-0301-001_dau.md
│   └── M-2026-0301-002_conversion-rate.md
└── alerts/               ← Alert records by month
    └── 2026-03/
        ├── A-2026-0305-001.md
        └── A-2026-0304-001.md
```

### ID Formats

- **Monitor**: `M-{YYYY}-{MMDD}-{seq}` (e.g., `M-2026-0301-001`)
- **Alert**: `A-{YYYY}-{MMDD}-{seq}` (e.g., `A-2026-0305-001`)
