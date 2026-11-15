-- DBMS Experiment 10
-- Aim: Generate at least 10,000 rows, identify five slow SQL queries
-- using EXPLAIN/EXPLAIN ANALYZE, optimize them using indexing
-- and query rewriting, and compare performance.

CREATE DATABASE IF NOT EXISTS Experiment10;
USE Experiment10;

-- =========================================================
-- 1. CREATE DATASET
-- =========================================================

DROP TABLE IF EXISTS Customer_Order;

CREATE TABLE Customer_Order (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Customer_Name VARCHAR(60),
    City VARCHAR(50),
    Product_Category VARCHAR(40),
    Product_Name VARCHAR(80),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Order_Date DATE,
    Payment_Mode VARCHAR(20),
    Order_Status VARCHAR(20),
    Total_Amount DECIMAL(12,2)
) ENGINE=InnoDB;

SET SESSION cte_max_recursion_depth = 11000;

INSERT INTO Customer_Order (
    Order_ID, Customer_ID, Customer_Name, City,
    Product_Category, Product_Name, Quantity, Unit_Price,
    Order_Date, Payment_Mode, Order_Status, Total_Amount
)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 10000
)
SELECT
    n,
    1000 + MOD(n,1000),
    CONCAT('Customer_', 1000 + MOD(n,1000)),
    CASE MOD(n,5)
        WHEN 0 THEN 'Delhi'
        WHEN 1 THEN 'Lucknow'
        WHEN 2 THEN 'Kanpur'
        WHEN 3 THEN 'Noida'
        ELSE 'Jaipur'
    END,
    CASE MOD(n,4)
        WHEN 0 THEN 'Electronics'
        WHEN 1 THEN 'Grocery'
        WHEN 2 THEN 'Clothing'
        ELSE 'Books'
    END,
    CONCAT('Product_', MOD(n,100)),
    1 + MOD(n,5),
    200 + MOD(n,50) * 25,
    DATE_ADD('2026-01-01', INTERVAL MOD(n,300) DAY),
    CASE MOD(n,3)
        WHEN 0 THEN 'UPI'
        WHEN 1 THEN 'CARD'
        ELSE 'CASH'
    END,
    CASE MOD(n,4)
        WHEN 0 THEN 'DELIVERED'
        WHEN 1 THEN 'PENDING'
        WHEN 2 THEN 'SHIPPED'
        ELSE 'CANCELLED'
    END,
    (1 + MOD(n,5)) * (200 + MOD(n,50) * 25)
FROM seq;

-- =========================================================
-- 2. VERIFY DATASET
-- =========================================================

SELECT
    COUNT(*) AS Total_Rows,
    MIN(Order_Date) AS First_Order,
    MAX(Order_Date) AS Last_Order
FROM Customer_Order;

-- =========================================================
-- 3. SLOW QUERY 1 - CITY FILTER
-- =========================================================

EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE City = 'Lucknow';

-- Optimize Query 1
CREATE INDEX idx_city
ON Customer_Order(City);

EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE City = 'Lucknow';

-- =========================================================
-- 4. SLOW QUERY 2 - CUSTOMER AND DATE FILTER
-- =========================================================

EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE Customer_ID = 1250
  AND Order_Date BETWEEN '2026-02-01' AND '2026-06-30';

-- Optimize Query 2
CREATE INDEX idx_customer_date
ON Customer_Order(Customer_ID, Order_Date);

EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE Customer_ID = 1250
  AND Order_Date BETWEEN '2026-02-01' AND '2026-06-30';

-- =========================================================
-- 5. SLOW QUERY 3 - FUNCTION ON DATE COLUMN
-- =========================================================

EXPLAIN ANALYZE
SELECT COUNT(*) AS Total_Orders
FROM Customer_Order
WHERE YEAR(Order_Date) = 2026;

-- Optimize Query 3 by query rewriting
EXPLAIN ANALYZE
SELECT COUNT(*) AS Total_Orders
FROM Customer_Order
WHERE Order_Date >= '2026-01-01'
  AND Order_Date < '2027-01-01';

-- =========================================================
-- 6. SLOW QUERY 4 - CATEGORY AND STATUS FILTER
-- =========================================================

EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE Product_Category = 'Electronics'
  AND Order_Status = 'DELIVERED';

-- Optimize Query 4
CREATE INDEX idx_category_status
ON Customer_Order(Product_Category, Order_Status);

EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE Product_Category = 'Electronics'
  AND Order_Status = 'DELIVERED';

-- =========================================================
-- 7. SLOW QUERY 5 - AGGREGATION WITH CITY
-- =========================================================

EXPLAIN ANALYZE
SELECT
    City,
    SUM(Total_Amount) AS Total_Sales
FROM Customer_Order
GROUP BY City
ORDER BY Total_Sales DESC;

-- Optimize Query 5 using an index containing City and Total_Amount
CREATE INDEX idx_city_total
ON Customer_Order(City, Total_Amount);

EXPLAIN ANALYZE
SELECT
    City,
    SUM(Total_Amount) AS Total_Sales
FROM Customer_Order
GROUP BY City
ORDER BY Total_Sales DESC;

-- =========================================================
-- 8. FINAL INDEX VERIFICATION
-- =========================================================

SHOW INDEX FROM Customer_Order;

-- =========================================================
-- 9. BEFORE AND AFTER COMPARISON
-- =========================================================

SELECT
    'Query 1 - City Filter' AS Query_Name,
    'Before: no index on City' AS Before_Optimization,
    'After: idx_city' AS After_Optimization
UNION ALL
SELECT
    'Query 2 - Customer + Date',
    'Before: no composite index',
    'After: idx_customer_date'
UNION ALL
SELECT
    'Query 3 - YEAR(Order_Date)',
    'Before: function on column',
    'After: date range rewrite'
UNION ALL
SELECT
    'Query 4 - Category + Status',
    'Before: no composite index',
    'After: idx_category_status'
UNION ALL
SELECT
    'Query 5 - City Aggregation',
    'Before: no index on City, Total_Amount',
    'After: idx_city_total';
