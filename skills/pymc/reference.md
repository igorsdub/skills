## What it does

`pymc` provides reference patterns and best practices for Bayesian probabilistic modeling in Python using PyMC, PyTensor, and ArviZ. It enables the specification of generative statistical models, parameter estimation via the No-U-Turn Sampler (NUTS) Markov Chain Monte Carlo (MCMC) algorithm, and variational inference.

The skill covers hierarchical and multi-level regressions (non-centered and centered parameterizations), custom likelihoods and priors, prior and posterior predictive checks, out-of-sample predictions via mutable data containers (`pm.Data`), and rigorous MCMC convergence diagnostics (rank-normalized R-hat, bulk and tail effective sample size, divergences, energy BFMI). It also guides model evaluation and selection using Pareto-smoothed importance sampling leave-one-out cross-validation (PSIS-LOO) and Widely Applicable Information Criterion (WAIC).

## When to reach for it

Reach for `pymc` when standard frequentist point estimation is insufficient and you require complete posterior probability distributions over parameters, predictions, or latent variables.

| Your situation | Where to go |
| --- | --- |
| Full Bayesian inference, custom priors, hierarchical shrinkage, or MCMC sampling | `pymc` |
| Frequentist regression, OLS, GLMs, discrete choice, or standard econometric models | `statsmodels` |
| Classical hypothesis testing (t-tests, ANOVA) with APA reporting | `statistical-analysis` |
| Sample size calculation or prospective power analysis prior to data collection | `statistical-power` |
| Designing study structures, randomization, and blocking schedules | `experimental-design` |
| High-performance tabular data ingestion and manipulation | `polars` |

Reach for it when:
- Building hierarchical (random effects) models with partial pooling across groups or sites.
- Incorporating informative domain knowledge or regularizing priors to constrain parameter space.
- Quantifying parameter uncertainty directly as credible intervals rather than confidence intervals.
- Evaluating complex nonlinear data-generating mechanisms where analytical likelihoods are unavailable.
- Generating posterior predictive distributions that capture both parameter uncertainty and observation noise.

## Common questions

**What is the difference between centered and non-centered parameterizations in hierarchical models?**

In centered parameterizations, group-level parameters are sampled directly from the group hyperprior distribution (`theta ~ Normal(mu, sigma)`). When data per group are sparse, this creates a narrow geometry ("the funnel") where NUTS struggles, leading to divergences. Non-centered parameterizations break the geometry by sampling standard normal offsets (`offset ~ Normal(0, 1)`) and deterministically shifting them (`theta = mu + offset * sigma`). As a rule of thumb, use non-centered parameterizations when sample size per group is small, and centered parameterizations when data per group are abundant.

**How should I address divergent transitions during sampling?**

Divergences indicate that the sampler encountered regions of high posterior curvature that the leapfrog integrator could not navigate accurately. First, increase the target acceptance probability (`target_accept=0.95` or `0.99`), which forces smaller integration steps. If divergences persist, reparameterize the model (for example, switching from centered to non-centered hierarchical priors) or check for overly broad priors that permit implausible parameter regimes.

**What do R-hat and Effective Sample Size (ESS) indicate?**

Rank-normalized R-hat assesses convergence across independent MCMC chains. Values close to 1.0 (ideally R-hat < 1.01) indicate good chain mixing; values above 1.05 suggest poor convergence. Bulk ESS measures the precision of mean and median posterior estimates, while Tail ESS measures the precision of credible interval endpoints (such as 95% intervals). Aim for both Bulk ESS and Tail ESS > 400 across all sampled chains.

**How do I perform out-of-sample predictions with PyMC?**

Define predictor coordinates and inputs using `pm.Data("x", x_train)` inside the model context. After fitting the posterior with `pm.sample()`, update the container with new test features using `pm.set_data({"x": x_test})`, then call `pm.sample_posterior_predictive()` to draw predictions for new inputs.

## It's working if

- Generative models declare explicit coordinates and dimensions using `pm.Model(coords=...)` and named variables.
- Prior predictive checks (`pm.sample_prior_predictive()`) verify that chosen priors generate plausible simulated data before seeing the observed data.
- Sampling runs across multiple independent chains and passes diagnostic criteria: zero divergences, R-hat < 1.01, and adequate bulk and tail ESS.
- Posterior predictive checks (`pm.sample_posterior_predictive()`) validate that fitted models reproduce observed data features and distributions.
- Predictions and model comparisons (via `az.compare()` using PSIS-LOO) are evaluated using ArviZ inference data structures.
