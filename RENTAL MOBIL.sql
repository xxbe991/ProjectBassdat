CREATE TABLE Mobil (
	plat_nomor VARCHAR (10) PRIMARY KEY,
	merk VARCHAR (50),
	model VARCHAR(50),
	harga_sewa BIGINT,
	tahun_keluar BIGINT,
	tempat_duduk BIGINT,
	status_rental VARCHAR(50)
);

CREATE TABLE Pelanggan (
	id_pelanggan VARCHAR (3) PRIMARY KEY,
	nama VARCHAR (50),
	NIK BIGINT,
	alamat VARCHAR(50),
	no_telepon VARCHAR(20),
	email VARCHAR (50),
	pekerjaan VARCHAR (50)
);

CREATE TABLE Karyawan (
	id_karyawan VARCHAR (20) PRIMARY KEY,
	nama VARCHAR(50),
	NIK BIGINT,
	no_telepon VARCHAR(20),
	no_rekening BIGINT,
	gaji BIGINT,
	email VARCHAR(50),
	alamat VARCHAR(50),
	jabatan VARCHAR(50)
);

CREATE TABLE Pemesanan (
    id_pemesanan VARCHAR(10) PRIMARY KEY,
    id_pelanggan VARCHAR(3),
    id_mobil VARCHAR (10),
	tanggal_pemesanan DATE,
	tanggal_peminjaman DATE,
    tanggal_pengembalian DATE,
	opsi_supir VARCHAR(20),
	id_supir VARCHAR(20),
	harga_supir_perhari BIGINT,
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan),
    FOREIGN KEY (id_mobil) REFERENCES Mobil(plat_nomor),
	FOREIGN KEY (id_supir) REFERENCES Karyawan(id_karyawan)
);

CREATE TABLE Pembayaran (
	id_pembayaran VARCHAR (20) PRIMARY KEY,
	id_pemesanan VARCHAR (10),
	tanggal_pembayaran DATE,
	id_kasir VARCHAR (20),
	total_pembayaran BIGINT,
	FOREIGN KEY (id_pemesanan) REFERENCES Pemesanan (id_pemesanan),
	FOREIGN KEY (id_kasir) REFERENCES Karyawan (id_karyawan)
);

INSERT INTO Mobil VALUES
('B1234XYZ', 'Toyota', 'Avanza', 500000, 2019, 7, 'Tidak Tersedia'),
('B5678XYZ', 'Honda', 'Brio', 400000, 2020, 5, 'Tidak Tersedia'),
('B9012XYZ', 'Suzuki', 'Ertiga', 450000, 2018, 7, 'Tidak Tersedia'),
('B3456XYZ', 'Daihatsu', 'Xenia', 500000, 2021, 7, 'Tidak Tersedia'),
('B7890XYZ', 'Mitsubishi', 'Pajero', 1000000, 2022, 7, 'Tidak Tersedia'),
('B2468XYZ', 'Toyota', 'Fortuner', 800000, 2021, 7, 'Tidak Tersedia'),
('B1357XYZ', 'Honda', 'CRV', 750000, 2019, 7, 'Tidak Tersedia'),
('B8642XYZ', 'Suzuki', 'Ignis', 350000, 2020, 5, 'Tidak Tersedia'),
('B9753XYZ', 'Toyota', 'Kijang Innova', 600000, 2021, 7, 'Tidak Tersedia'),
('B3141XYZ', 'Mitsubishi', 'Xpander', 550000, 2021, 7, 'Tidak Tersedia'),
('B1122XYZ', 'Honda', 'Mobilio', 500000, 2018, 7, 'Tidak Tersedia'),
('B3344XYZ', 'Nissan', 'Livina', 400000, 2019, 7, 'Tidak Tersedia'),
('B5566XYZ', 'Daihatsu', 'Gran Max', 450000, 2020, 8, 'Tidak Tersedia'),
('B7788XYZ', 'Suzuki', 'Baleno', 480000, 2022, 5, 'Tidak Tersedia'),
('B9900XYZ', 'Toyota', 'Yaris', 550000, 2021, 5, 'Tidak Tersedia'),
('B4455XYZ', 'Toyota', 'Corolla', 650000, 2020, 5, 'Tersedia'),
('B5567XYZ', 'Honda', 'Jazz', 500000, 2021, 5, 'Tersedia'),
('B7789XYZ', 'Suzuki', 'Swift', 450000, 2022, 5, 'Tersedia');

