-- Query 1: Top 5 Customers by Number of Orders
SELECT customer_id, COUNT(*) AS total_order
FROM orders
GROUP BY customer_id
ORDER BY total_order DESC
LIMIT 5;

-- Query 2: INNER JOIN — Products in Orders
SELECT o.order_id, p.product_name, oi.quantity
FROM orders AS o
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
INNER JOIN products AS p ON oi.product_id = p.product_id;

-- Query 3: LEFT JOIN — Customers Who Haven’t Placed Any Orders
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Query 4: RIGHT JOIN — Orders Without Customer Information
SELECT o.order_id, o.order_date, c.first_name
FROM orders AS o
RIGHT JOIN customers AS c ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- Query 5: Subquery — Products That Are Priced Above the Average Price
SELECT product_id, product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- Query 6: Total Revenue per Product
SELECT p.product_name, SUM(oi.quantity * oi.price) AS revenue
FROM order_items AS oi
JOIN products AS p ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Query 7: Create a View for Top Selling Products
CREATE VIEW top_selling_products AS
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items AS oi
JOIN products AS p ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- View Output
SELECT * FROM top_selling_products;

-- Query 8: Create Index to Optimize JOINs and Filtering
-- Creating index on product_id for faster joins between order_items and products
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Creating index on customer_id for faster customer-order lookups
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
