-- 1.	List the top 3 products by revenue in each category.
WITH ProductRevenue AS (
    SELECT 
        p.Category,
        p.ProductKey,
        p.Product_Name,
        SUM(p.Unit_Price_USD * s.Quantity) AS Revenue
    FROM Sales s
    JOIN Products p ON s.ProductKey = p.ProductKey
    GROUP BY p.Category, p.ProductKey, p.Product_Name
),
RankedProducts AS (
    SELECT *,
           RANK() OVER (PARTITION BY Category ORDER BY Revenue DESC) AS RankInCategory
    FROM ProductRevenue
)
SELECT * 
FROM RankedProducts
WHERE RankInCategory <= 3;

-- 2.	Rank customers by total sales in their respective states.
WITH CustomerSales AS (
    SELECT 
        c.Name,
        c.State,
        SUM(p.Unit_Price_USD * s.Quantity) AS TotalSales
    FROM Sales s
    JOIN Customers c ON s.CustomerKey = c.CustomerKey
    JOIN Products p ON s.ProductKey = p.ProductKey
    GROUP BY c.CustomerKey, c.Name, c.State
),
RankedCustomers AS (
    SELECT *,
           RANK() OVER (PARTITION BY State ORDER BY TotalSales DESC) AS StateRank
    FROM CustomerSales
)
SELECT * 
FROM RankedCustomers
ORDER BY State, StateRank;

-- 3.	Calculate running total of revenue by month.
WITH MonthlyRevenue AS (
    SELECT 
        month(Order_Date) AS OrderMonth,
        SUM(p.Unit_Price_USD * s.Quantity) AS MonthlyRevenue
    FROM Sales s
    JOIN Products p ON s.ProductKey = p.ProductKey
    GROUP BY OrderMonth
)
SELECT 
    OrderMonth,
    MonthlyRevenue,
    SUM(MonthlyRevenue) OVER (ORDER BY OrderMonth) AS RunningTotalRevenue
FROM MonthlyRevenue
ORDER BY OrderMonth;

-- 4.	Find the first and last product purchased by each customer.
WITH CustomerOrders AS (
    SELECT 
        s.CustomerKey,
        c.Name,
        s.Order_Date,
        p.Product_Name,
        ROW_NUMBER() OVER (PARTITION BY s.CustomerKey ORDER BY s.Order_Date ASC) AS FirstOrderRank,
        ROW_NUMBER() OVER (PARTITION BY s.CustomerKey ORDER BY s.Order_Date DESC) AS LastOrderRank
    FROM Sales s
    JOIN Products p ON s.ProductKey = p.ProductKey
    JOIN Customers c ON s.CustomerKey = c.CustomerKey
)
SELECT 
    CustomerKey,
    Name,
    MAX(CASE WHEN FirstOrderRank = 1 THEN Product_Name END) AS FirstProduct,
    MAX(CASE WHEN LastOrderRank = 1 THEN Product_Name END) AS LastProduct
FROM CustomerOrders
GROUP BY CustomerKey, Name;

-- 5. Rank products by total profit within each subcategory.
WITH subcategory_profit AS (
    SELECT 
        p.Product_Name,
        p.Subcategory,
        SUM(p.Unit_Price_USD * s.Quantity) - SUM(p.Unit_Cost_USD * s.Quantity) AS profit
    FROM Sales s
    JOIN Products p ON s.ProductKey = p.ProductKey
    GROUP BY p.Product_Name, p.Subcategory
),
rank_subcategory AS (
    SELECT 
        Product_Name,
        Subcategory,
        profit,
        ROW_NUMBER() OVER (PARTITION BY Subcategory ORDER BY profit DESC) AS profit_rank
    FROM subcategory_profit
)
SELECT 
    Product_Name,
    Subcategory,
    profit_rank
FROM rank_subcategory
ORDER BY Subcategory, profit_rank;




