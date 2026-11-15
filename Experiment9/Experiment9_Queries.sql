-- DBMS Experiment 9: Queries Only
USE Experiment9;

-- Query 1 - Verify record count
SELECT COUNT(*) AS Total_Bookings
FROM Railway_Booking;

-- Query 2 - Verify generated data
SELECT *
FROM Railway_Booking
LIMIT 10;

-- Query 3 - Benchmark before indexing
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE Train_No = 12003;

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE Train_No = 12003;

-- Query 4 - Verify single index
SHOW INDEX FROM Railway_Booking;

EXPLAIN
SELECT *
FROM Railway_Booking
WHERE Train_No = 12003;

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE Train_No = 12003;

-- Query 5 - Verify composite index
EXPLAIN
SELECT *
FROM Railway_Booking
WHERE Train_No = 12003
  AND Journey_Date BETWEEN '2026-11-05' AND '2026-11-15';

EXPLAIN ANALYZE
SELECT *
FROM Railway_Booking
WHERE Train_No = 12003
  AND Journey_Date BETWEEN '2026-11-05' AND '2026-11-15';

-- Query 6 - Compare query plans
EXPLAIN
SELECT Booking_ID, Passenger_Name, Journey_Date
FROM Railway_Booking
WHERE Train_No = 12003;

EXPLAIN
SELECT Booking_ID, Passenger_Name, Journey_Date
FROM Railway_Booking
WHERE Train_No = 12003
  AND Journey_Date BETWEEN '2026-11-05' AND '2026-11-15';

-- Query 7 - Performance comparison
SELECT
    'BEFORE INDEX' AS Stage,
    'Use the EXPLAIN ANALYZE result recorded above' AS Observation
UNION ALL
SELECT
    'SINGLE INDEX',
    'Compare actual time and rows after idx_train_no'
UNION ALL
SELECT
    'COMPOSITE INDEX',
    'Compare actual time and rows after idx_train_date';
