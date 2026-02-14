# Contributing to alive-analysis

Thanks for your interest in contributing! This guide will help you get started.

## How to Contribute

### Reporting Issues

- Use [GitHub Issues](https://github.com/with-geun/alive-analysis/issues) for bug reports, feature requests, and questions.
- Search existing issues before creating a new one.
- Include steps to reproduce any bugs you find.

### Pull Requests

1. Fork the repository and create a feature branch from `main`.
2. Make your changes (see guidelines below).
3. Test your changes by installing the plugin into a sample project.
4. Open a PR with a clear description of what you changed and why.
5. Link any related issues.

## Development Setup

1. Clone the repository:

```bash
git clone https://github.com/with-geun/alive-analysis.git
cd alive-analysis
```

2. Install into a test project:

```bash
cd /path/to/your-test-project
bash /path/to/alive-analysis/install.sh
```

3. Initialize and verify:

```
/analysis init
/analysis status
```

## Project Structure

```
alive-analysis/
  core/                        # Shared methodology — single source of truth
    references/
      analytical-methods.md          # Metric interpretation, clustering, ANOVA, SHAP
      conversation-examples.md       # Full/Quick mode conversation examples
      experiment-statistics.md       # Statistical methods, SRM detection
    examples/
      full-investigation/            # 6-file Full analysis example
      quick-investigation.md
      quick-logistics.md
      quick-hr-finance.md
    GLOSSARY.md
  platforms/
    claude-code/               # Claude Code optimized
      SKILL.md                       # Full version (~1,660 lines)
      commands/                      # 16 .md files (conversational flow)
      hooks/
        hooks.json
        session-start.sh
        post-analysis-action.sh
    cursor/                    # Cursor 2.4+ optimized
      SKILL.md                       # Slim version (~265 lines)
      commands/                      # 16 .md files (batch-oriented flow)
      rules/
        alive-analysis.mdc           # Agent-requested rule entry point
      hooks/
        hooks-cursor.json
        post-analysis-action.sh
  install.sh                   # Automated installer with --claude/--cursor/--both
  README.md
  INSTALL.md
  CONTRIBUTING.md              # This file
  CHANGELOG.md
  CODE_OF_CONDUCT.md
  GLOSSARY.md
  LICENSE
  .gitignore
```

- **`core/`** -- Shared methodology files referenced by both platform SKILL.md files. The single source of truth for analytical methods, examples, and glossary.
- **`platforms/claude-code/`** -- Claude Code-specific files. SKILL.md is the full version (~1,660 lines). Commands use conversational (sequential question) flow. Hooks include SessionStart for auto-welcome.
- **`platforms/cursor/`** -- Cursor-specific files. SKILL.md is a slim version (~265 lines). Commands use batch-oriented flow (all questions at once). Includes `.mdc` rule for agent-requested activation. State is file-based (`.analysis/status.md`).
- **`core/references/`** -- Detailed reference material extracted from SKILL.md to keep the core file focused.
- **`core/examples/`** -- Sample analyses demonstrating Full, Quick, and non-SaaS use cases.

## SKILL.md Modification Guidelines

`SKILL.md` is the core methodology file that defines how the AI assistant performs analyses. Please treat changes to it with care:

- **Keep it focused.** SKILL.md should contain the methodology, templates, and decision logic. Detailed educational content (e.g. "how to interpret CV" or "when to use ANOVA") belongs in `references/`.
- **Keep it under ~1,600 lines.** If it grows beyond this, look for content that can be extracted into `references/`.
- **Test changes end-to-end.** After modifying SKILL.md, run through a full analysis cycle (`/analysis new` through `/analysis next` to completion) to make sure nothing breaks.
- **Document changes.** Update CHANGELOG.md when making meaningful SKILL.md changes.

## Checklist Customization

Analysis quality is enforced through checklists stored in `.analysis/checklists/`. These are generated per-project by `/analysis init` and can be customized:

- Edit checklist files directly to add, remove, or modify quality gates for your team.
- Changes to checklists are git-tracked, so teams can review modifications through normal PR workflows.
- Custom checklists are project-local and do not affect the plugin source.

## Questions?

Open an issue or start a discussion on GitHub. We are happy to help!
