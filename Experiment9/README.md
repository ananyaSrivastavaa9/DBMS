# DBMS Experiment 9

## Aim

To create a Railway Booking table containing at least 5,000 records, benchmark query performance before and after creating single and composite indexes, and compare the execution plans using `EXPLAIN`.

## Database

`Experiment9`

## Concepts Covered

1. **Large Dataset Generation** — Creating 5,000 Railway Booking records using a recursive CTE.
2. **EXPLAIN** — Inspecting the query execution plan.
3. **EXPLAIN ANALYZE** — Comparing actual execution behavior and row processing.
4. **Single Index** — Creating `idx_train_no` on `Train_No`.
5. **Composite Index** — Creating `idx_train_date` on `(Train_No, Journey_Date)`.
6. **Index Comparison** — Comparing query plans for train-only and train-plus-date filters.

## Files

- `Experiment9.sql` — Complete dataset generation, benchmarking and indexing script.
- `Experiment9_Queries.sql` — Queries for verifying the dataset, execution plans and index usage.
- `README.md` — Experiment description and documentation.

## Dataset

The script generates **5,000 records** in `Railway_Booking`.

## Indexes

- `idx_train_no` — Single index on `Train_No`.
- `idx_train_date` — Composite index on `Train_No, Journey_Date`.

## Important Note

`EXPLAIN ANALYZE` requires a MySQL version that supports it. The actual execution time and rows processed should be taken from the result returned by MySQL Workbench.

## Execution Requirements

- MySQL 8.x with recursive CTE and `EXPLAIN ANALYZE` support.
- MySQL Workbench or another MySQL client.
- Execute the dataset-generation section before benchmarking the queries.
