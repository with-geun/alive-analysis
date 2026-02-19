# ASK — Should We Lower Delivery Fees?
> Analysis ID: L-scenario-i2 | Mode: Learn | Stage: ASK | Scenario: i2-delivery-fee

---

## Analysis Type

**Simulation** — Evaluating a proposed policy before implementation.

This is NOT an Investigation (no incident occurred). This is a forward-looking model: "What will likely happen to QuickBite's P&L if we reduce delivery fees from ₩3,000 to ₩1,500?"

---

## Policy Under Evaluation

**Proposed change**: Reduce delivery fee from ₩3,000 to ₩1,500 per order (−50%, flat rate)

**Scope**: All orders, all users, all markets (company-wide, unless phased)

**Timeline**: Permanent change (not a time-limited promo)

---

## Variables Affected by This Policy

| Variable | Direction | Mechanism |
|----------|-----------|-----------|
| Delivery fee revenue | Down | Direct: ₩1,500 less per non-subscriber order |
| Order volume | Up (uncertain) | Price elasticity: lower fee attracts more orders |
| Platform commission revenue | Up | More orders = more GMV = more commission |
| Rider costs | Up | More orders = more deliveries |
| Subscription conversion | Down (uncertain) | Lower fee reduces subscription value proposition |

---

## Variables Held Constant (Assumptions)

| Variable | Assumed Value | Note |
|----------|--------------|-------|
| Platform commission rate | 15% of GMV | Unchanged |
| Average order value (AOV) | ₩25,000 | May shift slightly — test as sensitivity |
| Marketing spend | Unchanged | No additional marketing budget for this |
| Subscriber share at baseline | 12% | Starting point before behavioral change |

---

## Three Scenarios

| Scenario | Sustained Order Volume Increase | Rationale |
|----------|--------------------------------|-----------|
| Conservative | +12% | Below promo week 4 (+15%), accounts for competitor response |
| Neutral | +18% | Between promo week 4 (+15%) and overall promo avg (+22%) |
| Aggressive | +25% | Near promo week 1 peak (+28%), assumes no competitor response |

Note: Scenarios represent sustained (steady-state) order increase, not the initial promo spike.

---

## Success Criteria

**Primary**: Net positive monthly P&L impact within 3 months of launch

**Minimum bar**: Monthly net contribution ≥ current baseline (₩2.05B/month)

**Stretch**: Monthly net contribution > ₩2.2B (10% improvement) — the threshold at which the CEO's growth thesis is vindicated

---

## Breakeven Threshold (to be calculated in INVESTIGATE)

**Working hypothesis**: Need approximately +13% sustained order increase to offset the revenue loss from the fee cut.

- Revenue lost per month from fee reduction: ₩1,500 × ~324,000 non-subscriber orders ≈ ₩486M
- Each additional order nets: commission + delivery fee − rider cost
- Breakeven order count increase: ~59,000 additional orders/month (~+13%)

---

## Key Questions This Analysis Must Answer

1. Under each scenario, what is the monthly P&L impact?
2. What % order increase is needed to break even?
3. Which variable (order volume increase, subscription conversion, rider cost discount) has the biggest P&L sensitivity?
4. What conditions would make the Conservative scenario a win, and what conditions make even the Neutral scenario a loss?
5. Is there a phased implementation approach that limits downside while still capturing the upside?

---

## Constraints and Deadline

- Deadline: Board presentation in 5 days
- Data available: 6 months order history, promo results, competitor data, rider cost structure
- Key constraint: Rider capacity ceiling at 18,000 orders/day (current: 15,000)
