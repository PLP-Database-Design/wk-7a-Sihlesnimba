-- Question 1
-- First we need a database for the table.
CREATE DATABASE first_nf_db;

-- Specify to the server which database to use.
USE first_nf_db;

-- Creating the ProductDetail table.
CREATE TABLE ProductDetail(
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(30),
Products VARCHAR(50)
);

-- Insert values into the table
INSERT INTO ProductDetail(OrderID, CustomerName, Products)
VALUES (101, "John Doe", "Laptop, Mouse"),
(102, "Jane Smith", "Tablet, Keyboard, Mouse"),
(103, "Emily Clark", "Phone");

-- Achieving 1NF
-- Step 1: remove the Products column from the ProductDetail table.
ALTER TABLE ProductDetail
DROP COLUMN Products;

-- Step 2: create a seperate table.
CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
OrderID INT,
FOREIGN KEY (OrderID) REFERENCES ProductDetail(OrderID)
);

-- Insert values to Products table.
INSERT INTO Products(ProductID, ProductName, OrderID)
VALUES (1, "Laptop", 101),
(2, "Mouse", 101),
(4, "Tablet", 102),
(5, "Keyboard", 102),
(6, "Mouse", 102),
(7, "Phone", 103);

-- 1NF has been achieved.


-- Question 2

USE first_nf_db;

-- Creating the table that violates 2NF.
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
    
);

INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity) 
VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Achieving 2NF.
-- Step 1: Remove the CustomerName column from the OrderDetails table.
ALTER TABLE OrderDetails
DROP COLUMN CustomerName;

-- Step 2: Create the new table "Orders".
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName) 
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Add foreign key to OrderDetails table.
ALTER TABLE OrderDetails
ADD FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);


