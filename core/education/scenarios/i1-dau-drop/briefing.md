# Scenario Briefing: "Why did DAU drop 15%?"

## Your Role
You are a data analyst at **ShopFlow**, a mobile-first e-commerce app with 120K DAU. The CEO flagged an unusual metric drop in the Monday morning review and tagged you directly:

> "DAU dropped from 120K to 102K — that's a 15% decline week-over-week starting Feb 3. We had several things launch last week. I need to know if this is real, what caused it, and what we're doing about it. Can you get me something by Wednesday?"

## Context
- ShopFlow operates on iOS, Android, and Web
- App update v3.2 was released on Feb 2 (new bottom navigation redesign)
- Push notification system migration from legacy provider to FCM was performed Feb 1-3
- Loyalty program tier thresholds were adjusted on Jan 28 (some users downgraded)
- Lunar New Year ran Feb 1-4 (significant shopping holiday in ShopFlow's primary market)
- Competitor app "QuickBuy" launched same-day delivery on Feb 1
- A heavy snowstorm hit Seoul metro area Feb 3-4

## Available Data
1. **BigQuery** — `shopflow.events` table (event-level user activity logs, user segments)
2. **GA4** — Traffic sources, session data, acquisition channels
3. **Push delivery logs** — `platform_eng.push_delivery` table (delivery rates by platform)
4. **App Store reviews** — Public reviews with timestamps (qualitative signal)

## Your Task
Use the full ALIVE loop to investigate the DAU drop. This is a **Full Investigation** — produce 5 separate stage files (01_ask.md through 05_evolve.md).

## Timeline
3 days (results due Wednesday)

## Key Challenge
Multiple factors are potentially contributing at the same time. Resist the temptation to stop at the first plausible explanation. Your job is to quantify each factor's contribution and give decision-makers a clear picture of what actually drove the drop.
