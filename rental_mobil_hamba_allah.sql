-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 19, 2023 at 12:49 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rental mobil hamba allah`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tampiPenyewaan` ()   BEGIN
    SELECT
        p.id AS penyewaan_id,
        m.merek AS merek_mobil,
        pl.nama AS nama_pelanggan,
        p.tanggal_mulai,
        p.tanggal_selesai,
        p.biaya,
        CASE
            WHEN DATEDIFF(p.tanggal_selesai, p.tanggal_mulai) <= 3 THEN 'sebentar'
            WHEN DATEDIFF(p.tanggal_selesai, p.tanggal_mulai) > 3 AND DATEDIFF(p.tanggal_selesai, p.tanggal_mulai) <= 7 THEN 'cukup'
            ELSE 'lama'
        END AS lama_pinjam
    FROM
        penyewaan p
    JOIN
        mobil m ON p.id_mobil = m.id
    JOIN
        pelanggan pl ON p.id_pelanggan = pl.id;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `tambahMobil` (`mobil_id` INT(20), `mobil_merek` VARCHAR(50), `mobil_model` VARCHAR(50), `mobil_tahun` INT(4), `mobil_warna` VARCHAR(20)) RETURNS TINYINT(1)  BEGIN
    DECLARE sukses BOOLEAN;

    INSERT INTO mobil (id, merek, model, tahun, warna)
    VALUES (mobil_id, mobil_merek, mobil_model, mobil_tahun, mobil_warna);

    SET sukses = (SELECT ROW_COUNT() = 1);

    RETURN sukses;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `id` int(20) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_hp` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`id`, `nama`, `jabatan`, `alamat`, `no_hp`) VALUES
(1, 'David Johnson', 'Manager', '111 Main St, City', '555-1111'),
(2, 'Jessica Lee', 'Supervisor', '222 Park Ave, Town', '555-2222'),
(3, 'Robert Smith', 'Salesperson', '333 Center Rd, Village', '555-3333'),
(4, 'Karen Williams', 'Salesperson', '444 First St, Town', '555-4444'),
(5, 'Richard Davis', 'Mechanic', '555 Elm St, City', '555-5555'),
(6, 'Laura Wilson', 'Mechanic', '666 Oak Ave, Village', '555-6666'),
(7, 'Christopher Martin', 'Cleaner', '777 Second St, City', '555-7777'),
(8, 'Maria Taylor', 'Cleaner', '888 Pine Rd, Town', '555-8888'),
(9, 'Andrew Anderson', 'Security', '999 Maple Ave, Village', '555-9999'),
(10, 'Elizabeth Brown', 'Security', '101 Third St, City', '555-0000');

-- --------------------------------------------------------

--
-- Table structure for table `mobil`
--

CREATE TABLE `mobil` (
  `id` int(20) NOT NULL,
  `merek` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `tahun` int(4) NOT NULL,
  `warna` varchar(20) NOT NULL,
  `status` enum('tersedia','tidak tersedia') NOT NULL DEFAULT 'tersedia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mobil`
--

