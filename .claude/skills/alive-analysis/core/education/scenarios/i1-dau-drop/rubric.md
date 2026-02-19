# Rubric: i1-dau-drop — "Why did DAU drop 15%?"

> **Total**: 100 points | **Difficulty**: Intermediate | **Format**: Full (5 files)
>
> Intermediate-level expectations: hypotheses are comprehensive, contributions are quantified, audience messages are differentiated, and monitoring plans are specific. Vague or single-hypothesis answers will not reach passing score.

---

## ASK (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Hypothesis tree completeness | 8 | 5+ branches across internal, external, and data artifact categories. Missing any major branch (e.g., no data artifacts, no external factors) = -3 pts each. |
| Causal framing | 4 | Question explicitly framed as causation, not correlation. Decision context stated ("determines sprint priority"). |
| Multi-lens scope plan | 4 | Plan explicitly includes macro (market/holiday), meso (infra/product), and micro (user segment) lenses. |
| Success criteria | 4 | Clear definition of "done" — includes contribution quantification, confidence levels, and a sprint/action recommendation. |

**Common mistakes at Intermediate level**:
- Listing only 2-3 hypotheses and jumping to data
- Framing success as "find the root cause" without specifying confidence or contribution
- Omitting data artifact hypotheses (bot filter, GA4 migration)

---

## LOOK (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Platform segmentation | 5 | iOS, Android, Web broken out. Android -23.6% identified as outlier vs iOS/Web -7.7%. |
| Channel segmentation | 5 | Organic, Push, Paid broken out. Push -37.1% identified. Paid 0% as signal of no market-wide issue. |
| Data quality check | 5 | Bot filter impact quantified (~2K sessions, ~1.7% of drop). GA4 migration verified clean. |
| External factors assessed | 5 | Lunar New Year: consistent with organic drop but not Android push collapse or post-holiday persistence. Competitor: no acquisition signal. Snowstorm: local, minor. |

**Common mistakes at Intermediate level**:
- Looking only at total DAU without segmenting
- Missing the channel segmentation (the key insight that push collapsed)
- Not quantifying the bot filter impact
- Accepting holiday as the full explanation without checking if the drop persisted past Feb 4

---

## INVESTIGATE (25 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Push failure confirmed with mechanism | 8 | Delivery rate data cited (94% → 61%), timing verified (migration completion → delivery drop → DAU drop), iOS control group used. |
| Contribution estimates quantified | 7 | Push ~60%, holiday ~25%, bot ~10%, residual ~5%. Estimates may vary ±10% — must sum to ~100% with reasoning. |
| Eliminated hypotheses justified | 5 | Competitor: paid acquisition and uninstall data cited. App update: iOS/Web also got v3.2, unaffected. Clear evidence-based rejection. |
| Sensitivity analysis | 5 | At least two checks: extended window (Feb 14 shows push still depressed), bot filter exclusion (13.3% vs 15%), or historical LNY comparison. |

**Common mistakes at Intermediate level**:
- Stopping at "push broke" without quantifying how much of the 15% it explains
- Not testing the competitor or app update hypotheses with evidence
- Missing that holiday explains the organic segment dip but not the Android push persistence
- No sensitivity analysis (this is required at Intermediate level)

---

## VOICE (20 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Finding-specific "So What → Now What" | 6 | Each major finding has a business impact statement and at least one concrete action option. Not just "we should investigate further." |
| Audience-tailored messages | 8 | Three distinct messages: CEO (1 sentence, verdict + timeline), Engineering (specific system/file/mechanism), Product (sprint decision + recovery expectation). Messages must differ in content, not just length. |
| Confidence with reasoning | 3 | Confidence levels stated with reasoning, not just a label. "High — because iOS is an unaffected control group" is better than just "High." |
| Limitations acknowledged | 3 | At least 2 honest limitations stated (contribution estimates are approximations, some users may not return, competitor impact may manifest later). |

**Common mistakes at Intermediate level**:
- Writing one generic message and calling it "stakeholder communication"
- Not providing a specific action for Engineering (e.g., which system, which component)
- Omitting limitations — at Intermediate level, first-class limitations are expected
- Confidence levels without reasoning

---

## EVOLVE (15 pts)

| Criterion | Points | Expectations |
|-----------|--------|-------------|
| Monitoring plan with specifics | 6 | At least one metric with a specific threshold, cadence, and named owner. "Watch DAU" is not enough. |
| Stress-test questions | 3 | At least one credible falsification condition ("what would disprove our conclusion?"). At least one unverified assumption surfaced. |
| Reusable knowledge captured | 3 | At least 2 generalizable patterns documented for the team (not scenario-specific learnings). |
| Impact tracking setup | 3 | Recommendations from VOICE linked to decisions, owners, and outcome check dates. At least 2 entries. |

**Common mistakes at Intermediate level**:
- Monitoring plan without a threshold or owner
- No follow-up questions about process gaps (why wasn't push delivery monitored?)
- Reusable knowledge that's too scenario-specific ("check push delivery for ShopFlow") rather than generalizable ("check push delivery rate in any DAU investigation")
- Impact tracking table left blank or filled with placeholders

---

## Score Interpretation

| Score | Level | Meaning |
|-------|-------|---------|
| 90-100 | Excellent | Ready for Advanced scenarios. Analysis is thorough, quantified, and well-communicated. |
| 75-89 | Proficient | Solid Intermediate work. Review missed criteria and retry one stage. |
| 60-74 | Developing | Key gaps in quantification or communication. Re-read hints Level 2 and retry. |
| Below 60 | Needs work | Consider revisiting b1/b2 Beginner scenarios first. |

---

## Self-Assessment Checklist

Before scoring yourself, confirm:
- [ ] My hypothesis tree has 5+ branches across all three categories
- [ ] I segmented by both platform AND channel (not just one)
- [ ] I quantified each factor's contribution as a percentage
- [ ] I wrote three distinct audience messages (CEO / Engineering / Product)
- [ ] I provided a monitoring plan with a specific threshold and owner
- [ ] I captured at least 2 reusable patterns for the team
