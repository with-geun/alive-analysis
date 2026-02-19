# Scenario Briefing: "Which onboarding flow is better?"

## Your Role
You are a data analyst at **FlowSaaS**, a B2B SaaS product with ~8,000 monthly signups. The PM has sent you a Slack message:

> "Hey — we ran Flow B (the simplified 3-step onboarding) alongside our current Flow A (5-step) for the past two weeks. Before we ship Flow B to everyone, can you look at the data and tell me which one we should go with? Want to make the call by end of this week."

## Context
- **Flow A** (current): 5-step onboarding — email, password, role selection, company info, **mandatory phone verification**
- **Flow B** (redesign): 3-step onboarding — email, password, **optional email verification** (no phone required)
- Both flows ran as an informal split from **Jan 27 – Feb 9** (2 weeks)
- Users were not randomly assigned; the split was done by acquisition channel (new feature in the routing layer)
- The product uses **Mixpanel** for funnel tracking and has a D7 activation event ("user completes first core action within 7 days")

## Available Data
You have access to:
1. **Mixpanel funnel report** — signup completion rates by channel and flow, exported CSV
2. **User segment breakdown** — counts per flow per acquisition channel
3. **D7 activation data** — available after you have reviewed the funnel data (revealed in INVESTIGATE stage)

## Your Task
Use the ALIVE loop to evaluate Flow A vs. Flow B and make a clear recommendation to the PM.

## Deadline
2 days (this is a Quick analysis)
