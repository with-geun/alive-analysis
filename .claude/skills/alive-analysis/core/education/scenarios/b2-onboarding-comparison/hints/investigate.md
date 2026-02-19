# Hints: INVESTIGATE Stage

## Level 1 — Direction
You've confirmed Flow B converts better across all channels. But signup rate is only one side of the story. Think about what happens *after* signup. Is there any evidence that the users who signed up through Flow B are equally engaged once they are inside the product?

## Level 2 — Specific
Request the **D7 activation data** — the percentage of users who completed a meaningful first action within 7 days of signing up.

This is your counter-metric. If Flow B's simpler signup is letting in lower-intent users (people who sign up but never really use the product), D7 activation will be lower for Flow B users.

Also check: does the activation difference hold **in every channel segment**, or is it just in the noisier smaller groups? A 2pp difference on Paid Google (n=1,750) is much less reliable than the same gap on Organic (n=6,000).

## Level 3 — Near-answer
The key analytical move in INVESTIGATE is comparing two tables side by side:

**Table 1 — Signup rate by segment**: Does Flow B win in every segment? (Checks for Simpson's Paradox in signup rate)

**Table 2 — D7 activation rate by segment**: Does Flow A win in every segment? (Checks whether activation concern is consistent or isolated to one noisy group)

If Flow A wins on D7 activation in **every** segment (not just overall), then the pattern is real and consistent — not an artifact of one small group. That changes the recommendation from "ship Flow B confidently" to "ship Flow B, but monitor closely."

Also look at the funnel step detail: which specific step in Flow A causes the biggest drop-off? Understanding the **mechanism** (phone verification vs. email verification) tells you whether the activation gap is structural (removing intent-filtering friction) or incidental (sampling noise).
