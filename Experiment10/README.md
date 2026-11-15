# DBMS Experiment 10

## Aim

To generate a dataset containing at least 10,000 rows, identify five slow SQL queries using `EXPLAIN` and `EXPLAIN ANALYZE`, optimize them using indexing and query rewriting, and compare execution performance before and after optimization.

## Database

`Experiment10`

## Concepts Covered

1. **Large Dataset Generation** — Creating 10,000 Customer Order records using a recursive CTE.
2. **EXPLAIN ANALYZE** — Examining query execution behavior.
3. **Single Indexing** — Optimizing a city filter using `idx_city`.
4. **Composite Indexing** — Optimizing customer and date filtering using `idx_customer_date`.
5. **Query Rewriting** — Replacing `YEAR(Order_Date) = 2026` with a date range condition.
6. **Composite Indexing** — Optimizing category and status filtering using `idx_category_status`.
7. **Aggregation Optimization** — Creating `idx_city_total` for the city and total-amount aggregation query.
8. **Before/After Comparison** — Comparing execution plans and performance observations.

## Files

- `Experiment10.sql` — Complete dataset generation, slow-query analysis, optimization and verification script.
- `Experiment10_Queries.sql` — Queries for testing the five slow queries and their optimized versions.
- `README.md` — Experiment description and documentation.

## Dataset

The script generates **10,000 records** in `Customer_Order`.

## Slow Queries and Optimizations

| Query | Problem | Optimization |
|---|---|---|
| City Filter | No index on `City` | `idx_city` |
| Customer + Date | No composite index | `idx_customer_date` |
| YEAR(Order_Date) | Function applied to date column | Date-range query rewrite |
| Category + Status | No composite index | `idx_category_status` |
| City Aggregation | No index for city/amount access | `idx_city_total` |

## Important Note

The actual performance values should be taken from the `EXPLAIN ANALYZE` output in MySQL Workbench. The experiment compares the execution behavior before and after each optimization rather than hard-coding timing values.

## Execution Requirements

- MySQL 8.x with recursive CTE and `EXPLAIN ANALYZE` support.
- MySQL Workbench or another MySQL client.
- Execute the dataset-generation section before running the optimization queries.
