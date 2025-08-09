# SQL-HandsOn-DataAnalysis

## Description

It includes creating a sample **E-Commerce Database**, inserting realistic data, and performing queries to extract meaningful business insights.  
This project showcases my SQL skills learned as part of my Data Science training and placement preparation.

## Objectives

- Design a normalized relational database schema.
  
- Practice SQL commands for **data creation, manipulation, and retrieval**.
  
- Write optimized queries for analytical and reporting purposes.
  
- Demonstrate **real-world problem-solving** using SQL.


## Tech Stack

- **Database Engine:** MySQL (Compatible with PostgreSQL, MariaDB)
  
- **Query Language:** SQL
  
- **Tools:** MySQL Workbench / pgAdmin / DBeaver


## Skills Demonstrated

1. **Database Creation & Management** – `CREATE DATABASE`, `CREATE TABLE`
   
2. **Data Insertion & Updating** – `INSERT INTO`, `UPDATE`, `DELETE`
   
3. **Data Retrieval** – `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`
   
4. **Joins** – `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
   
5. **Aggregate Functions** – `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`
    
6. **Subqueries & Nested Queries**
    
7. **Filtering & Conditions** – Logical operators, `BETWEEN`, `IN`, `LIKE`


## File Contents

**`SQL_HandsOn_Project.sql`** includes:

1. **Database Creation**
   
2. **Table Creation** (Customers, Products, Orders, OrderDetails)
   
3. **Sample Data Insertion**
   
4. **Business Queries:**
   
   - Top 5 customers by total purchase
     
   - Monthly sales report
     
   - Products with low stock
     
   - Average order value
     
   - Orders with customer and product names


---

## **📄 SQL_HandsOn_Project.sql (with definitions)**

Here’s how I’ll structure it inside the SQL file:

```
-- SQL Hands-On Project: E-Commerce Database

-- 1️⃣ CREATE DATABASE
-- CREATE DATABASE is used to make a new database.
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- 2️⃣ CREATE TABLES
-- CREATE TABLE defines the structure of a table with columns and data types.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    City VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 3️⃣ INSERT DATA
-- INSERT INTO adds new rows to a table.
INSERT INTO Customers (Name, City, Email) VALUES
('Alice Johnson', 'Chennai', 'alice@example.com'),
('Bob Smith', 'Mumbai', 'bob@example.com'),
('Charlie Davis', 'Delhi', 'charlie@example.com');

INSERT INTO Products (ProductName, Price, Stock) VALUES
('Laptop', 55000.00, 5),
('Mouse', 500.00, 50),
('Keyboard', 1500.00, 20);

INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2024-06-10'),
(2, '2024-07-05'),
(3, '2024-07-20');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 2, 1);

-- 4️⃣ SELECT QUERY
-- SELECT is used to retrieve data from a table.
SELECT * FROM Customers;

-- 5️⃣ INNER JOIN EXAMPLE
-- INNER JOIN combines rows from two or more tables where conditions match.
SELECT o.OrderID, c.Name, p.ProductName, od.Quantity
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID;

-- 6️⃣ AGGREGATE FUNCTION EXAMPLE
-- SUM() calculates the total of a numeric column.
SELECT c.Name, SUM(p.Price * od.Quantity) AS TotalPurchase
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.Name
ORDER BY TotalPurchase DESC
LIMIT 5;

```


