---
name: storm
description: "Deep multi-perspective research using the Stanford STORM method. Discovers expert personas, simulates grounded interviews, maps consensus and disagreements, and generates a cited report with a visual HTML dashboard."
disable-model-invocation: true
---

# STORM Research

Conduct deep, exhaustive research on complex topics using the Stanford STORM method (Synthesis of Topic Outlines through Retrieval and Multi-perspective Question Asking), inspired by Nate Herk's AI agent research engine framework.

Rather than asking a language model to generate an answer from training memory in a single turn, STORM decomposes research into multi-perspective inquiry: discovering diverse expert personas, simulating grounded information-seeking interviews against primary sources, mapping consensus and disagreement, and generating dual outputs: a visual HTML dashboard and a permanent cited Markdown report.

## Core Philosophy

Single-prompt research suffers from four systemic failure modes:
1. **Superficiality**: Models default to common knowledge rather than uncovering nuanced, deep technical details.
2. **Consensus Bias**: Models smooth over legitimate controversies and flatten competing technical trade-offs into bland generalities.
3. **Hallucination**: Claims are synthesized without verifiable primary-source grounding.
4. **Blind Spots**: A single inquiry reflects only the initial prompt framing, missing critical perspectives from operations, security, economics, or competing paradigms.

STORM replaces single-prompt generation with a structured six-phase pipeline:
- **Topic Scoping**: Establish clear boundaries, questions, and deliverables.
- **Perspective Discovery**: Synthesize 3 to 6 distinct expert personas with divergent worldviews, incentives, and inquiry focuses.
- **Interactive Approval Gate**: Review the expert roster and research plan with the user before executing deep retrieval.
- **Grounded Interviews**: Simulate iterative, multi-turn information-seeking conversations anchored in real web searches and document reads.
- **Synthesis and Disagreement Mapping**: Collate evidence into a hierarchical outline, explicitly highlighting areas of consensus and unresolved friction.
- **Dual Output Generation**: Produce both an interactive HTML report launched in the browser and a permanent Markdown report in `research/<topic-slug>.md`.

---

## The Six-Phase Execution Loop

### Phase 1: Topic Scoping and Goal Clarification

Define the research boundaries before launching queries. Establish:
1. **Target Topic**: What specific subject, technology, system, or decision is being investigated?
2. **Core Inquiries**: What 2 to 4 pivotal questions must this research resolve?
3. **Depth and Boundaries**: What related topics are explicitly in scope, and what is out of scope?
4. **Target Audience**: Who will read and act on the findings (for example, senior architects, executive leadership, or research scientists)?

If the user provides a brief topic (such as "CRDTs vs OT" or "State of Solid-State Batteries"), infer reasonable boundaries, summarize the scoping assumptions concisely, and present them in Phase 3.

### Phase 2: Diverse Expert Perspective Discovery

Brainstorm 3 to 6 distinct expert personas. Avoid generic roles like "Researcher 1" or "Software Engineer." Personas must embody genuinely divergent worldviews, incentives, risk tolerances, and inquiry angles:

- **Contrasting Incentives**: Pair an ambitious innovator with a conservative operational auditor.
- **Theoretical vs Practical**: Pair a formal academic theorist with a pragmatic production engineer who deals with messy outages.
- **Economic vs Technical**: Pair an architect focused on raw performance with a financial or procurement strategist evaluating total cost of ownership.
- **Safety, Security, and Compliance**: Include personas focused on edge cases, failure modes, adversarial security, regulatory friction, or user privacy.

For each persona, specify:
- **Role Title**: A descriptive title (for example, "Pragmatic Distributed Systems SRE" or "Post-Quantum Cryptography Theorist").
- **Worldview and Assumptions**: What priors, biases, or operational realities govern their perspective?
- **Inquiry Angle**: What specific dimension of the topic do they scrutinize?
- **Key Questions**: 2 to 3 targeted questions they demand answers to.

### Phase 3: Interactive Approval Gate

Present the proposed research plan to the user before launching heavy search queries. Render a structured summary in chat:
1. **Topic Scope**: The topic boundaries and key questions.
2. **Expert Roster**: The 3 to 6 personas, their worldviews, and their focal inquiries.
3. **Proposed Outline**: The initial structure for the final report.

Ask the user:
> "Here is the expert persona roster and research outline. Would you like to adjust any personas, add specific questions, or proceed with research?"

**Fast-Path Bypass**: If the user passed flags such as `--fast`, `--yes`, or explicitly stated "run without asking", "skip approval", or "auto", proceed directly to Phase 4 without pausing.