INSERT INTO Pelanggan VALUES
('P01', 'Aulia Rahman', 320123456789012, 'Jl. Mawar', '081234567890', 'aulia@gmail.com', 'Pegawai'),
('P02', 'Dina Anggraini', 321234567890123, 'Jl. Melati', '081345678901', 'dina@gmail.com', 'Mahasiswa'),
('P03', 'Rizky Pratama', 322345678901234, 'Jl. Dahlia', '081456789012', 'rizky@gmail.com', 'Freelancer'),
('P04', 'Intan Permata', 323456789012345, 'Jl. Cempaka', '081567890123', 'intan@gmail.com', 'Wiraswasta'),
('P05', 'Yusuf Santoso', 324567890123456, 'Jl. Anggrek', '081678901234', 'yusuf@gmail.com', 'Pegawai'),
('P06', 'Nadia Putri', 325678901234567, 'Jl. Bougenville', '081789012345', 'nadia@gmail.com', 'Mahasiswa'),
('P07', 'Andi Saputra', 326789012345678, 'Jl. Kenanga', '081890123456', 'andi@gmail.com', 'Pengusaha'),
('P08', 'Fitri Sari', 327890123456789, 'Jl. Teratai', '081901234567', 'fitri@gmail.com', 'Pegawai'),
('P09', 'Hendra Gunawan', 328901234567890, 'Jl. Flamboyan', '082012345678', 'hendra@gmail.com', 'Freelancer'),
('P10', 'Lia Hartini', 329012345678901, 'Jl. Tanjung', '082123456789', 'lia@gmail.com', 'Wiraswasta'),
('P11', 'Fadli Ahmad', 330123456789012, 'Jl. Pinus', '082234567890', 'fadli@gmail.com', 'PNS'),
('P12', 'Anisa Dewi', 331234567890123, 'Jl. Cemara', '082345678901', 'anisa@gmail.com', 'Guru'),
('P13', 'Siska Lestari', 332345678901234, 'Jl. Bambu', '082456789012', 'siska@gmail.com', 'Dokter'),
('P14', 'Budi Cahyono', 333456789012345, 'Jl. Merpati', '082567890123', 'budi@gmail.com', 'Pegawai'),
('P15', 'Ayu Lestari', 334567890123456, 'Jl. Elang', '082678901234', 'ayu@gmail.com', 'Mahasiswa');

INSERT INTO Karyawan VALUES
('K001', 'Rama Santoso', 340123456789012, '081234567890', 123456789012345, 7000000, 'rama@example.com', 'Jl. Jati', 'Manajer'),
('K002', 'Siti Aminah', 341234567890123, '081345678901', 234567890123456, 4000000, 'siti@example.com', 'Jl. Bambu', 'Kasir'),
('K003', 'Andri Wijaya', 342345678901234, '081456789012', 345678901234567, 4500000, 'andri@example.com', 'Jl. Melati', 'Supir'),
('K004', 'Hendra Pratama', 343456789012345, '081567890123', 456789012345678, 4500000, 'hendra@example.com', 'Jl. Dahlia', 'Supir'),
('K005', 'Dewi Hartati', 344567890123456, '081678901234', 567890123456789, 4000000, 'dewi@example.com', 'Jl. Cemara', 'Administrasi'),
('K006', 'Rina Puspita', 345678901234567, '081789012345', 678901234567890, 4000000, 'rina@example.com', 'Jl. Mawar', 'Teknisi'),
('K007', 'Yudi Permana', 346789012345678, '081890123456', 789012345678901, 4500000, 'yudi@example.com', 'Jl. Anggrek', 'Supir'),
('K008', 'Mira Safitri', 347890123456789, '081901234567', 890123456789012, 4000000, 'mira@example.com', 'Jl. Cempaka', 'Customer Service'),
('K009', 'Adi Nugraha', 348901234567890, '082012345678', 901234567890123, 4500000, 'adi@example.com', 'Jl. Tanjung', 'Supir'),
('K010', 'Lina Sari', 349012345678901, '082123456789', 123456789012346, 4000000, 'lina@example.com', 'Jl. Pinus', 'Teknisi'),
('K011', 'Fikri Rahmat', 350123456789012, '082234567890', 234567890123457, 4500000, 'fikri@example.com', 'Jl. Jati', 'Supir'),
('K012', 'Winda Ayu', 351234567890123, '082345678901', 345678901234568, 4000000, 'winda@example.com', 'Jl. Flamboyan', 'Kasir'),
('K013', 'Samsul Huda', 352345678901234, '082456789012', 456789012345679, 4500000, 'samsul@example.com', 'Jl. Kenanga', 'Supir'),
('K014', 'Novi Handayani', 353456789012345, '082567890123', 567890123456780, 4000000, 'novi@example.com', 'Jl. Bougenville', 'Marketing'),
('K015', 'Anton Priyanto', 354567890123456, '082678901234', 678901234567891, 4500000, 'anton@example.com', 'Jl. Teratai', 'Supir');

