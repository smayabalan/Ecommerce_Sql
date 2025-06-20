
--  Daily Sales Report Query
SELECT 
    DATE(o.order_date) AS sale_date,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    SUM(o.subtotal) AS gross_sales,
    SUM(o.tax_amount) AS total_tax,
    SUM(o.shipping_cost) AS total_shipping,
    SUM(o.discount_amount) AS total_discounts,
    SUM(o.total_amount) AS net_sales,
    AVG(o.total_amount) AS avg_order_value
FROM orders o
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    AND o.order_status NOT IN ('cancelled', 'returned')
GROUP BY DATE( o.order_date )
ORDER BY sale_date DESC;


--  Monthly Sales Summary Report SELECT 
    YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    MONTHNAME(o.order_date) AS month_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    SUM(o.total_amount) AS total_revenue,
    AVG(o.total_amount) AS avg_order_value,
    SUM(CASE WHEN o.order_status = 'delivered' THEN o.total_amount ELSE 0 END) AS delivered_revenue, ROUND(
        SUM(CASE WHEN o.order_status = 'delivered' THEN o.total_amount ELSE 0 END) / 
        SUM( o.total_amount) * 100,  2
    ) AS delivery_rate_percent
FROM orders o
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY YEAR(o.order_date), MONTH( o.order_date), MONTHNAME(o.order_date )
ORDER BY year DESC, month DESC;
