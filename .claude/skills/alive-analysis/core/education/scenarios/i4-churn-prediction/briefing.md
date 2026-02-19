# Scenario Briefing: "Can we predict which users will churn?"

## Your Role
You are a data analyst at **CloudDash**, a B2B SaaS analytics dashboard platform with ~2,400 active accounts and an average revenue per user (ARPU) of $85/month. The Head of Customer Success has scheduled a meeting with you:

> "We're losing about 6.2% of our accounts every month — that was 149 cancellations last month. My team is five reps, and each can handle about 20 meaningful outreach calls a month, so we have 100 intervention slots. Right now we only react when someone submits a cancellation request, and by then it's too late. I want a model that tells us WHO is about to churn so we can reach them before they decide to leave." — Head of Customer Success

## Context
- CloudDash serves mid-market B2B companies (50-500 employees) with a real-time analytics dashboard
- Product is sold on both monthly ($85/mo) and annual ($75/mo, billed $900/yr) contracts
- Current monthly churn rate: 6.2% (149 of 2,400 accounts churned last month)
- CS team capacity: 5 reps x 20 interventions/month = **100 interventions/month**
- Historical intervention save rate (when CS reaches a dissatisfied customer): ~25%
- Average intervention cost: ~$50 per touch (rep time + tooling)

## Available Data
1. **Account data** — Account age, contract type, plan tier, company size, industry vertical
2. **Usage logs** — Daily active users per account, feature adoption, login frequency, dashboard views
3. **Support data** — Ticket volume, ticket severity, NPS scores (collected quarterly, 40% response rate)
4. **Billing data** — Payment history, plan changes, discount usage
5. **Churn records** — 12 months of historical churn labels (canceled + 30-day inactive)

## Your Task
Conduct a **Full Modeling analysis** using the ALIVE framework.

This is NOT an investigation (nothing is broken). This is a **prediction problem**: you need to define the target, explore features, compare modeling approaches, and deliver a deployable recommendation that fits the CS team's operational constraints.

**Deliverables**:
- A clearly defined prediction target with a time window
- Feature exploration with data quality assessment
- Model comparison (at least rule-based vs ML)
- A deployment recommendation matched to CS capacity (100/month)
- A monitoring and feedback loop plan

## Timeline
Prototype in 2 weeks, deploy in 4 weeks (Full analysis format — 5 ALIVE stages across 5 files)

## Key Challenge
"Days since last login" is trivially the strongest single predictor, but it only catches the obvious churners — accounts that have already disengaged. **31% of churners are "hidden"**: they are still logging in but their engagement is declining**. These hidden churners are the highest-value CS targets because they can still be saved. A simple 3-rule model achieves 80% of the ML model's F1 score — is the complexity of ML worth it? Your job is to make the tradeoffs visible and give the CS team a model they can actually use.
