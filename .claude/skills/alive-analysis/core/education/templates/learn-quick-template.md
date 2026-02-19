# Quick: {title}
> ID: {ID} | Mode: 📚 Learn | Stage: ❓ ASK | Difficulty: {Beginner/Intermediate} | Started: {YYYY-MM-DD}

> **Welcome!** This is a guided learning scenario. Work through each ALIVE stage
> in order. The AI will give you feedback and advance you to the next stage
> when you run `/analysis-learn-next`.

## ASK

> **Why ASK matters**: The biggest analysis mistakes happen before any data is touched.
> A poorly framed question leads to wasted effort. ASK is about making sure
> you're solving the RIGHT problem.

- Question / Objective:
- Framing: Causation / Correlation / Comparison / Evaluation
  > 💡 Causation = "Why did X happen?", Correlation = "Are X and Y related?",
  > Comparison = "Which is better, A or B?", Evaluation = "What would happen if we do X?"
- Top hypotheses: (1) (2) (3)
  > **Hint**: Think about internal factors (product, engineering, operations),
  > external factors (market, competitors, seasonality), and data artifacts
  > (tracking changes, definition changes).
- Deadline:

## LOOK

> **Why LOOK matters**: Most analysis errors come from skipping data quality checks
> and jumping straight to conclusions. LOOK is "look before you leap."

- Data source:
- Data readiness: Do we have enough data? (rows, date range, coverage)
- Key segments checked:
  > **Why segment?**: Averages hide stories. "Signups dropped 30%" might mean
  > "mobile dropped 60% while desktop grew 10%." The cause and fix depend
  > entirely on WHERE the drop happened.
- Are groups comparable? (if comparing: same period? same population? similar conditions?)
- External factors considered:
- Notable findings:

## INVESTIGATE

> **Why INVESTIGATE matters**: It's tempting to stop at the first explanation that
> fits. INVESTIGATE forces you to test alternatives and prove your conclusion
> is robust — not just plausible.

- Method: (e.g., before/after comparison, trend analysis, cohort comparison, group comparison)
- Hypotheses tested: ✅ / ❌ / ⚠️
  > **Hint**: For each hypothesis, ask "What evidence would DISPROVE this?"
  > Test the easiest-to-disprove ones first.
- Result:
- Confidence: 🟢 High / 🟡 Medium / 🔴 Low

## VOICE

> **Why VOICE matters**: An insight that no one understands or acts on is worthless.
> VOICE transforms findings into decisions.

- So What? (business impact):
  > 💡 State the SIZE of the effect and what it MEANS in practice.
- Now What? (recommended action):
- Audience:

## EVOLVE

> **Why EVOLVE matters**: The best analysts don't just answer questions — they
> generate better questions. EVOLVE captures what you learned and what to
> explore next.

- What would change this conclusion?
- Follow-up needed: Yes / No
- Next question:

---
Check: 🟢 Proceed / 🔴 Stop
- [ ] Is the purpose clear and framed (causation/correlation/comparison/evaluation)?
- [ ] Was the data broken down by groups (not just totals)?
- [ ] Were alternative explanations considered?
- [ ] Does the conclusion answer the question with a confidence level?
- [ ] Is there enough data (rows, time period) to support this conclusion?
