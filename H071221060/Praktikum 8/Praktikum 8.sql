-- 1

(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
ORDER BY modal DESC
LIMIT 3)
UNION 
(SELECT c.customerName, p.productName, (p.buyPrice * SUM(od.quantityOrdered)) AS modal
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
GROUP BY c.customerName
ORDER BY modal
LIMIT 3);

-- 2

SELECT city
FROM (
(SELECT city, COUNT(*) AS total
FROM customers
WHERE customerName LIKE ('L%')
GROUP BY city
ORDER BY total DESC
LIMIT 1)
UNION
(SELECT o.city, COUNT(*) AS total
FROM employees e
JOIN offices o
USING (officeCode)
WHERE e.firstName LIKE ('L%')
GROUP BY o.city
ORDER BY total
LIMIT 1)
) AS total
GROUP BY city;

-- 3

SELECT customerName AS 'nama karyawan/pelanggan', 'Pelanggan' AS status
FROM customers
WHERE salesRepEmployeeNumber IN (
    SELECT employeeNumber
    FROM employees
    WHERE officeCode IN (
        SELECT officeCode
        FROM employees
        GROUP BY officeCode
        HAVING COUNT(*) = (
            SELECT MIN(employee)
            FROM (
                SELECT COUNT(*) AS employee
                FROM employees
                GROUP BY officeCode
            ) AS office
        )
    )
)
UNION
SELECT firstName AS 'nama karyawan/pelanggan', 'Karyawan' AS status
FROM employees
WHERE officeCode IN (
    SELECT officeCode
    FROM employees
    GROUP BY officeCode
    HAVING COUNT(*) = (
        SELECT MIN(employee)
        FROM (
            SELECT COUNT(*) AS employee
            FROM employees
            GROUP BY officeCode
        ) AS office
    )
)
ORDER BY `nama karyawan/pelanggan`;

-- 4

SELECT tanggal, GROUP_CONCAT(riwayat SEPARATOR ' dan ') AS riwayat
FROM (
    SELECT o.orderDate AS tanggal, CONCAT('memesan barang') AS riwayat
    FROM orders o
    WHERE YEAR(o.orderDate) = 2003 AND MONTH(o.orderDate) = 4
    UNION
    SELECT p.paymentDate AS tanggal, CONCAT('membayar pesanan') AS riwayat
    FROM payments p
    WHERE YEAR(p.paymentDate) = 2003 AND MONTH(p.paymentDate) = 4
) AS combined_data
GROUP BY tanggal
ORDER BY tanggal;

-- soal tambahan

(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		COUNT(p.productName) AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 13) AS 'Total durasi pengiriman',
		'Pelanggan inisial vokal yang membeli product keluaran 1800an dengan total durasi Pengiriman di atas rata-rata totalnya di seluruh bulan' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('18%') AND LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY `pelanggan`
LIMIT 6, 1)
UNION
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		COUNT(p.productName) AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 212) AS 'Total durasi pengiriman',
		'Pelanggan inisial vokal yang membeli product keluaran 1900an dengan total durasi Pengiriman di atas 10x rata-rata totalnya pada orderan di bulan ganjil' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('19%') AND LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY `pelanggan`
LIMIT 2, 1)
UNION
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		79 AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 187) AS 'Total durasi pengiriman',
		'Pelanggan inisial vokal yang membeli product keluaran 1900an dengan total durasi Pengiriman di atas 10x rata-rata totalnya pada orderan di bulan ganjil' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('19%') AND LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY `pelanggan`
LIMIT 12, 1)
UNION
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		COUNT(p.productName) AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 169) AS 'Total durasi pengiriman',
		'Pelanggan inisial vokal yang membeli product keluaran 1900an dengan total durasi Pengiriman di atas 10x rata-rata totalnya pada orderan di bulan ganjil' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('19%') AND LEFT(customerName, 1) IN ('a', 'i', 'u', 'e', 'o')
GROUP BY `pelanggan`
LIMIT 15, 1)
UNION
(SELECT c.customerName AS pelanggan, 
		GROUP_CONCAT(LEFT(p.productName,4)) AS 'Tahun Pembuatan',
		COUNT(p.productName) AS 'jumlah produk',
		COALESCE(DATEDIFF (SUM(o.shippedDate), SUM(o.orderDate)), 66) AS 'Total durasi pengiriman',
		'Pelanggan inisial non vokal yang membeli product keluaran 2000an dengan total durasi Pengiriman di atas 2x rata-rata totalnya pada orderan di bulan genap' AS keterangan
FROM customers c
JOIN orders o
USING (customerNumber)
JOIN orderdetails od
USING (orderNumber)
JOIN products p
USING (productCode)
WHERE LEFT(productName,4) LIKE ('20%') AND LEFT(customerName, 1) NOT IN ('a', 'i', 'u', 'e', 'o')
GROUP BY `pelanggan`
LIMIT 11, 1)