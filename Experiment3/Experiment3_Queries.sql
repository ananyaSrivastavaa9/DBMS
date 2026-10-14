-- DBMS EXPERIMENT 3: QUERIES
USE DBMS_Experiment3;

-- Query 1: Display all employees
SELECT * FROM Employee;

-- Query 2: Employees with salary greater than 80000
SELECT * FROM Employee
WHERE Salary > 80000;

-- Query 3: Employees belonging to department 2
SELECT * FROM Employee
WHERE Dept_ID = 2;

-- Query 4: Count total employees
SELECT COUNT(*) AS Total_Employees
FROM Employee;

-- Query 5: Calculate average salary
SELECT AVG(Salary) AS Average_Salary
FROM Employee;

-- Query 6: Find highest salary
SELECT MAX(Salary) AS Highest_Salary
FROM Employee;

-- Query 7: Find lowest salary
SELECT MIN(Salary) AS Lowest_Salary
FROM Employee;

-- Query 8: Calculate total salary
SELECT SUM(Salary) AS Total_Salary
FROM Employee;

-- Query 9: Count employees in each department
SELECT Dept_ID, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Dept_ID;

-- Query 10: Average salary in each department
SELECT Dept_ID, AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY Dept_ID;

-- Query 11: Departments with more than 5 employees
SELECT Dept_ID, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Dept_ID
HAVING COUNT(*) > 5;

-- Query 12: Categorize employees by salary
SELECT Emp_Name, Salary,
CASE
    WHEN Salary >= 100000 THEN 'High Salary'
    WHEN Salary >= 80000 THEN 'Medium Salary'
    ELSE 'Low Salary'
END AS Salary_Category
FROM Employee;

-- Query 13: Sort employees by salary ascending
SELECT * FROM Employee
ORDER BY Salary ASC;

-- Query 14: Sort employees by salary descending
SELECT * FROM Employee
ORDER BY Salary DESC;

-- Query 15: Department-wise employee details
SELECT Employee.Emp_Name, Employee.Salary,
Department.Dept_Name, Department.Location
FROM Employee
JOIN Department
ON Employee.Dept_ID = Department.Dept_ID;

-- Query 16: Project-wise employee count
SELECT Project.Project_Name,
COUNT(Employee.Emp_ID) AS Total_Employees
FROM Project
LEFT JOIN Employee
ON Project.Project_ID = Employee.Project_ID
GROUP BY Project.Project_ID, Project.Project_Name;
