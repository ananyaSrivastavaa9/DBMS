# DBMS Experiment 5

## Aim

To create SQL views for department salary summary and employee hierarchy, test the updatability of views, and implement a recursive CTE to display reporting chains.

## Database

`DBMS_Experiment3`

## Tables Used

* `Department`
* `Employee`
* `Project` (used by the existing database schema)

## Concepts Covered

1. **Department Salary Summary View** — Displays employee count, average salary, total salary, highest salary, and lowest salary for each department.
2. **Employee Hierarchy View** — Displays employee details along with their manager's name.
3. **View Updatability** — Tests updating an employee's salary through a simple view.
4. **Recursive CTE** — Displays employee reporting chains and hierarchy levels.

## Files

* `Experiment5.sql` — Complete SQL script for the experiment.
* `Experiment5_Queries.sql` — Queries-only SQL script.
* `README.md` — Experiment description and documentation.

## Important Note

The salary update query increases the salary of employee ID 1 by 1000. Execute it only once if you need to demonstrate the update.

## Execution

The scripts are written for MySQL and use the existing `DBMS_Experiment3` database. The required `Department` and `Employee` tables must already exist.
