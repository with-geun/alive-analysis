# Scenario Briefing: "Did the new checkout flow actually improve conversion?"

## Your Role
You are a data analyst at **ShopNow**, a mid-size e-commerce platform with approximately 200K monthly visitors. The product team recently completed an A/B test on the checkout flow, and the PM is eager to ship. Your job is to evaluate the experiment and make a recommendation.

The PM sent you this Slack message Monday morning:

> "Hey! The 2-step checkout test wrapped up last Friday. We ran it for 3 weeks and conversion is up 8% overall. I want to ship it to 100% of users before the spring sale campaign kicks off next week. Can you validate the numbers and give me a green light by Wednesday's product review?"

## Context
- **ShopNow** sells fashion, electronics, and home goods with an average order value of ~68,000 KRW
- The current checkout is a 4-step flow: Cart Review → Shipping Info → Payment → Confirmation
- The variant is a redesigned 2-step flow: Cart + Shipping (combined) → Payment + Confirmation (combined)
- The test ran for 3 weeks (Jan 13 - Feb 2, 2026) using ShopNow's experimentation platform (internally built)
- Traffic allocation target was 50/50 between Control and Variant
- Total users in the test: approximately 100,000 (across both groups)
- The PM's "8% conversion lift" claim is based on the aggregate results from the experimentation platform dashboard

## Available Data
1. **Experimentation platform dashboard** — aggregate results (conversion rates, sample sizes, p-values)
2. **BigQuery** — `shopnow.checkout_events` table (event-level checkout logs with user IDs, timestamps, device type, group assignment)
3. **BigQuery** — `shopnow.orders` table (completed orders with amounts, timestamps, user IDs)
4. **Pre-test power analysis document** — minimum detectable effect, required sample size, statistical power
5. **Daily assignment logs** — number of users assigned to Control vs Variant by date

## Your Task
Use the full ALIVE loop to evaluate this A/B test result. This is a **Full Experiment Evaluation** — produce 5 separate stage files (01_ask.md through 05_evolve.md).

## Timeline
2 days (product review meeting is Wednesday)

## Key Challenge
A PM is presenting an "8% lift" as a done deal and wants to ship immediately. Your job is not to rubber-stamp the result, nor to be a gatekeeper for the sake of it. Your job is to determine whether the test was valid, the result is trustworthy, and the right decision is to launch, kill, extend, or iterate. The answer may not be a simple yes or no.
