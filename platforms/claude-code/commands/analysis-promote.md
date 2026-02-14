# /analysis-promote

Promote a Quick analysis to Full when it outgrows the Quick format.

## Instructions

### Step 1: Identify the Quick analysis

- If argument provided (Quick ID): use that analysis
- If no argument: read `.analysis/status.md` and show active Quick analyses. Ask user which to promote.
- If no Quick analyses exist: tell user "No active Quick analyses to promote."

### Step 2: Assess promotion readiness

Read the Quick analysis file and evaluate whether it has outgrown the Quick format.

**Auto-detection signals** (AI should proactively suggest promotion when 2+ signals are present):

| Signal | Detection | Why it matters |
|--------|-----------|----------------|
| Multiple hypotheses | INVESTIGATE section lists 3+ hypotheses or findings | Quick is for one focused question |
| Multiple data sources | LOOK section references 2+ distinct data sources | Data complexity exceeds Quick scope |
| Long INVESTIGATE | INVESTIGATE section exceeds ~20 lines of content | Analysis depth warrants full structure |
| Multiple audiences | VOICE section addresses 2+ distinct stakeholder groups | Communication complexity needs full VOICE |
| Follow-up spawning | EVOLVE section proposes 2+ follow-up analyses | The question is branching |
| Metric proposal | EVOLVE section has a "Proposed New Metrics" block filled | Metric definition needs full rigor |
| Scope creep noted | A "Parked Questions" section exists | The scope expanded beyond Quick |
| Data quality issue | A "Data Quality Issue" section exists | Quality issues need full documentation |

**Promotion prompt:**
```
AI: "This Quick analysis is showing signs of outgrowing the format:
     - {signal 1}
     - {signal 2}

     Promoting to Full would give you:
     - Separate files for each ALIVE stage (easier to navigate)
     - Full checklists (more rigorous quality control)
     - Better structure for multiple hypotheses/audiences

     Want to promote it? (This keeps the original Quick file for reference)"
```

**When NOT to promote:**
- The Quick analysis is nearly done (VOICE or EVOLVE stage, wrapping up)
- The user explicitly chose Quick for speed and is OK with the trade-offs
- The "complexity" is just thorough documentation, not actual scope growth

### Step 2b: Handle "When NOT to promote" conditions

If the analysis matches a "When NOT to promote" condition:

- **AI-initiated (proactive suggestion)**: Do NOT suggest promotion. The "When NOT to promote" rules take precedence.
- **User-initiated (explicit `/analysis-promote`)**: Warn the user with the specific reason and explain the trade-off:
  - Nearly done: "This analysis is already in {VOICE/EVOLVE} and nearly complete. Promoting now means restructuring work that's almost done. Want to finish as Quick and archive instead?"
  - User explicitly chose Quick: "You chose Quick for speed. Promoting now adds structure but also overhead. Continue anyway?"
  - If user confirms after the warning, proceed to Step 3.

### Step 3: Confirm with user

Ask: "Ready to promote {ID} to a Full analysis? The original Quick file will be kept for reference."

If user declines: respect the decision, add a note: "Staying Quick — consider promoting later if scope grows."

### Step 4: Execute promotion

Run the existing Quick→Full succession logic from `/analysis-new --from {ID}`:

1. Generate a new Full ID (same type as the Quick: Investigation/Modeling/Simulation)
2. Create the Full analysis folder in `analyses/active/{new-ID}_{slug}/`
3. Map Quick sections to Full files using the content mapping from `analysis-new.md` Step 2c:
   - ASK → `01_ask.md`
   - LOOK → `02_look.md`
   - INVESTIGATE → `03_investigate.md`
   - VOICE → `04_voice.md`
   - EVOLVE → `05_evolve.md`
4. Only generate files for non-empty sections (same rule as Step 2c)
5. Create `assets/` folder

### Step 5: Update references

1. **Quick file**: Update Status to `⬆️ Promoted to Full: {new Full ID}`
2. **status.md**:
   - Change Quick row's Stage to `⬆️ Promoted → {new Full ID}`
   - Add new Full row with current stage
3. **Tags**: Carry over any tags from the Quick analysis to the Full analysis

### Step 6: Confirmation

Tell the user:
- "Promoted {Quick ID} → {Full ID}"
- Show the new folder path
- Indicate which stage files were generated
- "Review and expand the content in `{last file}`, then run `/analysis-next` to continue."
- "Original Quick file is preserved at {path} for reference."

## Proactive Promotion (AI Behavior)

The AI should monitor Quick analyses during the conversation and proactively suggest promotion when signals are detected. This is NOT a separate command — it's conversational guidance.

**When to suggest:**
- During INVESTIGATE: "This analysis is getting complex — 4 hypotheses, 2 data sources. Want to promote to Full for better structure?"
- During VOICE: "You're writing for 3 different audiences. A Full analysis would give you a dedicated VOICE file for this."
- During EVOLVE: "You've proposed 3 follow-ups and a new metric. This might benefit from Full format."

**How to suggest:**
- Be helpful, not pushy — the user chose Quick for a reason
- Show the specific signals, not just "this is complex"
- Make it easy: "Just say `/analysis-promote` and I'll handle the rest"
- If user declines twice for the same analysis, stop suggesting
