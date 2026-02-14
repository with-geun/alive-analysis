---
name: alive-analysis
description: Data analysis workflow kit using the ALIVE loop (Ask, Look, Investigate, Voice, Evolve)
---

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
Key concepts: CV (variability check), deviation vs error, STEDII metric validation, risk-adjusted metrics, trend momentum, cohort analysis pitfalls.

> For details, see `core/references/analytical-methods.md` § Metric Interpretation Guide

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
Method selection quick reference:

| Question | Method |
|----------|--------|
| Which groups are different? | t-test (2 groups), ANOVA (3+) |
| Which users are similar? | K-Means clustering |
| What appears together? | Association rules (Lift) |
| Can we predict an outcome? | LTV models, time series |
| Is this A/B test real? | Experiment analysis |
| How spread out / risky? | CV, Sharpe ratio adaptation |

> For details, see `core/references/analytical-methods.md` § Analytical Methods Toolkit

#### When A/B Testing Isn't Possible — Quasi-Experimental Methods

| Method | When to use |
|--------|------------|
| DiD (Difference-in-Differences) | Before/after event + comparison group |
| RDD (Regression Discontinuity) | Clear threshold/cutoff determines treatment |
| PSM (Propensity Score Matching) | Groups inherently different, need fair comparison |
| IV (Instrumental Variables) | External factor affects treatment only |

> For details, see `core/references/analytical-methods.md` § Quasi-Experimental Methods

#### Model Interpretability
When building prediction models, always pair prediction with explanation (feature importance, SHAP). Never deploy a "black box" — stakeholders need to know which levers to pull.

> For details, see `core/references/analytical-methods.md` § Model Interpretability

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
For every success metric, identify a counter-metric that reveals if we're just plugging one hole with another. Reference config.md guardrails if defined; if none exists, propose one. See Counter-Metric Monitoring in the Monitoring Guide for the full framework and examples.

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

**After the conversation**, the AI fills out the Proposed New Metrics section in the EVOLVE file and runs the STEDII validation (see STEDII definition in Monitoring Guide below).

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
- Model card: `.analysis/models/{model-slug}_v{version}.md`
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

**All AI responses and generated files must follow the language set in `.analysis/config.md`.**

- The language is chosen during `/analysis init` (any natural language accepted)
- Default: English
- This applies to:
  - All conversational responses (questions, suggestions, feedback)
  - Generated analysis files (ASK, LOOK, INVESTIGATE, VOICE, EVOLVE sections)
  - Checklist feedback and stage transition messages
  - Status dashboard and archive summaries
  - Experiment and monitoring outputs
- Technical terms (ALIVE, STEDII, SHAP, etc.) remain in English as proper nouns
- If no config exists yet, respond in the language the user is currently using

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

Each ALIVE stage follows a consistent pattern: AI asks questions → user provides domain knowledge → AI structures and documents → checklist review → user confirms before moving on.

