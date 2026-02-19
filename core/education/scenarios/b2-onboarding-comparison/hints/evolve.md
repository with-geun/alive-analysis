# Hints: EVOLVE Stage

## Level 1 — Direction
The analysis is done, but the question is not closed. What would make you change your recommendation? And what do you need to watch after Flow B ships to 100%?

## Level 2 — Specific
Your recommendation includes a condition: monitor D7 activation for 30 days after full rollout. To make this actionable, you need to be specific:
- Which metric exactly? (D7 activation rate, segmented by channel)
- What is the threshold? (>3pp drop vs. Flow A baseline)
- Who checks it, and when? (set a calendar reminder or dashboard alert)

Also think about what a longer time window might show. D7 activation is a short-term proxy. Does D30 retention (users still active after 30 days) tell a different story? If Flow B users activate at the same rate by Day 30, the D7 gap may just be a timing difference, not a quality difference.

## Level 3 — Near-answer
Strong EVOLVE answers for this scenario include:

**Follow-up**: After 30 days at full Flow B traffic, pull D7 and D30 retention for Flow B users and compare against the Flow A historical baseline. If the D7 gap has grown beyond 3pp, re-introduce optional phone verification as a trust signal (not mandatory) and recheck.

**Counter-metric monitoring plan**:
- Alert: D7 activation drops >3pp (absolute) vs. Flow A baseline
- Review cadence: Weekly for the first 4 weeks, then monthly
- Owner: PM + analyst

**Reusable insight**: Mandatory phone verification is a significant friction point — it caused a 35% drop-off at that step in Flow A. Consider making phone verification optional everywhere in the product, not just onboarding. Any future onboarding redesign should treat intent-filtering steps (verification, role selection, company info) as a friction vs. quality trade-off, not just a UX clean-up.
