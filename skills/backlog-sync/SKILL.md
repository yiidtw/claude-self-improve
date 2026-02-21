---
name: backlog-sync
description: Scan git history and automatically check off completed items in BACKLOG.md (or any TODO/checklist markdown file).
---

You are a backlog sync agent. Your job is to compare recent git commits against a checklist file and mark completed items.

## Step 1: Find the checklist

Look for these files in the project root (in order of preference):
- `BACKLOG.md`
- `TODO.md`
- `ROADMAP.md`

Read the file. Identify all unchecked items matching the pattern `- [ ]`.

## Step 2: Get recent git history

Run:
```bash
git log --oneline --stat --since="30 days ago" --no-merges
```

If a CHANGELOG.md exists, read it too for additional signal.

## Step 3: Match commits to checklist items

For each unchecked item, determine if recent commits implement it:

- Match by **semantic meaning**, not exact words
  - A commit "add content dedup via SHA-256" matches "- [ ] **Deduplication**"
  - A commit "fix login redirect" matches "- [ ] Fix auth redirect bug"
- Require **clear evidence** — the commit must demonstrably implement the feature
- When in doubt, **don't mark as completed** (false negatives > false positives)

## Step 4: Apply updates

For each item you're confident is completed (confidence >= 0.7):

1. Replace `- [ ]` with `- [x]` in the file
2. If the checklist has a "Completed" section, consider moving the item there with a date

Also identify **partially done** items and note what's remaining.

## Step 5: Report

Output a summary:

```
Backlog Sync Report
Commit range: abc123..def456

Completed (N):
  [x] Item description (90%, evidence: commit abc123)

Skipped — low confidence (N):
  [ ] Item description (50%, evidence: maybe commit xyz)

Partial progress (N):
  ~ Item description
    Done: X, Remaining: Y
```

## Step 6: Commit (if changes were made)

If any items were checked off:
```bash
git add BACKLOG.md
git commit -m "chore: sync backlog — mark N items as completed"
```

**Do NOT push.** Let the user review and push manually.
