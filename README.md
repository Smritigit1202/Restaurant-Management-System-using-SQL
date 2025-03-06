# Restaurant-Management-System-using-SQL

## Project Overview
This project is a structured **Restaurant Database Management System** designed using **MySQL**. It efficiently stores, manages, and retrieves restaurant-related data, including menu items, ingredients, customers, and orders. The database follows **normalization principles** to optimize performance, prevent data redundancy, and ensure data integrity.

## Features
- **Structured Relational Database**: Designed with well-defined entities like `Restaurant`, `Menu`, `Orders`, and `Customers`.
- **Data Integrity**: Uses primary keys, foreign keys, and constraints for robust data relationships.
- **Optimized Queries**:
  - Joins, subqueries, and aggregations for meaningful data insights.
  - Reports to track revenue, most popular dishes, and top-spending customers.
- **Scalability**: Easily extendable to accommodate more data and analytics.

## Database Schema
The project consists of the following tables:
1. **Restaurant**: Stores restaurant details such as name, address, and contact information.
2. **Categories**: Defines different food categories (e.g., Main Course, Appetizers, Desserts).
3. **Menu**: Lists food items, descriptions, prices, and associated categories.
4. **Ingredients**: Keeps track of ingredient inventory.
5. **Customers**: Stores customer details.
6. **Orders**: Tracks customer orders and total amounts.
7. **Order_Items**: Stores ordered dishes and quantities.

## Setup Instructions
1. **Install MySQL**: Ensure MySQL is installed and running on your system.
2. **Create Database**:
   ```sql
   CREATE DATABASE RestaurantDB;
   USE RestaurantDB;
   ```
3. **Execute SQL Script**: Run the provided SQL file to create tables and insert initial data.
4. **Run Queries**: Execute the analytical queries to generate insights.

## Sample Queries
Here are a few sample queries executed in this project:
1. **Retrieve all orders with customer details and order total:**
   ```sql
   SELECT o.order_id, c.name AS customer_name, o.order_date, o.total_amount 
   FROM Orders o
   JOIN Customers c ON o.customer_id = c.customer_id;
   ```
2. **Find the most popular dish based on quantity ordered:**
   ```sql
   SELECT m.name AS dish_name, SUM(oi.quantity) AS total_ordered 
   FROM Order_Items oi
   JOIN Menu m ON oi.dish_id = m.dish_id 
   GROUP BY m.name 
   ORDER BY total_ordered DESC 
   LIMIT 1;
   ```
3. **Calculate total revenue and average order value:**
   ```sql
   SELECT SUM(total_amount) AS total_revenue, AVG(total_amount) AS avg_order_value FROM Orders;
   ```

## Insights and Analytics
- **Total revenue generated and average order value**.
- **Top-spending customers and their total spending**.
- **Most popular dishes based on order frequency**.
- **Customer order patterns and total number of orders per customer**.


## Conclusion
This **Restaurant Database Management System** enables efficient handling of restaurant operations, from managing menu items and orders to generating insightful reports for decision-making.
