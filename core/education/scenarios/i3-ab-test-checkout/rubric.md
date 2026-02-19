# Rubric: i3-ab-test-checkout — "Did the new checkout flow actually improve conversion?"

> **Total**: 100 points | **Difficulty**: Intermediate | **Format**: Full (5 files)
>
> Intermediate-level expectations: experiment validity is checked before interpreting results, guardrail metrics are evaluated alongside the primary metric, segmentation reveals the true story, and the recommendation is nuanced (not binary). Accepting the headline number without scrutiny will not reach passing score.

---

## ASK (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Experiment framing | 5 | Question framed as experiment evaluation (not investigation). Explicitly distinguishes "is the test valid?" from "is the result significant?" Decision context stated (ship/kill/extend/iterate). |
| Metrics identification | 5 | Primary metric (checkout conversion rate) clearly defined. Guardrail metrics specified: AOV, revenue per user, checkout error rate. Not just "conversion." |
| Validity criteria | 5 | Evaluation framework includes randomization check, sample size vs power analysis, runtime adequacy, and SUTVA. These must be listed before the test starts, not discovered reactively. |
| Hypothesis | 5 | Clear null hypothesis (no difference) and alternative (2-step improves conversion). Decision criteria defined: what evidence is needed to ship vs kill vs extend? |

**Common mistakes at Intermediate level**:
- Framing as "investigate why conversion changed" instead of "evaluate whether the experiment is valid"
- Defining only the primary metric without guardrails
- Not specifying validity checks (randomization, sample size, runtime) as explicit evaluation steps
- Jumping straight to results without an evaluation framework

---

## LOOK (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| SRM detection | 8 | The 48,700/51,300 split identified as a problem. Chi-square test performed (or equivalent). SRM confirmed as statistically significant (p < 0.001). Explicitly states that the overall result cannot be trusted until SRM is explained. |
| Sample size verification | 4 | Both groups checked against the pre-test power analysis (42,000 required per group). Confirmed that sample size is sufficient — the issue is bias, not power. |
| Power analysis check | 4 | MDE (3% relative) compared to observed lift (6.4%). Runtime (21 days) compared to required (18-21 days). Both checks pass, ruling out "test was too short" or "test was underpowered." |
| Data quality | 4 | PM's headline number (8%) verified against actual data (6.4%). Denominator discrepancy identified. Daily assignment pattern examined — weekend skew noted. |

**Common mistakes at Intermediate level**:
- Not calculating SRM — accepting the 48.7/51.3 split as "close enough to 50/50"
- Seeing the p-value of 0.018 and concluding "significant, ship it" without checking randomization first
- Not verifying the PM's headline number against the raw data
- Ignoring the daily assignment pattern that reveals the SRM mechanism

---

## INVESTIGATE (25 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Device segmentation | 7 | Results segmented by mobile and desktop. Mobile +22.3% (p=0.002) identified as the real signal. Desktop +3.2% (p=0.41) identified as not significant. Conclusion: aggregate lift is driven by mobile. |
| AOV guardrail violation | 6 | Average order value drop of -10% (68,000 KRW to 61,200 KRW, p=0.01) identified. Revenue per checkout entrant calculated: -4.3% despite higher conversion. Mechanism explained (less cart review time in 2-step flow). |
| Novelty effect | 6 | Week-over-week lift decline documented (Week 1: +15.6%, Week 2: +7.1%, Week 3: +0.6%). Pattern identified as novelty decay. Conclusion: 3-week aggregate is inflated; Week 3 is the better predictor of long-term performance. |
| SRM root cause | 6 | Caching bug in experimentation platform identified. Returning visitor enrichment in Variant documented (58.3% vs 54.6%). Connection to higher baseline conversion for returning visitors (~18% vs ~12%) explained. Weekend skew pattern linked to cookie expiration behavior. |

**Common mistakes at Intermediate level**:
- Not segmenting by device — treating the aggregate as the whole story
- Checking conversion only, not guardrail metrics like AOV
- Not looking at the time series — missing the novelty decay pattern
- Identifying SRM but not investigating the root cause
- Not calculating revenue impact (conversion x AOV)

---

## VOICE (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| No-ship recommendation with reasoning | 6 | Clear recommendation: do not ship to 100%. Three reasons stated: SRM invalidity, AOV guardrail violation, novelty effect. Not just "the test failed" — explains why each issue matters for the decision. |
| Mobile-specific finding | 5 | Mobile signal (+22.3%) highlighted as worth pursuing. Acknowledges it is partially confounded by SRM but the effect size is large enough to warrant a re-test. Proposes mobile-only re-test or mobile-only launch with monitoring. |
| Stakeholder communication | 5 | At least 3 distinct messages tailored to different audiences (PM, CFO, Engineering). Messages differ in content and framing, not just length. PM gets the decision and timeline. CFO gets the revenue math. Engineering gets the technical bug details. |
| Confidence levels | 4 | Confidence levels assigned with reasoning: High for SRM/AOV/novelty findings. Medium for mobile signal (real but confounded). Reasoning provided, not just labels. |

