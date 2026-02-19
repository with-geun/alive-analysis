# INVESTIGATE — Why did DAU drop 15%?
> ID: L-i1-dau-drop | Mode: Learn | Stage: INVESTIGATE | Difficulty: Intermediate | Updated: 2026-02-11

> **Reference Solution** — This is the expected output for the INVESTIGATE stage. Compare your own 03_investigate.md against this after completing the stage.

## Hypothesis Testing

### Hypothesis 1: Push notification migration broke Android FCM delivery
**Evidence for:**
- Android push delivery rate fell from 94% to 61% on Feb 3 (data from `platform_eng.push_delivery`)
- iOS APNs delivery rate stable at 92-94% throughout — unaffected by migration
- Timing matches exactly: migration completed Feb 3 AM, delivery failure observed Feb 3 AM, DAU drop starts Feb 3 PM
- Android push-driven DAU still depressed through Feb 14 — sustained failure, not a blip
- iOS is a natural control group: same migration, different delivery path, unaffected

**Evidence against:**
- None found

**Verdict**: Confirmed — Android FCM delivery broke during migration

---

### Hypothesis 2: Lunar New Year holiday reduced organic usage
**Evidence for:**
- Historical ShopFlow data: 5-8% DAU dip during Lunar New Year (consistent across 2024, 2025)
- Organic DAU dropped 7.7% — consistent with historical holiday effect
- Non-push, non-Android segments show ~7-8% dip

**Evidence against:**
- Drop continued through Feb 9, well past holiday end (Feb 4)
- Continuing drop concentrated in Android push users — not the holiday pattern

**Verdict**: Partially explains — accounts for ~25% of the total drop (the organic/non-push segment dip)

---

### Hypothesis 3: Competitor "QuickBuy" stole users
**Evidence for:**
- QuickBuy launched same-day delivery Feb 1

**Evidence against:**
- Paid acquisition CPC and install rate: unchanged (if QuickBuy was pulling users, CAC would spike)
- ShopFlow uninstall rate: no spike detected
- Power user retention dipped only 10.9% (largely explained by holiday + push)

**Verdict**: Not supported — no evidence of meaningful user migration in this window

---

### Hypothesis 4: Bot filter removed legitimate sessions
**Evidence for:**
- Bot filter deployed Feb 3, removed ~2,000 sessions/day

**Evidence against:**
- Sessions confirmed as bots by filter review
- Impact limited to 2,000/18,000 = ~11% of the drop

**Verdict**: Partially explains — minor, confirmed, expected

---

### Hypothesis 5: App update v3.2 caused a UX regression
**Evidence for:**
- Released Feb 2, one day before drop

**Evidence against:**
- iOS also received v3.2 but shows no extra drop beyond holiday baseline
- Web (also updated) shows same -7.7% as iOS
- Drop is channel-specific (push), not platform-navigation specific

**Verdict**: Not supported — the app update is not the cause

---

## Contribution Estimate
| Factor | Contribution | DAU Impact | Confidence |
|--------|-------------|-----------|------------|
| Android push delivery failure | ~60% of total drop | ~10,800/day | High |
| Lunar New Year holiday | ~25% of total drop | ~4,500/day | High |
| Bot filter cleanup | ~10% of total drop | ~1,800/day | High |
| Unknown / noise | ~5% | ~900/day | — |

*These contributions are estimates, not precisely measured splits. The 60/25/10/5 breakdown is a reasonable approximation — see Sensitivity Analysis.*

## Multi-Lens Analysis

### Macro (market/industry)
- Competitor threat (QuickBuy): real as a long-term signal, but no measurable impact in this window
- Holiday effect: confirmed, bounded, predictable

### Meso (company/product)
- Push infra migration: root cause of the primary drop
- v3.2 app update: not causal (iOS/Web unaffected despite same update)
- Bot filter: expected infra hygiene, minor impact

### Micro (user/session)
- D8-D30 returning users hit hardest: they rely on push to re-engage, and their push notifications weren't arriving
- Power users (D30+) partially protected: stronger intrinsic motivation, app opens even without push

## Causation Verification (for Push Failure hypothesis)
- **Time ordering**: Migration completed Feb 3 AM → delivery failure Feb 3 AM → DAU drop Feb 3 PM. Cause precedes effect.
- **Mechanism**: FCM delivery rate dropped from 94% to 61%. The push notifications that would have re-engaged 13K users per day were not delivered.
- **Counterfactual**: iOS delivery rate unchanged, iOS DAU drop limited to holiday-consistent 7.7%. Android-specific push path affected, Android DAU dropped 23.6%.
- **Conclusion**: Causal — push migration broke Android delivery, which caused the DAU drop

## Sensitivity Analysis
- **Exclude bot filter**: Drop changes from 15% to 13.3% — conclusion unchanged, push failure still primary cause
- **Extend window to Feb 14**: Android push DAU still depressed at ~28K vs 35K baseline. Non-push segments recovering (holiday resolved). Push issue is ongoing.
- **Historical Lunar New Year comparison (2025)**: Non-push segments in 2025 dropped ~7% during holiday and recovered within 3 days. Pattern matches 2026 non-push behavior — holiday is well-characterized.
- **Different metric definition (Weekly Active Users instead of DAU)**: WAU drop would show similar ~15% decline, concentrated in Android push users.

## Checklist — INVESTIGATE
- [x] Have you tested MULTIPLE hypotheses? — 5 tested: 1 confirmed, 2 partial, 2 eliminated
- [x] Have you applied multi-lens analysis? — Macro (holiday, competitor), Meso (push system, app update), Micro (user segments)
- [x] If claiming causation, have you verified? — Time ordering, mechanism, counterfactual (iOS), dose-response
- [x] Have you performed sensitivity analysis? — Date range, bot filter, historical comparison, metric definition
- [x] Have you assigned confidence levels? — High for all three main factors, contribution estimates noted as approximations
