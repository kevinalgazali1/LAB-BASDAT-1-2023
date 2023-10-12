USE classicmodels

-- 1

SELECT c.customerName, p.productName, pa.paymentDate, o.`status`
FROM payments pa
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE p.productName LIKE '%Ferrari%' AND o.`status` = 'shipped'
AND c.customerName LIKE 'Signal%';

-- 2

-- a

SELECT c.customerName, p.paymentDate, CONCAT (e.firstName, e.lastName) AS 'Nama karyawan', p.amount
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (p.paymentDate) = 11;

-- b

SELECT c.customerName, p.paymentDate, CONCAT (e.firstName, e.lastName) AS 'Nama karyawan', p.amount
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE MONTH (p.paymentDate) = 11
ORDER BY p.amount DESC
LIMIT 1;

-- c

SELECT c.customerName, pr.productName
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
WHERE MONTH (p.paymentDate) = 11 AND customerName LIKE ('Corporate%');

-- d

SELECT c.customerName, GROUP_CONCAT(pr.productName) AS 'Nama Produk'
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products pr
USING (productCode)
WHERE MONTH (p.paymentDate) = 11 AND customerName LIKE ('Corporate%');

-- 3

SELECT c.customerName, o.orderDate, o.shippedDate, DATEDIFF (o.shippedDate, o.orderDate) AS 'Lama Hari'
FROM customers c
JOIN orders o
USING (customerNumber)
WHERE customerName LIKE ('GiftsFor%') AND o.orderDate <> 'NULL' AND o.shippedDate <> 'NULL';

-- 4

USE world

SELECT * FROM country

SELECT `code`, `name`, lifeExpectancy
FROM country
WHERE `code` LIKE ('C%K') AND lifeExpectancy <> 'NULL';

-- soal tambahan

-- 1

SELECT * FROM products;
SELECT * FROM orderdetails;
SELECT * FROM orders;
SELECT c.customerNumber AS 'Nama Pelanggan', c.country AS 'Negara', CONCAT (firstName, ' ', lastName) AS 'Nama Lengkap Karyawan'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE country NOT RLIKE '^[aeiouAEIOU]';

-- 2

SELECT p.productName AS 'Nama Produk', YEAR(o.orderDate) AS 'Tahun', MONTH(o.orderDate) AS 'Bulan', DAY(o.orderDate) AS 'Hari'
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
WHERE productName LIKE ('200%') 
AND MONTH (o.orderDate) % 2 = 0;

-- 3

SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM offices;

SELECT c.customerName AS 'Nama Pelanggan', c.addressLine2 'Alamat Kedua Pelanggan', CONCAT (e.firstName, ' ', e.lastName) AS  'Nama Lengkap Karyawan', o.addressLine2 AS 'Alamat Kedua Karyawan'
FROM customers c
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o
USING (officeCode)
WHERE c.addressLine2 IS NULL AND o.addressLine2 IS NULL;

-- 4

SELECT * FROM customers;
SELECT * FROM payments;
SELECT * FROM orders;

SELECT c.customerName AS 'Nama Pelanggan', o.comments AS 'Komentar', p.amount AS 'Pembayaran'
FROM payments p
JOIN customers c
USING (customerNumber)
JOIN orders o
USING (customerNumber)
WHERE amount > 80000 
AND comments IS NOT NULL 
AND LEFT (customerName, 1) IN ('A', 'I', 'U', 'E', 'O');