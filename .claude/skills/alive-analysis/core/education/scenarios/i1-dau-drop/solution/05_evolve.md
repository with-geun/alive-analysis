# EVOLVE — Why did DAU drop 15%?
> ID: L-i1-dau-drop | Mode: Learn | Stage: EVOLVE | Difficulty: Intermediate | Updated: 2026-02-12

> **Reference Solution** — This is the expected output for the EVOLVE stage. Compare your own 05_evolve.md against this after completing the stage.

## Conclusion Robustness Check
- **What would disprove our conclusion?** If Android DAU does not recover within 5 days of the push fix shipping, there is another factor we missed.
- **Unverified assumption**: Push notification users will return once delivery is restored. Some may have formed a habit of opening the app less frequently, or tried QuickBuy during the outage.
- **Weakest point**: The 60/25/10/5 contribution split is estimated, not precisely measured. The push contribution could range from 50-70%.
- **What would make us say "we were wrong" in 3 months?** If the D8-D30 cohort retention metrics are permanently lower after the push fix — indicating we lost users, not just sessions.

## Reflection
- **What went well**: Platform and channel segmentation quickly isolated Android push as the primary signal. iOS as a control group was key.
- **What could be improved**: We should have checked push delivery rate first, before spending time on holiday analysis. Build a standard "infra check" step for DAU investigations.
- **What surprised us**: The Lunar New Year effect was almost perfectly masked by the push failure — the two events overlapped in a way that initially made the drop look larger and more mysterious than it was.

## Monitoring Plan

| Metric | Target | Warning | Critical | Cadence | Owner |
|--------|--------|---------|----------|---------|-------|
| Android push delivery rate | >90% | <85% | <75% | Real-time during migrations; daily otherwise | Platform Engineering |
| DAU by platform (Android) | >50K | <45K | <40K | Daily | Data team |
| Push-driven DAU | >30K | <25K | <20K | Daily | Data team |
| DAU post-fix recovery | ~115K by Feb 17 | <110K | <105K | Daily until recovery | Data team |

## Follow-up Questions
1. Why was push delivery rate not monitored during the migration window? What process gap allowed this?
2. Should push delivery rate be added as a Guardrail metric in `config.md`?
3. Is there a long-term retention impact on users who missed 7+ days of push notifications? (Check D30 retention for the Feb 3-9 cohort in March.)
4. What is the actual revenue loss from 7 days of broken Android push? (Finance team follow-up)

## Follow-up Analysis Proposals
- [ ] Long-term retention impact study: compare D30 retention for users affected during Feb 3-9 vs equivalent cohort from prior year — (not yet created)
- [ ] QuickBuy competitive analysis at 30-day mark: re-examine install/uninstall data and market share signals — (not yet created)

## Impact Tracking

| # | Recommendation | Decision | Owner | Status | Outcome |
|---|---------------|----------|-------|--------|---------|
| 1 | Hotfix Android FCM delivery (`PushService.refreshToken()`) | Accepted | Platform Engineering | Done (Feb 11) | Delivery rate back to 93% by Feb 12 |
| 2 | Monitor Android push delivery rate daily for 2 weeks post-fix | Accepted | Data team | In progress | DAU at 116K by Feb 14 — on track |
| 3 | Update dashboard baselines to reflect post-bot-filter numbers | Accepted | Data team | Done (Feb 12) | No further confusion about historical baseline |

- **Analysis influenced a decision?** Yes — hotfix prioritized and shipped within 24 hours of this analysis
- **Decision date**: Feb 10, 2026
- **Outcome check date**: Feb 24, 2026

## Reusable Knowledge
- **Push delivery rate is a standard DAU investigation check**: Always pull push delivery rates when DAU drops unexpectedly. A single metric can expose infra failures invisible in aggregate DAU.
- **Holiday effects for ShopFlow**: ~5-8% DAU dip, recovers within 3 days after holiday ends. Organic and non-push segments are the leading signal.
- **Bot filter changes can look like metric drops**: Always check recent infra changes before diagnosing a DAU decline. Document filter changes in the team changelog.
- **iOS as a control group for Android investigations**: When Android shows an anomaly, iOS behavior provides a clean counterfactual — same app, same users, different delivery path.
- **Migrations need a delivery check before DAU review**: Add push delivery monitoring to migration runbooks, not just post-mortem investigation templates.

## One-Sentence Insight
"The 15% DAU drop was a push infrastructure failure masked by holiday noise — fixing delivery restored Android DAU within 5 days, and the 60/25/10 contribution breakdown provided a reusable diagnostic framework for future drops."

## Checklist — EVOLVE
- [x] Have you stress-tested the conclusion? — Identified what would disprove it; weakest assumption surfaced
- [x] Have you set up monitoring? — Specific metric, threshold, cadence, and owner for each KPI
- [x] Have you connected findings to North Star? — DAU is a leading metric for Weekly Active Buyers (ShopFlow NSM)
- [x] Are follow-up questions defined? — 4 follow-ups captured, 2 formal analysis proposals
- [x] Have you captured reusable knowledge? — 5 patterns documented for the team
