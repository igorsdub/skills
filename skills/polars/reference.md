## What it does

`polars` provides reference patterns and best practices for high-performance DataFrame operations in Python using the Polars library. It covers expression-based transformations, lazy query optimization via `LazyFrame`, streaming execution for out-of-core datasets, Arrow memory interoperability, and migration patterns from pandas.

The skill emphasizes idiomatic Polars: using expressions inside execution contexts (`select`, `with_columns`, `filter`, `group_by`) rather than row iterations or custom Python loops. It outlines how the query optimizer pushes predicates and projections down to the scan layer, how window functions operate across groups without altering row shapes, and how to write memory-efficient ETL pipelines.

## When to reach for it

Reach for `polars` when processing tabular data where execution speed, memory efficiency, or query expressiveness matter.

| Your situation | Where to go |
| --- | --- |
| High-throughput tabular ETL, large CSV/Parquet processing, or out-of-core pipelines | `polars` |
| Migrating legacy pandas pipelines to Polars expression syntax | `polars` |
| Statistical hypothesis testing, ANOVA, or linear model estimation | `statistical-analysis` or `statsmodels` |
| Bayesian inference or probabilistic programming | `pymc` |
| Designing experimental layouts or determining sample size before data collection | `experimental-design` or `statistical-power` |

Reach for it when:
- Reading large CSV, Parquet, JSON, or database sources that strain system memory.
- Writing complex data pipelines requiring chained aggregations, window operations, or joins.
- Moving away from pandas performance bottlenecks or index-based idioms.
- Setting up lazy query plans to push filters down before loading data into RAM.

## Common questions

**Why should I prefer LazyFrame over eager DataFrame?**

A `LazyFrame` delays execution until `collect()` is called, allowing the Polars query optimizer to inspect the entire execution graph. The optimizer pushes filters and column selections directly into the file reader, merges projection operations, and executes non-dependent branches in parallel. Eager execution reads entire tables into memory immediately, bypassing these optimizations.

**How does `with_columns` handle dependencies between new columns?**

All expressions in a single `with_columns` call are evaluated in parallel against the input schema of that step. If a new column depends on another column created in the same step, chain multiple `with_columns` calls sequentially.

**How does Polars handle missing data compared to pandas?**

Polars separates missing values (`null`) from floating-point non-finite values (`NaN`). Functions such as `fill_null()` only target null values and leave `NaN` intact. To handle non-finite numbers, use explicit conditions with `is_nan()`. Furthermore, Polars does not have an index: row access relies strictly on integer indexing or explicit key columns.

**When should I use streaming mode?**

Use `collect(engine="streaming")` or `sink_parquet()` when working with datasets that exceed available RAM. Streaming processes data in batches, though operations requiring global state (such as full-table sorts or complex pivots) may still require significant memory.

## It's working if

- Operations rely on expressions (`pl.col(...)`) and execution contexts instead of custom Python functions or row-wise iteration.
- Queries against large datasets build a `LazyFrame` via `scan_*` methods and trigger execution via `collect()` or `sink_*`.
- Filter conditions and column projections are placed early in the query graph so the query optimizer can push them down.
- New columns that depend on newly computed values are split into separate chained `with_columns` steps.
- Joins include explicit keys and validate relationship cardinalities where appropriate.
