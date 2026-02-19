# Hints: LOOK Stage

---

## Level 1 — Direction

Before you build any model, you need to know where you're starting from. What is the current state? What data do you have that tells you how this business actually works today? And do you have any historical evidence of what happens when delivery fees change?

---

## Level 2 — Specific

Three things to do in LOOK for a Simulation:

1. **Calculate current unit economics** — You need a precise baseline before you can model changes. What does QuickBite earn per order today, broken down by revenue line and cost line? Don't guess — use the actual numbers from the data.

2. **Find historical analogues** — You're lucky: QuickBite ran a 50% delivery fee discount promo last quarter. That's real behavioral data. What did it show? Be careful: promo data is often optimistic (novelty effect, marketing support). Look at the week-by-week trend, not just the overall headline number.

3. **Check the competitive landscape** — A fee reduction doesn't happen in a vacuum. What are competitors charging? What happened when QuickBite ran a promo last time — did competitors respond? Factor competitive response into your model framing.

Also: distinguish **fixed vs variable** elements of your revenue and cost structure. This matters for calculating how the model shifts at different volume levels.

---

## Level 3 — Near-Answer

Key numbers to calculate in LOOK:

**Current monthly baseline:**
- Orders: 450,000/month
- Revenue: (₩3,750 commission + ₩3,000 delivery fee) × 450,000 = ₩3.04B
- Rider costs: ₩2,200 × 450,000 = ₩990M
- Net monthly contribution: ₩2.05B

**From the promo data (your historical analogue):**
- Week 1: +28% orders (novelty spike)
- Week 4: +15% orders (the number that matters for sustained impact)
- The headline "+22%" overstates the permanent effect

**Fixed vs variable:**
- Fixed per order: ₩1,500 rider base pay (does not change with volume)
- Variable per order: ₩700 rider distance cost (negotiable at scale)
- Revenue fixed per order: ₩3,750 commission (percentage of GMV)
- Revenue variable per order: delivery fee (this is what you're changing)

**Competitor context:**
- Competitor A at ₩2,500 has already been gaining share
- Competitor A matched QuickBite's last promo in 2 weeks — assume they will again
