-- Checking Data about Products

-- Top 10 best-selling products by Quantity
SELECT TOP 10 StockCode, Description, SUM(Quantity) as TopSellingProductsQ
FROM store_sales..sales_mod$
GROUP BY StockCode,description
ORDER BY 3 DESC;

-- Top products by Orders
SELECT StockCode, Description, COUNT(InvoiceNo) as TopSellingProductsO
FROM store_sales..sales_mod$
GROUP BY StockCode, Description
ORDER BY 3 DESC;

-- Top selling products by price
SELECT StockCode, Description,  SUM((UnitPrice*Quantity)) as TopSellingProductsO
FROM store_sales..sales_mod$
GROUP BY StockCode, Description
ORDER BY 3 DESC;

-- The Most Expensive Product
SELECT StockCode, Description, MAX(UnitPrice) AS ExpProduct
FROM store_sales..sales_mod$
GROUP BY StockCode, Description
ORDER BY 3 DESC

-- Check Top 10 products which one is most often buy in combination with the best-selling product.

--322 Combinations by InvoiceNo
SELECT COUNT(*) AS TotalComb FROM 
(SELECT InvoiceNo
FROM store_sales..sales_mod$
WHERE StockCode = '85123A'
INTERSECT
SELECT InvoiceNo
FROM store_sales..sales_mod$
WHERE StockCode = '85231B') A;

-- Checking Data About Customers

-- Customers Who Spent The Most 
SELECT CustomerID, SUM((UnitPrice*Quantity)) AS TotalSpent
FROM store_sales..sales_mod$
GROUP BY CustomerID 
ORDER BY 2 DESC;

-- Customer Who Ordered Most Often
SELECT CustomerID, Count(InvoiceNo) AS NumberOfOrders
FROM store_sales..sales_mod$
GROUP BY CustomerID
ORDER BY 2 DESC;

-- Which Customer Has the Largest Average Purchase Value
SELECT CustomerID, ROUND(AVG((UnitPrice*Quantity)),2) AS AvPurchaseByCustomer
FROM store_sales..sales_mod$
GROUP BY CustomerID
ORDER BY AvPurchaseByCustomer DESC;


-- Checking Data About Countries

-- Which Country Purchased The Most Products
SELECT Country, SUM(Quantity) as TopProducts
FROM store_sales..sales_mod$
GROUP BY Country
ORDER BY 2 DESC;

-- Which Country Purchased The Most Orders
SELECT Country, Count(InvoiceNo) as TopOrders
FROM store_sales..sales_mod$
GROUP BY Country
ORDER BY 2 DESC;

--Which Country Has The Largest Average Purchase Value
SELECT Country, ROUND(AVG(UnitPrice*Quantity),2) AS AvPurchaseByC
FROM store_sales..sales_mod$
GROUP BY Country
ORDER BY AvPurchaseByC DESC;

-- Total Orders per Month
SELECT month(InvoiceDate) AS MonthName, COUNT(InvoiceNo) AS NumOrders
FROM store_sales..sales_mod$
GROUP BY month(InvoiceDate)
ORDER BY 2 DESC

-- Total Sales per Month
SELECT month(InvoiceDate) AS MonthName, ROUND(SUM(UnitPrice*Quantity),2) AS NumOrders
FROM store_sales..sales_mod$
GROUP BY month(InvoiceDate)
ORDER BY 2 DESC

