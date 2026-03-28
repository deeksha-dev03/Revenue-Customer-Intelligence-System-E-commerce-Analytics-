/* Creating Database */ 
CREATE DATABASE ecommerce_analytics;
USE ecommerce_analytics;



/* Creating Tables */
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp VARCHAR(50),
    order_approved_at VARCHAR(50),
    order_delivered_carrier_date VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date VARCHAR(50),
    price FLOAT,
    freight_value FLOAT
);

CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(20),
    payment_installments INT,
    payment_value FLOAT
);

CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
);

CREATE TABLE products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT
);

CREATE TABLE sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);



/* Checking the data */
select * from customers;
select * from orders;
select * from order_items;
select * from order_payments;
select * from order_reviews;
select * from product_category_translation;
select * from products;
select * from sellers;




/*      Data Exploration      */ 

/* Highest Revenue Products */
SELECT COUNT(DISTINCT customer_unique_id) as Total_Customers
FROM customers;

/* Total Order Count*/
SELECT COUNT(*) AS total_order
FROM orders;

/* Order status count */
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

/* Total Revenue*/
SELECT ROUND(SUM(payment_value),2) AS total_revenue
FROM order_payments;

/* Average Order Value */
SELECT 
ROUND(SUM(payment_value) / COUNT(DISTINCT order_id),2) 
AS average_order_value
FROM order_payments;

/* Total Transactions by Payemnt Type*/
SELECT payment_type,
COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

/* Total orders by customer city wise*/
SELECT 
customer_city,
COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY customer_city
ORDER BY total_orders DESC
LIMIT 10;

/* Monthly trend of orders */
SELECT 
DATE_FORMAT(
    STR_TO_DATE(order_purchase_timestamp,'%m/%d/%Y %H:%i'),
    '%Y-%m'
) AS order_month,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

/* Highest Revenue Products */
SELECT 
p.product_category_name,
COUNT(oi.product_id) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;

/* Highest Revenue Products */
SELECT 
p.product_category_name,
ROUND(SUM(oi.price),2) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 10;




/*      Data Cleaning + Feature Engineering      */

CREATE VIEW clean_orders AS
SELECT
	order_id,
	customer_id,
	order_status,
	STR_TO_DATE(order_purchase_timestamp,'%m/%d/%Y %H:%i') AS order_purchase_time,
	STR_TO_DATE(order_delivered_customer_date,'%m/%d/%Y %H:%i') AS delivered_date
FROM orders;

CREATE VIEW order_features AS
SELECT
order_id,
customer_id,
order_purchase_time,
DATE_FORMAT(order_purchase_time,'%Y-%m') AS order_month
FROM clean_orders;

SELECT
order_id,
DATEDIFF(delivered_date, order_purchase_time) AS delivery_days
FROM clean_orders
WHERE delivered_date IS NOT NULL;

SELECT
customer_id,
COUNT(order_id) AS total_orders
FROM clean_orders
GROUP BY customer_id;

SELECT
customer_id,
COUNT(order_id) AS total_orders,
CASE
	WHEN COUNT(order_id) > 1 THEN 'Repeat Customer'
	ELSE 'One-time Customer'
END AS customer_type
FROM clean_orders
GROUP BY customer_id;

SELECT
c.customer_unique_id,
ROUND(SUM(op.payment_value),2) AS customer_lifetime_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY customer_lifetime_value DESC;





/*           Advanced Business Analysis in SQL                */

/*Top 10 High-Value Customers (by Revenue)*/
SELECT
c.customer_unique_id,
ROUND(SUM(op.payment_value),2) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;

/*Revenue by Product Category*/
SELECT
p.product_category_name,
ROUND(SUM(oi.price),2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;

/*Top 10 Best-Selling Products (by Volume)*/
SELECT
product_id,
COUNT(order_item_id) AS total_sales
FROM order_items
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 10;

/*Customer Retention (Repeat vs One-Time Customers)*/
SELECT
CASE
WHEN order_count > 1 THEN 'Repeat Customer'
ELSE 'One-time Customer'
END AS customer_type,
COUNT(*) AS total_customers
FROM (
SELECT
customer_id,
COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
) AS customer_orders
GROUP BY customer_type;

/*Average Delivery Time*/
SELECT
ROUND(
AVG(
DATEDIFF(
STR_TO_DATE(order_delivered_customer_date,'%m/%d/%Y %H:%i'),
STR_TO_DATE(order_purchase_timestamp,'%m/%d/%Y %H:%i')
)
),2) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;


select * from customers;
select * from orders;
select * from order_items;
select * from order_payments;
select * from products;




