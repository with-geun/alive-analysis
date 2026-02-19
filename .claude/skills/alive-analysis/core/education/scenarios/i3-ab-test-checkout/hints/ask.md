# Hints: ASK Stage

## Level 1: Direction
This is not a standard investigation — it is an experiment evaluation. Before looking at any results, define what makes an A/B test valid. What checks must pass before you can trust the headline number? Think about the test design, not just the outcome.

## Level 2: Specific
Frame your question around three evaluation dimensions: (1) Was the test properly designed and executed? (randomization, sample size, runtime), (2) Is the observed result statistically and practically significant? (p-value, effect size, guardrails), (3) What is the correct decision — launch, kill, extend, or iterate? Your primary metric is checkout conversion rate, but you also need to define guardrail metrics: average order value, revenue per user, and error rate. Without guardrails, you cannot tell if a conversion win is actually a business win.

## Level 3: Near-Answer
Your evaluation framework should cover:
1. **Test validity**: Check randomization (was the 50/50 split achieved?), sample size (did it meet the power analysis requirement?), and runtime (was it long enough to capture weekly cycles and avoid novelty effects?)
2. **Primary metric**: Checkout conversion rate — is the lift real and statistically significant?
3. **Guardrail metrics**: AOV (did order value change?), revenue per user (net revenue impact?), checkout error rate (did quality degrade?)
4. **SUTVA**: Are the treatment and control groups independent? Could one group affect the other?
5. **Decision criteria**: What threshold of evidence is needed to ship? What would make you say "extend" instead of "launch"?

Success criteria: A clear experiment evaluation with validity checks, primary + guardrail metrics, and a decision recommendation with confidence levels.
