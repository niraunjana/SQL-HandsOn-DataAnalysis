-- SQL Hands-On Project
-- Author: Niraunjana Gayathri
-- Description: Sample database and queries for practicing SQL concepts.
-- Database: E_CommerceDB

-- 1. Create Database
CREATE DATABASE E_CommerceDB;
USE E_CommerceDB;

-- 2. Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 3. Insert Sample Data
INSERT INTO Customers VALUES
(1, 'John Smith', 'john.smith@example.com', 'USA'),
(2, 'Priya Sharma', 'priya.sharma@example.com', 'India'),
(3, 'David Lee', 'david.lee@example.com', 'UK'),
(4, 'Maria Garcia', 'maria.garcia@example.com', 'Spain');

INSERT INTO Orders VALUES
(101, 1, '2024-08-01', 500.00),
(102, 2, '2024-08-02', 150.00),
(103, 3, '2024-08-03', 300.00),
(104, 1, '2024-08-04', 200.00);

INSERT INTO Products VALUES
(201, 'Laptop', 'Electronics', 1000.00),
(202, 'Smartphone', 'Electronics', 500.00),
(203, 'Desk Chair', 'Furniture', 150.00),
(204, 'Book', 'Stationery', 20.00);

INSERT INTO OrderDetails VALUES
(301, 101, 201, 1),
(302, 101, 204, 5),
(303, 102, 202, 1),
(304, 103, 203, 2),
(305, 104, 204, 10);

-- 4. Sample Queries

-- Q1: List all customers from India
SELECT * FROM Customers WHERE Country = 'India';

-- Q2: Find total sales per customer
SELECT c.Name, SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Name;

-- Q3: Get top 3 most expensive products
SELECT ProductName, Price FROM Products
ORDER BY Price DESC LIMIT 3;

-- Q4: Find all orders placed in August 2024
SELECT * FROM Orders
WHERE MONTH(OrderDate) = 8 AND YEAR(OrderDate) = 2024;

-- Q5: Get average order value per country
SELECT c.Country, AVG(o.TotalAmount) AS AvgOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Country;

-- Q6: Find customers who bought 'Laptop'
SELECT DISTINCT c.Name
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Laptop';

-- Q7: Use a subquery to list customers who spent more than $400
SELECT Name FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID FROM Orders
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > 400
);

-- Q8: Calculate total quantity sold for each product category
SELECT p.Category, SUM(od.Quantity) AS TotalSold
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.Category;

-- Q9: List orders with more than 2 products
SELECT o.OrderID, COUNT(od.ProductID) AS ProductCount
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID
HAVING COUNT(od.ProductID) > 2;

-- Q10: Show highest single order amount
SELECT MAX(TotalAmount) AS HighestOrder FROM Orders;
