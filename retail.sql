DROP DATABASE IF EXISTS retail_analytics;
CREATE DATABASE retail_analytics;
USE retail_analytics;

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;

-- CREATE TABLES
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_level INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Data
INSERT INTO products VALUES
(1, 'T-Shirt', 'Apparel', 19.99),
(2, 'Sneakers', 'Footwear', 89.99),
(3, 'Backpack', 'Accessories', 49.99),
(4, 'Water Bottle', 'Accessories', 14.99);

INSERT INTO sales VALUES
(1, 1, '2025-06-01', 3),
(2, 2, '2025-06-01', 1),
(3, 1, '2025-06-02', 2),
(4, 3, '2025-06-03', 1),
(5, 4, '2025-06-03', 4);

INSERT INTO inventory VALUES
(1, 50),
(2, 25),
(3, 15),
(4, 5);

-- Total revenue by product
SELECT 
    p.name,
    SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.name;

-- Top 3 best-selling products
SELECT 
    p.name,
    SUM(s.quantity) AS total_units_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.name
ORDER BY total_units_sold DESC
LIMIT 3;

-- Low inventory alerts (stock below 10)
SELECT 
    p.name,
    i.stock_level
FROM inventory i
JOIN products p ON i.product_id = p.product_id
WHERE i.stock_level < 10;
