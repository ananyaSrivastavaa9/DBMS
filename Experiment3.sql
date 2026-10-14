-- DBMS EXPERIMENT 3
-- Database: DBMS_Experiment3

CREATE DATABASE IF NOT EXISTS DBMS_Experiment3;
USE DBMS_Experiment3;

-- TABLE 1: Department
CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Location VARCHAR(50)
);

-- TABLE 2: Project
CREATE TABLE Project (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100),
    Budget DECIMAL(12,2)
);

-- TABLE 3: Employee
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Job_Role VARCHAR(50),
    Dept_ID INT,
    Project_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
);

-- INSERT DATA INTO DEPARTMENT
INSERT IGNORE INTO Department (Dept_ID, Dept_Name, Location) VALUES
(1, 'Computer Science', 'Lucknow'),
(2, 'Artificial Intelligence', 'Noida'),
(3, 'Cyber Security', 'Delhi'),
(4, 'Data Science', 'Mumbai'),
(5, 'Information Technology', 'Pune');

-- INSERT DATA INTO PROJECT
INSERT IGNORE INTO Project (Project_ID, Project_Name, Budget) VALUES
(101, 'Smart Campus', 500000),
(102, 'AI Chatbot', 300000),
(103, 'Network Security', 450000),
(104, 'Data Analytics', 250000),
(105, 'Cloud Computing', 600000),
(106, 'Web Development', 200000),
(107, 'Machine Learning', 550000),
(108, 'Database Management', 150000);

-- INSERT DATA INTO EMPLOYEE
INSERT IGNORE INTO Employee
(Emp_ID, Emp_Name, Salary, Job_Role, Dept_ID, Project_ID)
VALUES
(1, 'Aarav Sharma', 85000, 'Developer', 1, 101),
(2, 'Priya Singh', 92000, 'Data Analyst', 2, 104),
(3, 'Rahul Verma', 75000, 'Tester', 3, 103),
(4, 'Ananya Gupta', 105000, 'AI Engineer', 2, 107),
(5, 'Rohan Kumar', 65000, 'Developer', 1, 106),
(6, 'Sneha Mishra', 88000, 'Security Analyst', 3, 103),
(7, 'Aditya Jain', 95000, 'Data Scientist', 4, 104),
(8, 'Neha Agarwal', 72000, 'Web Developer', 5, 106),
(9, 'Karan Malhotra', 110000, 'AI Engineer', 2, 102),
(10, 'Pooja Yadav', 68000, 'Database Admin', 5, 108),
(11, 'Arjun Mehta', 82000, 'Developer', 1, 101),
(12, 'Ishita Roy', 98000, 'Data Scientist', 4, 107),
(13, 'Vivek Tiwari', 78000, 'Tester', 3, 103),
(14, 'Kavya Sinha', 115000, 'AI Engineer', 2, 102),
(15, 'Mohit Saxena', 70000, 'Web Developer', 5, 106),
(16, 'Riya Kapoor', 89000, 'Data Analyst', 4, 104),
(17, 'Siddharth Rao', 125000, 'Project Lead', 1, 101),
(18, 'Simran Kaur', 76000, 'Security Analyst', 3, 103),
(19, 'Yash Patel', 93000, 'AI Engineer', 2, 107),
(20, 'Meera Joshi', 67000, 'Database Admin', 5, 108),
(21, 'Dev Khanna', 86000, 'Developer', 1, 106),
(22, 'Tanya Bose', 102000, 'Data Scientist', 4, 104),
(23, 'Manish Pandey', 74000, 'Tester', 3, 103),
(24, 'Aditi Das', 99000, 'AI Engineer', 2, 102),
(25, 'Varun Bhatia', 81000, 'Developer', 1, 101),
(26, 'Nisha Reddy', 87000, 'Data Analyst', 4, 104),
(27, 'Akash Dubey', 69000, 'Web Developer', 5, 106),
(28, 'Sakshi Arora', 108000, 'AI Engineer', 2, 107),
(29, 'Harsh Goel', 91000, 'Security Analyst', 3, 103),
(30, 'Diya Chawla', 79000, 'Database Admin', 5, 108);

-- QUERY 1: Display all employees
SELECT * FROM Employee;

-- QUERY 2: Employees with salary greater than 80000
SELECT * FROM Employee
WHERE Salary > 80000;

-- QUERY 3: Employees belonging to department 2
SELECT * FROM Employee
WHERE Dept_ID = 2;

-- QUERY 4: Count total employees
SELECT COUNT(*) AS Total_Employees
FROM Employee;

-- QUERY 5: Calculate average salary
SELECT AVG(Salary) AS Average_Salary
FROM Employee;

-- QUERY 6: Find highest salary
SELECT MAX(Salary) AS Highest_Salary
FROM Employee;

-- QUERY 7: Find lowest salary
SELECT MIN(Salary) AS Lowest_Salary
FROM Employee;

-- QUERY 8: Calculate total salary
SELECT SUM(Salary) AS Total_Salary
FROM Employee;

-- QUERY 9: Count employees in each department
SELECT Dept_ID, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Dept_ID;

-- QUERY 10: Average salary in each department
SELECT Dept_ID, AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY Dept_ID;

-- QUERY 11: Departments with more than 5 employees
SELECT Dept_ID, COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Dept_ID
HAVING COUNT(*) > 5;

-- QUERY 12: Categorize employees by salary
SELECT Emp_Name, Salary,
CASE
    WHEN Salary >= 100000 THEN 'High Salary'
    WHEN Salary >= 80000 THEN 'Medium Salary'
    ELSE 'Low Salary'
END AS Salary_Category
FROM Employee;

-- QUERY 13: Sort employees by salary ascending
SELECT * FROM Employee
ORDER BY Salary ASC;

-- QUERY 14: Sort employees by salary descending
SELECT * FROM Employee
ORDER BY Salary DESC;

-- QUERY 15: Department-wise employee details
SELECT Employee.Emp_Name, Employee.Salary,
Department.Dept_Name, Department.Location
FROM Employee
JOIN Department
ON Employee.Dept_ID = Department.Dept_ID;

-- QUERY 16: Project-wise employee count
SELECT Project.Project_Name,
COUNT(Employee.Emp_ID) AS Total_Employees
FROM Project
LEFT JOIN Employee
ON Project.Project_ID = Employee.Project_ID
GROUP BY Project.Project_ID, Project.Project_Name;