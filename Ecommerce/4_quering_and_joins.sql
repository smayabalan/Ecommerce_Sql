--  Query 1: Join customer and order tables to show recent orders
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    o.order_id,
    o.order_number,
    o.order_date,
    o.order_status,
    o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY o.order_date DESC;


--  Query 2: Calculate total sales per customer SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_sales,
    AVG(o.total_amount) AS average_order_value,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_sales DESC;


--  Query 3: Filter data by date range and order status
SELECT 
    o.order_id,
    o.order_number,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    o.order_status,
    o.total_amount,
    p.payment_status
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
    AND o.order_status IN ('confirmed', 'processing', 'shipped', 'delivered')
ORDER BY o.order_date DESC;


--  Query 4: Use aggregate functions like SUM and COUNT
SELECT 
    o.order_status,
    COUNT(*) AS order_count,
    SUM(o.total_amount) AS total_revenue,
    AVG(o.total_amount) AS average_order_value,
    MIN(o.total_amount) AS min_order_value,
    MAX(o.total_amount) AS max_order_value
FROM orders o
GROUP BY o.order_status
ORDER BY total_revenue DESC;
