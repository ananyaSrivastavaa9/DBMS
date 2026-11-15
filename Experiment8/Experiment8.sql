-- DBMS Experiment 8
-- Aim: Implement banking-style transactions using BEGIN, COMMIT,
-- ROLLBACK and SAVEPOINT, and demonstrate isolation levels
-- and concurrency anomalies using two database sessions.

CREATE DATABASE IF NOT EXISTS Experiment8;
USE Experiment8;

-- =========================================================
-- 1. CREATE BANKING TABLES
-- =========================================================

DROP TABLE IF EXISTS Transaction_Log;
DROP TABLE IF EXISTS Bank_Account;

CREATE TABLE Bank_Account (
    Account_ID INT PRIMARY KEY,
    Account_Holder VARCHAR(50),
    Balance DECIMAL(12,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Transaction_Log (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    From_Account INT,
    To_Account INT,
    Amount DECIMAL(12,2),
    Log_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

INSERT INTO Bank_Account VALUES
(101, 'Aarav Sharma', 50000),
(102, 'Riya Verma', 30000),
(103, 'Karan Mehta', 20000);

-- =========================================================
-- 2. COMMIT A SUCCESSFUL TRANSFER
-- =========================================================

START TRANSACTION;

UPDATE Bank_Account
SET Balance = Balance - 5000
WHERE Account_ID = 101;

UPDATE Bank_Account
SET Balance = Balance + 5000
WHERE Account_ID = 102;

INSERT INTO Transaction_Log (From_Account, To_Account, Amount)
VALUES (101, 102, 5000);

COMMIT;

-- =========================================================
-- 3. ROLLBACK A FAILED TRANSFER
-- =========================================================

START TRANSACTION;

UPDATE Bank_Account
SET Balance = Balance - 7000
WHERE Account_ID = 101;

-- Account 999 does not exist.
UPDATE Bank_Account
SET Balance = Balance + 7000
WHERE Account_ID = 999;

ROLLBACK;

-- =========================================================
-- 4. SAVEPOINT FOR PARTIAL FAILURE
-- =========================================================

START TRANSACTION;

UPDATE Bank_Account
SET Balance = Balance - 3000
WHERE Account_ID = 101;

SAVEPOINT after_debit;

UPDATE Bank_Account
SET Balance = Balance + 3000
WHERE Account_ID = 103;

SAVEPOINT after_credit;

UPDATE Bank_Account
SET Balance = Balance - 1000
WHERE Account_ID = 102;

ROLLBACK TO SAVEPOINT after_credit;

COMMIT;

-- =========================================================
-- 5. ISOLATION LEVELS
-- =========================================================

SELECT @@transaction_isolation AS Current_Isolation_Level;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT @@transaction_isolation AS Isolation_Level;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT @@transaction_isolation AS Isolation_Level;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT @@transaction_isolation AS Isolation_Level;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT @@transaction_isolation AS Isolation_Level;