### Phase 4: Hybrid Parallel Perspective Research and Grounded Interviews

Conduct grounded information-seeking interviews for each approved persona.

#### The Grounding Loop
For each persona, simulate an expert conducting a targeted inquiry:
1. **Generate Targeted Queries**: Formulate precise search queries reflecting the persona's angle and technical vocabulary.
2. **Execute Retrieval**: Use web search tools (`search_web`) and URL readers (`read_url_content`) to retrieve live documentation, whitepapers, academic publications, benchmarks, and official guides.
3. **Information Extraction**: Extract concrete facts, metrics, quotes, code snippets, and counterarguments. Record the source URL, domain, title, and retrieval timestamp for every claim.
4. **Iterative Follow-up**: Conduct 2 to 4 turns of inquiry per persona. As initial search results reveal nuances, formulate follow-up questions that probe deeper into trade-offs and edge cases.

#### Execution Architecture
- **Concurrent Subagents (Preferred)**: When background subagents are available, launch parallel worker agents for each persona. Each subagent conducts its own search and retrieval loop, returning structured notes with citations.
- **Sequential Fallback**: If subagents are unavailable or constrained, iterate through each persona sequentially in the main thread.
- **Citation Enforcement**: Every statement of fact must link to a primary source URL. If a claim cannot be verified via retrieval, mark it as unverified or remove it.

### Phase 5: Synthesis and Disagreement Mapping

Collate all gathered findings across the persona interviews into a unified knowledge structure.

1. **Hierarchical Outline Synthesis**:
   - Merge perspective-specific outlines into an exhaustive, logical structure.
   - Group findings by domain theme rather than isolating them into disconnected persona silos.

2. **Disagreement and Tension Mapping**:
   - **Consensus Findings**: Identify principles, benchmarks, or conclusions where all expert angles agree.
   - **Active Debates and Friction**: Map areas where experts disagree (for example, performance overhead vs development velocity, centralized vs decentralized consistency, or capital expenditure vs operational flexibility).
   - Characterize the trade-offs fairly without artificially resolving them.

3. **Blind Spots and Open Frontiers**:
   - Highlight unanswered questions where available literature lacks consensus or empirical data.

### Phase 6: Dual Output Generation

Deliver results through two distinct, complementary channels:

#### 1. Visual HTML Report
Write a self-contained, high-fidelity HTML report to the OS temporary directory:
- Resolve temp path: `$TMPDIR/storm-research-<timestamp>.html`, `/tmp/storm-research-<timestamp>.html`, or `%TEMP%\storm-research-<timestamp>.html`.
- Follow the visual specifications in [HTML-REPORT.md](HTML-REPORT.md).
- Use Tailwind CSS and Mermaid.js loaded via CDN.
- Include the header, persona cards deck, consensus vs disagreement matrix, comprehensive cited article, and verified sources ledger.
- Automatically launch the file in the default browser using the host OS command:
  - macOS: `open <path>`
  - Linux: `xdg-open <path>`
  - Windows: `start <path>`
- Print the absolute file path clearly in the chat output.

#### 2. Permanent Cited Markdown Report
Write a permanent report to `research/<topic-slug>.md` in the current workspace. Ensure the directory exists.

The Markdown report must include:
- **Title and Metadata**: Topic, date, methodology, and persona roster summary.
- **Executive Summary**: High-level overview of findings and strategic implications.
- **Expert Personas Overview**: Table or cards summarizing the 3 to 6 perspectives, their focuses, and their distinct contributions.
- **Consensus vs Disagreement Matrix**: Clear tables and callouts identifying points of alignment versus unresolved debates.
- **Comprehensive Research Synthesis**: In-depth narrative sections organized hierarchically, with inline numeric citations (`[^1]`, `[^2]`).
- **Verified Sources Bibliography**: Complete list of numbered references formatted with titles, domains, full URLs, and retrieval dates.
- **Methodology Note**: Brief explanation of the STORM multi-perspective research process.

---

## Writing Guidelines and Repo Conventions

- **Strict No Em-Dash Rule**: Do not use em-dashes (Unicode U+2014) anywhere in prose, comments, reports, or generated HTML. Use commas, colons, parentheses, periods, or conjunctions.
- **Primary Source Grounding**: Prioritize official documentation, RFCs, peer-reviewed papers, engineering postmortems, and reproducible benchmarks over SEO blog posts.
- **Maintain Neutrality**: Present competing viewpoints with technical rigor. Do not take partisan sides on legitimate engineering debates; lay out the trade-offs so the user can make an informed decision.
