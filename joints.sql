SELECT *
FROM clients;

SELECT *
FROM invoices;

SELECT *
FROM payments;

SELECT *
FROM payment_methods;

DESCRIBE clients; 
DESCRIBE invoices;
DESCRIBE payments;
DESCRIBE payment_methods;

-- count invoices per client 
SELECT client_id, COUNT(*) AS total_invoices 
FROM invoices 
GROUP BY client_id;

-- total amount invoiced per client 
SELECT client_id, SUM(invoice_total) AS total_invoiced 
FROM invoices 
GROUP BY client_id;

-- Counts of payments per method
SELECT pm.name,
	p.payment_method, COUNT(*) AS num_payments
FROM payments p
JOIN payment_methods pm
    ON p.payment_method = pm.payment_method_id
GROUP BY p.payment_method;

-- combining tables 
-- how much each client has paid 
SELECT 
    c.client_id,
    c.name,
    SUM(p.amount) AS total_paid
FROM clients c
JOIN invoices i
    ON c.client_id = i.client_id
JOIN payments p
    ON i.invoice_id = p.invoice_id
GROUP BY c.client_id, c.name
ORDER BY total_paid DESC;
	
-- who has uppaid invoices and how many
SELECT 
	c.client_id,
    c.name,
    COUNT(i.invoice_id) AS unpaid_invoices
FROM clients c
JOIN invoices i
	ON c.client_id = i.client_id
LEFT JOIN payments p
	ON i.invoice_id = p.invoice_id
WHERE i.payment_date IS NULL
GROUP BY c.client_id, c.name
ORDER BY unpaid_invoices;

-- OR

SELECT 
	c.client_id,
    c.name,
    SUM(
		CASE
			WHEN i.payment_date IS NULL THEN 1
			ELSE 0
		END
	) AS unpaid_invoices
FROM clients c 
JOIN invoices i
	ON c.client_id = i.client_id
GROUP BY c.client_id, c.name
ORDER BY unpaid_invoices;

-- paid and unpaid invoices
SELECT
	i.client_id,
    i.invoice_id,
    c.name,
    pm.name,
    CASE
		WHEN i.payment_date IS NOT NULL THEN "paid"
        ELSE "not paid"
	END AS payment_status 
FROM invoices i
LEFT JOIN payments p
	ON i.invoice_id = p.invoice_id
LEFT JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
JOIN clients c
	ON c.client_id = i.client_id
ORDER BY i.client_id;




-- Which client has the highest total unpaid amount?




-- What is the most popular payment method?
-- Which month has the most payments?
-- Average payment delay (invoice date → payment date) per client.





SELECT *
FROM clients AS c
JOIN invoices AS i 
	ON c.client_id = i.client_id;
    -- ORDER BY invoices.invoice_id
    
-- selecting the actual columns 
SELECT i.payment_date, i.client_id, i.payment_total, i.invoice_total
FROM payments AS p
JOIN invoices AS i 
	ON p.invoice_id = i.invoice_id
    ORDER BY i.client_id;
    
SELECT *
FROM payments AS p
RIGHT JOIN invoices AS i
	ON p.invoice_id = i.invoice_id
    ORDER BY i.client_id;
    
-- Self join more like matching content on the same table 

-- joining multiple tables
SELECT i.invoice_id,
	p.date,
	pm.name
FROM payments AS p
JOIN invoices AS i 
	ON p.invoice_id = i.invoice_id
JOIN payment_methods AS pm
	ON p.payment_method = pm.payment_method_id;
    
-- unions allows you to combine rows together 

SELECT 
	i.client_id,
    i.invoice_id,
    i.number,
    "paid" As payment_status
FROM invoices i
JOIN payments p
	ON i.invoice_id = p.invoice_id
WHERE i.payment_date IS NOT NULL
UNION
SELECT 
	i.client_id,
    i.invoice_id,
	i.number,
    "not paid" As payment_status
FROM invoices i
LEFT JOIN payments p
	ON i.invoice_id = p.invoice_id
WHERE i.payment_date IS NULL
ORDER BY client_id;

-- string function mostlt used when cleaning and standardising data 
-- case statement

-- this siplify the long union statement above 


	








