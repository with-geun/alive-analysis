# Experiment Statistics Reference

> Detailed statistical methods for A/B test analysis.
> Extracted from the alive-analysis SKILL.md for readability.

---

## Statistical Methods Guide

### Choosing the right test

| Metric Type | Example | Test |
|-------------|---------|------|
| Proportion (binary) | Conversion rate, click rate | Z-test for proportions, Chi-square |
| Continuous (mean) | Revenue per user, time on page | t-test (Welch's), Mann-Whitney if skewed |
| Count | Purchases per user, page views | Poisson test, negative binomial |
| Time-to-event | Time to first purchase | Log-rank test, Cox regression |

### Key concepts (plain language)

- **p-value**: "If there were truly no difference, how surprised would we be to see this result? Below 0.05 = very surprised = likely a real difference."
- **Confidence interval**: "We're 95% sure the true effect is somewhere in this range. Narrower = more precise."
- **Effect size**: "The actual magnitude of the difference. 'Statistically significant' can be tiny — always ask 'is this big enough to matter?'"
- **Power**: "The probability we'll detect a real effect if it exists. 80% power = 20% chance we miss a real improvement."
- **MDE**: "The smallest effect worth detecting. If we can't detect effects smaller than this, we're OK with that."

### Multiple comparisons

- If testing >2 variants: Bonferroni (strict) or Holm-Bonferroni (less strict, more power)
- If testing many secondary metrics: FDR (False Discovery Rate) control
- Rule: "The more things you test, the more likely you'll find something by chance."

---

## SRM (Sample Ratio Mismatch)

**What**: When the actual split ratio differs from the intended ratio.
**Why it matters**: SRM means randomization is broken → results are invalid, no matter how significant.

### Common causes

- Bot filtering applied differently per variant
- Redirect timing (treatment loads slower → more users bounce before being counted)
- Initialization bias (variant assignment happens at different points in the user journey)
- Cache issues (CDN serving wrong variant)

### Detection

- Chi-square goodness-of-fit test comparing expected vs observed counts
- p < 0.001 → SRM likely present

### Response

- Do NOT proceed with analysis if SRM is detected
- Investigate root cause with engineering
- May need to restart the experiment

---

## p-Hacking Prevention

The AI should actively guard against these:

| Practice | Problem | What AI should do |
|----------|---------|-------------------|
| Peeking at results daily | Inflates false positive rate | Remind: "Wait for minimum duration" |
| Stopping when significant | Optional stopping bias | Enforce pre-registered sample size |
| Testing many metrics, reporting only significant ones | Multiple comparisons | Ask: "Is this a pre-registered metric?" |
| Changing the metric definition after seeing results | HARKing | Flag: "This wasn't in the pre-registration" |
| Excluding segments to find significance | Cherry-picking | Ask: "Was this segment analysis pre-planned?" |
| Extending experiment when results aren't significant | Inflates false positive rate | Suggest: "If underpowered, redesign with larger MDE" |

### AI conversation guide

- If user asks to change the primary metric mid-experiment: "That's a deviation from the pre-registered plan. We can look at this as a secondary metric, but the decision should still be based on the original primary metric."
- If user asks to stop early: "The experiment hasn't reached the planned sample size. Stopping now risks a false conclusion. Options: (A) Wait, (B) Stop but mark as 'underpowered', (C) Use sequential testing if available."
