---
name: status
description: Show a summary of collected tool usage data and project health.
---

Read the tool usage log at `${CLAUDE_PLUGIN_DIR}/data/tool-log.jsonl` and show a concise summary:

1. **Total tool calls** logged
2. **Failures** (PostToolUseFailure events) — list each with tool name and error
3. **Most used tools** — top 5 by count
4. **Date range** — first and last entry timestamps
5. **Git status** — `git log --oneline -5` and `git status --short`

Keep the output brief and actionable. If there are failures, highlight them.
