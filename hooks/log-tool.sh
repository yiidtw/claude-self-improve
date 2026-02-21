#!/bin/bash
# Log tool calls to a local JSONL file for later analysis.
# Receives JSON on stdin from Claude Code hook system.

PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="${PLUGIN_DIR}/data"
LOG_FILE="${LOG_DIR}/tool-log.jsonl"

mkdir -p "$LOG_DIR"

INPUT=$(cat)
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Append timestamped entry
echo "{\"ts\":\"${TIMESTAMP}\",\"data\":${INPUT}}" >> "$LOG_FILE"

exit 0
