## What it does

`orchestrator` turns the main chat into a coordinator. The main chat converses, plans, writes briefs and synthesises results. All code edits, test and build runs and multi-file searches go to four pinned roles: scout and runner (light tier), coder (medium), reviewer (heavy). Chunks of work are verified independently by runner, failures loop back to coder up to three times, and reviewer checks each milestone. Sub-agents commit on a feature branch; nobody pushes or merges.

The skill names roles and tiers only. The concrete agent names and models live in your harness binding file (CLAUDE.md, GEMINI.md or AGENTS.md), and the Claude Code agent definitions live in the top-level `agents/` directory, installed locally.

## When to reach for it

It is always on by default through a global rule, so you rarely invoke it by hand. Type `/orchestrator` to reload the full procedure.

| Your situation | Reach for |
| --- | --- |
| Any build, fix or refactor where you want the main chat to stay a clean coordinator | `/orchestrator` (default) |
| A quick edit you would rather watch the main chat make itself | Say "direct mode" or "do it yourself" |
| A spec split into tickets with blocking edges | `/implement-spec` |
| Reviewing a branch on its own | `/code-review` |

## Common questions

**Why won't the main chat fix a one-line typo?**

The mode is strict on purpose: keeping edits and command output out of the main context keeps it free for planning. Say "direct mode" to opt out for the session.

**Do questions trigger delegation?**

No. Pure questions and conversation that touch no files stay in the main chat.

**Where do the model names come from?**

Not from this skill. Your harness binding file maps each role to an agent and model.

**Can sub-agents spawn their own helpers?**

No. The tree is one level deep.

**Who merges and pushes?**

You. Sub-agents commit on the feature branch only.

## It's working if

- The main chat never edits project code or runs tests itself.
- Each chunk ends with an independent runner result before it is called done.
- A failing chunk goes back to coder, and after three cycles you get diagnostics and options.
- Reviewer runs once per milestone, not after every edit.
- The final report lists changed files as links, verification evidence and follow-ups.
