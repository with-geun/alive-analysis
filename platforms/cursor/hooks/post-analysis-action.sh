#!/bin/bash
# alive-analysis post-action hook
# Reminds to keep status.md in sync after file changes in analysis/experiment/monitor paths
# Works in both Claude Code (CLAUDE_TOOL_INPUT_FILE_PATH) and Cursor (CURSOR_FILEPATH)

FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-${CURSOR_FILEPATH:-}}"

# Check if the changed file is in an analysis-related path
if echo "$FILE_PATH" | grep -qE "(analyses/|ab-tests/|\.analysis/metrics/)"; then
    # Check if status.md exists
    if [ -f ".analysis/status.md" ]; then
        echo "reminder: If you changed an analysis/experiment/monitor, make sure .analysis/status.md is up to date."
    fi
fi
