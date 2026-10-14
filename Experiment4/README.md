# DBMS Experiment 4

## Aim

To write and execute SQL queries using the Employee schema to demonstrate INNER JOIN, LEFT JOIN, SELF JOIN, 3-WAY JOIN, correlated subqueries, EXISTS, simulated INTERSECT and EXCEPT operations, and compare query execution plans using EXPLAIN.

## Database

`DBMS_Experiment3`

## Tables Used

* Employee
* Department
* Project

## Queries Covered

1. INNER JOIN
2. LEFT JOIN
3. SELF JOIN
4. 3-WAY JOIN
5. Correlated Subquery
6. EXISTS
7. Simulated INTERSECT using EXISTS
8. Simulated EXCEPT using NOT EXISTS
9. EXPLAIN for INNER JOIN
10. EXPLAIN for LEFT JOIN
11. EXPLAIN for Correlated Subquery
12. EXPLAIN for 3-WAY JOIN
13. Comparison of execution plans for INNER JOIN and correlated subquery

## Files

* `Experiment4.sql` — Complete SQL script containing all queries.
* `Experiment4_Queries.sql` — Queries-only SQL script.

## Note

Query 7 may return an empty result with the current sample data because no project has a budget greater than 800000. This is expected and is not a syntax error.

## Execution

Run the SQL script in MySQL Workbench after selecting the `DBMS_Experiment3` database.
