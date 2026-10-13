## What it does

`scholar-evaluation` provides developmental, qualitative-first, and evidence-traceable review of scholarly works, including manuscripts, proposals, protocols, and research ideas. It also audits whether low-stakes research-assessment rubrics and processes adhere to established principles of responsible evaluation.

The skill operates under a strict, non-negotiable safety boundary:
- Never rank individual scholars.
- Never reduce a person or their career to a composite score.
- Never use this skill to automate, influence, or score high-stakes decisions (hiring, tenure, promotion, admissions, disciplinary actions, or funding decisions).

Core capabilities include:
- **Developmental Feedback:** Evaluates research ideas across soundness (empirical support in literature) and contribution (differentiation from prior art), providing actionable options for improvement rather than pass/fail verdicts.
- **Rubric Auditing:** Inspects assessment rubrics to ensure they define explicit constructs, observable evidence anchors, missingness policies, and transparent scoring weights.
- **Local Tooling:** Bundles deterministic, offline Python scripts to validate JSON schemas, verify evidence traceability against source documents, evaluate rubric weight sensitivity, and summarize inter-rater agreement.
- **Responsible Assessment Alignment:** Grounds evaluation practices in the San Francisco Declaration on Research Assessment (DORA), the Leiden Manifesto, CoARA, and the Hong Kong Principles.

## When to reach for it

Reach for `scholar-evaluation` when seeking structured developmental feedback on a draft paper or research concept, or when designing transparent, responsible assessment rubrics.

| Your situation | Where to go |
| --- | --- |
| Developmental feedback on a scientific idea, protocol, or manuscript draft | `scholar-evaluation` |
| Auditing an internal research rubric for validity, bias, and sensitivity | `scholar-evaluation` |
| Drafting and refining grant proposals for NSF, NIH, DOE, or DARPA | `research-grants` |
| Compiling literature packets and finding claim evidence | `research-lookup` |
| Reviewing code changes for architectural and implementation standards | `code-review` |

If requested to rank applicants, generate hiring recommendations, or score candidate dossiers, the skill must refuse the task and redirect to qualitative review of individual scholarly artifacts.

## Common questions

**Why is there an absolute prohibition on ranking individuals or making personnel decisions?**

Automated evaluation of individuals creates severe risks of bias amplification, gaming of unvalidated proxies, and erosion of academic fairness. Responsible research assessment frameworks (such as DORA, CoARA, and the Leiden Manifesto) require that qualitative expert judgment lead all substantive evaluations. Algorithms must never replace human governance or decide career outcomes.

**What is ScholarEval and how is it used here?**

ScholarEval refers to the research framework described by Moussa et al. (arXiv:2510.16234), which explores retrieval-augmented evaluation of research idea soundness and contribution. In this skill, ScholarEval principles serve as an experimental framework for developmental critique of concepts, not as an automated grading engine.

**Can this skill predict journal acceptance or review outcomes?**

No. The skill does not issue publication-readiness ratings, top-tier designations, or accept/reject forecasts. Its sole purpose is developmental feedback: clarifying claims, checking literature support, and highlighting areas that need stronger evidentiary grounding.

**What do the bundled scripts in `scripts/` do?**

The bundled tools run purely locally without network access or external APIs:
- `validate_rubric.py`: verifies that a rubric schema defines required fields, valid scales, and bounded weights.
- `check_traceability.py`: ensures every claim or score links to cited evidence excerpts.
- `calculate_scores.py`: computes bounded criterion totals without ungrounded extrapolations.
- `weight_sensitivity.py`: tests how stable rubric outputs remain under variations in criterion weights.
- `summarize_agreement.py`: computes inter-rater agreement statistics for calibration exercises.

## It's working if

- Feedback focuses on qualitative critique, methodological soundness, and literature groundedness.
- Requests to rank people, grade job candidates, or decide funding awards are immediately refused.
- Every criterion rating maps to explicit text anchors and documented evidence references.
- Limitations regarding disciplinary scope, rater uncertainty, and construct validity are clearly declared.
- Bundled schemas and validation scripts run cleanly without external dependencies.
