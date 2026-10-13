## What it does

`storm` performs deep, multi-perspective research on complex questions using the Stanford STORM method (Synthesis of Topic Outlines through Retrieval and Multi-perspective Question Asking), inspired by Nate Herk's AI agent research engine framework.

Rather than relying on single-prompt language model generation, which tends to hallucinate, smooth over genuine technical controversies, and reflect only the prompt author's initial perspective, `storm` automates a rigorous inquiry workflow:
1. **Scopes the topic**: Clarifies boundaries, key questions, and target depth.
2. **Discovers expert perspectives**: Formulates 3 to 6 distinct expert personas with divergent worldviews, assumptions, and inquiry angles.
3. **Presents an interactive approval gate**: Shares the expert roster and research outline with the user before executing heavy search queries.
4. **Conducts grounded interviews**: Simulates multi-turn information-seeking conversations anchored in real web searches and document fetches.
5. **Maps consensus and disagreement**: Collates evidence into an outline, explicitly highlighting points of agreement alongside active technical or philosophical tensions.
6. **Produces dual outputs**: Generates a self-contained, interactive HTML dashboard launched in the local browser, plus a permanent, cited Markdown report in `research/<topic-slug>.md`.

---

## When to reach for it

Reach for `storm` when investigating complex topics where multiple valid approaches exist, trade-offs are non-trivial, or a comprehensive survey grounded in real sources is required.

| Skill | Method | Output | When to pick it |
| --- | --- | --- | --- |
| `storm` | Multi-perspective expert persona discovery, grounded simulated interviews, consensus and tension mapping. | Interactive HTML dashboard in temp directory and permanent cited Markdown report in `research/`. | Complex topics, architectural decisions, technology evaluations, and subjects with competing expert paradigms. |
| `research` | Single background agent investigating primary docs, source code, and specs. | Single Markdown file in the repo. | Targeted factual lookups, verifying API signatures, or single-perspective documentation checks. |
| `research-lookup` | Multi-database scholarly search across 18 APIs (such as PubMed, arXiv, Crossref). | Formatted evidence packet with citation provenance. | Preparing academic manuscripts, looking up DOIs, or gathering peer-reviewed papers for scientific writing. |
| `grill-with-docs` | Interactive interview grilling the human user against existing documentation. | Conversational critique and updated specifications. | Stress-testing a proposed architectural plan against documented project rules. |

---

## Common questions

**How does STORM handle subagent nesting without runaway recursion?**

STORM uses a flat, single-tier subagent architecture. When background subagents are available, the orchestrator spawns one worker agent per persona. Each worker conducts its grounded search queries and returns a structured findings dossier to the orchestrator. Workers do not spawn subagents of their own. If background subagents are unavailable or constrained, STORM executes the persona interviews sequentially in the main thread.

**Does interviewing 3 to 6 personas consume too many tokens?**

STORM bounds token consumption through focused, iterative turns rather than open-ended dialogue. Each persona pursues 2 to 4 targeted information-seeking turns focused on specific inquiry angles. Unfiltered search results are condensed into relevant facts and citations before synthesis. The final synthesis aggregates findings by thematic outline rather than concatenating raw conversational transcripts.

**What happens when experts arrive at contradictory findings?**

STORM treats disagreement as high-value signal rather than an error to hide. Instead of averaging conflicting opinions into generic compromise, the Consensus and Disagreement Matrix explicitly documents points of tension. The report attributes divergent conclusions to differing assumptions, operational environments, or optimization goals (such as developer ergonomics versus strict operational efficiency).

**How does STORM ensure source validity and prevent hallucinated URLs?**

Every factual claim in the report is anchored to a primary source URL retrieved during the grounded interview phase. The skill validates links through live web searches and URL reads. Claims that cannot be verified against retrieved documentation are marked as unverified or removed.

**How does STORM handle fast-moving topics where training data is outdated?**

Because STORM uses live web search and document retrieval during the interview loop, it accesses current documentation, recent benchmark reports, RFC updates, and release announcements. Every entry in the Verified Sources Ledger records the domain, URL, and retrieval timestamp.

---

## It's working if

- The research begins by presenting 3 to 6 distinct expert personas with divergent technical backgrounds, worldviews, and focal questions.
- An interactive approval gate gives the user a chance to inspect and refine the persona roster before deep retrieval begins (unless bypassed with `--fast` or `--yes`).
- Each persona conducts a grounded information-seeking inquiry backed by live web searches and document reads.
- The synthesis explicitly distinguishes empirical consensus from active technical or architectural debates.
- A self-contained HTML dashboard with Tailwind styling and Mermaid diagrams is generated in the OS temp directory and launched in the browser.
- A permanent, fully cited Markdown report is saved to `research/<topic-slug>.md` with numbered citations and a verified source bibliography.
- No em-dashes appear anywhere in the generated documentation, HTML report, or Markdown summary.
