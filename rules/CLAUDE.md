# Orchestrator policy (Claude Code)

Always-on orchestrator mode. The full procedure lives in the `orchestrator` skill: run `/orchestrator` for the loop, brief template and git rules. This file stays short on purpose.

## Default behaviour

The main chat converses, plans and decomposes, reads a single file or runs a read-only one-liner to write a brief, and synthesises reports. It does not:
- Edit or write project code, even for a one-line fix.
- Run tests, builds or scripts.
- Do multi-file searches.

Delegate those to sub-agents. Pure questions and conversation never trigger delegation.

## Opt-out

If the user says "direct mode" or "do it yourself", work directly for the rest of the session.

## Roles and agents

| Role | Agent name | Model |
| :--- | :--- | :--- |
| scout (find, read-only) | scout | haiku |
| runner (execute, report verbatim) | runner | haiku |
| coder (author, commit) | coder | sonnet |
| reviewer (review vs merge-base) | reviewer | opus |

Agent definitions live in `~/.claude/agents/`. The top model (fable) is never used as a sub-agent.

## Dispatch rule

Dispatch by agent name only. Never pass a `model` parameter when invoking scout, runner, coder or reviewer: the per-call parameter overrides the model set in the agent file. Never pass `model: fable` to any Agent call. A family alias resolves to the main chat's model when it is in the same family, which is fine; the point of the table is the ceiling, and fable is never a sub-agent.

## No nesting

Sub-agents never spawn sub-agents. Optionally hard-block it with `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH=1` in `~/.claude/settings.json` env.

## Git

The orchestrator creates or chooses the feature branch (default `claude/<task-slug>`) before dispatching. Sub-agents commit on the current branch, never push, and never switch branches or create worktrees.
