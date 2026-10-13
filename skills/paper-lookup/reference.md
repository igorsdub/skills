## What it does

`paper-lookup` queries 18 scholarly APIs across disciplines to retrieve papers, preprints, citation edges, open-access full text, repository records, and institutional metadata with full provenance.

Supported databases and registries include:
- **Biomedical Literature:** PubMed, PMC, Europe PMC
- **Preprint Servers:** bioRxiv, medRxiv, arXiv
- **Multidisciplinary Indexes:** OpenAlex, Crossref, Semantic Scholar, CORE
- **Citations and Open Access:** OpenCitations, Unpaywall, DOAJ
- **Repositories and Entities:** PubTator3, Zenodo, Figshare, ROR, BioStudies

The primary design principle of the skill is reproducible retrieval under silent-failure conditions. Many scholarly APIs return HTTP 200 responses on errors, such as empty JATS XML bodies when publishers forbid redistribution, arXiv returning "Error" entries as valid search results, or bioRxiv skipping records when given miscalculated cursor offsets. `paper-lookup` incorporates defensive verification and bundles standard-library Python scripts for deterministic pagination, JATS text extraction, arXiv Atom feed parsing, and OpenAlex abstract reconstruction.

## When to reach for it

Reach for `paper-lookup` whenever you need direct, authoritative bibliographic retrieval from academic databases rather than general web search.

| Your situation | Where to go |
| --- | --- |
| Looking up a DOI, PMID, arXiv ID, paper abstract, or citation count | `paper-lookup` |
| Finding open-access full-text PDFs or XML across PMC, Europe PMC, or Unpaywall | `paper-lookup` |
| Compiling a 60-reference evidence packet and claim map for a manuscript | `research-lookup` |
| Conducting a PRISMA systematic review with screening workflows | `literature-review` |
| Validating citations and generating bibliography files | `citation-management` |

## Common questions

**Why does the skill emphasize HTTP 200 hazards?**

Several scholarly APIs do not raise non-200 HTTP status codes when requests fail or data is restricted. For example, PMC eFetch returns HTTP 200 with an empty body and an XML comment when a publisher forbids text redistribution. bioRxiv returns HTTP 200 even when a cursor offset is misaligned, silently dropping intermediate records. Europe PMC embeds error codes within 200 payloads. The skill inspects response envelopes and payload structures instead of relying solely on HTTP headers.

**Are API keys required to use this skill?**

No. All 18 APIs support public, keyless usage. Optional keys (such as `NCBI_API_KEY`, `S2_API_KEY`, `OPENALEX_API_KEY`, and `CORE_API_KEY`) increase rate limits or unlock full text, but the skill functions without them by respecting polite rate limits.

**When should I use the bundled scripts instead of custom curl commands?**

Always use the bundled scripts for complex operations:
- `scripts/paginate.py`: handles correct cursor math, rate limiting, and count reconciliation.
- `scripts/jats_to_text.py`: extracts structured sections and fails non-zero on bodyless metadata.
- `scripts/arxiv_atom.py`: decodes arXiv Atom feeds, strips wrapping, and detects error entries.
- `scripts/openalex_abstract.py`: reconstructs word order from OpenAlex inverted indices.

**How does preprint keyword search work for bioRxiv and medRxiv?**

Neither bioRxiv nor medRxiv provides native keyword search on their official public APIs; they only support date ranges and DOI lookups. To search preprints by keyword, `paper-lookup` routes queries through Europe PMC using `SRC:"PPR"` or through OpenAlex and Semantic Scholar.

## It's working if

- Queries route to the authoritative database matching the field and identifier type.
- Returned results include complete provenance (endpoint, parameters, access date, and identifier).
- Exhaustive searches report expected count versus retrieved count and flag any reconciliation shortfalls.
- Non-open-access articles are reported as metadata-only rather than hallucinated full text.
- Rate limits are respected without triggering 429 throttling errors.
