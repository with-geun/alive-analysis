# Hints: VOICE Stage

## Level 1: Direction
The answer is not a simple "ship it" or "kill it." The SRM invalidates the overall result, but the mobile signal is interesting. The AOV drop is a real concern. Frame your recommendation as a nuanced decision — not a binary one. And remember: the PM, the CFO, and the Engineering lead each need to hear a different message.

## Level 2: Specific
Your recommendation should be: **Do NOT ship to 100%.** Three reasons: (1) SRM makes the overall result unreliable, (2) AOV dropped 10%, and (3) the novelty effect means the conversion lift will likely not sustain. However, the mobile signal (+22.3%) is strong enough to warrant a follow-up test. Propose a re-test that fixes the caching bug, runs mobile-only (or at least segments mobile separately), and adds AOV as a hard launch gate. For the PM: explain that a flawed test shipped to 100% during the spring sale could hurt revenue. For the CFO: show the revenue-per-user math.

## Level 3: Near-Answer
Stakeholder messages:
- **PM (Jiyeon)**: "The test has a randomization flaw (SRM) that makes the headline 6.4% lift unreliable. Mobile shows a real +22% signal, but AOV dropped 10%, and the lift decayed to near-zero by Week 3. Shipping to 100% before the spring sale would risk revenue. I recommend we fix the randomization bug and re-run a clean test — we can get mobile results within 2 weeks."
- **CFO (Seonghyun)**: "Your AOV concern is justified. Despite higher conversion, revenue per checkout entrant actually dropped 4.3%. A 100% rollout would likely reduce total revenue. A mobile-only launch could be revenue-positive (+12.4% revenue per mobile entrant), but we should confirm this with a clean re-test first."
- **Eng Lead (Minho)**: "There is a caching bug in the experimentation platform v2.1 that reassigns returning visitors to Variant when cookies expire. This caused a Sample Ratio Mismatch (51.3/48.7 instead of 50/50, p < 0.001). The bug needs to be fixed before any test results from this platform can be trusted."

Confidence: High that the overall test is flawed. Medium that the mobile conversion effect is real. Low that the effect would sustain beyond Week 3.
