# EVOLVE — Did the New Checkout Flow Actually Improve Conversion?
> ID: L-i3-ab-test-checkout | Mode: Learn | Stage: EVOLVE | Difficulty: Intermediate | Updated: 2026-02-12

> **Reference Solution** — This is the expected output for the EVOLVE stage. Compare your own 05_evolve.md against this after completing the stage.

## Conclusion Robustness Check
- **What would disprove our conclusion?** If a clean re-test (with the caching bug fixed) still shows a +6% lift across all users with no AOV drop, our recommendation to not ship was too conservative. We would revisit.
- **Unverified assumption**: The mobile +22.3% effect is real and not entirely driven by the SRM composition bias. A clean re-test is needed to confirm.
- **Weakest point**: We cannot precisely separate "treatment effect" from "SRM bias" in the current data. The true mobile effect could be anywhere from +10% to +22%.
- **What would make us say "we were wrong" in 3 months?** If a competitor ships a similar 2-step checkout and captures significant market share while we are still testing. Speed matters in competitive markets, and our caution has an opportunity cost.

## Reflection
- **What went well**: Catching the SRM before the PM shipped the change. If the checkout had gone live before the spring sale with a 10% AOV drop, the revenue impact would have been significant.
- **What could be improved**: The experimentation platform should have flagged the SRM automatically. Running a 3-week test without a daily SRM check is a process gap.
- **What surprised us**: The novelty effect was dramatic — from +18% on Day 1 to near-zero by Day 21. This reinforces the principle that short A/B tests can be dangerously misleading.

## Re-Test Plan

### Design
| Parameter | Value | Rationale |
|-----------|-------|-----------|
| Target population | Mobile users only (initially) | Strongest signal, faster sample accumulation |
| Traffic split | 50/50 | With daily SRM monitoring |
| Duration | 4 weeks minimum | Account for novelty decay + 2 full weekly cycles |
| Novelty burn-in | Exclude Week 1 from primary analysis | Analyze Week 2-4 as the steady-state signal |
| Primary metric | Mobile checkout conversion rate | Same as original |
| Guardrail: AOV | Hard gate: auto-pause if AOV drops > 5% | Prevent revenue loss |
| Guardrail: Revenue/user | Must remain flat or positive | Net business impact |
| Guardrail: Error rate | Must not increase > 0.5 pp | Quality |
| SRM check | Automated daily chi-square test (alert if p < 0.05) | Catch randomization issues early |
| Prerequisites | Caching bug in experimentation platform v2.1 MUST be fixed first | Non-negotiable |

### Timeline
| Date | Milestone |
|------|-----------|
| Feb 3-7 | Engineering fixes caching bug + unit tests |
| Feb 10-14 | QA the fix with a dummy A/A test (both groups get same experience, verify 50/50 split) |
| Feb 17 | Launch mobile-only re-test |
| Mar 16 | 4 weeks complete; analyze Week 2-4 data |
| Mar 18 | Decision: ship mobile / extend / kill |

## Monitoring Plan

| Metric | Target | Warning | Critical | Cadence | Owner |
|--------|--------|---------|----------|---------|-------|
| SRM (chi-square p-value) | > 0.05 | < 0.05 | < 0.01 | Daily (automated) | Engineering |
| Mobile checkout CVR (Variant lift) | > +5% (Week 2+) | < +3% | Negative | Weekly | Data team |
| Average Order Value (Variant vs Control) | Within -5% | < -5% | < -8% | Daily | Data team |
| Revenue per mobile checkout entrant | Flat or positive | < -3% | < -5% | Weekly | Data team |
| Novelty trend (rolling 7d lift vs cumulative) | Stable or increasing | Declining >2pp/week | Declining >5pp/week | Weekly | Data team |

## Follow-up Questions
1. Does the experimentation platform caching bug affect other active tests? Audit all currently running experiments for SRM.
2. Can the 2-step flow be modified to include a cart summary, preserving the speed benefit while reducing the AOV drop?
3. Is the mobile vs desktop difference in treatment effect driven by screen size, or by user type (mobile users may be more purchase-intent)?
4. What is the long-term AOV trajectory? Does it stabilize or continue to decline as users get accustomed to the shorter flow?

