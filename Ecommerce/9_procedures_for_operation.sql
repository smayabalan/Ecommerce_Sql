--  Stored procedure to get customer order history
DELIMITER //
CREATE PROCEDURE GetCustomerOrderHistory(IN customer_id_param INT)
BEGIN     SELECT 
        o.order_id,
        o.order_number,
        o.order_date,
        o.order_status,
        o.total_amount,
        GROUP_CONCAT(
            CONCAT(p.product_name, ' (', od.quantity, ')')
            SEPARATOR ', '
        ) AS products
    FROM orders o
    INNER JOIN order_details od ON o.order_id = od.order_id
    INNER JOIN products p ON od.product_id = p.product_id
    WHERE o.customer_id = customer_id_param     GROUP BY o.order_id, o.order_number, o.order_date, o.order_status, o.total_amount ORDER BY o.order_date DESC;
END //
DELIMITER ;
