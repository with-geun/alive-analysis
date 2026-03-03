# Sub-agent Runtime — Invocation, Merge & Logging Policy
# alive-analysis v1.2+

## Overview

The Sub-agent Dispatch System runs within the ALIVE loop to provide
just-in-time specialist assistance. All agent output is written into
the analysis markdown files for full Git traceability.

---

## Invocation Flow

### 1. Trigger point
Sub-agents are invoked at two moments:
- **`/analysis-next`**: after generating the new stage file (Step 4)
- **`/analysis-agent`**: explicit user call, any time

### 2. Router evaluation (deterministic)
1. Read `.analysis/status.md` + current stage file + user message
2. Evaluate `core/agents/router.yml` gate conditions → identify gates to auto-run
3. Evaluate routing rules → score all agents → filter by threshold → take top_k
4. Check suppression: skip if same agent ran in this stage without content change
5. Read user config from `.analysis/agents.yml` (falls back to `core/config/agents.yml`)

### 3. Gate execution (no user confirmation)
Required-gate agents run automatically when their signals fire:
```
[auto] Running scope-guard — Scope section empty detected
[auto] Running ethics-guard — PII keyword "이메일" detected
```
Output is merged into the current stage file immediately.

### 4. Recommendation block (optional agents)
After gates complete, show compact recommendation block (≤3 agents):
```
─────────────────────────────────────────
🤖 Specialist Recommendations — {STAGE}
─────────────────────────────────────────
  1. sql-writer      — 데이터소스 확인됨, 가설별 쿼리 초안 생성 가능
  2. stats-agent     — 가설 검증 중, 통계 검정 방법론 검토
  3. peer-reviewer   — 결과 도출 완료, 시니어 관점 검토
─────────────────────────────────────────
Run? (1 / 2 / 3 / all / n)  →
```

Ask **at most one** confirmation question. If `ask_confirmation: false` in config,
run all recommendations automatically.

### 5. Agent execution
- Claude Code: invoke agents as parallel sub-tasks using Agent tool when multiple selected
- Cursor: each agent prompt is applied sequentially (Cursor background agent limitation)
- Each agent reads its input_contract files, generates output, calls Write/Edit tool

### 6. Merge
Merge order: **required-gates first → score desc → id asc**

Before writing, check for duplicate headings:
- If `### 🔧 Sub-agent: {id}` already exists in the file → skip (dedup)
- If content in the target section is already ≥80% similar → skip

---

## Output Format (per agent)

Each agent appends a clearly delimited section to the target stage file:

```markdown
---
### 🔧 Sub-agent: {id}
> Stage: {STAGE} | Triggered: {YYYY-MM-DD HH:MM} | Reason: {matched signal}
> Inputs: {files/sections read}

{agent output — markdown, structured to fill the target section}

> Next: {optional follow-up agent recommendation or action}
---
```

**Rules:**
- Never overwrite user-written content. Append below or fill empty sections only.
- If the target section has user content, insert agent output in a sub-subsection.
- Use `>` blockquotes for meta-information (reason, inputs, next).

---

## State Tracking

Agent run history is stored in `.analysis/agent-state.md` (auto-created):

```markdown
# Agent State
> Auto-managed by alive-analysis. Do not edit manually.

## {Analysis ID}
| Stage | Agent | Ran At | Content Hash | Status |
|-------|-------|--------|-------------|--------|
| ASK | hypothesis-gen | 2026-03-01 | abc123 | completed |
| ASK | scope-guard | 2026-03-01 | def456 | auto-gate |
```

**Content hash**: MD5 of the target section text at time of run.
Used for suppression: if hash unchanged since last run, agent is suppressed.

---

## Parallelism

**Claude Code:**
- When user selects multiple agents (e.g., "1 3" or "all"), invoke them in parallel
  using separate Agent tool calls in a single response
- Merge results in order: required-gates first, then by score desc

**Cursor:**
- Sequential execution (Cursor background agent constraint)
- Same registry/router definitions, same output format

---

## Error Handling

- If an agent fails or produces no output: log `[skip]` in agent-state.md, continue
- Never block the user's primary workflow on agent failure
- On partial output: write what was generated, mark section `[incomplete]`