## Follow-up Analysis Proposals
- [ ] A/A test to validate experimentation platform fix — run for 1 week with same traffic split, verify SRM is resolved — (scheduled Feb 10-14)
- [ ] Mobile-only re-test with AOV guardrail — 4-week test with clean randomization — (scheduled Feb 17)
- [ ] Cart summary UX exploration — Design team to prototype a 2-step flow with an inline cart review — (proposed to Design Lead)

## Impact Tracking

| # | Recommendation | Decision | Owner | Status | Outcome |
|---|---------------|----------|-------|--------|---------|
| 1 | Do NOT ship to 100% before spring sale | Accepted | PM (Jiyeon) | Done | Spring sale launched with current 4-step checkout |
| 2 | Fix experimentation platform caching bug | Accepted | Engineering (Minho) | In progress (Feb 3) | — |
| 3 | Run A/A validation test after bug fix | Accepted | Data team | Scheduled (Feb 10) | — |
| 4 | Re-run mobile-only test with AOV guardrail | Accepted | Data team + PM | Scheduled (Feb 17) | — |
| 5 | Add daily SRM monitoring to experimentation platform | Accepted | Engineering | In progress | — |

- **Analysis influenced a decision?** Yes — prevented a potentially revenue-negative 100% rollout during the spring sale campaign
- **Decision date**: Feb 5, 2026 (Wednesday product review)
- **Outcome check date**: Mar 18, 2026 (after re-test completes)

## Reusable Knowledge
- **Always check SRM before interpreting A/B test results**: A significant p-value on the primary metric is meaningless if the randomization is broken. SRM detection (chi-square test on sample counts) should be the FIRST check in any experiment evaluation, not an afterthought.
- **Novelty effect is real and common in UX experiments**: Any UI change can produce a temporary lift simply because it is new. Run tests for at least 3-4 weeks, and compare Week 1 vs Week 3+ lift to assess novelty decay. Consider excluding Week 1 from the primary analysis.
- **Guardrail metrics can override a winning primary metric**: A +6% conversion lift is meaningless if AOV drops 10% and net revenue declines. Always define guardrail metrics (AOV, revenue/user, error rate) before the test starts, with explicit thresholds for what constitutes a violation.
- **Segment before you aggregate**: The aggregate +6.4% hid two very different stories — mobile (+22%) and desktop (+3%, not significant). Segment analysis by device, user type, and geography should be standard practice for all A/B test evaluations.
- **PM urgency is not a reason to skip validation**: The spring sale deadline created pressure to ship, but shipping a flawed test result would have been worse than waiting. Frame the re-test as risk mitigation, not obstruction.

## Experiment Evaluation Checklist (Reusable Template)
This checklist can be used for any A/B test evaluation at ShopNow:

- [ ] **SRM check**: Chi-square test on sample counts. p > 0.05?
- [ ] **Sample size**: Both groups meet the pre-test power analysis requirement?
- [ ] **Runtime**: Test ran for at least 2 full weekly cycles?
- [ ] **Novelty assessment**: Compare Week 1 lift vs Week 3+ lift. Stable or decaying?
- [ ] **Primary metric**: Statistically significant (p < 0.05)? Practically significant (exceeds MDE)?
- [ ] **Guardrail metrics**: All within acceptable range? Any violations?
- [ ] **Segmentation**: Results hold across key segments (device, user type, geography)?
- [ ] **SUTVA**: No interference between groups?
- [ ] **Revenue impact**: Net revenue positive after accounting for all metric changes?
- [ ] **Decision**: Launch / Kill / Extend / Iterate — with confidence levels and reasoning?

## One-Sentence Insight
"The +6.4% checkout conversion lift was unreliable due to a randomization bug, masked a 10% AOV drop, and decayed to zero by Week 3 — but the strong mobile signal warrants a clean re-test with proper guardrails."

## Checklist — EVOLVE
- [x] Have you stress-tested the conclusion? — Identified what would disprove it; weakest assumption surfaced
- [x] Have you set up a re-test plan? — Mobile-only, 4 weeks, AOV hard gate, daily SRM monitoring
- [x] Have you set up monitoring? — 5 metrics with specific thresholds, cadence, and owners
- [x] Are follow-up questions defined? — 4 follow-ups and 3 analysis proposals
- [x] Have you captured reusable knowledge? — 5 patterns + reusable experiment evaluation checklist
