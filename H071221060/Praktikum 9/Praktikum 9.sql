-- 1

SELECT * FROM products
WHERE productName LIKE '1%' OR productName LIKE '2%';

SELECT YEAR(o.orderDate) AS tahun, COUNT(o.orderNumber) AS 'jumlah pesanan',
case 
when COUNT(o.orderNumber) > 150 then 'banyak'
when COUNT(o.orderNumber) < 75 then 'sedikit'
ELSE 'sedang'
END AS 'Kategori'
FROM orders o
GROUP BY YEAR(o.orderDate)
ORDER BY `jumlah pesanan` DESC;

-- 2

SELECT 
	CONCAT(e.firstName, ' ', e.lastName) AS 'nama pegawai',
	SUM(p.amount) AS 'gaji',
case
when SUM(p.amount) > (SELECT AVG(total)
							FROM (SELECT SUM(p.amount) AS total
							FROM payments p
							JOIN customers c
							USING(customerNumber)
							JOIN employees e
							ON e.employeeNumber = c.salesRepEmployeeNumber
							GROUP BY e.employeeNumber
							) AS apa) then 'di atas rata'
ELSE 'di bawah rata'
END AS 'kategori gaji'
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p
USING(customerNumber)
GROUP BY e.employeeNumber
ORDER BY `gaji` DESC;

-- 3

(SELECT c.customerName AS 'Pelanggan', 
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ',') AS 'Tahun Pembuatan', 
			 COUNT(p.productCode) AS 'Jumlah Produk', 
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)) AS 'Total Durasi Pengiriman',
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > 
					(SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) 
					AS 'total' FROM orders GROUP BY customerNumber) a)
					then 'Target 1'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					SUM(DATEDIFF(o.shippedDate, o.orderDate)) > 
					(SELECT AVG(total) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) 
					AS 'total' FROM orders GROUP BY customerNumber) a)
					then 'Target 2'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '18%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL) 
UNION 	 
(SELECT c.customerName,
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
			 COUNT(p.productCode),
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)),
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 
					FROM (	SELECT COUNT(productName) 
					AS total FROM products GROUP BY productCode ) a)
					then 'Target 3'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT AVG(total) * 10 
					FROM (	SELECT COUNT(productName) 
					AS total FROM products GROUP BY productCode ) a)
					then 'Target 4'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '19%'	
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
UNION 	
(SELECT c.customerName,
			 GROUP_CONCAT(LEFT(p.productName, 4) SEPARATOR ','), 
			 COUNT(p.productCode),
			 SUM(DATEDIFF(o.shippedDate, o.orderDate)),
			 case 
			 when MONTH(o.orderDate) % 2 = 1 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 
					FROM (SELECT COUNT(productName) 
					AS total FROM products GROUP BY productCode ) a)
					then 'Target 5'
			 when MONTH(o.orderDate) % 2 = 0 AND 
					COUNT(p.productCode) > (SELECT MIN(total) * 3 
					FROM (SELECT COUNT(productName) 
					AS total FROM products GROUP BY productCode ) a)
					then 'Target 6'
			END 'keterangan'
	FROM customers AS c
	JOIN orders AS o USING (customerNumber)
	JOIN orderdetails AS od USING (orderNumber)
	JOIN products AS p USING (productCode)
	WHERE p.productName LIKE '20%'
	GROUP BY c.customerNumber
	HAVING `keterangan` IS NOT NULL)
ORDER BY `keterangan`;