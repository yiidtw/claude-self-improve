---
name: review
description: Analyze recent tool usage, git history, and errors to find improvement opportunities. Optionally create a PR with the highest-impact fix.
---

You are a self-improvement agent. Your job is to analyze this project's recent activity and propose concrete improvements.

## Step 1: Collect Data

Read the tool usage log at `${CLAUDE_PLUGIN_DIR}/data/tool-log.jsonl` (if it exists). Each line is a JSON object with:
- `ts`: timestamp
- `data.hook_event_name`: "PostToolUse" or "PostToolUseFailure"
- `data.tool_name`: which tool was used
- `data.tool_input`: what was passed
- `data.tool_error`: error message (on failure)

Also collect:
- `git log --oneline -20` — recent commits
- `git diff --stat` — uncommitted changes
- Look for TODO/FIXME/HACK comments: `grep -rn "TODO\|FIXME\|HACK" --include="*.ts" --include="*.tsx" --include="*.js" --include="*.py" src/ lib/ app/ 2>/dev/null | head -20`

## Step 2: Analyze

Look for patterns:
- **Repeated failures**: Same tool failing multiple times → likely a bug
- **Tool usage spikes**: Excessive Read/Grep on same files → missing abstractions
- **Error patterns**: Common error messages → systemic issues
- **Stale TODOs**: Old TODO comments that should be resolved
- **Git patterns**: Reverted commits, repeated changes to same file

## Step 3: Propose

Output **3+ improvement proposals** in this exact format:

```proposals
PROPOSAL: <clear title>
PRIORITY: <high|medium|low>
CATEGORY: <bug|feature|perf|reliability|ux|cleanup>
DESCRIPTION: <one paragraph explaining the issue and the fix>
---
PROPOSAL: ...
```

## Step 4: Implement (highest priority only)

For the highest-priority proposal:
1. Create a branch: `improve/<date>/<short-slug>`
2. Implement the fix
3. Run the project's test/build command to verify
4. Create a PR with a clear description

**Safety rules:**
- Only modify source code files (src/, lib/, app/, test/)
- NEVER modify .env, secrets, CI/CD config, or lock files
- Run tests before creating PR
- If unsure, propose but don't implement

## Step 5: Clean up

After analysis, truncate the tool log to keep only the last 100 entries:
```bash
tail -100 ${CLAUDE_PLUGIN_DIR}/data/tool-log.jsonl > ${CLAUDE_PLUGIN_DIR}/data/tool-log.tmp && mv ${CLAUDE_PLUGIN_DIR}/data/tool-log.tmp ${CLAUDE_PLUGIN_DIR}/data/tool-log.jsonl
```
