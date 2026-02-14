# /analysis retro

Generate an automatic retrospective report from archived analyses.

## Instructions

**Before executing**: Read `.analysis/status.md` and `.analysis/config.md` to load current state.

### Step 1: Parse period parameters

Check the user's arguments:
- `--last-month` (default) -- previous calendar month
- `--last-quarter` -- previous 3 calendar months
- `--range {from} {to}` -- custom range (e.g., `--range 2026-01 2026-03`)
- `--all` -- all archived analyses

If no arguments provided, default to `--last-month`.

### Step 2: Scan archived analyses

Read all analyses in `analyses/archive/{YYYY-MM}/` folders within the specified period.

For each analysis, extract:
- **ID** and **title** (from folder/file name)
- **Type**: Investigation / Modeling / Simulation (from file header or ASK stage)
- **Mode**: Full / Quick
- **Tags** (from file header or status.md)
- **Key Insight** (from summary.md or EVOLVE one-sentence insight)
- **Confidence levels** (from VOICE: count of High/Medium/Low)
- **Impact Tracking table** (from EVOLVE):
  - Each recommendation's Decision (Accepted/Rejected/Modified/Pending)
  - Each recommendation's Status (Not started/In progress/Done)
  - Outcome notes
- **Follow-up proposals** (from EVOLVE "Follow-up Analyses" section)
- **Duration** (from ID date to archive date)

Also scan `analyses/active/` for any follow-up analyses that reference archived ones.

### Step 3: Generate retro report

Create the file at `analyses/.retro/retro_{period}.md` (e.g., `retro_2026-02.md` or `retro_2026-Q1.md`).

Create the `.retro/` directory inside `analyses/` if it doesn't exist.

Use this template:

```markdown
# Analysis Retrospective -- {Period}
> Generated: {today}
> Scope: {N} analyses from {period}

---

## Summary

{2-3 sentence overview of the period's analysis activity, major themes, and key outcomes.}

---

## Analysis Activity

| Metric | Count |
|--------|-------|
| Total analyses | {N} |
| Full | {n} |
| Quick | {n} |
| Investigation | {n} |
| Modeling | {n} |
| Simulation | {n} |

Average duration: {X} days (Full), {X} days (Quick)

---

## Impact Tracking

### Decision Outcomes
| Status | Count | % |
|--------|-------|---|
| Accepted | {n} | {%} |
| Rejected | {n} | {%} |
| Modified | {n} | {%} |
| Pending | {n} | {%} |

### Top Wins
{List the recommendations that were Accepted + Done with positive outcomes. Max 5.}

1. **{ID}** -- {Recommendation} -> {Outcome}
2. ...

### Unresolved Items
{List recommendations still Pending or Not Started.}

- {ID} Rec #{n}: "{recommendation}" -- {status}
- ...

---

## Patterns

### Recurring Topics
{Topics/tags that appeared in 3+ analyses.}

| Topic | Analyses | Key Trend |
|-------|----------|-----------|
| {tag} | {count} | {one-line summary of how findings evolved} |

### Common Findings
{Findings that appear across multiple analyses -- convergent evidence.}

- {Finding shared by IDs}

### Confidence Distribution
| Level | Count | % |
|-------|-------|---|
| High | {n} | {%} |
| Medium | {n} | {%} |
| Low | {n} | {%} |

{If Low > 30%: "High proportion of low-confidence findings. Consider investing in better data infrastructure or longer analysis timelines."}

---

## Unresolved Follow-ups

{EVOLVE sections propose follow-up analyses. List those that haven't been started yet.}

| Source | Proposed Follow-up | Status |
|--------|--------------------|--------|
| {ID} | {follow-up question} | Not started / Started as {new-ID} |

{If >50% unstarted: "Most follow-up proposals haven't been acted on. Consider prioritizing the top 2-3 as next analyses."}

---

## Recommendations

Based on this retrospective:

1. **{Recommendation}**: {Explanation with supporting data}
2. **{Recommendation}**: {Explanation}
3. **{Recommendation}**: {Explanation}

{Generate 2-4 recommendations based on the patterns above.}

---

## Appendix -- Full Analysis List

| # | ID | Title | Type | Mode | Tags | Key Insight | Impact |
|---|-----|-------|------|------|------|-------------|--------|
| 1 | {ID} | {title} | {type} | {mode} | {tags} | {insight} | {Accepted/Rejected/Pending} |
| 2 | ... | ... | ... | ... | ... | ... | ... |
```

### Step 4: Handle edge cases

- **No analyses in period**: Tell the user "No archived analyses found for {period}. Nothing to retrospect."
- **Very few analyses (1-2)**: Generate a simplified retro without Patterns and Cross-References sections. Note: "Only {N} analyses in this period -- patterns require more data."
- **Missing data**: If Impact Tracking is empty for most analyses, note it in the Summary and add a recommendation to improve tracking discipline.
- **Active analyses from the period**: If there are still-active analyses whose IDs fall within the retro period, mention them: "{N} analyses from this period are still active and not included."

### Step 5: Confirmation

Tell the user:
- Retro report generated at `analyses/.retro/retro_{period}.md`
- Show the Summary section inline
- Show the Impact Tracking decision outcomes
- Show the top recommendation
- Suggest: "Review the full report and share it with your team. Use `/analysis search` to dig deeper into any pattern."
- If unresolved follow-ups exist: "Consider starting one of the {N} unresolved follow-up analyses."

**After executing**: Update `.analysis/status.md` with any state changes.
