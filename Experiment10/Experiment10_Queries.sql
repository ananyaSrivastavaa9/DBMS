-- DBMS Experiment 10: Queries Only
USE Experiment10;

-- Query 1 - Verify dataset
SELECT
    COUNT(*) AS Total_Rows,
    MIN(Order_Date) AS First_Order,
    MAX(Order_Date) AS Last_Order
FROM Customer_Order;

-- Query 2 - Slow query 1
EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE City = 'Lucknow';

-- After idx_city
EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE City = 'Lucknow';

-- Query 3 - Slow query 2
EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE Customer_ID = 1250
  AND Order_Date BETWEEN '2026-02-01' AND '2026-06-30';

-- After idx_customer_date
EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE Customer_ID = 1250
  AND Order_Date BETWEEN '2026-02-01' AND '2026-06-30';

-- Query 4 - Slow query 3
EXPLAIN ANALYZE
SELECT COUNT(*) AS Total_Orders
FROM Customer_Order
WHERE YEAR(Order_Date) = 2026;

-- Rewritten query
EXPLAIN ANALYZE
SELECT COUNT(*) AS Total_Orders
FROM Customer_Order
WHERE Order_Date >= '2026-01-01'
  AND Order_Date < '2027-01-01';

-- Query 5 - Slow query 4
EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE Product_Category = 'Electronics'
  AND Order_Status = 'DELIVERED';

-- After idx_category_status
EXPLAIN ANALYZE
SELECT *
FROM Customer_Order
WHERE Product_Category = 'Electronics'
  AND Order_Status = 'DELIVERED';

-- Query 6 - Slow query 5
EXPLAIN ANALYZE
SELECT
    City,
    SUM(Total_Amount) AS Total_Sales
FROM Customer_Order
GROUP BY City
ORDER BY Total_Sales DESC;

-- After idx_city_total
EXPLAIN ANALYZE
SELECT
    City,
    SUM(Total_Amount) AS Total_Sales
FROM Customer_Order
GROUP BY City
ORDER BY Total_Sales DESC;

-- Query 7 - Final index verification
SHOW INDEX FROM Customer_Order;