INSERT INTO `mobil` (`id`, `merek`, `model`, `tahun`, `warna`, `status`) VALUES
(1, 'Toyota', 'Corolla', 2021, 'White', 'tersedia'),
(2, 'Honda', 'Civic', 2022, 'Black', 'tersedia'),
(3, 'Ford', 'Mustang', 2020, 'Red', 'tersedia'),
(4, 'Chevrolet', 'Cruze', 2019, 'Blue', 'tersedia'),
(5, 'Nissan', 'Sentra', 2023, 'Silver', 'tersedia'),
(6, 'BMW', 'X5', 2022, 'Grey', 'tersedia'),
(7, 'Mercedes-Benz', 'C-Class', 2020, 'White', 'tersedia'),
(8, 'Audi', 'A4', 2021, 'Black', 'tersedia'),
(9, 'Hyundai', 'Tucson', 2023, 'Red', 'tersedia'),
(10, 'Kia', 'Sportage', 2022, 'Blue', 'tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(20) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `no_hp` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `alamat`, `no_hp`) VALUES
(1, 'John Doe', '123 Main St, City', '555-1234'),
(2, 'Jane Smith', '456 Park Ave, Town', '555-5678'),
(3, 'Michael Johnson', '789 Center Rd, Village', '555-9012'),
(4, 'Emily Williams', '321 First St, Town', '555-3456'),
(5, 'Daniel Lee', '654 Elm St, City', '555-7890'),
(6, 'Olivia Davis', '987 Oak Ave, Village', '555-2345'),
(7, 'William Wilson', '432 Second St, City', '555-6789'),
(8, 'Sophia Martin', '876 Pine Rd, Town', '555-0123'),
(9, 'James Taylor', '345 Maple Ave, Village', '555-4567'),
(10, 'Isabella Anderson', '678 Third St, City', '555-8901');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` int(20) NOT NULL,
  `id_sewa` int(20) NOT NULL,
  `tanggal_pembayaran` date NOT NULL,
  `jumlah` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `id_sewa`, `tanggal_pembayaran`, `jumlah`) VALUES
(1, 3, '2023-09-12', 200.00),
(2, 7, '2023-11-23', 300.00),
(3, 2, '2023-08-05', 150.00),
(4, 9, '2024-04-01', 350.00),
(5, 5, '2023-11-28', 270.00),
(6, 6, '2023-12-16', 390.00),
(7, 8, '2024-02-18', 200.00),
(8, 1, '2023-07-18', 100.00),
(9, 10, '2024-04-05', 360.00),
(10, 4, '2023-10-08', 250.00);

-- --------------------------------------------------------

--
-- Table structure for table `penyewaan`
--

CREATE TABLE `penyewaan` (
  `id` int(20) NOT NULL,
  `id_mobil` int(20) NOT NULL,
  `id_pelanggan` int(20) NOT NULL,
  `id_karyawan` int(20) NOT NULL,
  `tanggal_mulai` date NOT NULL,
  `tanggal_selesai` date NOT NULL,
  `biaya` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penyewaan`
--

INSERT INTO `penyewaan` (`id`, `id_mobil`, `id_pelanggan`, `id_karyawan`, `tanggal_mulai`, `tanggal_selesai`, `biaya`) VALUES
(1, 2, 4, 6, '2023-07-15', '2023-07-20', 250.00),
(2, 5, 1, 3, '2023-08-01', '2023-08-07', 350.00),
(3, 3, 3, 2, '2023-09-10', '2023-09-15', 300.00),
(4, 7, 2, 5, '2023-10-05', '2023-10-10', 400.00),
(5, 1, 7, 8, '2023-11-20', '2023-11-25', 270.00),
(6, 8, 5, 10, '2023-12-12', '2023-12-18', 390.00),
(7, 6, 9, 1, '2024-01-08', '2024-01-15', 500.00),
(8, 4, 10, 4, '2024-02-14', '2024-02-21', 320.00),
(9, 9, 6, 9, '2024-03-25', '2024-03-31', 420.00),
(10, 10, 8, 7, '2024-04-02', '2024-04-09', 360.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mobil`
--
ALTER TABLE `mobil`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sewa` (`id_sewa`);

--
-- Indexes for table `penyewaan`
--
ALTER TABLE `penyewaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_mobil` (`id_mobil`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_karyawan` (`id_karyawan`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_sewa`) REFERENCES `penyewaan` (`id`);

--
-- Constraints for table `penyewaan`
--
ALTER TABLE `penyewaan`
  ADD CONSTRAINT `penyewaan_ibfk_1` FOREIGN KEY (`id_mobil`) REFERENCES `mobil` (`id`),
  ADD CONSTRAINT `penyewaan_ibfk_2` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id`),
  ADD CONSTRAINT `penyewaan_ibfk_3` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawan` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
