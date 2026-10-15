-- DBMS Experiment 6: Queries Only

USE DBMS_Experiment3;

-- Query 1: Test a valid employee transfer
-- CALL transfer_employee(1, 2);

-- Query 2: Verify employee department
SELECT Emp_ID, Emp_Name, Dept_ID
FROM Employee
WHERE Emp_ID = 1;

-- Query 3: Test a valid salary update
-- UPDATE Employee SET Salary = 50000 WHERE Emp_ID = 1;

-- Query 4: View salary audit records
SELECT * FROM Employee_Audit;

-- Query 5: Test invalid employee ID
-- Expected error: Employee does not exist
-- CALL transfer_employee(999, 2);

-- Query 6: Test invalid department ID
-- Expected error: Department does not exist
-- CALL transfer_employee(1, 999);

-- Query 7: Test invalid salary during update
-- Expected error: Salary must be greater than zero
-- UPDATE Employee SET Salary = -5000 WHERE Emp_ID = 1;

-- Query 8: Test invalid salary during insert
-- Expected error: Salary must be greater than zero
-- INSERT INTO Employee
-- (Emp_ID, Emp_Name, Salary, Job_Role, Dept_ID, Project_ID)
-- VALUES (999, 'Test Employee', -5000, 'Tester', 1, 107);
