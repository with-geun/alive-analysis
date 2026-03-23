# ALIVE Dashboard

A single-file team dashboard for visualizing analysis history as a node graph.

Each analysis is a node. Follow-up connections are edges. Click a node to see its connections light up and explore the thread.

## Quick Start

**1. Export your analyses to JSON**

```bash
# Run from your project root (where analyses/ folder is)
bash /path/to/alive-analysis/dashboard/export.sh > export.json
```

**2. Open the dashboard**

Open `alive-dashboard.html` in any browser (file://).

**3. Load your data**

Click the **Load** button → paste the contents of `export.json` → confirm.

That's it.

---

## Adding Extended Metadata

The export script reads what it can from your analysis markdown files (ID, title, type, stage, dates).

To add `analyst`, `tags`, `followups`, and `keyFinding`, create a `meta.yml` in each analysis folder:

```
analyses/active/F-2026-0303-001_checkout-drop/
  01_ask.md
  02_look.md
  meta.yml        ← add this
```

**meta.yml format:**
```yaml
analyst: geun
tags: [checkout, conversion]
followups: [F-2026-0305-001]
keyFinding: "결제 UI 리디자인 이후 2.4pp 하락 확인"
```

---

## Dashboard Features

- **Node graph** — force-directed layout, node size = ALIVE stage progress
- **Arc ring** — shows which stages are complete (ASK → LOOK → INVESTIGATE → VOICE → EVOLVE)
- **Click highlight** — selected node's connections light up, others dim
- **Filters** — type, status, period, analyst (multi-select), tags (multi-select)
- **⌘K search** — fuzzy search across title, ID, analyst, tags
- **Team panel** — analyst workload, recent activity feed

## Obsidian

Your `analyses/` folder is already an Obsidian vault. Open it directly.

For graph-view connections, reference follow-up analyses in your markdown:

```markdown
## Follow-ups
- [[F-2026-0305-001]] Android 푸시 알림 효과 분석
```

Obsidian picks up the `[[wiki-link]]` and draws the connection automatically.
