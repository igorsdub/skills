## What it does

`statsmodels` provides in-depth patterns for estimating and diagnosing statistical and econometric models in Python. It supports ordinary least squares (OLS), weighted least squares (WLS), generalized least squares (GLS), generalized linear models (GLM, including logistic, Poisson, and negative binomial models), discrete choice models (multinomial logit, probit, hurdle models), linear mixed effects models, and time series models (ARIMA, SARIMAX, VAR).

Beyond model estimation, the skill guides formal diagnostic testing: heteroscedasticity tests (Breusch-Pagan, White), autocorrelation tests (Durbin-Watson, Ljung-Box), multicollinearity screening (variance inflation factor, VIF), influence diagnostics (Cook's distance, leverage), specification tests (Ramsey RESET), and robust covariance adjustments (HC0 through HC3, clustered standard errors, Newey-West).

## When to reach for it

Reach for `statsmodels` when conducting formal econometric modeling, parameter inference, regression diagnostics, or statistical hypothesis tests that require customized model specifications.

| Your situation | Where to go |
| --- | --- |
| Regression modeling, GLMs, discrete choice, robust SEs, or econometric inference | `statsmodels` |
| Quick hypothesis tests, standard t-tests, ANOVA, and APA-formatted summaries | `statistical-analysis` |
| Fully Bayesian generative models or custom prior/posterior MCMC sampling | `pymc` |
| Planning study sample size or simulating statistical power prior to collection | `statistical-power` |
| Determining experimental layouts, factor levels, and randomization | `experimental-design` |
| High-performance tabular data manipulation and lazy execution | `polars` |

Reach for it when:
- Estimating coefficients with standard errors, t-statistics, p-values, and confidence intervals.
- Specifying models using R-style formulas (`smf.ols("y ~ x1 + C(x2) + x1:x2", data=df)`).
- Applying heteroscedasticity-consistent standard errors (such as `cov_type='HC3'`) or cluster-robust standard errors.
- Fitting discrete outcome models and extracting average marginal effects via `get_margeff()`.
- Modeling stationary or non-stationary time series with SARIMAX or state space models.

## Common questions

**What is the difference between `statsmodels.api` and `statsmodels.formula.api`?**

`statsmodels.api` expects NumPy arrays or pandas DataFrames directly for the endogenous outcome (`endog`) and exogenous predictors (`exog`). In this API, users must explicitly add a constant column via `sm.add_constant(X)`. In contrast, `statsmodels.formula.api` accepts an R-style formula string and a pandas DataFrame, automatically adding an intercept and encoding categorical variables unless explicitly suppressed with `- 1`.

**When should I use HC3 standard errors over standard OLS standard errors?**

Standard OLS standard errors assume homoscedasticity: errors have constant variance across all levels of the predictors. When residuals exhibit heteroscedasticity, standard OLS standard errors are biased and yield invalid hypothesis tests. HC3 standard errors provide finite-sample robust variance estimates that resist both heteroscedasticity and high-leverage points without changing coefficient estimates.

**How do I interpret coefficients in logistic or Poisson regression?**

In logistic regression (`sm.Logit` or `GLM` with Binomial family), raw coefficients represent changes in the log-odds of the outcome per unit increase in the predictor. Exponentiating coefficients (`np.exp(params)`) yields odds ratios. In Poisson regression (`sm.GLM` with Poisson family), exponentiated coefficients represent incident rate ratios (multiplicative effects on the expected count). Alternatively, call `results.get_margeff().summary()` to report average marginal effects on the probability scale.

**How do I select between AIC and BIC for model comparison?**

Both criteria balance goodness-of-fit against model complexity. AIC penalizes each additional parameter by 2, favoring predictive accuracy, while BIC penalizes parameters by `ln(n)`, placing a heavier penalty on complexity in large samples. Lower values indicate better fit. When models are nested, likelihood ratio tests (`lr_test`) provide a formal statistical test of parameter restrictions.

## It's working if

- Regressors in array-based models explicitly include an intercept column via `sm.add_constant()`, while formula models specify categorical factors and interactions cleanly.
- Model assumptions are validated using post-estimation diagnostics (residual plots, Breusch-Pagan, VIF, or Durbin-Watson).
- Standard errors use appropriate robust covariance types (`cov_type='HC3'` or `cov_type='cluster'`) whenever heteroscedasticity or group clustering is present.
- Nonlinear models (logit, probit, Poisson) report marginal effects or exponentiated ratios rather than misinterpreting raw latent scale coefficients.
- Model comparisons state whether models are nested and compare information criteria (AIC/BIC) on identical datasets.
