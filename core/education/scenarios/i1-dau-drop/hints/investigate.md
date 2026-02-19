# Hints: INVESTIGATE Stage

## Level 1 (Direction)
You have identified Android push as the primary signal. Now prove it — and quantify how much of the 15% each factor explains. The answer is not "Android push broke." The answer is "X% from push, Y% from holiday, Z% from bot filter, with confidence levels."

## Level 2 (Specific)
Pull Android push delivery rates from `platform_eng.push_delivery`. Compare before/after the migration. Then use historical Lunar New Year data to estimate the seasonal contribution. Calculate the bot filter impact in DAU terms. Make sure the contributions sum to ~100% of the observed drop.

## Level 3 (Near-answer)
Contribution breakdown:
- **Push failure (~60%)**: Android FCM delivery rate dropped 94% → 61% on Feb 3 — timing matches migration exactly. iOS unaffected (control group). This caused ~10,800 daily DAU loss.
- **Lunar New Year (~25%)**: Historical 5-8% dip, consistent with organic and non-push segment behavior. Recovers naturally. ~4,500 daily DAU loss.
- **Bot filter (~10%)**: 2,000 sessions removed, confirmed as bots. ~2,000 daily DAU reduction.
- **Unknown/noise (~5%)**: Residual unattributed.

Sensitivity checks: Extend window to Feb 14 — Android push DAU still depressed (push issue ongoing), non-push segments recovering (holiday resolved). Competitor hypothesis: no uninstall spike, paid acquisition stable — not supported.
