# Quick Investigation — Warehouse Fulfillment Delay

> **ID**: Q-2026-0213-001
> **Type**: Quick Analysis (Root Cause)
> **Created**: 2026-02-13
> **Status**: Archived

## ASK
**Question**: "Why has average order fulfillment time increased from 1.2 days to 2.1 days over the past 3 weeks?"

**Framing**: Root cause analysis (why did this happen?)

**Context**: Operations team noticed SLA breaches increasing. Customer complaints about late deliveries rose 40%. Need to identify whether this is a capacity issue, process issue, or seasonal effect.

## LOOK
**Data source**: WMS (Warehouse Management System) export, carrier tracking API

**Fulfillment time by stage** (hours, last 3 weeks vs prior 3 weeks):

| Stage | Before | After | Change |
|-------|--------|-------|--------|
| Pick & Pack | 4.2h | 4.5h | +0.3h |
| Quality Check | 1.1h | 1.0h | -0.1h |
| Carrier Handoff | 2.8h | 9.6h | +6.8h |
| In-Transit | 20.7h | 21.2h | +0.5h |

**By warehouse**:

| Warehouse | Before | After | Volume Change |
|-----------|--------|-------|--------------|
| East Hub (NJ) | 1.1 days | 1.3 days | +5% |
| West Hub (CA) | 1.3 days | 3.2 days | +35% |
| Central (TX) | 1.2 days | 1.4 days | +8% |

**External factors**: No major weather events. No carrier service changes announced.

## INVESTIGATE
- The delay is concentrated in **one stage** (Carrier Handoff) and **one warehouse** (West Hub CA)
- West Hub volume increased 35% due to a new B2B wholesale channel launched 3 weeks ago
- B2B orders are larger (avg 45 items vs 3 items for B2C) but use the same single carrier handoff slot
- **Root cause**: B2B palletized shipments are blocking the carrier dock, delaying B2C parcel pickups
- East and Central hubs have separate B2B/B2C dock areas — West Hub does not
- **No Simpson's Paradox** (a phenomenon where the overall trend reverses when data is split into groups): the problem is genuinely isolated to West Hub

## VOICE
**So What**: Fulfillment delays are caused by B2B shipments blocking the carrier dock at the West Hub. This is a physical capacity constraint, not a staffing or process issue.

**Now What**:
- Immediate: Schedule B2B carrier pickups in a separate time window (AM for B2B, PM for B2C)
- Short-term: Designate a second dock door for B2C parcels at West Hub
- Monitor: B2C fulfillment SLA compliance as counter-metric (a metric we track to ensure our B2B growth doesn't degrade B2C service)

**Confidence**: High — the data clearly isolates the problem to one stage, one warehouse, and one time period matching the B2B launch.

## EVOLVE
- **Follow-up**: After implementing separate dock schedules, check if fulfillment time returns to <1.5 days within 1 week
- **Counter-metric to watch**: B2B fulfillment time (ensure the fix doesn't just shift the problem)
- **Reusable insight**: When launching new fulfillment channels, always assess physical dock capacity before go-live

## Quick Checklist
- [x] Is the purpose clear and framed? — Root cause, why fulfillment delayed
- [x] Was the data broken down by groups? — By stage and warehouse
- [x] Were alternative explanations considered? — Weather, carriers, seasonality ruled out
- [x] Does the conclusion answer the question with confidence? — Yes, dock contention at West Hub
- [x] Is there enough data? — 3 weeks of order data, 3 warehouses compared

**Tags**: `logistics`, `fulfillment`, `operations`, `root-cause`
