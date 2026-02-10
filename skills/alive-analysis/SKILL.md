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

Common mistakes to prevent:
- Starting analysis without a clear question
- Scope creep — trying to answer everything at once
- Not confirming the requester's actual goal (vs stated goal)
- Confusing "interesting" with "actionable"
- Ignoring the hypothesis tree — jumping to the first plausible explanation

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

**Risk-adjusted metrics (Sharpe Ratio concept):**
- Raw performance numbers can be misleading without considering risk/volatility
- **Sharpe Ratio idea**: (return - baseline) / volatility — "how much performance per unit of risk?"
- Apply this thinking: "Channel A has higher conversion but huge variance. Channel B is lower but stable. Which is actually better?"
- When comparing options: normalize by variability, not just average performance
- Especially useful for: campaign comparison, channel evaluation, pricing strategy assessment

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
- If true experiment isn't possible → quasi-experimental methods (diff-in-diff, regression discontinuity, propensity score matching)

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

**Handle Bar concept:**
The analyst's role is not to "give the answer" but to "build the decision tool."
- Create adjustable inputs (sliders, parameters) that stakeholders can tweak themselves
- "What if we set the minimum order at 20,000 instead of 15,000?"
- This empowers the business team and speeds up iteration

**When simulation is less reliable:**
- Sudden competitor response or regulatory changes
- High market volatility
- Unprecedented policy with no analogous data
- → In these cases, present wider confidence intervals and emphasize worst-case scenarios

#### Mid-Conversation Data Handling
- When user provides a file: read it, summarize structure, ask what to look for
- When MCP is available: propose queries, get confirmation, run and discuss results
- When user shares screenshots: interpret patterns, ask clarifying questions
- When running ad-hoc analysis: document every query/step for reproducibility in `assets/`

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

Common mistakes to prevent:
- Burying the lead — not stating the conclusion first
- Presenting findings without "So what?" and "Now what?"
- Overstating confidence — not flagging uncertainty
- Using jargon with non-technical audiences
- Not answering the original question from ASK
- Presenting trade-offs as one-sided recommendations

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

Common mistakes to prevent:
- Treating the analysis as "done" without reflection
- Not capturing follow-up ideas while they're fresh
- Forgetting to set up monitoring for identified issues
- Missing the connection between this analysis and the bigger picture

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

For Quick mode, use these 4 items:
```markdown
Check: 🟢 Proceed / 🔴 Stop
- [ ] Is the purpose clear and framed (causal/correlational)?
- [ ] Was the data segmented (not just aggregated)?
- [ ] Were alternative hypotheses considered?
- [ ] Does the conclusion answer the question with confidence level?
```

---

## ID Format

- **Full**: `F-{YYYY}-{MMDD}-{sequence}` (e.g., `F-2026-0210-001`)
- **Quick**: `Q-{YYYY}-{MMDD}-{sequence}` (e.g., `Q-2026-0210-002`)
- Sequence resets daily, starts at 001

---

## Stage Icons

```
❓ ASK → 👀 LOOK → 🔍 INVESTIGATE → 📢 VOICE → 🌱 EVOLVE
✅ Archived | ⏳ Pending | 🟡 In Progress
```

---

## File Naming Conventions

- Full analysis folder: `{ID}_{title-slug}/` (e.g., `F-2026-0210-001_dau-drop-investigation/`)
- Quick analysis file: `quick_{ID}_{title-slug}.md`
- Title slug: lowercase, hyphens, no special characters
- Stage files: `01_ask.md`, `02_look.md`, `03_investigate.md`, `04_voice.md`, `05_evolve.md`

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
- Default: Korean (한국어)
- Supported: Korean, English, Japanese

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
     hypothesis tested (not just assumed)? ✅"
AI: "Archive this, or keep it active?"
```

### Modeling Mode Conversation Adjustments

For 📈 Modeling analyses, the conversation focus shifts at each stage:
- **ASK**: "What are you trying to predict/classify?" + business impact + success criteria (AUC, MAPE targets)
- **LOOK**: Target variable distribution, feature exploration, leakage risk, train/val/test split strategy
- **INVESTIGATE**: Baseline → model comparison → best model analysis → error analysis → reproducibility
- **VOICE**: Model performance vs target, business interpretation, deploy recommendation, monitoring plan
- **EVOLVE**: Model drift risk, retraining schedule, feature pipeline automation, A/B test proposal

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

**Rules:**
- Always refer back to the original scope defined in ASK
- Never silently expand scope — make it visible
- If user chooses C (expand), update 01_ask.md scope section and re-estimate timeline
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
