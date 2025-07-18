# Sales & Product Analysis with Database and SQL
This project is focused on analyzing a sales dataset using MySQL. The dataset includes tables for Sales, Customers, Products, and Stores. The goal of this project is to explore, analyze, and visualize sales performance, customer behavior, and store operations. I have created a series of SQL queries at various difficulty levels to gain insights and answer business-related questions.
# Key Features
-- Basic Analysis: Simple queries like total sales, customer counts, and product aggregations.

-- Intermediate Analysis: Deeper insights like trends, profit calculations, and customer segmentation.

-- Advanced Analysis: Complex queries using CTEs, subqueries, and window functions for ranking, running totals, and more.

# Technologies Used
-- Database: MySQL

-- SQL Functions: Aggregations, Joins, Window Functions, CTEs, Subqueries

-- Version Control: Git, GitHub
# Data Schema
The analysis is performed on a relational database that includes the following key tables:

| Table        | Description |
|--------------|-------------|
| `Sales`      | Transaction data including product, quantity, customer, store, and delivery details |
| `Customers`  | Demographic and geographic info of customers |
| `Products`   | Product details including category, subcategory, cost, and price |
| `Stores`     | Store-level data such as size, location, and opening date |
| `ExchangeRates` | Historical exchange rates for currency conversion |

# Query Categories
📘 Basic Level Questions (Joins, Aggregations, Filters)
1.	What is the total number of orders placed per year?
2.	What are the total sales (USD) by product category?
3.	Which 5 customers made the highest number of purchases?
4.	What is the total quantity sold for each product?
5.	List all distinct countries and continents where the customers are located.
6.	What is the average delivery time (in days) for each state?
7.	List top 10 best-selling products by unit sold.
8.	What is the total revenue generated by each store?
9.	What is the number of male vs female customers?
10.	Which product categories are sold in which countries?

📗 Intermediate Level Questions (Multiple Joins, Date & String Functions)
1.	What is the monthly trend of revenue in USD?
2.	Calculate the profit per order (Revenue - Cost).
3.	What is the average age of customers per country?
4.	Which stores are operating in states with the highest number of customers?
5.	Which customer city has the highest sales volume?
6.	What is the average number of days between order and delivery per category?
7.	Which brands have the highest average profit margins?
8.	List products whose unit price is more than twice their unit cost.
9.	Convert sales from other currencies to USD using exchange rates.
    
📙 Hard Level Questions (CTE, Subquery, Window Functions)
1.	List the top 3 products by revenue in each category.
2.	Rank customers by total sales in their respective states.
3.	Calculate running total of revenue by month.
4.	Find the first and last product purchased by each customer.
5.	Rank products by total profit within each subcategory.
# Visual Outputs (Screenshots)

1. <img width="376" alt="image" src="https://github.com/user-attachments/assets/b5f473ea-487a-40f8-a7ef-af34ffb877f8" />

2.<img width="382" alt="image" src="https://github.com/user-attachments/assets/f5c4de46-338f-4f41-9284-c070b0fb3810" />

3.<img width="382" alt="image" src="https://github.com/user-attachments/assets/941a245a-3780-41d7-a12a-cbeaa01794a3" />

4.<img width="449" alt="image" src="https://github.com/user-attachments/assets/ad45ab57-9e72-443d-9af2-4294f6cd0c05" />

## 📌 How to Explore Queries 
Clone the repo and view:
- `.sql` files for full logic


