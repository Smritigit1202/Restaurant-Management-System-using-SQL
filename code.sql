-- Create Database
CREATE DATABASE RestaurantDB;
USE RestaurantDB;

-- Create Tables
CREATE TABLE Restaurant (
  restaurant_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  contact_number VARCHAR(20) NOT NULL UNIQUE,
  opening_hours VARCHAR(100) NOT NULL
);

CREATE TABLE Categories (
  category_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Menu (
  dish_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) CHECK (price > 0),
  category_id INT,
  FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE
);

CREATE TABLE Ingredients (
  ingredient_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  quantity DECIMAL(10, 2) CHECK (quantity >= 0),
  unit_of_measurement VARCHAR(20) NOT NULL
);

CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  contact_number VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(10, 2) CHECK (total_amount >= 0),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE Order_Items (
  order_item_id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  dish_id INT NOT NULL,
  quantity INT CHECK (quantity > 0),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
  FOREIGN KEY (dish_id) REFERENCES Menu(dish_id) ON DELETE CASCADE
);

-- Insert Data
INSERT INTO Restaurant (restaurant_id, name, address, contact_number, opening_hours)
VALUES 
(1, 'Tasty Bites', '456 Elm St', '555-123-4567', '8am-10pm'),
(2, 'Gourmet Haven', '789 Oak St', '555-987-6543', '10am-11pm');

INSERT INTO Categories (category_id, name)
VALUES 
(1, 'Main Course'),
(2, 'Appetizers'),
(3, 'Desserts');

INSERT INTO Menu (dish_id, name, description, price, category_id)
VALUES 
(1, 'Spaghetti Bolognese', 'Classic Italian pasta with meat sauce', 12.99, 1),
(2, 'Caesar Salad', 'Crispy romaine with creamy dressing', 8.99, 2),
(3, 'Chocolate Lava Cake', 'Warm chocolate cake with molten center', 6.99, 3);

INSERT INTO Ingredients (ingredient_id, name, quantity, unit_of_measurement)
VALUES 
(1, 'Tomato Sauce', 5, 'cups'),
(2, 'Lettuce', 3, 'heads'),
(3, 'Chocolate', 4, 'bars');

INSERT INTO Customers (customer_id, name, contact_number)
VALUES 
(1, 'Alice Johnson', '555-234-5678'),
(2, 'Bob Smith', '555-876-5432');

INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES 
(1, '2023-06-15', 18.99),
(2, '2023-06-16', 22.50);

INSERT INTO Order_Items (order_id, dish_id, quantity)
VALUES 
(1, 1, 1),
(1, 2, 2),
(2, 3, 1);

-- Queries for Advanced Analytics

-- 1. Retrieve all orders with customer details and order total
SELECT o.order_id, c.name AS customer_name, o.order_date, o.total_amount 
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

-- 2. Find the most popular dish (by quantity ordered)
SELECT m.name AS dish_name, SUM(oi.quantity) AS total_ordered 
FROM Order_Items oi
JOIN Menu m ON oi.dish_id = m.dish_id 
GROUP BY m.name 
ORDER BY total_ordered DESC 
LIMIT 1;

-- 3. Calculate total revenue and average order value
SELECT SUM(total_amount) AS total_revenue, AVG(total_amount) AS avg_order_value FROM Orders;

-- 4. List all menu items with their categories and price range
SELECT m.name AS dish_name, c.name AS category_name, m.price 
FROM Menu m
JOIN Categories c ON m.category_id = c.category_id
ORDER BY m.price DESC;

-- 5. Count total orders per customer and their total spending
SELECT c.name AS customer_name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id 
GROUP BY c.name
ORDER BY total_spent DESC;

-- 6. Find the top 3 highest-spending customers
SELECT c.name AS customer_name, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 3;
