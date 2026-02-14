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
  commands/              # One .md file per slash command (e.g. analysis-new.md, experiment-new.md)
  skills/
    alive-analysis/
      SKILL.md           # Core methodology file -- the heart of the plugin
  hooks/
    hooks.json           # Claude Code hook configuration (SessionStart, PostToolUse)
    hooks-cursor.json    # Cursor hook configuration (afterFileEdit)
    session-start.sh
    post-analysis-action.sh
  references/            # Detailed guides extracted from SKILL.md
    analytical-methods.md      # Metric interpretation, clustering, ANOVA, SHAP, quasi-experimental
    conversation-examples.md   # Full/Quick mode conversation examples
    experiment-statistics.md   # Statistical methods, SRM detection, p-hacking prevention
  examples/              # Sample analyses for learning and testing
  .gitignore             # Framework files committed, user data excluded
  CHANGELOG.md           # Version history
  CODE_OF_CONDUCT.md     # Contributor Covenant
  CONTRIBUTING.md        # This file
  GLOSSARY.md            # Key analysis terms defined
  INSTALL.md             # Installation instructions
  install.sh             # Automated installer (Claude Code + Cursor)
  LICENSE                # MIT license
  README.md              # Project overview
```

- **`commands/`** -- Each file defines one slash command. The filename maps to the command name (e.g. `analysis-new.md` becomes `/analysis new`).
- **`skills/alive-analysis/SKILL.md`** -- The core methodology document that powers the ALIVE loop. This is the most important file in the project.
- **`hooks/`** -- Shell scripts triggered on session events. `session-start.sh` shows a welcome message (Claude Code only); `post-analysis-action.sh` reminds you to update status after actions (both Claude Code and Cursor).
- **`references/`** -- Detailed reference material (analytical methods, conversation examples, experiment statistics) extracted from SKILL.md to keep the core file focused.
- **`examples/`** -- Sample analyses demonstrating Full, Quick, and non-SaaS use cases for onboarding and testing.

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
