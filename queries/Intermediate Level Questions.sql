use RetailSalesDB;
-- 1.	What is the monthly trend of revenue in USD?
SELECT 
    MONTH(s.Order_Date) AS months,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue
FROM
    sales s
        JOIN
    products p ON p.ProductKey = s.ProductKey
GROUP BY months;
select CURDATE();
-- 2.	Calculate the profit per order (Revenue - Cost)
SELECT 
    s.Order_Number,
    (SUM(p.Unit_Price_USD * s.Quantity) - SUM(p.Unit_Cost_USD * s.Quantity)) AS profit_per_order
FROM
    sales s
        JOIN
    products p ON s.ProductKey = p.ProductKey
GROUP BY Order_Number
ORDER BY profit_per_order DESC;

-- 3.	What is the average age of customers per country?
SELECT 
    country,
    AVG(TIMESTAMPDIFF(YEAR, Birthday, CURDATE())) AS Average_Age
FROM
    customers
GROUP BY country;

-- 4.	Which stores are operating in states with the highest number of customers?
SELECT 
    st.State, COUNT(c.CustomerKey) AS Total_Customers
FROM
    sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    stores st ON s.StoreKey = st.StoreKey
GROUP BY st.State
ORDER BY Total_Customers DESC;

-- 5.	Which customer city has the highest sales volume?
SELECT 
    c.city, SUM(p.Unit_Price_USD * s.Quantity) AS Total_sales
FROM
    sales s
        JOIN
    products p ON s.ProductKey = p.ProductKey
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
GROUP BY c.city
ORDER BY Total_sales DESC;

-- 6.	What is the average number of days between order and delivery per category?
SELECT 
    p.Category,
    ROUND(AVG(DATEDIFF(s.Delivery_Date, s.Order_Date))) AS average_delivery_time
FROM
    sales s
        JOIN
    products p ON s.ProductKey = p.ProductKey
GROUP BY p.Category;

-- 7.	Which brands have the highest average profit margins?
SELECT 
    brand,
    ROUND(AVG(((Unit_Price_USD - Unit_Cost_USD) / Unit_Price_USD)),
            2) AS Profit_Margin
FROM
    products
GROUP BY brand
ORDER BY Profit_Margin DESC;

-- 8.	List products whose unit price is more than twice their unit cost.
SELECT 
    product_name
FROM
    products
WHERE
    Unit_Price_USD > 2 * Unit_Cost_USD;
-- 9.	Convert sales from other currencies to USD using exchange rates.
SELECT 
    s.Order_Number,
    s.Currency_Code,
    s.order_date,
    s.Quantity,
    p.Product_Name,
    p.Unit_Price_USD AS Unit_Price_Local,
    (p.Unit_Price_USD * s.Quantity) AS Revenue_Local,
    CASE
        WHEN s.Currency_Code = 'USD' THEN (p.Unit_Price_USD * s.Quantity)
        ELSE (p.Unit_Price_USD * s.Quantity) / IFNULL(er.Exchange, 1)
    END AS Revenue_USD
FROM
    Sales s
        JOIN
    Products p ON s.ProductKey = p.ProductKey
        LEFT JOIN
    exchange_rates er ON s.order_date = er.Date
        AND s.Currency_Code = er.Currency;
