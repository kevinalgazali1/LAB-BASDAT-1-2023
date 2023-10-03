USE classicmodels;

-- 1

SELECT c.customerName AS 'Nama Customer', c.country AS 'Negara', p.paymentDate AS 'Tanggal'
FROM customers AS c
JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE paymentDate > '2004-12-31'
ORDER BY paymentDate;

-- 2

SELECT DISTINCT c.customerName AS 'Nama Customer', p.productName, pl.textDescription
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
JOIN productlines AS pl
USING (productLine)
WHERE productName = 'The Titanic';

-- 3

ALTER TABLE products ADD `status` VARCHAR (20);

SELECT * FROM products;
SELECT * FROM orderdetails;

-- productCode yang memiliki jumlah pesanan terbanyak ialah S12_4675

UPDATE products
SET `status` = 'Best Selling'
WHERE productCode = 'S12_4675';

SELECT p.productCode, p.productName, od.quantityOrdered, p.`status`
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
ORDER BY quantityOrdered DESC
LIMIT 1;

-- 4

SELECT DISTINCT `status`
FROM orders
WHERE `status` = 'cancelled';

ALTER TABLE orderDetails DROP FOREIGN KEY orderdetails_ibfk_1;
ALTER TABLE  orderDetails ADD FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber) ON DELETE CASCADE;

DELETE FROM orders
WHERE `status` = 'cancelled';

SELECT DISTINCT c.customerName, o.`status`
FROM customers AS c
JOIN orders AS o
USING (customerNumber);

-- soal tambahan

-- 1

SELECT c.customerName AS 'Nama Pelanggan', pl.productLine AS 'Jenis produk',
o.orderDate AS 'Tanggal Pemesanan', od.quantityOrdered AS 'Jumlah pesanan'
FROM customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
JOIN productlines AS pl
USING (productline)
WHERE p.productline = 'planes' AND od.quantityOrdered > 50
ORDER BY orderDate;

-- 2

SELECT e.firstName AS 'Nama depan karyawan', o.territory AS 'Teritorial', 
c.city, c.customerName AS 'Nama pelanggan', p.amount AS 'Jumlah Pembayaran'
FROM offices AS o
JOIN employees AS e
USING (officeCode)
JOIN customers AS c
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS p
USING (customerNumber)
WHERE territory = 'Japan' AND c.city != 'singapore'
ORDER BY amount DESC
LIMIT 3;

-- 3

SELECT DISTINCT p.productName AS 'Nama Produk'
FROM products AS p
JOIN orderdetails AS od
USING (productCode)
JOIN orders AS o
USING (orderNumber)
JOIN customers AS c
USING (customerNumber)
WHERE c.addressLine2 != 'NULL';

-- 4

SELECT DISTINCT c.customerName AS 'Nama Pelanggan', p.productName AS 'Nama produk', 
od.quantityOrdered AS 'Jumlah orderan'
FROM  customers AS c
JOIN orders AS o
USING (customerNumber)
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE productVendor = 'exoto designs' AND c.country != 'italy';

-- 5

SELECT o.orderDate AS 'tanggal pemesanan',o.shippedDate AS 'Tanggal pengiriman', p.productName AS 'Nama Produk'
FROM orders AS o
JOIN orderdetails AS od
USING (orderNumber)
JOIN products AS p
USING (productCode)
WHERE p.quantityInStock < 100 AND od.quantityOrdered < 50;