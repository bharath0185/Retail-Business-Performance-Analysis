-- Retail Business Performance & Profitability Analysis
-- Author: Bharath K
-- Objective: Analyze sales, profit margins, and inventory performance

----------------------------------------------------
-- 1️⃣ View overall data
----------------------------------------------------
SELECT * FROM retail_data_cleaned
LIMIT 10;

----------------------------------------------------
-- 2️⃣ Calculate total revenue, total cost, and total profit
----------------------------------------------------
SELECT
    ROUND(SUM(Price * Quantity), 2) AS Total_Revenue,
    ROUND(SUM(Cost * Quantity), 2) AS Total_Cost,
    ROUND(SUM((Price - Cost) * Quantity), 2) AS Total_Profit
FROM retail_data_cleaned;

----------------------------------------------------
-- 3️⃣ Profit margin by Category
----------------------------------------------------
SELECT
    Category,
    ROUND(SUM((Price - Cost) * Quantity), 2) AS Total_Profit,
    ROUND(AVG((Price - Cost) / Price * 100), 2) AS Avg_Profit_Margin
FROM retail_data_cleaned
GROUP BY Category
ORDER BY Total_Profit DESC;

----------------------------------------------------
-- 4️⃣ Region-wise profitability
----------------------------------------------------
SELECT
    Region,
    ROUND(SUM((Price - Cost) * Quantity), 2) AS Total_Profit,
    ROUND(SUM(Quantity), 0) AS Total_Quantity
FROM retail_data_cleaned
GROUP BY Region
ORDER BY Total_Profit DESC;

----------------------------------------------------
-- 5️⃣ Sub-category performance (Top 10 by profit)
----------------------------------------------------
SELECT
    Sub_Category,
    Category,
    ROUND(SUM((Price - Cost) * Quantity), 2) AS Total_Profit,
    ROUND(AVG((Price - Cost) / Price * 100), 2) AS Avg_Profit_Margin
FROM retail_data_cleaned
GROUP BY Sub_Category, Category
ORDER BY Total_Profit DESC
LIMIT 10;

----------------------------------------------------
-- 6️⃣ Identify slow-moving inventory (High inventory days, low profit)
----------------------------------------------------
SELECT
    Sub_Category,
    AVG(Inventory_Days) AS Avg_Inventory_Days,
    ROUND(AVG((Price - Cost) / Price * 100), 2) AS Avg_Profit_Margin
FROM retail_data_cleaned
GROUP BY Sub_Category
HAVING Avg_Inventory_Days > 15
ORDER BY Avg_Profit_Margin ASC
LIMIT 10;

----------------------------------------------------
-- 7️⃣ Month-wise sales trend
----------------------------------------------------
SELECT
    STRFTIME('%Y-%m', Date) AS Month,
    ROUND(SUM((Price - Cost) * Quantity), 2) AS Total_Profit,
    ROUND(SUM(Price * Quantity), 2) AS Total_Revenue
FROM retail_data_cleaned
GROUP BY Month
ORDER BY Month;
