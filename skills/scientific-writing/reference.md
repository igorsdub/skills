## What it does

`scientific-writing` drafts, revises, and audits scientific manuscripts and reports with explicit evidence provenance, reporting-guideline compliance, authorship accountability, confidentiality controls, and local consistency verification.

Key capabilities include:
- **Evidence Provenance:** Binds every factual or numeric assertion directly to verified evidence identifiers, ensuring claims remain anchored in source data without hallucinated details.
- **Reporting Guideline Coverage:** Evaluates manuscript structure against established reporting standards including CONSORT 2025, SPIRIT 2025, PRISMA 2020, STROBE, STARD, TRIPOD+AI, ARRIVE 2.0, CARE, SQUIRE 2.0, and CHEERS 2022.
- **Authorship Accountability:** Maps contributor responsibilities against CRediT taxonomy roles and ICMJE authorship criteria, maintaining explicit records of human accountability.
- **Ethics and Declarations:** Structures required declarations covering funding sources, conflicts of interest, data and code availability, protocol registration, and AI assistance statements per COPE and ICMJE guidelines.
- **Deterministic Validation:** Bundles offline, standard-library Python tools in `scripts/` for checking authorship definitions, citation consistency, and manuscript completeness.

## When to reach for it

Reach for `scientific-writing` when authoring, structuring, or auditing academic manuscripts, preprints, or technical reports where scientific traceability and provenance are essential.

| Your situation | Where to go |
| --- | --- |
| Drafting or revising journal manuscript sections with evidence binding | `scientific-writing` |
| Auditing reporting-guideline compliance and contributor roles | `scientific-writing` |
| Designing publication-ready charts and multi-panel figures | `scientific-visualization` |
| Preparing conference presentations or defense slide decks | `scientific-slides` |
| Evaluating an external manuscript as an authorized reviewer | `peer-review` |
| Gathering literature references and compiling evidence packets | `research-lookup` |

## Common questions

**Can generative AI be listed as a co-author on a scientific paper?**

No. Consensus guidelines across major publication ethics bodies (ICMJE, COPE, Nature Portfolio, JAMA) state that AI tools cannot be named as authors because they cannot accept legal responsibility, approve final revisions, or guarantee the integrity of the research. AI tools must be transparently disclosed in methods or acknowledgments sections.

**How does the skill prevent citation fabrication?**

The skill strictly prohibits inventing citations, DOIs, PMIDs, or volume and page numbers. Every reference must originate from a verified database retrieval (such as PubMed, OpenAlex, or Crossref) or user-supplied source document. Unverified sources remain marked with explicit unverified status flags rather than plausible boilerplate.

**What is the confidentiality boundary for unpublished manuscripts?**

Unpublished drafts, pre-submission data, and peer-review materials must never be transmitted to external services without documented authorization from the manuscript owner and target venue. Processing defaults to local standard-library tools without network calls or external logging.

**Does this skill format manuscripts for specific journal styles?**

The skill provides structural drafting and content auditing against universal scientific standards. While it guides word count limits, reference formats, and figure callouts, final layout and journal-specific typography must be verified against the target journal's current author guidelines before submission.

## It's working if

- Every factual claim maps to an explicit, verified evidence identifier.
- Reporting guidelines appropriate to the study design are checked and documented.
- Author contributions align with CRediT roles and ICMJE criteria.
- Required disclosure statements (competing interests, funding, data availability) are present and verifiable.
- Unverified assertions and missing data retain explicit placeholder flags rather than fabricated prose.
