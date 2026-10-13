## What it does

`experimental-design` structures comparative studies and experiments before data collection begins. It operationalizes Fisher's core principles of design: randomization (to balance known and unknown confounders), replication (at the true unit of experimental independence to prevent pseudoreplication), and blocking (to isolate known nuisance variation such as day, batch, plate, or operator).

The skill provides reproducible generation scripts for treatment allocation schedules (simple, permuted block, stratified block, cluster) and design of experiments (DOE) matrices (full factorial, fractional factorial with alias resolution analysis, Plackett-Burman screening, central composite, and Box-Behnken response-surface optimization). It also establishes rules for controls, blinding, plate layout, split-plot structures, and group-sequential monitoring.

## When to reach for it

Reach for `experimental-design` whenever an experiment or trial is being planned, before allocating subjects or generating samples.

| Your situation | Where to go |
| --- | --- |
| Designing experimental layouts, randomization schedules, or DOE matrices | `experimental-design` |
| Calculating sample sizes, statistical power, or minimum detectable effects | `statistical-power` |
| Analyzing collected data, conducting hypothesis tests, and APA reporting | `statistical-analysis` |
| Specifying linear models, GLMs, or mixed-effects models | `statsmodels` |
| Formulating Bayesian generative models and fitting posteriors | `pymc` |

Reach for it when:
- Deciding how to assign subjects, animals, or lab specimens to experimental conditions.
- Removing nuisance batch or operator variation through blocking or Latin squares.
- Planning screening experiments across many candidate factors using fractional factorial or Plackett-Burman designs.
- Setting up response-surface optimization (CCD or Box-Behnken) for continuous factors.
- Avoiding structural errors such as pseudoreplication, broken allocation, or omitted sham controls.

## Common questions

**What is pseudoreplication and how do I avoid it?**

Pseudoreplication occurs when dependent, repeated measurements on the same experimental unit are treated as independent replicates in statistical testing. For example, testing three mice per group and taking 100 cell measurements per mouse yields an independent sample size of n = 3, not n = 300. The true replicate is the smallest unit to which the treatment was independently randomized. To avoid pseudoreplication, either aggregate measurements to the unit level before testing or fit a hierarchical mixed-effects model specifying random intercepts for each experimental unit.

**Why is factorial design superior to one-factor-at-a-time (OFAT) experimentation?**

OFAT varies one variable while fixing all others, which fails to detect interactions between factors and requires substantially more experimental runs. In contrast, factorial designs vary factors simultaneously. Every observation contributes to estimating every main effect, and interactions between factors are directly estimable.

**What is aliasing in fractional factorial designs and why does resolution matter?**

Fractional factorials run a fraction of a full design to conserve resources, which causes certain effects to become mathematically indistinguishable (aliased or confounded). The design's resolution determines the severity of aliasing:
- Resolution III: Main effects are aliased with two-factor interactions (suitable only for coarse screening).
- Resolution IV: Main effects are clear of two-factor interactions, but two-factor interactions are aliased with each other.
- Resolution V: Both main effects and two-factor interactions are unconfounded with each other.

**When should I use block randomization instead of simple randomization?**

Simple randomization (unrestricted coin-flipping) works well for large sample sizes, but with small samples it often causes severe group size imbalances or imbalances across prognostic subgroups. Block randomization enforces balance at every complete block boundary, ensuring equal allocation throughout ongoing recruitment.

## It's working if

- The independent experimental unit is defined as the physical entity independently receiving treatment assignment, distinguishing biological units from technical measurements.
- Known nuisance variables (batch, instrument, litter, plate location) are partitioned into blocks rather than confounded with treatment conditions.
- Randomization schedules use fixed seeds and are exported as reproducible, auditable allocation tables.
- Fractional factorial designs document their generator strings, resolution, and alias structures before running experiments.
- Analysis plans explicitly match the study structure, including blocking factors, nesting levels, and repeated measures.
