# Rubric: b2-onboarding-comparison

**Total: 100 points**

---

## ASK — 20 points

| Criterion | Points | What to Look For |
|-----------|--------|------------------|
| Correct framing as Comparison (not Causation) | 5 | Learner explicitly labels this as a Comparison question; does not say "why is Flow B higher" |
| Identifies primary metric | 5 | Signup completion rate named as the metric to evaluate |
| Identifies counter-metric need | 5 | Explicitly asks: "does higher signup rate mean better users?" or names D7/D30 activation, retention, or user quality as a check |
| Clear scope and deadline | 5 | States the time period (Jan 27–Feb 9), both flows, and acknowledges the 2-day delivery constraint |

**Common mistakes to flag**:
- Treating this as a Causation question ("why is Flow B better") — subtract 3pts and explain the difference
- Optimizing for only one metric without asking about user quality — subtract 3pts, explain counter-metric concept

---

## LOOK — 20 points

| Criterion | Points | What to Look For |
|-----------|--------|------------------|
| Breaks down results by acquisition channel | 8 | Shows or describes per-channel results (Organic, Paid IG, Paid Google), not just the overall 32% vs. 38% |
| Explicitly checks for Simpson's Paradox | 5 | Notes that overall trend could be driven by channel mix; verifies that Flow B wins within each channel |
| Notes sample size differences across segments | 4 | Flags that Paid Google (n=1,750) is much smaller than Organic (n=6,000) and should be treated with more caution |
| Checks and clears external factors | 3 | Notes no holidays, no product changes, no tracking changes during the test period |

**Common mistakes to flag**:
- Stopping at overall numbers (32% vs 38%) without segmentation — subtract 5pts, explain Simpson's Paradox
- Not noting the non-random assignment (routing by channel) — subtract 2pts, explain why this matters for interpretation

---

## INVESTIGATE — 25 points

| Criterion | Points | What to Look For |
|-----------|--------|------------------|
| Requests and analyzes D7 activation data | 8 | Pulls D7 activation rates for both flows; does not stop after signup rate |
| Identifies that Flow A wins on D7 activation in every segment | 7 | Per-segment activation comparison (not just overall 45% vs 42%); notes that Flow A wins consistently |
| Identifies the mechanism (phone verification step) | 6 | Connects the signup improvement to the removal of mandatory phone verification; notes the 35% step drop-off in Flow A |
| Checks for Simpson's Paradox in activation data | 4 | Confirms that the activation gap is consistent per segment (not reversed or inflated by mix) |

**Common mistakes to flag**:
- Concluding "Flow B wins" from signup data alone without checking activation — subtract 6pts, explain counter-metric analysis
- Noting overall activation gap (-3pp) but not checking per-segment consistency — subtract 3pts
- Identifying the activation gap but not explaining the mechanism — subtract 3pts

---

## VOICE — 20 points

| Criterion | Points | What to Look For |
|-----------|--------|------------------|
| Presents both findings without suppressing one side | 7 | Explicitly names the trade-off: Flow B converts better (+6pp) AND activates slightly worse (-1 to -3pp per segment) |
| Clear, actionable recommendation with a condition | 7 | Recommends shipping Flow B AND specifies a monitoring trigger (e.g., "if D7 drops >3pp, add optional phone verification back") |
| Confidence calibrated separately for each finding | 6 | High confidence for signup improvement; Medium confidence for activation gap; states the reasoning for each |

**Common mistakes to flag**:
- Recommending against Flow B because of the activation gap — this overcalibrates the caution; subtract 3pts
- Recommending Flow B with no mention of the activation gap — this under-reports the risk; subtract 3pts
- Stating "High confidence" for the activation gap without acknowledging the smaller sample sizes — subtract 2pts

---

## EVOLVE — 15 points

| Criterion | Points | What to Look For |
|-----------|--------|------------------|
| Specifies a counter-metric monitoring plan | 6 | Names D7 activation (and ideally D30 retention) as the metric to watch post-launch; gives a threshold (e.g., >3pp drop) |
| Sets a follow-up timeline | 5 | States when to review (e.g., weekly for 4 weeks, then monthly); not just "we'll check later" |
| Captures a reusable insight | 4 | Generalizes beyond this scenario: e.g., "mandatory phone verification is a friction point everywhere; consider making it optional across all product touchpoints" |

**Common mistakes to flag**:
- No monitoring plan after recommending shipping — subtract 4pts
- Monitoring plan with no threshold or timeline — subtract 2pts
- No reusable insight captured — subtract 2pts

---

## Scoring Guide

| Score | Interpretation |
|-------|----------------|
| 90–100 | Excellent — nuanced trade-off framing, consistent segment analysis, well-calibrated confidence |
| 75–89 | Good — solid methodology with minor gaps (e.g., Simpson's Paradox noted but not checked per-segment) |
| 60–74 | Adequate — correct direction but missing counter-metric or per-segment analysis |
| 45–59 | Developing — signup improvement identified but activation gap missed entirely |
| Below 45 | Needs review — framing or segmentation errors, recommend revisiting ALIVE loop basics |

---

## Most Common Mistakes at Beginner Level

1. **Concluding "Flow B wins" from signup data alone** — Not requesting or analyzing D7 activation as a counter-metric. The PM asked about signups, but a good analyst checks whether those signups become real users.

2. **Not checking Simpson's Paradox** — Accepting the aggregate +6pp without verifying it holds per channel. In this scenario it does hold, but the CHECK is the skill being tested.

3. **Framing as causation instead of comparison** — Saying "Flow B caused better signups" when the correct framing is "which flow is better?" Causation requires an experiment design evaluation; comparison requires consistent measurement.

4. **Missing the mechanism** — Noting the improvement without identifying that mandatory phone verification (35% drop-off) is the specific friction point. Without the mechanism, you can't generalize the insight.

5. **No monitoring trigger** — Recommending "ship Flow B" without setting a condition for when to re-evaluate (e.g., D7 activation drops >3pp).
