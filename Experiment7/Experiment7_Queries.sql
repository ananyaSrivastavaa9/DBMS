-- DBMS Experiment 7: Queries Only
USE Experiment7;

-- Query 1 - Verify UNF records
SELECT * FROM Sales_UNF ORDER BY Sale_ID;

-- Query 2 - Verify 1NF records
SELECT * FROM Sales_1NF
ORDER BY Sale_ID, Product_ID;

-- Query 3 - Verify 2NF decomposition
SELECT
    s.Sale_ID,
    s.Customer_Name,
    si.Product_ID,
    si.Product_Name,
    si.Quantity
FROM Sale_2NF s
JOIN Sale_Item_2NF si
    ON s.Sale_ID = si.Sale_ID
ORDER BY s.Sale_ID, si.Product_ID;

-- Query 4 - Verify 3NF decomposition
SELECT
    s.Sale_ID,
    s.Sale_Date,
    c.Customer_Name,
    sp.Salesperson_Name,
    p.Product_Name,
    si.Quantity,
    s.Payment_Mode
FROM Sale s
JOIN Customer c
    ON s.Customer_ID = c.Customer_ID
JOIN Salesperson sp
    ON s.Salesperson_ID = sp.Salesperson_ID
JOIN Sale_Item si
    ON s.Sale_ID = si.Sale_ID
JOIN Product p
    ON si.Product_ID = p.Product_ID
ORDER BY s.Sale_ID, p.Product_ID;

-- Query 5 - BCNF verification
SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Salesperson;
SHOW CREATE TABLE Product;
SHOW CREATE TABLE Sale;
SHOW CREATE TABLE Sale_Item;

-- Query 6 - Lossless join verification
SELECT
    (SELECT COUNT(*) FROM Sales_1NF) AS Original_Rows,
    (
        SELECT COUNT(*)
        FROM Sale s
        JOIN Customer c ON s.Customer_ID = c.Customer_ID
        JOIN Salesperson sp ON s.Salesperson_ID = sp.Salesperson_ID
        JOIN Sale_Item si ON s.Sale_ID = si.Sale_ID
        JOIN Product p ON si.Product_ID = p.Product_ID
    ) AS Reconstructed_Rows;

-- Query 7 - Dependency preservation verification
SELECT 'Customer FD violation' AS Check_Name, COUNT(*) AS Violations
FROM (
    SELECT Customer_ID
    FROM Customer
    GROUP BY Customer_ID
    HAVING COUNT(DISTINCT Customer_Name) > 1
        OR COUNT(DISTINCT Customer_City) > 1
) x
UNION ALL
SELECT 'Salesperson FD violation', COUNT(*)
FROM (
    SELECT Salesperson_ID
    FROM Salesperson
    GROUP BY Salesperson_ID
    HAVING COUNT(DISTINCT Salesperson_Name) > 1
) x
UNION ALL
SELECT 'Product FD violation', COUNT(*)
FROM (
    SELECT Product_ID
    FROM Product
    GROUP BY Product_ID
    HAVING COUNT(DISTINCT Product_Name) > 1
        OR COUNT(DISTINCT Product_Category) > 1
        OR COUNT(DISTINCT Unit_Price) > 1
) x
UNION ALL
SELECT 'Sale FD violation', COUNT(*)
FROM (
    SELECT Sale_ID
    FROM Sale
    GROUP BY Sale_ID
    HAVING COUNT(*) > 1
) x
UNION ALL
SELECT 'Sale_Item key violation', COUNT(*)
FROM (
    SELECT Sale_ID, Product_ID
    FROM Sale_Item
    GROUP BY Sale_ID, Product_ID
    HAVING COUNT(*) > 1
) x;
