# Hints: EVOLVE Stage

## Level 1: Direction
The test failed, but the failure taught you something. What would a proper re-test look like? What monitoring would catch the SRM and novelty effect earlier next time? And what reusable principles can you extract — not just for ShopNow, but for any A/B test evaluation?

## Level 2: Specific
Your re-test plan should address all three failures: (1) Fix the caching bug so randomization is clean — and add an SRM check that runs daily, not just at the end. (2) Run longer than 3 weeks to account for novelty effect — or use a "burn-in" period where you discard the first week of data. (3) Add AOV as a hard guardrail: if AOV drops more than 5%, the test auto-pauses. For reusable knowledge, document an "Experiment Evaluation Checklist" that any analyst can use before approving a test result.

## Level 3: Near-Answer
Complete EVOLVE plan:
1. **Re-test design**: Fix caching bug. 50/50 split with daily SRM monitoring (auto-alert if chi-square p < 0.05). Run for 4 weeks minimum. Consider mobile-only test first (stronger signal, faster sample size). Discard first 7 days for novelty burn-in, or analyze with and without Week 1 as a sensitivity check.
2. **Guardrail gates**: AOV must not drop more than 5% (hard gate — auto-pause). Revenue per user must remain flat or positive. Error rate must not increase more than 0.5 pp.
3. **Monitoring plan**: SRM check daily (automated), conversion by device daily, AOV by group daily, novelty trend weekly (compare rolling 7-day lift vs cumulative).
4. **Reusable Experiment Evaluation Checklist**:
   - [ ] SRM check passed (chi-square p > 0.05)?
   - [ ] Sample size meets power analysis requirement?
   - [ ] Runtime includes at least 2 full weekly cycles?
   - [ ] Novelty effect assessed (Week 1 vs Week 3 lift)?
   - [ ] All guardrail metrics within acceptable range?
   - [ ] Results hold across key segments (device, new/returning)?
   - [ ] SUTVA validated (no interference between groups)?
5. **Impact tracking**: Link this analysis to the decision (no-ship), schedule re-test for Feb 17, set outcome check for March 10.
