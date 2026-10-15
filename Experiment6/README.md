# DBMS Experiment 6

## Aim

To create a stored procedure `transfer_employee(emp_id, new_dept_id)` with validation and error handling, implement triggers for salary validation and audit logging, and test edge cases.

## Database

`DBMS_Experiment3`

## Concepts Covered

1. **Stored Procedure** — Transfers an employee to another department after validating the employee ID and department ID.
2. **Salary Validation Trigger (INSERT)** — Prevents inserting employees with a salary less than or equal to zero.
3. **Salary Validation Trigger (UPDATE)** — Prevents updating an employee's salary to a value less than or equal to zero.
4. **Salary Audit Trigger** — Records the old salary, new salary, employee ID, and action time whenever an employee's salary changes.
5. **Error Handling** — Uses `SIGNAL SQLSTATE '45000'` to report invalid employee IDs, invalid department IDs, and invalid salaries.

## Files

* `Experiment6.sql` — Complete SQL script containing the procedure, triggers, and test queries.
* `Experiment6_Queries.sql` — Queries for testing employee transfers, salary updates, audit records, and invalid inputs.
* `README.md` — Experiment description and documentation.

## Edge Cases

* Employee ID does not exist.
* Department ID does not exist.
* Salary is zero or negative.
* Salary update creates an audit record.

## Important Note

The test queries that modify database records are included as comments in the queries file to avoid accidental changes. Uncomment and execute them in MySQL Workbench only when you want to perform the corresponding test.

## Execution Requirements

* MySQL database with the `Department` and `Employee` tables already created.
* The `Employee_Audit` table is created by the SQL script if it does not exist.
* Execute the main SQL script before testing the stored procedure and triggers.
