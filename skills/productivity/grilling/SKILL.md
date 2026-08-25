---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
---

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree one decision at a time. Ask one question whose prerequisites are already settled, give your recommended answer, then wait for the user's answer before asking another question.

Format each question like so:

```
**Q1** - **<question title>**: <question body, which may include multiple paragraphs or choices>

Recommendation: <your recommended answer>
```

Each answer reshapes the tree: settled decisions unblock later questions. Reassess the tree after every answer, then ask the next question that can be settled without guessing at an answer you have not heard yet.

Finding _facts_ is your job, never the user's. When a question needs a fact from the environment (filesystem, tools, etc.), find it before asking the question. The _decisions_ are the user's: put each to them and wait.

The session is done when the tree has no unanswered decisions: every branch visited, nothing left silently assumed. Do not act on it until the user confirms you have reached a shared understanding.
