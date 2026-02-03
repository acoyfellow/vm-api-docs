# Bootstrap Prompt for exe.dev Agents

Copy and paste this entire prompt to set up the worker loop system on a new exe.dev VM.

---

## Setup Prompt

```
I need you to set up the exe.dev worker loop system on this VM. Run this command:

curl -fsSL https://vm-api-docs.pages.dev/install.sh | bash

Then add ~/bin to your PATH if needed.

After installation, you'll have these tools:
- worker - autonomous agent sessions with handoff recovery
- ctx - context window management  
- conv - conversation management
- shelley-search - search past sessions
- shelley-recall - get context for errors

The worker loop system lets you run autonomous tasks that survive context limits.
When you hit 75% context, the orchestrator extracts your last thoughts and hands off to a new session.

To test it works:
worker list

To start autonomous work:
worker start myproject --task "implement feature X" --dir /path/to/project --max 10

Read the full docs: https://vm-api-docs.pages.dev
```

---

## What Gets Installed

| Script | Purpose |
|--------|--------|
| `worker` | Start/stop/monitor autonomous loops |
| `ctx` | Search/delete messages in context window |
| `conv` | List/archive/cancel conversations |
| `shelley-search` | Find past sessions by keyword |
| `shelley-recall` | Get relevant past context for errors |

---

## Key Concepts for Agents

**Worker loops** run autonomously until:
- You output `DONE: <summary>` (task complete)
- You output `HANDOFF: <context>` (context limit approaching)
- Context hits 75% (orchestrator extracts your last `think` calls)
- Max sessions reached

**Best practice**: Use the `think` tool frequently. Your thoughts are preserved across session boundaries.

**Health checks**: If `gates/health.sh` exists in your project, it runs at session start. Use it for build gates.

---

## Quick Reference

```bash
# Start a worker
worker start name --task "do X" --dir /path --max 20

# Monitor
worker list
worker log name

# Stop
worker stop name
worker stop-all

# Context management
ctx size CONV_ID
ctx search CONV_ID "pattern"
ctx forget MSG_ID1 MSG_ID2

# Search past work
shelley-search "websocket"
shelley-recall "error TS2345"
```
