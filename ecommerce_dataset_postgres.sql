
-- Drop tables if they exist
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;

-- Create tables
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INTEGER REFERENCES categories(category_id),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date DATE,
    status VARCHAR(20)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER,
    price DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO customers (first_name, last_name, email, country) VALUES
('John', 'Doe', 'john@example.com', 'USA'),
('Jane', 'Smith', 'jane@example.com', 'Canada'),
('Alice', 'Johnson', 'alice@example.com', 'UK'),
('Bob', 'Brown', 'bob@example.com', 'USA');

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Books'),
('Clothing');

INSERT INTO products (product_name, category_id, price) VALUES
('Smartphone', 1, 699.99),
('Laptop', 1, 999.99),
('Headphones', 1, 199.99),
('Fiction Book', 2, 15.99),
('T-shirt', 3, 25.50);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-04-01', 'Shipped'),
(2, '2024-04-02', 'Pending'),
(1, '2024-04-03', 'Delivered'),
(3, '2024-04-04', 'Cancelled');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 699.99),
(1, 3, 2, 199.99),
(2, 4, 3, 15.99),
(3, 2, 1, 999.99),
(4, 5, 2, 25.50);
