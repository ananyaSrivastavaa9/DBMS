-- DBMS Experiment 8: Queries Only
USE Experiment8;

-- Query 1 - Verify initial/current balances
SELECT * FROM Bank_Account ORDER BY Account_ID;

-- Query 2 - Verify transaction log
SELECT * FROM Transaction_Log ORDER BY Log_ID;

-- Query 3 - Verify balances after COMMIT, ROLLBACK and SAVEPOINT operations
SELECT * FROM Bank_Account ORDER BY Account_ID;

-- =========================================================
-- TWO-SESSION CONCURRENCY TESTS
-- =========================================================

-- SESSION 1 - DIRTY READ SETUP
-- Run this in Session 1 and do NOT COMMIT immediately.
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

UPDATE Bank_Account
SET Balance = Balance + 10000
WHERE Account_ID = 101;

SELECT Account_ID, Balance
FROM Bank_Account
WHERE Account_ID = 101;

-- =========================================================
-- SESSION 2 - DIRTY READ
-- =========================================================
-- Run while Session 1 is still uncommitted.

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;

SELECT Account_ID, Balance
FROM Bank_Account
WHERE Account_ID = 101;

COMMIT;

-- Return to Session 1 and execute:
-- ROLLBACK;

-- =========================================================
-- NON-REPEATABLE READ
-- =========================================================

-- SESSION 1
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

SELECT Balance
FROM Bank_Account
WHERE Account_ID = 102;

-- Pause here and execute the next block in Session 2.

-- SESSION 2
-- SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- START TRANSACTION;
-- UPDATE Bank_Account
-- SET Balance = Balance + 2000
-- WHERE Account_ID = 102;
-- COMMIT;

-- Return to Session 1:
-- SELECT Balance FROM Bank_Account WHERE Account_ID = 102;
-- COMMIT;

-- =========================================================
-- PHANTOM READ
-- =========================================================

-- SESSION 1
-- SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- START TRANSACTION;
-- SELECT COUNT(*) AS Accounts_Above_40000
-- FROM Bank_Account
-- WHERE Balance > 40000;

-- SESSION 2 while Session 1 is open:
-- INSERT INTO Bank_Account
-- VALUES (104, 'Neha Gupta', 60000);
-- COMMIT;

-- SESSION 1 again:
-- SELECT COUNT(*) AS Accounts_Above_40000
-- FROM Bank_Account
-- WHERE Balance > 40000;
-- COMMIT;

-- =========================================================
-- ISOLATION LEVEL COMPARISON
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
