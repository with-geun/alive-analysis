# Hints: EVOLVE Stage

## Level 1 (Direction)
A 15% DAU drop from an infra migration went undetected for days. What monitoring would have caught this in hours? Think about the gap between when the migration completed and when the CEO flagged it.

## Level 2 (Specific)
Push delivery rate was never a monitored metric — it became one because of this incident. Define the specific threshold, cadence, and owner. Also ask: what process would have caught the Android delivery failure before it showed up in DAU?

## Level 3 (Near-answer)
Monitoring plan:
- **Metric**: Android push delivery rate — target >90%, Warning <85%, Critical <75%
- **Cadence**: Real-time alert during migrations; daily thereafter
- **Owner**: Platform Engineering (not Data — this is an infra metric)

Follow-up questions:
1. Why was push delivery not monitored during the migration window?
2. Should push delivery rate be added as a Guardrail metric in `config.md`?
3. Is there long-term retention impact for users who missed 7+ push notifications?

Reusable knowledge:
- Push delivery rate should be a standard check in any DAU investigation
- Holiday effects for ShopFlow: ~5-8% DAU dip, recovers within 3 days post-holiday
- Bot filter changes can appear as metric drops — always check recent infra changes before analyzing a drop
- Migrations should have a delivery/performance check BEFORE the post-migration DAU review
