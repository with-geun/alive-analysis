#!/bin/bash
# alive-analysis session start hook
# Displays welcome message and current analysis status

# Check if alive-analysis is initialized
if [ -f ".analysis/config.md" ]; then
    # Count active analyses
    ACTIVE_COUNT=0
    if [ -d "analyses/active" ]; then
        FULL_COUNT=$(find analyses/active -maxdepth 1 -type d -name "F-*" 2>/dev/null | wc -l | tr -d ' ')
        QUICK_COUNT=$(find analyses/active -maxdepth 1 -type f -name "quick_*" 2>/dev/null | wc -l | tr -d ' ')
        ACTIVE_COUNT=$((FULL_COUNT + QUICK_COUNT))
    fi

    echo "alive-analysis | Active: ${ACTIVE_COUNT} analyses | Run /analysis status for details"
else
    echo "alive-analysis | Not initialized | Run /analysis init to get started"
fi
