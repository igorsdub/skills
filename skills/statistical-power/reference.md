## What it does

`statistical-power` calculates sample sizes and statistical power for research design and study planning. It establishes the relationship between four key parameters: sample size (n), effect size, significance level (alpha), and statistical power (1 - beta).

The skill provides closed-form solvers for standard tests (t-tests, ANOVA, proportions, correlations, chi-square tests, and linear regression) via a unified interface wrapping statsmodels and SciPy. For complex designs that violate simple analytical formulas (such as generalized linear models, linear mixed-effects models, cluster-randomized trials, and survival analysis), it provides a Monte Carlo simulation harness to compute empirical rejection rates and solve for required sample sizes. Crucially, the skill enforces sensitivity analysis across a plausible range of effect sizes and adjusts for attrition, clustering design effects, and multiple comparisons.

## When to reach for it

Reach for `statistical-power` before collecting data, whenever planning a study, writing a grant proposal, preparing an IRB protocol, or pre-registering an analysis.

| Your situation | Where to go |
| --- | --- |
| Determining required sample size or minimum detectable effect (MDE) | `statistical-power` |
| Structuring randomization, blocking, controls, or factorial designs | `experimental-design` |
| Analyzing collected data, running hypothesis tests, and APA reporting | `statistical-analysis` |
| Specifying and estimating complex regressions, GLMs, or time series | `statsmodels` |
| Fitting Bayesian generative models or assessing posterior distributions | `pymc` |

Reach for it when:
- Answering questions like "how many samples or subjects do I need to detect this effect?"
- Determining the minimum detectable effect size for a fixed, constrained sample size.
- Generating power curves to illustrate power across different sample sizes or effect magnitudes.
- Adjusting planned enrollment for expected participant attrition or cluster correlations (ICC).
- Simulating power for complex hierarchical, longitudinal, or non-normal data generating processes.

## Common questions

**Why shouldn't I compute post-hoc ("observed") power after completing a study?**

Observed power calculates statistical power using the observed effect size and sample size from an already analyzed study. Mathematically, observed power is a direct one-to-one transformation of the p-value: a non-significant p-value will always produce low observed power. It adds no new information about whether the study was well-designed. If a study is complete and non-significant, report the confidence interval around the effect size or conduct a sensitivity analysis reporting the minimum effect the sample was equipped to detect.

**How should I select an effect size when planning sample size?**

Prioritize the smallest effect size of interest (SESOI): the smallest difference that carries clinical, practical, or theoretical significance. Powering on the SESOI ensures the experiment is sensitive to any meaningful outcome. If using estimates from pilot studies, account for selection bias and sample uncertainty by evaluating a range of plausible values rather than relying on an optimistic point estimate. Avoid treating Cohen's generic benchmarks (small = 0.2, medium = 0.5) as objective truths without domain justification.

**How does clustering or grouped observation affect power?**

When experimental units are clustered (such as patients within clinics or students within classrooms), observations within clusters are correlated. This correlation is measured by the intraclass correlation coefficient (ICC). Clustering inflates variance by the design effect: `DEFF = 1 + (m - 1) * ICC`, where `m` is cluster size. Analyzing clustered data as independent observations constitutes pseudoreplication and severely overstates statistical power.

**Why is sensitivity analysis essential in power calculations?**

Because effect size assumptions are inherently uncertain, reporting a single required sample size creates a false impression of precision. A sensitivity analysis evaluates sample size across a spectrum of plausible effect sizes and power levels (for example, generating a power curve), showing how sensitive the design is to small shifts in assumed parameters.

## It's working if

- The target hypothesis, test type, alpha, desired power, and effect size metric are explicitly specified.
- The effect size is grounded in a justified smallest effect size of interest (SESOI) or sensitivity range rather than an arbitrary guess.
- Required sample sizes are rounded up to whole integers and adjusted for expected dropout rates.
- Clustered or hierarchical designs account for design effects (ICC) or use simulation rather than assuming independence.
- Findings present a sensitivity range or power curve instead of an isolated single-point estimate.
