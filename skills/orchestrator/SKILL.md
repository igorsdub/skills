---
name: orchestrator
description: "Always-on coordinator mode: the main chat plans, briefs and synthesises, and delegates all code edits, runs and multi-file searches to four tiered roles (scout, runner, coder, reviewer). Opt out with 'direct mode'."
disable-model-invocation: true
---

# Orchestrator

The main chat is a coordinator. It converses, plans, writes briefs and synthesises reports. Sub-agents do the hands-on work. This mode is on by default; a global rule in your harness binding file points here for the full procedure.

Roles and tiers are named here, never tools or models. See your harness binding file (CLAUDE.md, GEMINI.md or AGENTS.md) for the concrete agent names and models. The binding files and the pinned agent definitions for Claude Code, Gemini CLI and Codex are kept in the separate `igorsdub/agents` repository (https://github.com/igorsdub/agents), which installs them with one script.

## What the main chat may and may not do

May:
- Converse with the user, plan, decompose, synthesise sub-agent reports.
- Read a single file, or run a read-only one-liner, when it needs one fact to write a good brief.

Must not, even for a one-line fix:
- Edit or write project code.
- Run tests, builds or scripts.
- Do multi-file searches.

Pure questions and conversation (no files touched) never trigger delegation.

## Opt-out

If the user says "direct mode" or "do it yourself", work directly for the rest of the session and stop delegating.

## Roles and tiers

| Role | Tier | Job |
| :--- | :--- | :--- |
| scout | light | Find files, grep, read configs, report locations and excerpts. Read-only. |
| runner | light | Run tests, builds, linters, scripts exactly as briefed. Report output verbatim. Never fixes. |
| coder | medium | Write and edit code, run tests on its own slice, commit on the current branch. |
| reviewer | heavy | Review the branch diff against its merge-base using the `/code-review` procedure (Standards and Spec axes). Diagnose hard bugs. Read-only. |

Rules:
- The top-tier model running the main chat is never used as a sub-agent.
- Work beyond the heavy tier (cross-cutting architecture, elusive bugs) is reasoned in the main chat, then the resulting plan is briefed to coder.
- Sub-agents never spawn sub-agents. The tree is one level deep.

## The loop

```
decompose -> branch/worktree (once) -> coder(s) -> chunk done?
                                          ^            |
                                          |            v
                              findings    |         runner (tests/build/lint)
                           reviewer <-----+            |
                          (per milestone,         pass? -> report
                           or stalled loop)        fail -> back to coder (max 3)
                                                          then escalate to user
```

1. **Decompose** into chunks with acceptance criteria. Group independent chunks for parallel dispatch; order dependent ones.
2. **Branch or worktree**, once per session, before any dispatch. Default: a feature branch `claude/<task-slug>` in the current checkout. Choose a worktree only when the user is running several orchestrator sessions on the same repo at once. Sub-agents never create worktrees.
3. **Dispatch coder(s)** with a brief (template below).
4. **Verify per chunk.** A chunk is a coherent slice or milestone, not every edit. After a chunk, dispatch runner to run tests, build and lint independently.
5. **Self-heal on failure.** Send coder the error log, failing trace and recent diff. Up to 3 cycles, then escalate to the user with diagnostics and options.
6. **Review** with reviewer once per milestone, or when a retry loop stalls. Findings go back to coder.
7. **Report:** what was done, files changed as clickable links, verification evidence, follow-ups.

## Git

Sub-agents commit their own work with descriptive messages on the feature branch. Nobody pushes. Nobody merges to main. Merge and push belong to the user.

## Brief template

Point at context (spec, ticket, earlier commits) instead of pasting it.

```
Role:        scout | runner | coder | reviewer
Goal:        one sentence outcome
Paths:       exact files or directories in scope
Context:     pointers (spec path, ticket id, commit range), not pasted text
Acceptance:  checkable criteria, including the command that proves it
Constraints: scope limits, no push, no branch switch, style rules
Report back: files changed, command output, anything left undone
```
