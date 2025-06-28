-- ========================================================================
-- Project: Retail Sales Database Schema
-- Description: SQL schema for retail sales data analysis, including sales,
--              customer profiles, product information, store details,
--              and currency exchange rates.
-- Author: Karthik Peddavarapu
-- GitHub: https://github.com/Karthik9492/SQL-Python-PowerBI-Project
-- ========================================================================


-- Create the database
create database RetailSalesDB;
use RetailSalesDB;

-- ================================
-- Table: Customers
-- ================================
-- Stores customer demographic and geographic information.

create table Customers(
      CustomerKey int primary key,
      Gender varchar(10),
      Name varchar(100),
      City VARCHAR(255),
      State_Code varchar(100),
      State varchar(100),
      Zip_Code VARCHAR(100),
      Country varchar(100),
      Continent varchar(100),
      Birthday date
);
-- ================================
-- Table: Products
-- ================================
-- Stores product details including pricing and category data.

create table Products(
	ProductKey INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Brand VARCHAR(100),
    Color VARCHAR(100),
    Unit_Cost_USD DECIMAL(10,2),
    Unit_Price_USD DECIMAL(10,2),
    SubcategoryKey INT,
    Subcategory VARCHAR(50),
    CategoryKey INT,
    Category VARCHAR(255)
);

-- ================================
-- Table: Stores
-- ================================
-- Contains store-specific information like location and size.
create table Stores(
    StoreKey int primary key,
    Country varchar(100),
    State varchar(100),
    Square_Meters int,
    Open_Date date
);

-- ================================
-- Table: Exchange_Rates
-- ================================
-- Stores daily currency exchange rates to convert local currencies to USD.

CREATE TABLE Exchange_Rates (
    Date DATE,
    Currency VARCHAR(100),
    Exchange DECIMAL(10,4),
    PRIMARY KEY (Date, Currency)
);
-- ================================
-- Table: Sales
-- ================================
-- Core transactional table linking customers, products, and stores.

create table sales(
    Order_Number INT,
    Line_Item INT,
    Order_Date DATE,
    Delivery_Date DATE,
    CustomerKey INT,
    StoreKey INT,
    ProductKey INT,
    Quantity INT,
    Currency_Code VARCHAR(100),
    PRIMARY KEY (Order_Number, Line_Item),
    FOREIGN KEY (CustomerKey) REFERENCES Customers(CustomerKey),
    FOREIGN KEY (StoreKey) REFERENCES Stores(StoreKey),
    FOREIGN KEY (ProductKey) REFERENCES Products(ProductKey)
);


-- ================================
-- End of Schema
-- ================================

-- Import products 
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Products.csv"
INTO TABLE products
character set latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
;
-- Repeat for other tables




