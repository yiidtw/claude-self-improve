# claude-self-improve

A Claude Code plugin that adds a **self-improvement loop** to any project.

It silently logs your Claude Code tool usage, then on demand, analyzes patterns — repeated failures, error spikes, stale TODOs — and creates a PR with the highest-impact fix.

<p align="center">
  <img src="demo/demo.svg" alt="claude-self-improve demo" width="700">
</p>

## How it works

```
You work normally with Claude Code
         │
         ▼
   Hooks silently log every tool call
   (Read, Write, Bash, Grep, etc.)
         │
         ▼
   /self-improve:review
         │
         ▼
   Analyzes: tool failures, git history,
   TODOs, error patterns
         │
         ▼
   Proposes 3+ improvements
   Implements the best one as a PR
```

## Install

```bash
git clone https://github.com/yiidtw/claude-self-improve.git
claude --plugin-dir ./claude-self-improve
```

## Commands

| Command | What it does |
|---------|-------------|
| `/self-improve:review` | Full analysis → proposals → implement best fix as PR |
| `/self-improve:status` | Quick summary of logged tool usage and project health |
| `/self-improve:backlog-sync` | Scan git history and check off completed BACKLOG.md items |

## What gets logged

The plugin logs tool calls to `data/tool-log.jsonl` inside the plugin directory. Each entry contains:

- Timestamp
- Tool name (Read, Write, Bash, Grep, etc.)
- Success or failure
- Error messages (on failure)

**No file contents or secrets are logged.** Only tool names and metadata.

## What it analyzes

- **Repeated failures** — same tool failing multiple times → likely a bug
- **Tool usage spikes** — excessive reads on same files → missing abstractions
- **Error patterns** — common error messages → systemic issues
- **Stale TODOs** — old TODO/FIXME/HACK comments in source
- **Git patterns** — reverted commits, repeated changes to same file

## How it differs from claude-review-loop

[claude-review-loop](https://github.com/hamelsmu/claude-review-loop) reviews code **after you write it** (reactive).

claude-self-improve reviews your project's **operational patterns over time** and proactively finds issues you didn't know existed (proactive). It's the difference between code review and continuous improvement.

## Safety

- Only modifies source code files (src/, lib/, app/, test/)
- Never touches .env, secrets, CI/CD config, or lock files
- Runs tests before creating any PR
- You approve every PR — nothing is auto-merged

## Origin

Extracted from [wonOS](https://github.com/yiidtw/wonos), a personal agent OS that runs this review loop nightly and has been self-improving since February 2026.

## License

MIT
