# Quick Investigation — Employee Turnover Cost Analysis

> **ID**: Q-2026-0213-002
> **Type**: Quick Analysis (Investigation)
> **Created**: 2026-02-13
> **Status**: Archived

## ASK
**Question**: "Engineering turnover increased from 12% to 19% this year. What is the financial impact and which segments are most affected?"

**Framing**: Investigation (quantify the problem and identify patterns)

**Context**: HR team needs to justify a retention budget increase to the CFO. Need concrete cost figures broken down by role level to prioritize interventions.

## LOOK
**Data source**: HRIS (Human Resource Information System) export, Finance department cost reports

**Turnover by level** (annualized, Engineering dept):

| Level | Last Year | This Year | Headcount | Departures |
|-------|-----------|-----------|-----------|------------|
| Junior (L1-L2) | 18% | 22% | 120 | 26 |
| Mid (L3-L4) | 10% | 20% | 85 | 17 |
| Senior (L5+) | 6% | 12% | 45 | 5 |
| All Engineering | 12% | 19% | 250 | 48 |

**Replacement cost per departure** (industry benchmark + internal data):

| Level | Recruiting | Onboarding | Lost Productivity | Total per Head |
|-------|-----------|------------|-------------------|---------------|
| Junior | $15K | $8K | $12K | $35K |
| Mid | $25K | $15K | $40K | $80K |
| Senior | $45K | $20K | $85K | $150K |

**External factors**: Industry-wide tech hiring surge. Two competitors raised base salaries 15% in Q3.

## INVESTIGATE
- **Total estimated cost**: (26 × $35K) + (17 × $80K) + (5 × $150K) = $910K + $1,360K + $750K = **$3.02M** this year
- **Biggest cost driver**: Mid-level turnover doubled (10% → 20%) and has the highest volume × cost combination ($1.36M)
- **Mid-level pattern**: Exit interviews show 70% cite "lack of growth path" — not compensation
- Junior turnover increased modestly (+4pp (percentage points)) — mostly normal early-career movement
- Senior turnover doubled (6% → 12%) but small absolute numbers — 3 of 5 departures went to the same competitor
- **Key insight**: The problem is different by level. Mid-level is a career development issue. Senior is a targeted poaching issue.

## VOICE
**So What**: Engineering turnover costs an estimated $3.02M this year, up from ~$1.5M last year. Mid-level engineers are the highest-impact segment — they're leaving due to career growth concerns, not pay.

**Now What**:
- **Priority 1**: Launch a mid-level career ladder program (estimated cost: $200K/year for mentorship + promotion track redesign). If it reduces mid-level turnover by just 5pp, it saves ~$400K/year.
- **Priority 2**: Targeted retention packages for senior engineers at poaching risk (3-5 individuals)
- **Monitor**: Quarterly turnover rate by level as the primary metric. Employee satisfaction score (eNPS) as a leading indicator.

**Confidence**: High for cost estimates (based on actual departures + industry benchmarks). Medium for root causes (exit interview data has self-reporting bias).

## EVOLVE
- **Follow-up**: Survey current mid-level engineers on career development satisfaction (anonymous, before designing the program)
- **Counter-metric to watch**: Time-to-fill for open positions (if the job market tightens, replacement costs could increase further)
- **Reusable insight**: Turnover analysis should always be segmented by level — aggregate turnover rate hides very different problems requiring different solutions

## Quick Checklist
- [x] Is the purpose clear and framed? — Quantify turnover cost, identify patterns
- [x] Was the data broken down by groups? — By role level
- [x] Were alternative explanations considered? — Compensation vs career growth vs poaching
- [x] Does the conclusion answer the question with confidence? — Yes, $3.02M impact, mid-level is priority
- [x] Is there enough data? — Full year of HRIS data, 250 headcount, 48 departures

**Tags**: `hr`, `turnover`, `finance`, `cost-analysis`