**Common mistakes at Intermediate level**:
- Recommending "launch" because p < 0.05, ignoring SRM and guardrails
- Recommending "kill" without acknowledging the mobile signal
- Writing one generic message for all stakeholders
- Not providing confidence levels with reasoning
- Not connecting the AOV drop to the spring sale campaign risk

---

## EVOLVE (15 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Re-test plan | 5 | Specific re-test design: fix caching bug first, mobile-only or full with SRM monitoring, 4+ week duration, novelty burn-in (exclude or flag Week 1), AOV as hard guardrail (auto-pause threshold). Not vague "run another test" — specific parameters. |
| Monitoring setup | 5 | At least 3 metrics with specific thresholds, cadence, and owners. Must include SRM check (daily, automated), AOV by group (daily), and novelty trend (weekly). |
| Reusable framework | 5 | At least 3 generalizable patterns documented. Should include: SRM check as first step, novelty assessment method, guardrail override principle. Bonus: reusable experiment evaluation checklist template. |

**Common mistakes at Intermediate level**:
- Re-test plan without addressing the SRM root cause (the caching bug)
- Monitoring plan without specific thresholds or owners
- No novelty burn-in strategy in the re-test design
- Reusable knowledge that is too specific to ShopNow instead of generalizable experiment evaluation principles
- No impact tracking table linking recommendations to decisions and outcome check dates

---

## Score Interpretation

| Score | Level | Meaning |
|-------|-------|---------|
| 90-100 | Excellent | Ready for Advanced scenarios. Thorough experiment evaluation with all validity checks, clear reasoning, and actionable re-test plan. |
| 75-89 | Proficient | Solid Intermediate work. Caught the major issues (SRM, AOV, or novelty) but may have missed one. Review missed criteria and retry one stage. |
| 60-74 | Developing | Key gaps in experiment evaluation methodology. Likely missed SRM or accepted the headline result. Re-read hints Level 2 and retry. |
| Below 60 | Needs work | Consider revisiting b1/b2 Beginner scenarios and reading about A/B test evaluation fundamentals. |

---

## Most Common Mistakes at Intermediate Level

1. **Ignoring the SRM and accepting the 8% headline**: The most frequent mistake. The 48.7/51.3 split looks "close enough" to many learners. In reality, for 100,000 users, this deviation is highly statistically significant (p < 0.001). Always run a chi-square test on sample counts as the first step of any A/B test evaluation.

2. **Not segmenting by device**: The aggregate +6.4% hides two completely different stories. Mobile (+22.3%, significant) and desktop (+3.2%, not significant) require different decisions. Learners who stop at the aggregate miss the most actionable finding.

3. **Missing the AOV guardrail violation**: Conversion is the PM's favorite metric, but AOV is the CFO's. A +6% conversion lift with a -10% AOV drop is a net negative for the business. Learners who celebrate the conversion win without checking guardrails make the same mistake as the PM.

4. **Recommending launch despite a flawed test**: Even learners who notice the SRM sometimes recommend "ship it anyway because the p-value is significant." A significant p-value in the presence of SRM is meaningless — the groups are not comparable. The correct response is to fix the randomization and re-test.

5. **Not connecting the novelty effect to sustained impact**: The +15.6% Week 1 lift is eye-catching, but the +0.6% Week 3 lift is the real signal. Learners who report the 3-week aggregate without examining the temporal trend overstate the expected long-term benefit. Always check whether the treatment effect is stable or decaying over time.

---

## Self-Assessment Checklist

Before scoring yourself, confirm:
- [ ] I framed this as an experiment evaluation, not an investigation
- [ ] I detected the SRM and stated that the overall result is unreliable
- [ ] I segmented by device and found the mobile vs desktop difference
- [ ] I checked guardrail metrics and identified the AOV drop
- [ ] I assessed the novelty effect using the time series data
- [ ] I recommended NOT shipping to 100% with clear reasoning
- [ ] I proposed a re-test plan that addresses the SRM root cause
- [ ] I wrote distinct messages for at least 3 stakeholders
- [ ] I set up monitoring with specific thresholds and owners
- [ ] I captured at least 3 reusable patterns for the team
