# Hints: INVESTIGATE Stage

---

## Level 1 — Direction

Now it's time to build the model. You have your baseline (from LOOK), your historical analogue (the promo data), and your three scenarios. How does the monthly P&L change under each scenario? And which variable has the biggest impact on whether this decision works out?

---

## Level 2 — Specific

Three things to do in INVESTIGATE for this Simulation:

1. **Build the scenario matrix** — For each scenario (Conservative/Neutral/Aggressive), calculate the monthly P&L. You need: new delivery fee revenue, new commission revenue (higher volume), new rider costs (higher volume, possibly with volume discount). Net each scenario vs current baseline.

2. **Calculate the breakeven** — At what % sustained order increase does the fee reduction exactly break even vs the current P&L? This is your most important number for the board. Hint: the answer is somewhere between +12% and +18%.

3. **Rank your sensitivities** — Which variable has the most impact on the outcome? Try changing each one:
   - What if sustained order increase is 10% vs 20%? (How much does P&L change?)
   - What if subscription conversion drops by 2pp instead of 1pp?
   - What if rider cost discount is 0% instead of 5%?

   The variable with the biggest swing in outcome is your most important uncertainty — and the one to emphasize in VOICE.

Also consider the **second-order subscription effect**: If lower fees suppress subscription growth, QuickBite loses high-margin, high-frequency customers. Model this separately as an addendum.

---

## Level 3 — Near-Answer

**Monthly P&L structure (use this template for each scenario):**

```
New monthly orders = 450,000 × (1 + order_increase%)
New delivery fee revenue = new_orders × ₩1,500 × subscriber_adjustment
  (subscribers don't pay delivery fee — they're ~28% of orders)
New commission revenue = new_orders × ₩3,750
New rider cost = new_orders × ₩2,200 (or lower if volume discount applies)
Net contribution = (fee_revenue + commission_revenue) − rider_cost
Change vs baseline = net_contribution − ₩2,050M
```

**Breakeven calculation:**
- Revenue lost from fee cut (non-subscriber orders): ₩1,500 × 450,000 × 0.72 ≈ ₩486M/month
- To recover, need extra orders generating net margin
- Each additional order generates: ₩1,500 (fee) + ₩3,750 (commission) − ₩2,200 (rider) = ₩3,050 net
- Orders needed to recover ₩486M: ₩486M ÷ ₩3,050 ≈ 59,400 extra orders
- As % of baseline: 59,400 ÷ 450,000 ≈ **+13.2%**

**Sensitivity ranking (approximate):**
1. Sustained order volume increase — dominates everything
2. Subscription conversion impact — second-order but meaningful over 6+ months
3. Rider cost volume discount — smaller lever, helps at high volume

**Promo data warning:** The +22% headline from the promo is not the right number for a permanent fee reduction. The week 4 figure (+15%) is a better proxy for sustained behavior. Use +15% as the basis for your Neutral scenario, not +22%.
