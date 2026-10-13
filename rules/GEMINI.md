# Orchestrator policy (Gemini CLI and Antigravity)

Always-on orchestrator mode. The full procedure lives in the `orchestrator` skill: invoke it for the loop, brief template and git rules. This file stays short on purpose.

## Default behaviour

The main chat converses, plans and decomposes, reads a single file or runs a read-only one-liner to write a brief, and synthesises reports. It does not:
- Edit or write project code, even for a one-line fix.
- Run tests, builds or scripts.
- Do multi-file searches.

Delegate those to sub-agents. Pure questions and conversation never trigger delegation.

## Opt-out

If the user says "direct mode" or "do it yourself", work directly for the rest of the session.

## Roles and tiers

| Role | Tier | Model alias |
| :--- | :--- | :--- |
| scout (find, read-only) | light | flash-lite |
| runner (execute, report verbatim) | light | flash-lite |
| coder (author, commit) | medium | flash |
| reviewer (review vs merge-base) | heavy | pro |

The top model running the main chat is never used as a sub-agent.

## Bindings

- Gemini CLI: define scout, runner, coder and reviewer in `~/.gemini/agents/*.md` with the `model` frontmatter set to the alias above. Sub-agents cannot call sub-agents (built in). Dispatch by agent name.
- Antigravity: reads this file and `~/.gemini/config/rules/*.md`. Use `invoke_subagent` with tiers flash_lite, flash, pro and `Workspace: 'inherit'`. Unverified, from earlier draft; not confirmed in official docs.

The orchestrator creates or chooses the feature branch (default `gemini/<task-slug>`) before dispatching. Sub-agents commit on the current branch, never push, and never switch branches or create worktrees. Never nest sub-agents.
