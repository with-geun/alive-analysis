# Data: VOICE Stage

> Additional context available when preparing stakeholder communication.

---

## Counter-metric Checks

| Guardrail Metric | Baseline | Feb 3-9 | Status |
|-----------------|----------|---------|--------|
| Push unsubscribe rate | 0.3% | 0.3% | Stable — no notification fatigue |
| App crash rate (Android) | 0.8% | 0.8% | Unchanged — not a stability issue |
| Session depth (avg pages/session) | 4.2 | 4.1 | Negligible change |
| 7-day retention (new users) | 38% | 37% | Stable — acquisition quality unchanged |

*The issue is delivery (users not receiving push), not engagement quality or app stability.*

---

## Revenue Impact Estimate

- Push notification-driven DAU: 35,000 baseline → 22,000 (Feb 3-9)
- Lost push sessions per day: ~13,000
- Average revenue per push-driven session: ~$1.00
- Estimated daily revenue loss: **~$13,000/day**
- Cumulative (7 days): ~$91,000

*This estimate is conservative. Push-driven users have higher purchase intent than organic visitors.*

---

## Stakeholder Context Notes

**CEO** — Wants a confidence call: is this seasonal noise or a real problem? One-sentence answer expected. Timeline for recovery matters most.

**Engineering (Platform team)** — Owns the FCM migration. Needs specific technical details: which system broke, what the mechanism is, where to look. They have the `PushService` codebase.

**Product team** — Concerned about whether to pause the current sprint (which includes the v3.2 navigation changes). They need reassurance that the navigation update is not the cause, and a recovery timeline.
