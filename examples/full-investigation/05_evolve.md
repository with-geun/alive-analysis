# EVOLVE — DAU Drop Investigation

> Analysis ID: F-2026-0210-001

## Robustness Check
- **What would disprove our conclusion?** If Android DAU doesn't recover within 5 days of the push fix, there's another factor we missed.
- **Unverified assumption**: We assume push notification users will return once delivery is restored. Some may have found alternative apps during the outage.
- **Weakest point**: The 60/25/10/5 contribution split is estimated, not precisely measured.

## Monitoring Plan
- **Metric**: Android push delivery rate (target: >90%)
- **Cadence**: Daily for 2 weeks post-fix
- **Threshold**: Warning if <85%, Critical if <75%
- **Owner**: Platform Engineering team
- **Also watch**: DAU by platform (expect Android recovery to ~55K within 1 week of fix)

## Follow-up Questions
1. Why wasn't push delivery monitoring in place before the migration?
2. Should we add push delivery rate as a Guardrail metric in config.md?
3. Is there a long-term retention impact on users who missed 7+ days of push notifications?

## Impact Tracking

| # | Recommendation | Decision | Owner | Status | Outcome |
|---|---------------|----------|-------|--------|---------|
| 1 | Hotfix Android push delivery | Accepted | Platform Eng | Done (Feb 11) | Delivery rate back to 93% by Feb 12 |
| 2 | Monitor recovery for 2 weeks | Accepted | Data team | In progress | DAU at 116K by Feb 14 (on track) |

- **Analysis influenced a decision?** Yes
- **Decision date**: Feb 10
- **Outcome check date**: Feb 24

## Reusable Knowledge
- Push notification delivery rate should be a standard check in any DAU investigation
- Holiday effects for ShopFlow: ~5-8% DAU dip, recovers within 3 days after holiday ends
- Bot filter changes can appear as metric drops — always check recent infra changes

## Key Insight (one sentence)
"The DAU drop was primarily a push infrastructure failure masked by holiday noise — fixing delivery restored 90% of lost users within 3 days."

## Checklist — EVOLVE
- [x] Have you stress-tested the conclusion? — Identified what would disprove it
- [x] Have you set up monitoring? — Daily push delivery rate + DAU by platform
- [x] Have you connected findings to North Star? — DAU is a leading metric for Weekly Active Buyers (NSM)
- [x] Are follow-up questions defined? — 3 follow-ups captured
- [x] Have you captured reusable knowledge? — 3 patterns documented
