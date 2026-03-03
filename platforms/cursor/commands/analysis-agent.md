# /analysis-agent

Run a specialist sub-agent for the current analysis stage.

**Usage:**
- `/analysis-agent` — show top recommended agents for current stage
- `/analysis-agent 1` — run the #1 recommended agent
- `/analysis-agent "통계"` — fuzzy match by alias and run

See `platforms/cursor/rules/alive-agents.mdc` for the full dispatch protocol.

## Instructions

Follow the Sub-agent Dispatch Protocol in `alive-agents.mdc`:

1. Load config (`.analysis/agents.yml` or fallback `core/config/agents.yml`)
2. Determine current stage and load stage file + agent-state.md
3. Evaluate gates → auto-run any matching required gates
4. Evaluate routing rules → score and rank optional agents
5. Show recommendation block (max 3) with single confirmation question
6. Execute selected agents using prompts from `core/agents/prompts/`
7. Write output to stage file + update `.analysis/agent-state.md`

## Agent aliases (for fuzzy matching)

| Type input | Matches |
|------------|---------|
| 가설, hypothesis, 원인, why | hypothesis-gen |
| 스코프, scope, 범위, 토끼굴 | scope-guard |
| 데이터품질, quality, 결측, sentinel | data-quality-sentinel |
| 쿼리, sql, query, 데이터추출 | sql-writer |
| 통계, stats, 유의성, p-value, 검정 | stats-agent |
| 리뷰, review, 비판, 시니어, 피드백 | peer-reviewer |
| 서술, narrative, 청중, 보고서 | narrative-agent |
| 윤리, ethics, PII, 개인정보, 편향 | ethics-guard |
