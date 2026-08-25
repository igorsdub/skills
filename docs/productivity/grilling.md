## What it does

`grilling` is the interview loop that stress-tests a plan, a decision, or an idea before anyone acts on it. It maps the subject as a **design tree**: every decision branches into the decisions that hang off it, and interviews you branch by branch until nothing is left silently assumed.

It asks one question at a time. Each question is a decision whose prerequisites are already settled, so it never asks you to answer something that depends on an answer it has not heard yet. Your answer settles a decision, reshapes the tree, and determines what the next question should be.

## When to reach for it

Type `/grilling`, or the [agent](https://www.aihero.dev/ai-coding-dictionary/agent) reaches for it on its own when a task fits. It is the only [skill](https://www.aihero.dev/ai-coding-dictionary/skill) in the grilling family that is model-invoked, which is why you rarely type it: usually a skill you *did* type is running it for you.

Typing `/grilling` directly gets you the plain interview and nothing else. Where you want something more than that:

| What you have | Reach for |
| --- | --- |
| You aren't working in a working directory | [grill-me](https://aihero.dev/skills-grill-me): the same [session](https://www.aihero.dev/ai-coding-dictionary/session), under a name the agent will never fire by itself |
| You are in a working directory | [grill-with-docs](https://aihero.dev/skills-grill-with-docs): the same session, and it writes `CONTEXT.md` and ADRs as it goes |
| An effort too big to hold in one session | [wayfinder](https://aihero.dev/skills-wayfinder): it charts a map and runs grilling inside the decision tickets |
| A question that talking cannot settle: how something should look or feel | [prototype](https://aihero.dev/skills-prototype): build the throwaway version, then come back |
| A skill of your own that needs an interview | Invoke `/grilling` from it, rather than writing another interview |

## The tree, the pace, and who decides

Three ideas carry the whole skill.

The **design tree** is the model of the subject: decisions with decisions hanging off them. The next question is one decision whose prerequisites are settled. After you answer it, the agent reassesses the tree before choosing the next question.

Each question arrives in a plain terminal-friendly shape: a number and title, the question body, then a `Recommendation:` line. One question per message gives you room to consider it, challenge the recommendation, or ask for context before deciding.

The other half of the design is the split between facts and decisions. Facts are the skill's own job: when a question needs something the [environment](https://www.aihero.dev/ai-coding-dictionary/environment) can settle, it finds it rather than asking you. Decisions are yours, and it must wait for them. An agent running `grilling` that answers its own decisions has broken the skill, not interpreted it liberally. The session ends when the tree has no unanswered decisions, and it will not act on what you agreed until you confirm you have reached a shared understanding.

The honest limit: the design tree is the agent's judgement, not a computed graph. Asking one question at a time reduces the chance that a later answer invalidates an earlier question, but it cannot prevent a missed branch. If that happens, reopen the affected decision and continue.

## What lives here and what lives in the wrappers

This page covers the mechanism. The things people most often want are documented one level up.

| Question | Where it is answered |
| --- | --- |
| The tree, one-question pacing, the question format, facts vs decisions | Here |
| How long a session should run, what to do with a question you can't answer by talking, how to avoid nodding along | [grill-me](https://aihero.dev/skills-grill-me) |
| What gets written to `CONTEXT.md`, what becomes an ADR | [grill-with-docs](https://aihero.dev/skills-grill-with-docs) |

## Common questions

**Why does it ask one question at a time?**
It keeps the conversation legible. You can consider the recommendation, correct a premise, or surface a dependency before the next question arrives. The agent also has a chance to update the tree after every answer.

**Where did `/batch-grill-me` go?**
It was folded into this skill during the round-based experiment. `grilling` is now sequential again, so there is no separate sequential skill to install.

**What if an earlier answer changes a later question?**
That is why the skill waits. It reassesses the design tree after every answer and asks only the next decision that is ready to settle.

**It ran out of questions and started building.**
A confirmation gate exists precisely for this: the skill is not finished when the tree has no unanswered decisions, it is finished when you say the understanding is shared. Weaker and faster [models](https://www.aihero.dev/ai-coding-dictionary/model) still break it. If yours does, add a line to your own `AGENTS.md` or `CLAUDE.md` telling the agent not to implement without permission.

**It answered its own questions instead of asking me.**
That is a bug in the run, not the intended behaviour, and it was the reason facts and decisions were separated in the skill's text. It shows up most when another skill runs `grilling` inside a resolve-this-ticket frame, where the surrounding task reads as licence to keep moving. The same constraint is why there is no async mode: people have asked for a variant that reads a GitHub issue and posts one consolidated decision memo, and that is a different skill, because a grilling session that nobody answers has produced the agent's opinion rather than yours.

**Can I cap the number of questions?**
No, and a cap is deliberately out of scope. Some plans need three questions and some need fifty; a fixed ceiling either truncates the hard case or feels arbitrary on the easy one. Steering in plain language is the intended control: tell it to wrap up, or stop and accept the plan where it stands. If a session is running very long, the cause is usually that the scope was too big; break the work up and grill the pieces.

**I installed `grill-me` on its own and nothing happens.**
`grill-me` is a one-line skill whose whole body is "run a `/grilling` session", so it needs this skill installed too. The same is true of `grill-with-docs`, which additionally needs [domain-modeling](https://aihero.dev/skills-domain-modeling). Installing the whole set avoids the problem; installing selectively means installing the primitives as well.

**`grill-with-docs` ran, but it never loaded `grilling`.**
A real and unfixed rough edge, reported across [harnesses](https://www.aihero.dev/ai-coding-dictionary/harness) and models: a skill that names another skill does not reliably cause that skill to load, and `grill-with-docs` names two. The tell is a session that asks everything at once with no recommendations attached: that is the model improvising an interview rather than running this one. Asking the agent directly whether it loaded `grilling` and `domain-modeling` usually recovers it.

## It's working if

- One plain, numbered question arrives at a time, with its recommendation on a separate `Recommendation:` line.
- The next question clearly builds on what you just decided.
- You have room to challenge the recommendation or correct a premise before the conversation continues.
- It goes and looks facts up (reading files, dispatching a sub-agent) rather than asking you something it could have found out.
- It stops at the end and asks you to confirm the understanding is shared, instead of starting work.
- Every branch gets visited without a dense batch of questions.

## Where it fits

`grilling` is a **primitive**, not a step you schedule: the single source of truth for the interview technique, kept in one place so every skill that needs an interview reaches for it instead of inventing one. [grill-me](https://aihero.dev/skills-grill-me) and [grill-with-docs](https://aihero.dev/skills-grill-with-docs) are its two user-invoked front doors, and `grill-with-docs` is where the main build chain begins, ahead of [to-spec](https://aihero.dev/skills-to-spec). [wayfinder](https://aihero.dev/skills-wayfinder) runs it to resolve decision tickets, [triage](https://aihero.dev/skills-triage) to grill a vague report into a workable one, and [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) to walk the tree once you have picked a candidate to deepen. When you are unsure which entry point fits, [ask-matt](https://aihero.dev/skills-ask-matt) routes you.
