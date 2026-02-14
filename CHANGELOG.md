# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] - 2026-02-14

First stable release. All features complete, dual-platform support.

### Highlights
- ALIVE loop with Full/Quick modes, 3 analysis types (Investigation, Modeling, Simulation)
- A/B test experiments, metric monitoring, model registry
- Insight search (`/analysis search`) and auto retrospectives (`/analysis retro`)
- Claude Code + Cursor 2.4+ dual-platform optimization
- 16 commands, quality checklists, archive system
- 40+ QA simulation tests across diverse roles, industries, and languages

### Added
- `/analysis search` command: deep full-text search across all analyses with context snippets, cross-reference analysis, and learning suggestions
- `/analysis retro` command: automatic retrospective report generation from archived analyses with impact tracking summary, pattern detection, and follow-up tracking
- `analyses/.retro/` directory for retrospective reports
- Insight Search & Retrospective section in SKILL.md (both platforms)

## [0.3.0] - 2026-02-14

### Added
- Platform separation: `platforms/claude-code/` and `platforms/cursor/` with optimized files for each
- Cursor slim SKILL.md (~265 lines) with batch-oriented methodology summary
- 16 Cursor-optimized command files with batch question flow and file-based state management
- Cursor `.mdc` agent-requested rule (`alive-analysis.mdc`) for automatic activation
- `core/` directory as single source of truth for shared methodology
- `core/references/` for analytical methods, conversation examples, experiment statistics
- `core/examples/` for Full and Quick analysis samples
- Platform comparison section in README.md
- `--claude` flag for install.sh (Claude Code only)

### Changed
- Restructured repository: `references/` → `core/references/`, `examples/` → `core/examples/`
- Moved `skills/alive-analysis/SKILL.md` → `platforms/claude-code/SKILL.md`
- Moved `commands/` → `platforms/claude-code/commands/`
- Moved `hooks/` → `platforms/claude-code/hooks/` and `platforms/cursor/hooks/`
- Updated `install.sh` to copy from `platforms/` structure with `--claude`/`--cursor`/`--both` flags
- Updated all `references/` paths to `core/references/` in SKILL.md
- INSTALL.md rewritten with platform-specific manual setup sections
- CONTRIBUTING.md updated with new project structure

## [0.2.1] - 2026-02-14

### Added
- GLOSSARY.md with definitions of key analysis terms
- README.ko.md (Korean translation)
- Non-SaaS example analyses (logistics, HR/finance)
- Cursor 2.4+ native support with separate hooks format
- hooks-cursor.json for Cursor-compatible hook configuration
- install.sh `--cursor` and `--both` flags
- install.sh directory validation and error recovery (jq fallback, malformed JSON backup)

### Fixed
- SHAP explanation in analytical-methods.md (corrected to additive contributions, not percentages)
- `find` command grouping bug in session-start.sh (`-o` without parentheses)
- install.sh path confusion when running from inside alive-analysis repo
- Inline term explanations in examples (pp, Simpson's Paradox, counter-metric, D7/D30)

### Changed
- .gitignore now separates framework files (committed) from user data (excluded)
- README compatibility table updated with correct Cursor paths
- INSTALL.md rewritten with Cursor setup section and clearer instructions
- install.sh auto-detects .cursor/ directory for dual installation

## [0.2.0] - 2026-02-14

### Added
- A/B test experiment module (Full and Quick modes)
- Metric monitoring with STEDII validation
- Alert escalation logic (Warning → Critical → Investigation)
- Quick→Full analysis promotion with complexity signals
- Tags for connecting related analyses
- Model registry for deployed ML models
- Counter-metric monitoring (Goodhart's Law prevention)
- Segment-level monitoring (Simpson's Paradox detection)
- Impact tracking in EVOLVE stage
- Simulation analysis type with Monte Carlo support
- Analysis independence protocol (anti p-hacking)
- Scope creep and rabbit hole guard protocols
- Data quality emergency protocol
- Non-analyst guides for experiments and monitoring
- install.sh automated installer

### Changed
- SKILL.md refactored: educational content moved to references/
- README overhauled with "Why" section and PM guide
- Init command supports --quick flag for fast setup

## [0.1.0] - 2026-01-15

### Added
- ALIVE loop (Ask, Look, Investigate, Voice, Evolve)
- Full analysis mode (5 files per analysis)
- Quick analysis mode (single file)
- Three analysis types: Investigation, Modeling, Simulation
- Stage checklists with quality gates
- Analysis archive with searchable summaries
- Metric proposal conversation in EVOLVE
- Structured data request framework (5 elements)
- Hypothesis tree methodology
- Multi-lens analysis (macro/meso/micro)
- Sensitivity analysis framework
- Audience-specific communication guide
- Metric framework (North Star, Leading, Guardrail, Diagnostic)
- SKILL.md open standard (Claude Code, Cursor, Codex compatible)
