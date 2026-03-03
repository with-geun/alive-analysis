# /analysis-agent

Run a specialist sub-agent for the current analysis stage.

**Usage:**
- `/analysis-agent` — show top recommended agents for current stage
- `/analysis-agent 1` — run the #1 recommended agent
- `/analysis-agent 1 3` — run agents #1 and #3 in parallel
- `/analysis-agent all` — run all recommended agents
- `/analysis-agent "통계"` — fuzzy match by alias and run

---

## Instructions

### Step 1: Load context

1. Read `.analysis/status.md` → find active Full analysis (or ask which if multiple)
2. Read `.analysis/agent-state.md` (if exists) → load suppression history
3. Read `.analysis/agents.yml` (if exists, else fallback to `core/config/agents.yml`) → user config
4. Determine current stage from analysis folder (which stage files exist)
5. Read the current stage file (all sections)

### Step 2: Parse argument

**No argument** → go to Step 3 (show recommendations)

**Number(s)** (e.g., `1`, `1 3`, `all`) → go to Step 5 (execute directly)
- "all" = run all agents in the last recommendation block

**Free text / alias** (e.g., `"통계"`, `"hypothesis"`, `"리뷰"`) →
- Fuzzy-match against `id`, `label`, and `aliases` fields in `core/agents/registry.yml`
- If 1 match: run it directly → Step 5
- If 2+ matches: show compact list, ask user to pick (single question)
- If 0 matches: show "No match. Available agents for {stage}: {list}" and exit

### Step 3: Evaluate router (no-arg flow)

Apply routing rules from `core/agents/router.yml` for current stage:

1. **Check gates**: evaluate gate auto_run conditions → list auto-run gates separately
2. **Score optional agents**: apply rule conditions + bonuses → filter by min_score_threshold
3. **Apply suppression**: skip agents in agent-state.md for this stage (unless content hash changed)
4. **Apply user config**: skip disabled agents, honor max_recos_per_stage
5. **Take top_k**: select top 3 by score

### Step 4: Show recommendation block

```
─────────────────────────────────────────────────────
🤖 Specialist Recommendations — {STAGE} stage
  Analysis: {ID} — {title}
─────────────────────────────────────────────────────
{If auto-gates fired:}
  [auto] Running {gate-id} — {reason}

{Recommendations:}
  1. {label}  —  {reason_template from router.yml}
  2. {label}  —  {reason_template}
  3. {label}  —  {reason_template}
─────────────────────────────────────────────────────
Run? (1 / 2 / 3 / 1 3 / all / n)  →
```

- If global.ask_confirmation: false → skip question, run all automatically
- If recommendations list is empty → "No specialist recommendations for {stage} at this time."

### Step 5: Execute agents

**For each selected agent (in order: gates first, then score desc):**

1. Read `core/agents/prompts/{agent-id}.md` — the agent's prompt/instructions
2. Invoke the agent: apply its prompt to the current analysis context
   - Claude Code: if multiple agents selected, invoke in parallel using Agent tool
   - Execute each agent's task as described in its prompt file
3. Write output to the target file per the agent's `output_contract.writes_to`
4. Verify the `### 🔧 Sub-agent: {id}` section header is included in output
5. Update `.analysis/agent-state.md`:
   - Add row: `{analysis_id} | {stage} | {agent_id} | {timestamp} | {content_hash}`

### Step 6: Confirmation

After all agents complete:
```
✅ Ran: {agent1}, {agent2}
📝 Updated: {file paths}
💡 Next: {suggested next step — e.g., "Fill Initial Observations, then /analysis next"}
```

---

## agent-state.md format (auto-managed)

Create `.analysis/agent-state.md` if it doesn't exist:

```markdown
# Agent State
> Auto-managed. Do not edit manually.

## {Analysis-ID}
| Stage | Agent | Ran At | Content Hash | Status |
|-------|-------|--------|-------------|--------|
| ASK | hypothesis-gen | 2026-03-01 10:30 | a1b2c3 | completed |
```

Content hash = first 6 chars of MD5(target section text). Used for suppression.
If hash matches last run → agent is suppressed (content unchanged).
