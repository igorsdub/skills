Skills are organized as follows:

- `skills/<skill-name>/`: active skills for daily engineering and productivity workflows
- `skills/in-progress/`: beta skills: public on purpose, feedback wanted, not shipped in the plugin
- `archive/`: obsolete or rarely used skills kept around for historical reference

Every active skill directly under `skills/` must have a reference in the top-level `README.md` and an entry in `.claude-plugin/plugin.json`'s `skills` array (the Claude Code plugin ships exactly the active set). Skills in `archive/` and `skills/in-progress/` must not appear in either.

Install commands are copied verbatim from [.agents/install-block.md](./.agents/install-block.md). `.claude-plugin/marketplace.json` is the repo's own marketplace. Every agent except Claude Code installs from it to get automatic updates, and Claude Code uses `claude-plugins-official`. Run `claude plugin validate . --strict` after touching either manifest. [ADR 0002](./.agents/adr/0002-ship-as-a-claude-code-plugin.md) records why.

Each skill entry in the top-level `README.md` must link the skill name to its `SKILL.md`.

Documentation is co-located inside each skill folder as `reference.md`. When you add, rename, or change the behaviour of an active skill, create or re-sync its `reference.md`. A finished documentation file carries four sections: **What it does**, **When to reach for it**, **Common questions**, and **It's working if**. Skills in `archive/` and `skills/in-progress/` do not require a separate reference file.

Every `SKILL.md` is either user-invoked (`disable-model-invocation: true` plus `policy.allow_implicit_invocation: false` in `agents/openai.yaml`, reachable only by the human) or model-invoked (model- or user-reachable). See [.agents/invocation.md](./.agents/invocation.md).

[`ask-matt`](./skills/ask-matt/SKILL.md) is the router that maps every user-reachable skill and how they relate. The same trigger that re-syncs a docs page applies to it: whenever you add, rename, remove, or change how a user-reachable skill fits the flows, re-read `ask-matt`'s `SKILL.md` and update it so the map stays accurate: a new skill it never mentions, or a stale one it still routes to, is a router that lies.

To (re)link every skill outside `archive/` into the local harness skill directories (`~/.claude/skills`, `~/.agents/skills`, `~/.gemini/config/skills`), run `scripts/link-skills.sh`. Each entry is a symlink into this repo, so a `git pull` keeps installed skills current; re-run the script after adding, removing, or renaming a skill.

To install the local-only orchestrator policy, run `scripts/link-orchestrator.sh`. It links `rules/CLAUDE.md`, `rules/GEMINI.md` and `rules/AGENTS.md` into `~/.claude`, `~/.gemini` and `~/.codex` (never overwriting a real file) and links the sub-agent definitions in `agents/` into `~/.claude/agents` (`--copy-agents` copies instead). `agents/` and `rules/` are not shipped in the plugin.

No em-dashes anywhere in this repo's prose (`SKILL.md` files, docs, `README.md`, `CHANGELOG.md`, ADRs, changesets, code comments). Where a sentence reaches for one, rewrite it instead with a comma, colon, period, parentheses, or a conjunction, whichever the sentence actually wants; never do a blind character substitution.

## Agent skills

### Triage labels

Canonical names, unchanged. See `docs/agents/triage-labels.md`. Issues are judged against [`SCOPE.md`](./SCOPE.md).
