-- DBMS Experiment 6
-- Aim: Stored procedure for employee transfer, salary validation triggers,
-- audit logging, and testing edge cases.

USE DBMS_Experiment3;

-- 1. Create Employee_Audit table if it does not exist
CREATE TABLE IF NOT EXISTS Employee_Audit (
Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
Emp_ID INT,
Old_Salary DECIMAL(10,2),
New_Salary DECIMAL(10,2),
Action_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Stored Procedure: Transfer Employee
DROP PROCEDURE IF EXISTS transfer_employee;

DELIMITER //

CREATE PROCEDURE transfer_employee(
IN p_emp_id INT,
IN p_new_dept_id INT
)
BEGIN
DECLARE v_emp_count INT DEFAULT 0;
DECLARE v_dept_count INT DEFAULT 0;

```
SELECT COUNT(*) INTO v_emp_count
FROM Employee
WHERE Emp_ID = p_emp_id;

IF v_emp_count = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Employee does not exist';
END IF;

SELECT COUNT(*) INTO v_dept_count
FROM Department
WHERE Dept_ID = p_new_dept_id;

IF v_dept_count = 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Department does not exist';
END IF;

UPDATE Employee
SET Dept_ID = p_new_dept_id
WHERE Emp_ID = p_emp_id;
```

END //

-- 3. Trigger: Validate Salary Before Insert
DROP TRIGGER IF EXISTS validate_salary_before_insert//

CREATE TRIGGER validate_salary_before_insert
BEFORE INSERT ON Employee
FOR EACH ROW
BEGIN
IF NEW.Salary <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Salary must be greater than zero';
END IF;
END //

-- 4. Trigger: Validate Salary Before Update
DROP TRIGGER IF EXISTS validate_salary_before_update//

CREATE TRIGGER validate_salary_before_update
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
IF NEW.Salary <= 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Salary must be greater than zero';
END IF;
END //

-- 5. Trigger: Audit Salary Changes
DROP TRIGGER IF EXISTS salary_audit_after_update//

CREATE TRIGGER salary_audit_after_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
IF OLD.Salary <> NEW.Salary THEN
INSERT INTO Employee_Audit
(Emp_ID, Old_Salary, New_Salary)
VALUES
(OLD.Emp_ID, OLD.Salary, NEW.Salary);
END IF;
END //

DELIMITER ;

-- 6. Test: Valid Employee Transfer
CALL transfer_employee(1, 2);

SELECT Emp_ID, Emp_Name, Dept_ID
FROM Employee
WHERE Emp_ID = 1;

-- 7. Test: Valid Salary Update
-- This changes the salary to 50000 and creates an audit entry
UPDATE Employee
SET Salary = 50000
WHERE Emp_ID = 1;

SELECT * FROM Employee_Audit;

-- 8. Edge Case: Invalid Employee ID
-- Expected error: Employee does not exist
-- CALL transfer_employee(999, 2);

-- 9. Edge Case: Invalid Department ID
-- Expected error: Department does not exist
-- CALL transfer_employee(1, 999);

-- 10. Edge Case: Invalid Salary
-- Expected error: Salary must be greater than zero
-- UPDATE Employee SET Salary = -5000 WHERE Emp_ID = 1;