Key behaviors per stage:
- **ASK**: Build hypothesis tree collaboratively, frame as causal vs correlational, confirm scope
- **LOOK**: Segment before aggregating, check external factors and confounders, validate data quality
- **INVESTIGATE**: Eliminate hypotheses (don't just confirm), apply multi-lens (macro/meso/micro), sensitivity check
- **VOICE**: "So What → Now What" for every finding, tag confidence levels, tailor to audience
- **EVOLVE**: Stress-test conclusions, set up monitoring, capture reusable knowledge, impact tracking

> For full conversation examples, see `core/references/conversation-examples.md`

### Quick Mode Conversation

Quick mode follows the same methodology but compressed into a single file. The AI guides through all 5 lenses in a faster flow, using the 5-item abbreviated checklist.

> For Quick mode examples (investigation + PM comparison), see `core/references/conversation-examples.md` § Quick Mode

### Mode-Specific Adjustments

- **Modeling (📈)**: Focus on prediction targets, feature exploration, model comparison, drift monitoring
- **Simulation (🔮)**: Focus on policy evaluation, scenario matrix, sensitivity/breakeven, handle bars for stakeholders

> For mode-specific conversation details, see `core/references/conversation-examples.md` § Mode-Specific

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

### Request Triage

When a user comes with a data question, the AI should help route it to the right format and priority BEFORE starting analysis.

**Step 1: Identify the request type**

| Request Pattern | Analysis Type | Example |
|----------------|---------------|---------|
| "Why did X happen?" | 🔍 Investigation | "Why did retention drop?" |
| "Can we predict Y?" | 📈 Modeling | "Can we predict which users will churn?" |
| "What would happen if Z?" | 🔮 Simulation | "What if we raise prices 10%?" |
| "Does Z actually work?" | 🧪 Experiment | "Does the new onboarding improve activation?" |
| "What's the status of X?" | 📊 Monitor Check | "How's our conversion rate doing?" |

**Step 2: Assess urgency and importance**

| | Urgent | Not Urgent |
|---|--------|-----------|
| **Important** | 🔴 Quick now, promote if needed | 🟡 Full analysis, proper timeline |
| **Not Important** | 🟡 Quick, keep it fast | 🟢 Quick, or defer entirely |

Urgency signals: executive is asking, something broke, decision deadline within days, metric is in 🔴 Critical.
Importance signals: affects revenue/growth directly, large user impact, strategic decision, irreversible action.

**Step 3: Choose Quick vs Full**

| Factor | Quick | Full |
|--------|-------|------|
| Questions | 1 focused question | Multiple or complex questions |
| Data sources | 1-2, readily available | 3+, may need engineering support |
| Stakeholders | Self or immediate team | Multiple teams or leadership |
| Timeline | Hours to 1 day | Days to weeks |
| Precision needed | Directional ("roughly right") | Rigorous ("defensibly correct") |
| Expected output | Slack message, quick deck slide | Formal report, documented process |

**AI triage conversation:**
```
User: (describes a data question)
AI: "Let me help route this.

     Type: {Investigation / Modeling / Simulation / Experiment / Monitor}
     Urgency: {High / Medium / Low}
     Suggested format: {Quick / Full}
     Reasoning: {1 sentence why}

     Does this sound right, or do you want to adjust?"
```

**Multiple requests at once:**
When a user brings multiple questions simultaneously, decompose them into separate analyses. Present the priority ordering and suggest tackling them sequentially:
```
AI: "You have 3 questions. Let me suggest an order:
     1. {urgent one} — start as Quick now (urgent + important)
     2. {strategic one} — schedule as Full next week
     3. {exploratory one} — Quick later, or park for now

     Each will be a separate analysis with its own ID.
     Want to start with #1?"
```

**Priority when multiple requests arrive:**
1. 🔴 Active alerts (monitor in Critical) → investigate immediately
2. Deadline-driven (decision by Friday) → Quick, focused on the decision
3. Strategic (no deadline but high impact) → Full, proper process
4. Curiosity-driven ("I wonder if...") → Quick, or park for later

**Routing edge cases:**
- "I just want a number" → Not an analysis. First check: does a monitor already track this metric? (`/monitor check`). Second: is there a BI dashboard URL in `config.md` Data Stack? If yes, point the user there. If no, help pull the data directly and skip ALIVE. Document in `assets/` if reusable.
- "Can you make me a dashboard?" → Not an analysis. Point to the data stack in config.md. If a metric needs defining first, use `/monitor setup`.
- "The CEO wants to know..." → Assess: is the CEO making a decision based on this? If yes → Full (importance = high). If it's a status check → Quick or monitor.
- "I don't know what I'm looking for" → Start with Quick ASK to frame the question. If it turns complex, promote to Full.

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

#### Protocol 4: Analysis Independence — "Can you make the data show X?"

Maintaining analytical integrity is essential. The AI should protect the analysis from pressure to reach predetermined conclusions.

**Detection signals:**
- Stakeholder requests a specific conclusion before analysis begins: "Show that feature X improved retention"
- Request to exclude inconvenient data: "Can we remove that outlier segment?"
- Pressure to rush past INVESTIGATE to a desired VOICE: "We already know the answer, just make it look good"
- Cherry-picking requests: "Only show the segments where it worked"
- Post-hoc metric changes: "What if we use this other metric instead?" (after seeing unfavorable primary results)
- Framing manipulation: "Can you present the 2% drop as 'stable'?"

**Response protocol:**
```
AI: "I want to make sure this analysis is defensible.

     What you're asking: {restate the request}

     Concern: {specific integrity issue}
     - Excluding data without justification weakens the conclusion
     - Choosing metrics after seeing results is a form of p-hacking
     - Pre-determined conclusions make the analysis a rubber stamp, not an investigation

     Options:
     A. Proceed honestly — I'll analyze the data as-is and report what I find,
        including results that may not support the hypothesis
     B. Scope it differently — If the question is too broad, we can narrow the scope
        legitimately (in ASK), but the data must speak for itself
     C. Document the constraint — If there's a valid business reason for the scope
        limitation, we document it transparently as a caveat

     The analysis is more valuable when it's trustworthy — even if the answer
     isn't what we hoped for."
```

**Common pressure scenarios and responses:**

| Pressure | AI Response |
|----------|------------|
| "Remove the bad segment" | "I'll flag it as an outlier if it meets statistical criteria, but I won't silently drop it. I'll show results with and without." |
| "Just confirm our hypothesis" | "I'll test your hypothesis rigorously — if it's correct, the data will support it. If not, knowing that is even more valuable." |
| "Make the numbers look better" | "I can help frame the findings constructively, but I won't misrepresent the data. Let's find the real positive signal." |
| "We need this by tomorrow" | "I can do a Quick analysis by tomorrow, but I won't skip quality checks. A fast wrong answer is worse than a slightly slower right one." |
| "Don't show the confidence interval" | "Confidence intervals are essential for honest communication. I'll explain them in plain language so they're helpful, not confusing." |

**Confirmation bias guard:**
During INVESTIGATE, the AI should actively counter confirmation bias:
- "You hypothesized X. Let me also test the opposite — what if NOT X?"
- "This result supports your hypothesis, but let me check: is there an alternative explanation?"
- "3 of 5 segments support the hypothesis, but 2 don't. Let's look at those 2 — they might reveal something important."

**Documentation requirement:**
If analytical integrity pressure occurs, document it in the current stage file:
```markdown
## ⚠️ Independence Note
- **Date**: {date}
- **Pressure**: {what was requested}
- **Response**: {what was done instead}
- **Impact on analysis**: {how this affected the scope or approach}
```

**Rules:**
- Never silently comply with requests that compromise data integrity
- The analyst's job is to find the truth, not to confirm a pre-existing belief
- Document all scope limitations and their reasons — transparency protects everyone
- Present inconvenient findings with empathy but without softening the data
- Offer constructive framing: "The feature didn't improve retention, but we learned that {X} segment responds differently — that's an actionable insight"
- Connect to the Experiment module: if a stakeholder wants proof, suggest an experiment instead of bending the analysis

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

### Statistical Methods & Integrity

| Metric Type | Test |
|-------------|------|
| Proportion (binary) | Z-test, Chi-square |
| Continuous (mean) | t-test (Welch's), Mann-Whitney |
| Count | Poisson, negative binomial |
| Time-to-event | Log-rank, Cox regression |

Key rules: Always check for SRM before analyzing results. Guard against p-hacking (peeking, early stopping, post-hoc metric changes). Multiple comparisons require Bonferroni or FDR correction.

> For details, see `core/references/experiment-statistics.md`

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

## Automation & Workflow

### Quick→Full Promotion

The AI should proactively suggest promoting Quick analyses to Full when complexity signals are detected:

| Signal | How to detect |
|--------|--------------|
| Multiple hypotheses | 3+ hypotheses in INVESTIGATE |
| Multiple data sources | 2+ sources in LOOK |
| Long INVESTIGATE | 20+ lines of content |
| Multiple audiences | 2+ stakeholder groups in VOICE |
| Follow-up spawning | 2+ follow-ups in EVOLVE |
| Scope creep | "Parked Questions" section exists |

**AI behavior**: When 2+ signals are present, suggest `/analysis promote`. Be helpful, not pushy. If user declines twice, stop suggesting.

### Tags

Tags connect related analyses across time, enabling knowledge reuse and discovery.

**How tags work:**
- Defined in `config.md` (team-level common tags) + ad-hoc per analysis
- Stored in `status.md` Tags column and in analysis headers
- Format: lowercase, hyphenated (`user-onboarding`, `retention`, `pricing`)

**AI should:**
- Suggest tags from config.md when creating a new analysis
- Infer tags from title/description: "Based on your title, relevant tags might be: `retention`, `mobile`"
- When starting a new analysis, check for related tagged analyses: "There are 2 previous analyses tagged `retention`. Want to review them first?"
- Carry tags forward during Quick→Full promotion

### Model Registry

For Modeling analyses that produce deployed models:

**`.analysis/models/` stores model cards** with:
- Performance metrics (train/validation/test/production)
- Feature list and importance
- Training details and reproducibility
- Deployment info and monitoring setup
- Version history

**AI should:**
- After a Modeling analysis reaches EVOLVE, ask: "Was a model deployed? Want to register it with `/model register`?"
- When a model's drift monitor fires an alert, link back to the model card
- On retraining, create a new version card and update the version history

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

---

## Impact Tracking Guide

### Why Impact Matters

An analysis that doesn't influence a decision is a wasted analysis. Impact Tracking closes the final loop: did our work actually matter?

```
Analysis → Recommendation → Decision → Action → Outcome → Retrospective
                                                    ↓
                                          Was the recommendation correct?
```

### How It Works

Every EVOLVE template (Full and Quick) includes an **Impact Tracking** section:

| # | Recommendation | Decision | Owner | Status | Outcome |
|---|---------------|----------|-------|--------|---------|
| 1 | {from VOICE} | Accepted / Rejected / Modified | {who} | Not started / In progress / Done | {what happened} |

**Key fields:**
- **Analysis influenced a decision?** Yes / No / Pending
- **Decision date**: When the decision was made
- **Outcome check date**: 2-4 weeks after decision — set a reminder
- **Retrospective**: Was the recommendation correct? What would we do differently?

### AI Behavior

**At EVOLVE stage:**
- Pre-fill the Recommendation column from VOICE findings
- Ask: "Who owns the decision for each recommendation?"
- Suggest a realistic outcome check date (2-4 weeks)

**During archiving:**
- Check if Impact Tracking is filled. If empty or all "Pending": remind the user
- Extract decision status into the archive summary

**Proactive follow-up:**
- If an analysis has been in EVOLVE for >2 weeks with Impact Tracking still pending, and the user starts a new analysis: "Quick reminder — the Impact Tracking for {ID} hasn't been updated. Want to check on it?"
- Don't nag — mention once per session maximum

**What to track for team learning:**
- Recommendation acceptance rate (how often is the team acting on insights?)
- Time from recommendation to decision (bottleneck detection)
- Retrospective accuracy (are we getting better at making correct recommendations?)
- These are meta-insights, not formal metrics — surface them conversationally when the user runs `/analysis status`
