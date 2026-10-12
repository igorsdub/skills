## What it does

`peer-review` prepares evidence-bounded, constructive peer-review drafts and structured manuscript assessments to assist authorized human reviewers.

Key capabilities include:
- **Confidentiality and Intake Authorization:** Enforces strict ethical boundaries per COPE and ICMJE guidelines, verifying reviewer authorization and journal AI policies before processing any unpublished submission.
- **Reporting Guideline Selection:** Identifies applicable reporting standards (such as CONSORT, PRISMA, STROBE, or ARRIVE) to assess whether the submission provides necessary methodological disclosures.
- **Claim-Evidence Matrix Alignment:** Maps empirical claims in the manuscript against supporting tables, figures, and statistical tests to pinpoint unsupported conclusions or overstatements.
- **Methodological and Statistical Auditing:** Checks statistical reporting (sample sizes, degrees of freedom, effect sizes, multiple testing corrections, and uncertainty intervals) and code/data availability.
- **Constructive Tone and Actionability Linting:** Evaluates review drafts to ensure comments are professional, specific, and actionable, eliminating dismissive or inflammatory phrasing.
- **Deterministic Offline Tooling:** Bundles deterministic standard-library Python scripts in `scripts/` to validate intake, check citations, and generate structured review scaffolds locally.

## When to reach for it

Reach for `peer-review` when evaluating an academic paper, protocol, preprint, or grant application under an authorized review mandate.

| Your situation | Where to go |
| --- | --- |
| Conducting formal, authorized peer review of a scientific manuscript | `peer-review` |
| Authoring or revising your own manuscript before journal submission | `scientific-writing` |
| Evaluating academic performance, hiring rubrics, or tenure dossiers | `scholar-evaluation` |
| Assessing research code quality and software architectures | `code-review` |
| Preparing a response to peer-review comments on your own paper | `scientific-writing` |

## Common questions

**Can unpublished manuscripts be submitted to external AI APIs?**

No. Unless explicit permission has been granted in writing by the journal editor and authors, uploading confidential manuscripts to external cloud services or public AI platforms violates peer-review confidentiality agreements. All bundled review scripts run locally and make zero external network requests.

**Does the skill make final editorial accept or reject decisions?**

No. Final publication recommendations remain the sole prerogative of the human reviewer and journal editors. The skill assists with identifying methodological gaps, verification of reporting standards, and structuring clear feedback.

**How does the skill ensure feedback is constructive?**

The skill uses a dedicated review linter (`scripts/lint_review.py`) that checks review comments for specificity, evidence references, and constructive phrasing. It flags vague criticisms (such as "the paper is unclear") and suggests concrete requests (such as specifying which paragraph needs clarification and what data would resolve the ambiguity).

**What happens if reviewer authorization is missing or ambiguous?**

The intake gate (`scripts/validate_review_intake.py`) blocks processing until the user documents their authorization status and the target journal's policy. If authorization cannot be confirmed, the skill will not process confidential manuscript text.

## It's working if

- Reviewer authorization and confidentiality criteria are formally confirmed at intake.
- Review observations cite specific page, paragraph, table, or figure references.
- Identified methodological issues include concrete suggestions for improvement or clarification.
- Draft comments maintain a constructive, objective, and scholarly tone throughout.
- Confidential manuscript content is processed strictly within authorized boundaries.
