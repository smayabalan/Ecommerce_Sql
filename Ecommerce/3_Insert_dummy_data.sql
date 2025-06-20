
--  Insert sample customers
INSERT INTO customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '123 Main St', 'New York', 'NY', '10001') ,
('Sarah', 'Johnson', 'sarah.johnson@email.com', '555-0102', '456 Oak Ave', 'Los 
Angeles', 'CA', '90001') ,
('Michael', 'Brown', 'michael.brown@email.com', '555-0103', '789 Pine Rd', 'Chicago', 'IL', '60601') ,
('Emily', 'Davis', 'emily.davis@email.com', '555-0104', '321 Elm St', 'Houston', 'TX', '77001') ,
('David', 'Wilson', 'david.wilson@email.com', '555-0105', '654 Maple Dr', 'Phoenix', 'AZ', '85001') ;


--  Insert sample products
INSERT INTO products (product_name, product_code, description, category, brand, price, cost, stock_quantity) VALUES
('Wireless Bluetooth Headphones', 'WBH-001', 'High-quality wireless headphones with noise cancellation', 'Electronics', 'TechBrand', 199.99, 120.00, 50),
('Smartphone Case', 'SPC-001', 'Protective case for smartphones', 'Accessories', 
'CasePro', 29.99, 15.00, 200), ('Laptop Stand', 'LPS-001', 'Adjustable aluminum laptop stand', 'Electronics', 
'DeskTech', 79.99, 45.00, 75),
 
('Coffee Mug Set', 'CMS-001', 'Set of 4 ceramic coffee mugs', 'Home & Kitchen', 'HomeStyle', 39.99, 20.00, 100),
('Fitness Tracker', 'FIT-001', 'Advanced fitness tracking device', 'Electronics', 
'FitTech', 149.99, 90.00, 30);


--  Insert sample orders
INSERT INTO orders (customer_id, order_number, subtotal, tax_amount, shipping_cost, total_amount, order_status) VALUES
(1, 'ORD-2024-001', 229.98, 18.40, 9.99, 258.37, 'delivered') ,
(2, 'ORD-2024-002', 79.99, 6.40, 7.99, 94.38, 'shipped') ,
(3, 'ORD-2024-003', 149.99, 12.00, 5.99, 167.98, 'processing') ,
(4, 'ORD-2024-004', 69.98, 5.60, 8.99, 84.57, 'confirmed') , (5, 'ORD-2024-005', 199.99, 16.00, 9.99, 225.98, 'pending') ;


--  Insert sample order details
INSERT INTO order_details (order_id, product_id, quantity, unit_price, line_total) VALUES
(1 , 1, 1, 199.99, 199.99),
(1 , 2, 1, 29.99, 29.99),
(2 , 3, 1, 79.99, 79.99),
(3 , 5, 1, 149.99, 149.99),
(4 , 4, 1, 39.99, 39.99),
(4 , 2, 1, 29.99, 29.99),
(5 , 1, 1, 199.99, 199.99);


--  Insert sample payments
INSERT INTO payments (order_id, payment_number, payment_method, amount, payment_status, transaction_id) VALUES
(1, 'PAY-2024-001', 'credit_card', 258.37, 'completed', 'TXN-ABC123') ,
(2, 'PAY-2024-002', 'paypal', 94.38, 'completed', 'TXN-DEF456') ,
(3, 'PAY-2024-003', 'credit_card', 167.98, 'processing', 'TXN-GHI789') ,
(4, 'PAY-2024-004', 'debit_card', 84.57, 'completed', 'TXN-JKL012') ,
(5, 'PAY-2024-005', 'credit_card', 225.98, 'pending', 'TXN-MNO345') ;
