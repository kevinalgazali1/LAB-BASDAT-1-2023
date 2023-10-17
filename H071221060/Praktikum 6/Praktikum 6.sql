-- 1

SELECT CONCAT 
	(e.firstname, ' ', e.lastname) AS 'Nama employee',
	GROUP_CONCAT(o.ordernumber, '; ') AS 'Nomor orderan',
	COUNT(o.ordernumber) AS 'Jumlah pesanan'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o
USING (customernumber) 
GROUP BY c.salesRepEmployeeNumber
HAVING COUNT(o.orderNumber) > 10;

-- 2

SELECT 
	p.productCode, 
	p.productName, 
	p.quantityInStock, 
	o.orderDate
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
WHERE p.quantityInStock > 5000
GROUP BY productCode
ORDER BY o.orderDate ASC;

-- 3

SELECT 
	o.addressLine1 AS 'Alamat',
	CONCAT(LEFT(o.phone, LENGTH(o.phone) - 5), '* **') AS 'Nomor Telp',
	COUNT(DISTINCT e.employeeNumber) AS 'Jumlah karyawan',
	COUNT(DISTINCT c.customerNumber) AS 'Jumlah Pelanggan',
	ROUND(AVG(p.amount), 2) AS 'Rata rata penghasilan'
FROM offices o
LEFT JOIN employees e
USING (officeCode)
LEFT JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments p
USING (customerNumber)
GROUP BY o.phone;

-- 4

SELECT 
	c.customerName, 
	YEAR(o.orderDate) AS 'Tahun order',
	MONTH(o.orderDate) AS 'Bulan order', 
	COUNT(od.quantityOrdered) AS 'Jumlah pesanan',
	SUM(od.quantityOrdered * od.priceEach) AS 'Uang total penjualan'
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
JOIN customers c
USING (customerNumber)
WHERE YEAR(orderDate) = 2003
GROUP BY customerName, YEAR(o.orderDate), MONTH(o.orderDate);

-- soal tambahan

-- 1

SELECT c.customerName, COUNT(o.orderNumber) AS 'jumlah orderan', SUM(od.quantityOrdered) AS 'total orederan'
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
WHERE customerName LIKE ('D%')
GROUP BY customerName
HAVING SUM(od.quantityOrdered) > 500;

-- 2

SELECT p.productName AS 'nama produk', YEAR(o.orderDate) AS 'tahun', MONTH(o.orderDate) AS 'bulan',
DAY(o.orderDate) AS 'tanggal', SUM(od.quantityOrdered) AS 'total pesanan'
FROM products p
JOIN orderdetails od
USING (productCode)
JOIN orders o
USING (orderNumber)
WHERE p.productName LIKE ('19%') AND MONTH(o.orderDate) % 2 = 1
GROUP BY p.productName, YEAR(o.orderDate)
HAVING SUM(od.quantityOrdered) < 450;