INSERT INTO Pemesanan VALUES
('PSN001', 'P01', 'B1234XYZ', '2024-11-20', '2024-11-21', '2024-11-25', 'Ya', 'K003', 200000),
('PSN002', 'P02', 'B5678XYZ', '2024-11-21', '2024-11-22', '2024-11-26', 'Tidak', NULL, NULL),
('PSN003', 'P03', 'B9012XYZ', '2024-11-22', '2024-11-23', '2024-11-28', 'Ya', 'K004', 200000),
('PSN004', 'P04', 'B3456XYZ', '2024-11-23', '2024-11-24', '2024-11-29', 'Ya', 'K007', 200000),
('PSN005', 'P05', 'B7890XYZ', '2024-11-24', '2024-11-25', '2024-11-30', 'Tidak', NULL, NULL),
('PSN006', 'P06', 'B2468XYZ', '2024-11-25', '2024-11-26', '2024-12-01', 'Ya', 'K009', 200000),
('PSN007', 'P07', 'B1357XYZ', '2024-11-26', '2024-11-27', '2024-12-02', 'Tidak', NULL, NULL),
('PSN008', 'P08', 'B8642XYZ', '2024-11-27', '2024-11-28', '2024-12-03', 'Ya', 'K011', 200000),
('PSN009', 'P09', 'B9753XYZ', '2024-11-28', '2024-11-29', '2024-12-04', 'Tidak', NULL, NULL),
('PSN010', 'P10', 'B3141XYZ', '2024-11-29', '2024-11-30', '2024-12-05', 'Ya', 'K003', 200000),
('PSN011', 'P11', 'B1122XYZ', '2024-11-30', '2024-12-01', '2024-12-06', 'Tidak', NULL, NULL),
('PSN012', 'P12', 'B3344XYZ', '2024-12-01', '2024-12-02', '2024-12-07', 'Ya', 'K004', 200000),
('PSN013', 'P13', 'B5566XYZ', '2024-12-02', '2024-12-03', '2024-12-08', 'Tidak', NULL, NULL),
('PSN014', 'P14', 'B7788XYZ', '2024-12-03', '2024-12-04', '2024-12-09', 'Ya', 'K007', 200000),
('PSN015', 'P15', 'B9900XYZ', '2024-12-04', '2024-12-05', '2024-12-10', 'Tidak', NULL, NULL);

INSERT INTO Pembayaran VALUES
('PB001', 'PSN001', '2024-11-28', 'K002', 3500000),
('PB002', 'PSN002', '2024-11-28', 'K012', 2000000),
('PB003', 'PSN003', '2024-11-28', 'K012', 3250000),
('PB004', 'PSN004', '2024-11-28', 'K012', 3500000),
('PB005', 'PSN005', '2024-11-28', 'K012', 5000000),
('PB006', 'PSN006', '2024-11-28', 'K012', 5000000),
('PB007', 'PSN007', '2024-11-28', 'K002', 3750000),
('PB008', 'PSN008', '2024-11-28', 'K012', 2750000),
('PB009', 'PSN009', '2024-11-28', 'K012', 3000000),
('PB010', 'PSN010', '2024-11-28', 'K002', 3750000),
('PB011', 'PSN011', '2024-11-28', 'K012', 2500000),
('PB012', 'PSN012', '2024-11-28', 'K002', 3000000),
('PB013', 'PSN013', '2024-11-28', 'K012', 2250000),
('PB014', 'PSN014', '2024-11-28', 'K012', 3400000),
('PB015', 'PSN015', '2024-11-28', 'K012', 2750000);





