# Hints: VOICE Stage

## Level 1: Direction
Three stakeholders need different messages: the Head of CS needs a workflow she can operationalize, the CFO needs ROI numbers, and VP Engineering needs to understand the maintenance commitment. The model itself is not the deliverable — the deliverable is a system that helps CS save accounts. Match the model's output to the CS team's capacity: 100 interventions per month.

## Level 2: Specific
Key communication points:
1. **Deployment recommendation**: Deploy rule-based v1 first (week 1-2). It's transparent, CS trusts it, and it captures 80% of the ML model's value. Upgrade to GBT v2 in month 2 after CS workflow is validated.
2. **Precision-recall operating point**: Flag the top 100 accounts weekly. At 25% save rate, rule-based v1 saves ~8 accounts/month ($8,466/yr retained). GBT v2 saves ~10.5/month ($10,710/yr). Both are ROI-positive against $60K/yr intervention cost.
3. **ROI framing for CFO**: Net annual value of rule-based v1 = $41,592. GBT v2 = $68,520. Breakeven save rate is ~15% — current 25% rate is well above. Investment pays back in month 2.

## Level 3: Near-Answer
Full VOICE stage:
- **Head of CS**: "Every Monday, your team gets a ranked list of the top 100 at-risk accounts with a risk reason (e.g., 'login frequency declining 40% over 90 days'). Assign 20 per rep. We start with transparent rules in week 1, then upgrade to a more accurate model in month 2 after we validate the workflow together."
- **CFO**: "Annual intervention cost: $60K. Expected retained revenue (conservative, rule-based): $101K LTV. Net value: $42K/year. Upgrading to ML in month 2 adds ~$27K/year. Breakeven requires only a 15% save rate — we're at 25%. This is ROI-positive from month 1."
- **VP Engineering**: "Phase 1 (rules) is a SQL query on a weekly cron — no ML infrastructure. Phase 2 (GBT) needs a Python scoring service, feature pipeline, and monthly retraining job. Total eng investment: ~2 weeks for Phase 1, ~4 weeks for Phase 2. Ongoing: ~4 hours/month maintenance."
- **Limitations**: Save rate of 25% is a historical average — it may change with proactive outreach. Hidden churners may respond differently to intervention than obvious churners (untested). Model performance assumes stable product and market conditions.
