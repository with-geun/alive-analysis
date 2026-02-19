# Hints: ASK Stage

---

## Level 1 — Direction

Think carefully about what TYPE of analysis this is. The CEO is proposing a change — nothing has gone wrong yet. This is not an Investigation (explaining why something happened). What kind of analysis do you do when you need to evaluate a policy *before* implementing it?

---

## Level 2 — Specific

This is a **Simulation**, not an Investigation or a Comparison. The key difference:
- Investigation: "Why did orders drop?" — you're looking backward at something that happened
- Comparison: "Which group performs better?" — you're comparing two existing groups
- Simulation: "What will happen if we do X?" — you're modeling the future under different assumptions

For Simulation, your ASK must:
1. Define exactly what policy is being evaluated (be precise about what changes and what stays the same)
2. Identify the variables that will change as a result of the policy
3. Identify the variables that are assumed to stay constant
4. Define multiple scenarios — because you don't know which future will happen
5. Set a success criterion: what result would make this decision "right"?

---

## Level 3 — Near-Answer

Frame your ASK as: **Policy evaluation — "What is the likely P&L impact of reducing delivery fees from ₩3,000 to ₩1,500, across Conservative, Neutral, and Aggressive scenarios?"**

Variables that change:
- Delivery fee revenue (direct: from ₩3,000 to ₩1,500 per order)
- Order volume (indirect: lower fee attracts more orders)
- Rider costs (indirect: more orders = more deliveries)
- Subscription conversion rate (second-order: lower fee reduces subscription value proposition)

Variables held constant (assumptions):
- Platform commission rate (15%)
- Average order value (₩25,000 — test this assumption later)
- Marketing spend
- Competitor behavior (in base case — model as a sensitivity)

Define your 3 scenarios based on sustained order volume increase:
- Conservative: +12% sustained orders
- Neutral: +18% sustained orders
- Aggressive: +25% sustained orders

Success criterion: **Net positive monthly P&L impact within 3 months of launch**

Your first task: identify the breakeven threshold — what % order increase is needed for the policy to break even vs the current state?
