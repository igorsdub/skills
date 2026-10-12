## What it does

`research-lookup` compiles external scholarly evidence to plan and write scientific manuscripts or research briefs. By default, it targets 60 verified, unique references and outputs a structured manuscript research packet rather than an unverified list of links.

The skill runs a Parallel-first workflow. It uses Parallel Search with academic filtering to discover candidates, followed by Parallel Extract to pull verified excerpts and source text. For exhaustive investigations, it can invoke Parallel Research or optional Perplexity fallback routing.

The output packet is written to a designated directory containing both human-readable summaries and machine-readable data:
- `packet.json` and `packet.md`: comprehensive manuscript research packet.
- `references.json` and `references.bib`: citation records formatted for reference managers.
- `evidence-matrix.json`: structured study evidence, study types, populations, and findings.
- `claim-source-map.json`: candidate claims directly mapped to source excerpts.
- `synthesis.json`: consensus points, conflicting findings, methods patterns, and open gaps.
- `section-briefs.json`: targeted evidence packets for Introduction, Methods rationale, and Discussion.
- `coverage.json`: audit report of target metrics, quality mix, date distribution, and limitations.
- `search-ledger.json`: reproducible query log with timestamps, parameters, and identifiers.

## When to reach for it

Reach for `research-lookup` when planning or drafting a paper and needing a grounded foundation of published literature to support claims, methods decisions, or discussion points.

| Your situation | Where to go |
| --- | --- |
| Need a 60-reference evidence packet and claim map for a manuscript | `research-lookup` |
| Looking up a specific paper, DOI, PMID, citation count, or open-access PDF | `paper-lookup` |
| Conducting a rigorous PRISMA systematic review with screening protocols and bias assessment | `literature-review` |
| Formatting citations, bibtex entries, or validating DOIs | `citation-management` |
| Drafting manuscript prose from an existing evidence packet | `scientific-writing` |

Do not reach for `research-lookup` for casual trivia questions, private unpublished datasets, or claims that can be settled using files already in the workspace.

## Common questions

**What does a "verified reference" mean in this skill?**

In `research-lookup`, a verified reference means an item was successfully retrieved with a non-empty excerpt via Extract, excluding known retractions. It confirms that the text exists and was accessible. It does not replace human scrutiny of claim support, study quality, or subsequent corrections.

**Why does the default workflow aim for 60 references?**

Standard full-length scientific manuscripts typically cite 40 to 70 relevant publications across introduction, background, methods justification, and discussion. Setting an explicit target of 60 ensures deep coverage of competing theories, alternative methodology, and diverse research groups rather than superficial confirmation bias.

**How does this skill differ from `paper-lookup`?**

`paper-lookup` is a precision tool for querying 18 specific scholarly APIs (like PubMed, arXiv, Crossref, and Semantic Scholar) for exact records, identifiers, citation graphs, and PDFs. `research-lookup` is a synthesis-oriented workflow engine that formulates search strategies, gathers dozens of papers, extracts excerpts, and organizes them into structured sections for manuscript preparation.

**What happens if some references are behind paywalls?**

The skill extracts all freely available open-access text, abstracts, and publisher metadata. When full text is inaccessible, it documents that limitation in `coverage.json` and restricts claims to what is substantiated by the retrieved abstract and metadata.

## It's working if

- A search ledger records queries, filters, target counts, and returned identifiers without silent omissions.
- The generated packet includes structured JSON and Markdown files linking extracted excerpts directly to claims.
- The reference target reaches or honestly reports shortfalls against the 60-reference baseline in `coverage.json`.
- Conflicting findings and methodological limitations are documented alongside consensus points.
- No synthetic or hallucinated citations are created; every entry resolves to real literature.
