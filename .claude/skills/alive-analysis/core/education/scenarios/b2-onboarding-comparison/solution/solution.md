# Quick: Which onboarding flow is better?

> **ID**: L-scenario-b2
> **Type**: Quick Analysis (Comparison)
> **Scenario**: b2-onboarding-comparison
> **Status**: Reference Solution

## ASK
**Question**: "Onboarding Flow A (current 5-step) vs. Flow B (simplified 3-step) — which should we ship to 100% of users?"

**Framing**: Comparison (which is better?), not Causation. Two metrics required:
- **Primary**: Signup completion rate (the PM's stated concern)
- **Counter-metric**: D7 activation rate (do those signups actually use the product?)

**Context**: PM wants to decide whether to ship Flow B to all users. Both flows ran as an informal split for 2 weeks (Jan 27 – Feb 9). Flow A = existing 5-step onboarding with mandatory phone verification. Flow B = simplified 3-step onboarding with optional email verification.

## LOOK
**Data source**: Mixpanel funnel report, exported CSV + D7 activation event data

**Segmented signup results**:

| Segment | Flow A (completion rate) | Flow B (completion rate) | Users (A / B) |
|---------|--------------------------|--------------------------|---------------|
| Organic | 34% | 41% | 3,200 / 2,800 |
| Paid (Instagram) | 28% | 32% | 1,500 / 1,200 |
| Paid (Google) | 31% | 38% | 900 / 850 |
| All | 32% | 38% | 5,600 / 4,850 |

**External factors**: No holidays, no major product changes, no tracking changes during test period.

## INVESTIGATE
- Flow B outperforms A in **every segment** for signup rate (+4–7pp across channels)
- **No Simpson's Paradox** (a phenomenon where an overall trend reverses when data is split into subgroups): the overall +6pp improvement holds in every channel independently
- **Drop-off analysis**: Flow A loses 35% of users at the phone verification step (Step 3 — mandatory). Flow B replaced this with optional email verification, which has only a 7% drop-off. This is the primary mechanism behind the signup improvement.

**D7 activation rates (users who completed first core action within 7 days)**:

| Segment | Flow A (D7 activation) | Flow B (D7 activation) | Difference |
|---------|------------------------|------------------------|------------|
| Organic | 48% | 46% | -2pp |
| Paid (Instagram) | 38% | 35% | -3pp |
| Paid (Google) | 42% | 40% | -2pp |
| All | 45% | 42% | -3pp |

- Flow B has **lower D7 activation in every segment** (1–3pp lower per channel)
- No Simpson's Paradox for activation either: Flow A wins consistently across all groups
- Interpretation: removing mandatory phone verification helps more users get through signup, but may admit slightly lower-intent users who are less likely to complete a first meaningful action

## VOICE
**So What**: Flow B's 3-step onboarding converts 6pp (percentage points) better than Flow A across all channels. The improvement is driven by removing mandatory phone verification. However, Flow B users activate in the first 7 days at a rate 1–3pp lower per segment — suggesting the easier entry may be attracting users with slightly lower intent.

**Now What**:
- Ship Flow B to 100% of users (the signup improvement is real and consistent)
- Set a monitoring alert: if D7 activation for Flow B users drops >3pp (percentage points) vs. the Flow A baseline after 30 days at full traffic, add optional phone verification back as a trust signal
- Do not make this change mandatory — the goal is to recover intent-filtering without re-introducing the friction that caused the 35% step drop-off

**Confidence**: High for signup improvement (n=10,450 total, consistent across all segments). Medium for activation gap (pattern is consistent but absolute gap is small, 2-week window is short, per-segment activated user counts are moderate).

## EVOLVE
- **Follow-up**: After 30 days of full Flow B traffic, pull D7 and D30 retention for Flow B users and compare against the Flow A historical baseline. If the D7 gap has narrowed to <1pp, the earlier gap was likely a timing artifact. If it has grown beyond 3pp, act on the monitoring trigger.
- **Counter-metric to watch**: D7 activation rate (weekly for the first 4 weeks post-launch; if it drops >3pp vs. Flow A baseline, investigate whether optional phone verification should be added back)
- **Reusable insight**: Mandatory phone verification caused a 35% step drop-off in Flow A — it is a major friction point. Consider making phone verification optional everywhere in the product. Any future onboarding redesign should treat intent-filtering steps as an explicit friction vs. quality trade-off.

## Quick Checklist
- [x] Is the purpose clear and framed? — Comparison, which flow produces better-quality signups
- [x] Was the data broken down by groups? — By acquisition channel (Organic, Paid IG, Paid Google)
- [x] Were alternative explanations considered? — Simpson's Paradox checked for both metrics; timing clean; no external events
- [x] Does the conclusion answer the question with confidence? — Yes: ship Flow B with monitoring trigger
- [x] Is there enough data? — 10,450 total users, 2-week period; organic segment reliable, paid channels directional

**Tags**: `onboarding`, `signup`, `funnel`, `comparison`, `counter-metric`, `simpsons-paradox`, `activation`
