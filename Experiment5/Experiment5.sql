-- DBMS Experiment 5
-- Aim: To create SQL views for department salary summary and employee hierarchy,
-- test the updatability of views, and implement a recursive CTE to display reporting chains.

USE DBMS_Experiment3;

-- 1. Department Salary Summary View
CREATE OR REPLACE VIEW Department_Salary_Summary AS
SELECT
d.Dept_ID,
d.Dept_Name,
COUNT(e.Emp_ID) AS Employee_Count,
AVG(e.Salary) AS Average_Salary,
SUM(e.Salary) AS Total_Salary,
MAX(e.Salary) AS Highest_Salary,
MIN(e.Salary) AS Lowest_Salary
FROM Department d
LEFT JOIN Employee e ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_ID, d.Dept_Name;

SELECT * FROM Department_Salary_Summary;

-- 2. Employee Hierarchy View
CREATE OR REPLACE VIEW Employee_Hierarchy AS
SELECT
e.Emp_ID,
e.Emp_Name,
e.Job_Role,
e.Dept_ID,
e.Manager_ID,
m.Emp_Name AS Manager_Name
FROM Employee e
LEFT JOIN Employee m ON e.Manager_ID = m.Emp_ID;

SELECT * FROM Employee_Hierarchy;

-- 3. Employee Basic View and Updatability Test
CREATE OR REPLACE VIEW Employee_Basic_View AS
SELECT
Emp_ID,
Emp_Name,
Salary,
Dept_ID
FROM Employee;

-- Increase salary by 1000 for employee with Emp_ID = 1
-- Execute this UPDATE only once to avoid repeated salary increases.
UPDATE Employee_Basic_View
SET Salary = Salary + 1000
WHERE Emp_ID = 1;

SELECT * FROM Employee_Basic_View
WHERE Emp_ID = 1;

-- 4. Recursive CTE: Reporting Chain
WITH RECURSIVE Reporting_Chain AS (
SELECT
Emp_ID,
Emp_Name,
Manager_ID,
0 AS Level
FROM Employee
WHERE Manager_ID IS NULL

```
UNION ALL

SELECT
    e.Emp_ID,
    e.Emp_Name,
    e.Manager_ID,
    rc.Level + 1
FROM Employee e
INNER JOIN Reporting_Chain rc
    ON e.Manager_ID = rc.Emp_ID
```

)
SELECT
Emp_ID,
Emp_Name,
Manager_ID,
Level
FROM Reporting_Chain
ORDER BY Level, Emp_ID;
don