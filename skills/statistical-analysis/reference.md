## What it does

`statistical-analysis` provides structured workflows and decision frameworks for conducting classical hypothesis testing, regression analysis, assumption checking, effect size calculations, and APA-compliant statistical reporting in Python.

It guides the selection of parametric tests (independent and paired t-tests, one-way and repeated-measures ANOVA), non-parametric counterparts (Mann-Whitney U, Wilcoxon signed-rank, Kruskal-Wallis, Friedman), correlation measures (Pearson, Spearman), and contingency table tests (chi-square test of independence, Fisher exact test). The skill enforces pre-test diagnostic checks (normality, homoscedasticity, linearity, multicollinearity) using bundled verification scripts. Crucially, it pairs every hypothesis test with effect size metrics and confidence intervals to ensure practical significance is assessed alongside statistical significance.

## When to reach for it

Reach for `statistical-analysis` when analyzing collected experimental or observational data to answer research questions, compare groups, evaluate associations, or prepare formal reports.

| Your situation | Where to go |
| --- | --- |
| Evaluating group differences, hypothesis tests, correlation, and APA reporting | `statistical-analysis` |
| Detailed statistical modeling, GLMs, discrete choice, or time series specifications | `statsmodels` |
| Planning an experiment, choosing controls, blocking, or setting up DOE | `experimental-design` |
| Sample size determination or power calculations before gathering data | `statistical-power` |
| Bayesian generative models, probabilistic programming, or MCMC inference | `pymc` |
| Fast tabular data loading and preprocessing | `polars` |

Reach for it when:
- Deciding whether a parametric or non-parametric test fits your data distribution and study design.
- Checking distributional assumptions (Shapiro-Wilk, Levene test, Q-Q plots, residual diagnostics).
- Computing standardized effect sizes (Cohen's d, partial eta-squared, Hedges' g, Cramér's V) with confidence intervals.
- Structuring academic results in APA 7th edition format.

## Common questions

**Why shouldn't I automatically switch to a non-parametric test when a normality test fails?**

Formal tests of normality such as Shapiro-Wilk become sensitive to trivial deviations at moderate or large sample sizes. Conversely, with very small sample sizes, they lack power to detect meaningful non-normality. Evaluate Q-Q plots and sample size alongside the test statistic. In many settings (such as independent two-group comparisons with unequal variances), Welch's t-test provides robust performance without losing the ability to interpret group mean differences.

**What is the difference between observed power and a sensitivity power analysis?**

Observed power (computing statistical power post-hoc using the observed effect size and sample size) is a direct, redundant mathematical transformation of the p-value. It provides no new information about study quality and is often misleading. If a completed study is non-significant, run a sensitivity power analysis to report the minimum effect size the design could reliably detect at 80% power.

**How should multiple comparisons be handled after ANOVA?**

When conducting post-hoc pairwise comparisons after a significant ANOVA, apply correction procedures to control family-wise error rates or false discovery rates. Use Tukey HSD for equal variances across all pairwise contrasts, Games-Howell when variances differ, or Benjamini-Hochberg FDR when testing large families of exploratory hypotheses.

**Why is statistical significance not equivalent to practical importance?**

With sufficiently large sample sizes, negligible effects achieve low p-values. Conversely, with small sample sizes, clinically important effects may fail to reach the alpha = 0.05 threshold. Lead your interpretation with the magnitude and confidence interval of the effect size rather than relying solely on p-values.

## It's working if

- The research question, variable roles (independent, dependent, covariates), and study design are identified before testing.
- Distributional and modeling assumptions are screened with diagnostic plots and tests prior to interpreting outcomes.
- Welch's correction is prespecified for independent two-sample comparisons unless equal variances are known a priori.
- Every statistical test reports descriptive statistics, test statistics with degrees of freedom, exact p-values, and effect sizes with confidence intervals.
- Planned analyses and non-significant results are documented transparently rather than dropped.
