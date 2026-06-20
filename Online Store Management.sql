CREATE DATABASE OnlineStore;
USE OnlineStore;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(50)
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT,
    stock INT
);CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers VALUES
(1, 'Nitin', 'nitin@gmail.com', 'Delhi'),
(2, 'Rahul', 'rahul@gmail.com', 'Noida'),
(3, 'Amit', 'amit@gmail.com', 'Mumbai');
INSERT INTO Products VALUES
(101, 'Laptop', 50000, 20),
(102, 'Mobile', 20000, 30),
(103, 'Headphones', 2000, 50);
INSERT INTO Orders VALUES
(1, 1, '2024-04-01'),
(2, 2, '2024-04-02'),
(3, 1, '2024-04-03');
INSERT INTO Order_Details VALUES
(1, 101, 1),
(1, 103, 2),
(2, 102, 1),
(3, 103, 3);
SELECT * FROM customers;
SELECT o.order_id, SUM(p.price * od.quantity) AS total_amount
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY o.order_id;
SELECT c.name, o.order_id, o.order_date
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;
SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id
ORDER BY total_orders DESC;
SELECT * FROM Products
WHERE stock < 10;
SELECT product_id, SUM(quantity) AS total_sold
FROM Order_Details
GROUP BY product_id
ORDER BY total_sold DESC;
SELECT c.name, o.order_id,
SUM(p.price * od.quantity) AS total_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.name, o.order_id;