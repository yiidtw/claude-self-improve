#!/bin/bash
# On session stop: print a reminder about running /self-improve:review
# This is a lightweight nudge, not an automatic review.

PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_FILE="${PLUGIN_DIR}/data/tool-log.jsonl"

if [ -f "$LOG_FILE" ]; then
  LINES=$(wc -l < "$LOG_FILE" | tr -d ' ')
  if [ "$LINES" -gt 20 ]; then
    echo "Tip: You have ${LINES} tool calls logged. Run /self-improve:review to analyze patterns and improve your project." >&2
  fi
fi

exit 0
