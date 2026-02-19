# Quick: How much does turnover cost us?

> **ID**: L-scenario-b3
> **Type**: Quick Analysis (Investigation — Quantification)
> **Scenario**: b3-turnover-cost
> **Status**: Reference Solution
> **Scenario**: b3-turnover-cost

---

## ASK
**Question**: "What is the total financial cost of engineering turnover this year, and which level is the highest-impact segment to address?"

**Framing**: Investigation (Quantification + Segmentation) — not pure causation. The CFO needs dollar amounts and ROI framing, not an explanation of organizational psychology.

**Context**: HR Director needs to justify a retention budget increase. The analysis must speak to cost, not sentiment. Two things to answer: (1) total cost broken down by level, (2) which level to prioritize and why.

**Audience note**: Primary output is CFO-facing. Lead with numbers and ROI. Keep HR-specific detail (eNPS, exit themes) as supporting evidence, not the headline.

---

## LOOK
**Data sources**: HRIS export (headcount + departures by level), Finance cost reports (replacement costs by level), external market data

**Turnover by level** (Engineering, this year vs last year):

| Level | Last Year | This Year | Headcount | Departures |
|-------|-----------|-----------|-----------|------------|
| Junior (L1-L2) | 18% | 22% | 120 | 26 |
| Mid (L3-L4) | 10% | 20% | 85 | 17 |
| Senior (L5+) | 6% | 12% | 45 | 5 |
| All Engineering | 12% | 19% | 250 | 48 |

**Replacement cost per departure**:

| Level | Recruiting | Onboarding | Lost Productivity | Total per Head |
|-------|------------|------------|-------------------|----------------|
| Junior | $15K | $8K | $12K | $35K |
| Mid | $25K | $15K | $40K | $80K |
| Senior | $45K | $20K | $85K | $150K |

**Total cost by level**:
- Junior: 26 × $35K = **$910K**
- Mid: 17 × $80K = **$1,360K**
- Senior: 5 × $150K = **$750K**
- **Total: $3.02M** (up from an estimated ~$1.5M last year)

**External factors**: Two competitors raised base salaries 15% in Q3. Industry-wide hiring surge is ongoing. These are relevant context for Junior and Senior segments but do not fully explain the Mid-level pattern (see Investigate).

---

## INVESTIGATE
**Cost driver**: Mid-level turnover is the single biggest cost driver at $1.36M (45% of total) despite having fewer departures than Junior. Mid turnover doubled from 10% to 20%, far exceeding the industry benchmark of 12%.

**Three distinct patterns by level**:

**Junior (L1-L2)**: 50% cite compensation, 30% work-life balance. Turnover at 22% is slightly above industry average (20%) — within normal range for early-career movement in a hot market. Average tenure at departure is 1.2 years. The Q3 competitor salary increases likely explain part of the increase. Not a structural crisis, but worth watching if salary gap persists.

**Mid (L3-L4)**: 70% cite lack of career growth path (compensation only 15%). Turnover doubled from 10% to 20%, vs industry benchmark of 12% — meaning Meridian is underperforming by 8 percentage points. eNPS of 22 is the company's lowest recorded score in 18 months and is a strong warning signal for continued attrition. Average tenure at departure is 2.8 years — these engineers invested real time and left anyway. This is an internal structural problem: the company does not have a clear promotion path for L3-L4 engineers, and the market has given them alternatives.

**Senior (L5+)**: 3 of the 5 departures went to the same competitor (Apex Systems), which ran a public senior hiring push in Q2. This is targeted poaching, not broad dissatisfaction — confirmed by an eNPS of 45 (healthy) among remaining seniors. 2 of 5 left for startup equity. The senior population is small (45 total) and individually high-value, making each departure $150K.

**Exit interview bias**: Self-reported data understates sensitive reasons (management problems, interpersonal conflicts). The 70% "career path" figure for Mid and the 15% "management" figure should be read as directionally correct, not precisely accurate.

**Industry comparison summary**:
- Junior: 22% vs 20% benchmark — slightly above, within normal range
- Mid: 20% vs 12% benchmark — 8pp above, significant underperformance
- Senior: 12% vs 8% benchmark — 4pp above, but driven by a single external actor

---

## VOICE
**So What**: Engineering turnover cost an estimated $3.02M this year, roughly double last year's ~$1.5M. Mid-level engineers are the highest-impact segment — $1.36M, 45% of total cost, turnover doubled from 10% to 20% while the industry average is 12%. The cause is structural: mid-level engineers lack a visible career growth path and are leaving after 2-3 years of investment. This is a fixable problem. Senior turnover is a concentrated poaching risk, not a cultural failure.

**Now What**:

- **Priority 1 — Mid-level career ladder program** (estimated investment: $200K/year for mentorship, promotion track redesign, and L3→L4 sponsorship). If this reduces mid-level turnover by 5 percentage points (from 20% to 15%), it avoids approximately 4 departures per year, saving ~$320K/year in replacement costs. At $200K/year investment, this program pays for itself within the first year and generates net savings in year two. Minimum 2:1 ROI at the 5pp improvement assumption.

- **Priority 2 — Senior targeted retention packages** (estimated investment: $50-80K one-time, 3-5 individuals identified as highest poaching risk by Apex Systems based on tenure and visibility). Cost of one additional senior departure is $150K. Retaining even one person fully covers the program cost.

- **Do not prioritize**: Junior turnover is near industry benchmark and partly market-driven. General compensation increases across the board would be expensive and would not address the Mid-level root cause (career path, not pay).

**Confidence**:
- High: Total cost figure ($3.02M) — based on actual departure counts and Finance-validated replacement cost estimates
- Medium: Root cause attribution by level — exit interview self-reporting bias means percentages are directional, not precise. Especially for Mid: the 70% "career path" finding is consistent with the eNPS score and tenure data, which strengthens confidence.

---

## EVOLVE
**Follow-up (immediate)**: Run an anonymous pulse survey targeting current Mid-level engineers (L3-L4) on career development satisfaction and promotion clarity before designing the career ladder program. Exit interview data tells you why people left — this tells you the state of the people who stayed.

**Metrics to monitor quarterly**:
- Turnover rate by level (lagging — will confirm whether interventions work)
- eNPS by level (leading — Mid eNPS at 22 is the earliest warning signal available; escalate if it drops below 20)
- Internal promotion rate for L3→L4 and L4→L5 (leading — tracks whether the career ladder program is actually moving people up)

**Counter-metric**: Time-to-fill for open roles by level. If the market remains hot or worsens, replacement cost estimates will need to be revised upward.

**Reusable insight**: Aggregate turnover rate hides fundamentally different problems requiring different interventions at each level. This analysis structure (cost by level + root cause by level + industry benchmark by level) should be standardized as a quarterly HR report. The arithmetic is simple; the cost is in not doing it.

---

## Quick Checklist
- [x] Is the purpose clear and framed? — Quantify turnover cost, identify highest-impact segment for CFO budget conversation
- [x] Was the data broken down by groups? — By seniority level (Junior / Mid / Senior)
- [x] Were alternative explanations considered? — External market (salary increases, hiring surge) vs internal structural issues (career path gap); poaching vs attrition
- [x] Does the conclusion answer the question with confidence? — Yes: $3.02M total, Mid-level is priority, specific interventions with cost and ROI stated
- [x] Is confidence calibrated? — High for cost (actual data), Medium for root causes (exit interview bias noted)
- [x] Is there a leading indicator identified? — Yes: eNPS by level, especially Mid at 22

**Tags**: `hr`, `turnover`, `finance`, `cost-analysis`, `segmentation`, `non-tech-domain`
