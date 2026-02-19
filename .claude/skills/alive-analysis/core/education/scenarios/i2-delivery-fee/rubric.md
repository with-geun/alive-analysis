# Rubric: i2-delivery-fee

> Total: 100 points across 5 ALIVE stages
> Difficulty: Intermediate | Analysis Type: Simulation | Format: Full (5 files)

---

## ASK (20 points)

| Item | Points | Criteria |
|------|--------|----------|
| Simulation identification | 5 | Explicitly identifies this as a Simulation (not Investigation or Comparison). States: "evaluating a policy before implementation" or equivalent. Zero points if framed as an Investigation. |
| Variable categorization | 5 | Correctly lists variables that change (delivery fee revenue, order volume, rider costs, subscription conversion) and variables held constant (commission rate, AOV, marketing spend). Must have at least 3 changed + 2 constant to earn full points. |
| Scenario definition | 5 | Defines exactly 3 scenarios with specific order volume assumptions: Conservative (~+12%), Neutral (~+15-18%), Aggressive (~+22-25%). Labels must align with the key uncertain variable (sustained order volume increase). |
| Success criteria + breakeven framing | 5 | States a clear success criterion (e.g., positive P&L within 3 months) AND notes that a breakeven threshold exists and needs to be calculated. Does not need the exact number — just the framing. |

**Partial credit**: 3 points per item if criteria are met but imprecisely stated.

---

## LOOK (20 points)

| Item | Points | Criteria |
|------|--------|----------|
| Current unit economics | 6 | Correctly calculates: commission revenue (₩3,750/order), delivery fee revenue (₩3,000 × non-subscriber orders), rider cost (₩2,200/order), and net contribution. Monthly totals within ±5% of reference values. |
| Promo data as analogue | 5 | Uses the 50% fee promo as the primary elasticity reference. Critically: must note that the +22% is a 4-week average and question whether this overstates the sustained effect (novelty bias). Must flag that volume returned to baseline post-promo — suggesting the effect may not be durable. Full credit only if skepticism about the headline number is raised. |
| Competitor context | 4 | Notes Competitor A's price (₩2,500) and historical fast-response behavior (matched promo in 2 weeks). Flags competitor response as a model risk. |
| Fixed vs variable identification | 5 | Correctly separates fixed (rider base pay ₩1,500, subscription fee) from variable (rider distance cost ₩700, commission revenue, delivery fee revenue) elements. Used in subsequent scenario modeling. |

---

## INVESTIGATE (25 points)

| Item | Points | Criteria |
|------|--------|----------|
| Scenario matrix with P&L | 8 | Builds a side-by-side P&L table for all 3 scenarios. Each scenario must include: new monthly orders, new commission revenue, new delivery fee revenue, new rider costs, and net contribution vs baseline. Numbers must be directionally correct (Conservative worst, Aggressive best). |
| Breakeven calculation | 7 | Calculates the breakeven order volume increase. Reference answer: ~+13% on incremental orders (₩486M revenue loss ÷ ₩3,050 net per new order = ~59,000 new orders = ~+13%). Accept any answer in the +12% to +15% range with correct methodology shown. |
| Sensitivity ranking | 5 | Correctly identifies sustained order volume increase as the #1 sensitivity variable. Must rank it above subscription conversion and rider cost discount. Explanation required (not just a label). |
| Subscription second-order effect | 5 | Identifies that lower fees reduce the value proposition of the subscription plan, potentially suppressing subscription growth. Quantifies or estimates the magnitude. Must be raised as a separate risk from the order volume effect. |

**Note**: The exact P&L numbers are less important than the methodology. Award full points if the logic and structure are correct even if specific numbers differ from the reference solution.

---

## VOICE (20 points)

| Item | Points | Criteria |
|------|--------|----------|
| 3-scenario summary table | 5 | Presents a clear comparison table showing all 3 scenarios side-by-side with at minimum: order volume increase, monthly P&L vs baseline, and rider capacity status. Must be presentable to a non-technical executive. |
| Breakeven named and explained | 5 | Explicitly states the breakeven threshold (approximately +13% incremental orders) in plain language. Connects it to the promo data. Does NOT just say "it depends" — names the number. |
| Handle bars presented | 5 | Offers at least 3 adjustable inputs the board can stress-test: order volume increase, subscription conversion impact, and at least one other (rider discount or competitor response timing). Explains what each handle changes in the P&L. |
| Phased recommendation | 5 | Recommends testing before full rollout. Specifies: test market (one city), test fee level (between current and proposed), duration (4 weeks), and a go/no-go criterion. Does not just say "test it" — defines what a successful test looks like. |

**Bonus (2 points)**: Audience-specific messages tailored to CEO (growth), CFO (margin/breakeven), and Head of Operations (capacity). Must be substantively different for each audience, not just minor rewording.

---

## EVOLVE (15 points)

| Item | Points | Criteria |
|------|--------|----------|
| Test-before-rollout plan | 5 | Specifies a concrete test: geography (specific city or region), duration (minimum 4 weeks), fee level for the test, and a binary go/no-go criterion. Not vague — the plan must be actionable. |
| Monitoring metrics with thresholds | 5 | Lists at least 4 specific metrics with baseline values and alert thresholds (not just "monitor orders"). Must include: order volume, subscription conversion rate, rider utilization, and at least one more. Cadence (daily/weekly) specified. |
| Assumption tracking template | 5 | Provides an Actual vs Predicted table template with at least 4 key model assumptions listed. Template must be fillable post-launch (not just a list of things to watch — a structured tracking artifact). |

**Partial credit**: 3 points per item if the right elements are present but incompletely specified.

---

## Scoring Summary

| Stage | Max Points | Passing Threshold |
|-------|------------|-------------------|
| ASK | 20 | 14 |
| LOOK | 20 | 14 |
| INVESTIGATE | 25 | 17 |
| VOICE | 20 | 14 |
| EVOLVE | 15 | 10 |
| **Total** | **100** | **70** |

**Grade levels**:
- 90-100: Excellent — ready for Intermediate+ or Advanced scenarios
- 75-89: Proficient — solid Simulation fundamentals
- 60-74: Developing — revisit INVESTIGATE (most common gap) and VOICE
- Below 60: Revisit i1-dau-drop and Beginner scenarios before retrying

---

## Most Common Mistakes at Intermediate Level

1. **Framing as Investigation** — Treating this as "why did orders drop" instead of "what will happen if we change the fee." The Simulation framing (forward-looking, policy evaluation) must be explicit.

2. **Using the +22% promo headline** — Taking the overall promo average instead of the week 4 sustained figure. A common error that leads to over-optimistic scenarios.

3. **Missing the subscriber adjustment** — Calculating delivery fee revenue on all 450,000 orders instead of only the 72% that are non-subscriber orders. This error inflates both the current baseline and the impact of the fee cut.

4. **No breakeven number** — Describing the tradeoff qualitatively without calculating the specific threshold. The breakeven is the single most useful number in this analysis.

5. **Generic VOICE** — Presenting one P&L table and calling it done. VOICE at Intermediate must include handle bars and audience-specific communication.
