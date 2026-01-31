SELECT *
FROM clients;

SELECT *
FROM invoices;

SELECT *
FROM payments;

SELECT *
FROM payment_methods;

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



