---
"mattpocock-skills": patch
---

`orchestrator` is rewritten to be harness-agnostic: it names four roles (scout, runner, coder, reviewer) across three tiers instead of tools and models, is on by default with a "direct mode" opt-out, verifies per chunk rather than per edit, and keeps sub-agents one level deep, committing on a feature branch with no pushes.

The always-on behaviour comes from a global rule in the separate `igorsdub/agents` repository, not from this plugin.
