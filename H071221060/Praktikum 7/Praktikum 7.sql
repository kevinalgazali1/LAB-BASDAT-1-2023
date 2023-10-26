-- 1

SELECT o.addressline1, o.addressline2, o.city, o.country, c.customerNumber, COUNT(p.amount)
FROM offices o
JOIN employees e
USING (officeCode)
JOIN customers c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments p
USING (customerNumber)
GROUP BY c.customerNumber
HAVING COUNT(p.amount) = 
			(
				SELECT COUNT(amount)
				FROM payments
				GROUP BY customerNumber
				ORDER BY COUNT(amount)
				LIMIT 1
			);
			
-- 2

SELECT CONCAT(e.firstname, ' ', e.lastname) AS 'Nama employee', SUM(p.amount) AS 'pendapatan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p 
USING (customerNumber)
GROUP BY e.employeeNumber
HAVING SUM(p.amount) =
							(
							SELECT MAX(amountTotal)
							FROM (SELECT SUM(amount) AS amountTotal
									FROM customers c
									JOIN payments p
									USING (customerNumber)
									GROUP BY c.salesRepEmployeeNumber
									) AS PalingTinggi)
OR SUM(p.amount) =
							(
							SELECT MIN(amountTotal)
							FROM (SELECT SUM(amount) AS amountTotal
									FROM customers c
									JOIN payments p
									USING (customerNumber)
									GROUP BY c.salesRepEmployeeNumber
									) AS PalingRendah);
									
-- 3

SELECT cl.`Language`
FROM country c
JOIN countrylanguage cl
ON c.Code = cl.CountryCode
WHERE c.Continent = 'Asia';

SELECT c.Name AS 'Negara', (c.Population * cl.Percentage) AS 'Pengguna Bahasa'
FROM country AS c
JOIN countrylanguage AS cl ON c.Code = cl.CountryCode
WHERE cl.Language = ( SELECT cl.Language
								FROM countrylanguage AS cl
								JOIN country AS c 
								ON cl.CountryCode = c.Code
								WHERE c.Continent = 'Asia'
								GROUP BY cl.Language
								ORDER BY COUNT(cl.Language) DESC
								LIMIT 1)
ORDER BY `Pengguna Bahasa` DESC ;

-- 4

SELECT ROUND(AVG(total), 2) 
FROM (SELECT SUM(amount) AS total
		FROM payments p
		JOIN customers c
		USING (customerNumber)
		GROUP BY c.customerNumber) AS apa;

SELECT c.customerName, SUM(p.amount), pr.quantityInStock, od.orderLineNumber
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
GROUP BY c.customerNumber
HAVING SUM(p.amount) > (SELECT ROUND(AVG(total), 2) 
								FROM (SELECT SUM(amount) AS total
								FROM payments
								GROUP BY customerNumber) AS apa)
ORDER BY SUM(p.amount) DESC;

-- soal tambahan

-- 1

SELECT ROUND(AVG(total), 2) 
FROM (SELECT SUM(amount) AS total
		FROM payments p
		GROUP BY p.customerNumber
		ORDER BY SUM(amount)) AS apa;
		
SELECT COUNT(quantityOrdered) 
FROM orderdetails
GROUP BY orderNumber;
		
SELECT c.customerName, COUNT(od.quantityOrdered), pr.productName, SUM(p.amount)
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
GROUP BY c.customerNumber
HAVING SUM(p.amount) < (SELECT ROUND(AVG(total)) 
								FROM (SELECT SUM(amount) AS total
								FROM payments p
								GROUP BY p.customerNumber
								ORDER BY SUM(amount)) AS apa);
								
-- 2

SELECT DISTINCT productName AS 'Nama Produk', LEFT(productName,4) AS 'Tahun Pembuatan', LENGTH(productName) AS 'Panjang Karakter'
FROM products
WHERE LENGTH(productName) > (SELECT MIN(LENGTH(productName)) * 3
										FROM products)
AND (LEFT(productName,4) LIKE ('19%') OR LEFT(productName,4) LIKE ('20%'));