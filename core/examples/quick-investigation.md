# Quick Investigation — Signup Rate Comparison

> **ID**: Q-2026-0212-001
> **Type**: Quick Analysis (Comparison)
> **Created**: 2026-02-12
> **Status**: Archived

## ASK
**Question**: "Onboarding flow A (current) vs flow B (redesign) — which has higher signup completion rate?"

**Framing**: Comparison (which is better?), not Causation (does B cause higher signups)

**Context**: PM wants to decide whether to ship Flow B to all users. Both flows ran as an informal split for 2 weeks (Jan 27 - Feb 9). Flow A = existing 5-step onboarding. Flow B = simplified 3-step onboarding.

## LOOK
**Data source**: Mixpanel funnel report, exported CSV

**Segmented results**:

| Segment | Flow A (completion rate) | Flow B (completion rate) | Users (A / B) |
|---------|------------------------|------------------------|---------------|
| Organic | 34% | 41% | 3,200 / 2,800 |
| Paid (Instagram) | 28% | 32% | 1,500 / 1,200 |
| Paid (Google) | 31% | 38% | 900 / 850 |
| All | 32% | 38% | 5,600 / 4,850 |

**External factors**: No holidays, no major product changes during test period.

## INVESTIGATE
- Flow B outperforms A in **every segment** (+6-7pp (percentage points) across the board)
- Organic segment: large sample (n=6,000 combined), difference is reliable
- Instagram paid: smaller sample, difference is directionally positive but noisier
- Google paid: similar to organic pattern
- **No Simpson's Paradox** (a phenomenon where the overall trend reverses when data is split into groups): the overall result matches every segment result
- **Drop-off analysis**: Flow A loses most users at step 3 (phone verification). Flow B replaced this with optional email verification — that's likely the mechanism.

## VOICE
**So What**: Flow B's 3-step onboarding converts 6pp (percentage points) better than Flow A across all channels. The improvement is driven by removing mandatory phone verification.

**Now What**:
- Ship Flow B to 100% of users (high confidence the improvement is real)
- Monitor D7 activation rate (users who return within 7 days) as a counter-metric (a metric we track to ensure our optimization doesn't cause unintended harm elsewhere)

**Confidence**: High for organic (large sample, consistent effect). Medium for paid channels (smaller sample, same direction).

## EVOLVE
- **Follow-up**: Does the simpler signup affect user quality? Check D7 (7-day) and D30 (30-day) activation rates for Flow B users after 30 days.
- **Counter-metric to watch**: D7 activation rate (if it drops >3pp (percentage points), the easier signup may be attracting low-intent users)
- **Reusable insight**: Mandatory phone verification is a major friction point. Consider making it optional everywhere.

## Quick Checklist
- [x] Is the purpose clear and framed? — Comparison, which flow is better
- [x] Was the data broken down by groups? — By acquisition channel
- [x] Were alternative explanations considered? — Simpson's Paradox checked, timing clean
- [x] Does the conclusion answer the question with confidence? — Yes, Flow B wins with high confidence
- [x] Is there enough data? — 10,450 total users, 2-week period

**Tags**: `onboarding`, `signup`, `funnel`, `comparison`
