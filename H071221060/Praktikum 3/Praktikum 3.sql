CREATE DATABASE praktikum3;

USE praktikum3;

-- 1

CREATE TABLE Mahasiswa (
NIM VARCHAR (10) PRIMARY KEY,
Nama VARCHAR (50) NOT NULL,
Kelas CHAR (1) NOT NULL,
`status` VARCHAR (50) NOT NULL,
Nilai INT (11)
);

INSERT INTO mahasiswa
VALUES 
		('H071241056', 'Kotlina', 'A', 'hadir', 100),
		('H071241060', 'Pitonia', 'A', 'alfa', 85),
		('H071241063', 'Javano', 'A', 'hadir', 50),
		('H071241065', 'Ciplus Kuadra', 'B', 'hadir', 65),
		('H071241066', 'Pihap E', 'B', 'hadir', 85),
		('H071241079', 'Ruby', 'B', 'alfa', 90);
		
SELECT * FROM mahasiswa;

-- 2

UPDATE mahasiswa
SET nilai = 0, Kelas = 'C'
WHERE `status` = 'alfa';

-- 3

DELETE FROM mahasiswa
WHERE Kelas = 'A' AND nilai > 90;

-- 4

INSERT INTO mahasiswa
VALUES ('H071221060', 'Kevin', 'B', 'pindahan', NULL);

UPDATE mahasiswa
SET nilai = 50
WHERE `status` = 'alfa';

UPDATE mahasiswa
SET Kelas = 'A';

-- 5

CREATE TABLE buku1 (
ID_buku INT PRIMARY KEY,
judul VARCHAR (50) NOT NULL,
pengarang VARCHAR (50),
tahun_terbit VARCHAR (50),
`status` VARCHAR (50) NOT NULL
);

INSERT INTO buku1 (ID_buku, judul, pengarang, tahun_terbit, `status`)
VALUES 
		(1, 'Buku web', 'penulis A', 2020, 'tersedia'),
		(2, 'Buku basdat', NULL, 2019, 'tersedia'),
		(3, 'Buku matdas', 'penulis C', NULL, 'dipinjam');

INSERT INTO buku1 (ID_buku, pengarang, tahun_terbit)
VALUES 
		(4, 'penulis D', 2020);
		
SELECT * FROM buku1;

CREATE TABLE pinjam (
ID_pinjam INT PRIMARY KEY,
NIM_mahasiswa VARCHAR (50),
ID_buku INT,
tanggal_pinjam VARCHAR (50) NOT NULL,
tanggal_kembali VARCHAR (50) NOT NULL,
FOREIGN KEY (NIM_mahasiswa) REFERENCES Mahasiswa (NIM),
FOREIGN KEY (ID_Buku) REFERENCES buku1 (ID_buku)
);

INSERT INTO pinjam
VALUES 
		(1, 'H071241060', 3, '2023-09-15', '2023-09-30'),
		(2, 'H071241079', 1, '2023-09-12', '2023-09-28'),
		(3, 'H071221060', 2, '2023-09-14', '2023-09-29');

SELECT * FROM pinjam;