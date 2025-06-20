--  View 1: Customer Summary View
CREATE VIEW customer_summary AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    c.city,
    c.state,
    c.status AS customer_status,
    c.date_created AS customer_since,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS lifetime_value, COALESCE(AVG(o.total_amount), 0) AS avg_order_value,
    MAX(o.order_date) AS last_order_date,
    DATEDIFF(CURDATE(), MAX(o.order_date)) AS days_since_last_order
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email, c.city, c.state, c.status, c.date_created;


--  View 2: Order Details Summary View CREATE VIEW order_summary AS
SELECT 
    o.order_id,
    o.order_number,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email AS customer_email,
    o.order_date,
    o.order_status,
    o.total_amount,
    COUNT(od.order_detail_id) AS line_items,     SUM(od.quantity) AS total_items,
    p.payment_status,
    p.payment_method,
    DATEDIFF(CURDATE(), o.order_date) AS days_old
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY o.order_id, o.order_number, c.first_name, c.last_name, c.email,
         o.order_date, o.order_status, o.total_amount, p.payment_status, p.payment_method;



--  Query customer summary view
SELECT * FROM customer_summary 
WHERE customer_status = 'active' 
ORDER BY lifetime_value DESC 
LIMIT 10;


--  Query order summary view for pending orders
SELECT * FROM order_summary 
WHERE order_status = 'pending' 
ORDER BY days_old DESC;
