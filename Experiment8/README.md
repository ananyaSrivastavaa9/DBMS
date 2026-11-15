# DBMS Experiment 8

## Aim

To implement banking-style transactions using `BEGIN`, `COMMIT`, `ROLLBACK` and `SAVEPOINT`, simulate partial transaction failures, and demonstrate isolation levels and concurrency anomalies using two database sessions.

## Database

`Experiment8`

## Concepts Covered

1. **COMMIT** — Permanently saves a successful transaction.
2. **ROLLBACK** — Cancels changes made by an uncommitted transaction.
3. **SAVEPOINT** — Allows partial rollback within a transaction.
4. **Dirty Read** — Demonstrated using `READ UNCOMMITTED` with two sessions.
5. **Non-Repeatable Read** — Demonstrated using `READ COMMITTED`.
6. **Phantom Read** — Demonstrated using two sessions and a new matching row.
7. **Isolation Levels** — `READ UNCOMMITTED`, `READ COMMITTED`, `REPEATABLE READ` and `SERIALIZABLE`.

## Files

- `Experiment8.sql` — Banking tables, transaction operations and isolation-level checks.
- `Experiment8_Queries.sql` — Verification queries and two-session concurrency demonstrations.
- `README.md` — Experiment description and documentation.

## Transaction Operations

- Successful transfer using `START TRANSACTION` and `COMMIT`.
- Failed transfer followed by `ROLLBACK`.
- Partial rollback using `SAVEPOINT`.

## Important Note

The dirty read, non-repeatable read and phantom read demonstrations require **two MySQL sessions**. Follow the session comments in `Experiment8_Queries.sql` and keep the first session uncommitted where indicated.

For the dirty-read test, execute `ROLLBACK` in Session 1 after observing the uncommitted value in Session 2 so that the test change is not permanently stored.

## Execution Requirements

- MySQL database server with InnoDB support.
- MySQL Workbench or another MySQL client.
- Two database sessions for concurrency demonstrations.
