-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 22, 2025 at 04:16 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `doan1`
--

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `chi_tiet_id` int(11) NOT NULL,
  `don_hang_id` int(11) NOT NULL,
  `san_pham_id` int(11) NOT NULL,
  `so_luong` int(11) NOT NULL,
  `gia` decimal(10,2) NOT NULL,
  `thanh_tien` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chi_tiet_don_hang`
--

INSERT INTO `chi_tiet_don_hang` (`chi_tiet_id`, `don_hang_id`, `san_pham_id`, `so_luong`, `gia`, `thanh_tien`) VALUES
(9, 4, 5, 1, 4190000.00, 4190000.00),
(10, 5, 11, 1, 9990000.00, 9990000.00),
(11, 6, 6, 1, 1290000.00, 1290000.00),
(12, 7, 3, 1, 9990000.00, 9990000.00),
(13, 8, 2, 1, 4290000.00, 4290000.00),
(14, 9, 2, 1, 4290000.00, 4290000.00),
(15, 10, 3, 2, 9990000.00, 19980000.00),
(19, 21, 2, 1, 4290000.00, 4290000.00),
(20, 22, 3, 1, 9990000.00, 9990000.00);

-- --------------------------------------------------------

--
-- Table structure for table `danh_muc`
--

CREATE TABLE `danh_muc` (
  `danh_muc_id` int(11) NOT NULL,
  `ten_danh_muc` varchar(100) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `danh_muc`
--

INSERT INTO `danh_muc` (`danh_muc_id`, `ten_danh_muc`, `mo_ta`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 'Vi xu ly (CPU)', 'Bo vi xu ly cho may tinh', '2025-12-14 22:45:43', '2025-12-14 22:45:43'),
(2, 'Bo mach chu (Mainboard)', 'Bo mach chu cac loai', '2025-12-14 22:45:43', '2025-12-14 22:45:43'),
(3, 'RAM', 'Bo nho RAM cho may tinh', '2025-12-14 22:45:43', '2025-12-14 22:45:43'),
(4, 'O cung & SSD', 'O cung HDD va SSD', '2025-12-14 22:45:43', '2025-12-14 22:45:43'),
(5, 'Card do hoa (VGA)', 'Card man hinh roi', '2025-12-14 22:45:43', '2025-12-14 22:45:43'),
(6, 'Nguon may tinh (PSU)', 'Nguon cap dien cho may tinh', '2025-12-14 22:45:43', '2025-12-14 22:45:43'),
(7, 'Tan nhiet & Cooling', 'Quat tan nhiet va he thong lam mat', '2025-12-14 22:45:43', '2025-12-14 22:45:43'),
(8, 'Linh kien khac', 'Cac linh kien dien tu khac', '2025-12-14 22:45:43', '2025-12-14 22:45:43');

-- --------------------------------------------------------

--
-- Table structure for table `don_hang`
--

CREATE TABLE `don_hang` (
  `don_hang_id` int(11) NOT NULL,
  `nguoi_dung_id` int(11) NOT NULL,
  `tong_tien` decimal(10,2) NOT NULL,
  `trang_thai` enum('pending','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  `dia_chi_giao_hang` text NOT NULL,
  `so_dien_thoai` varchar(20) NOT NULL,
  `ghi_chu` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `don_hang`
--

INSERT INTO `don_hang` (`don_hang_id`, `nguoi_dung_id`, `tong_tien`, `trang_thai`, `dia_chi_giao_hang`, `so_dien_thoai`, `ghi_chu`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(3, 4, 3990000.00, 'cancelled', 'sfaszfas', '0357757544', '', '2025-12-16 15:01:31', '2025-12-20 05:14:47'),
(4, 4, 4190000.00, 'cancelled', 'sfaszfas', '0357757544', '', '2025-12-19 16:39:49', '2025-12-22 00:52:05'),
(5, 4, 9990000.00, 'cancelled', 'sfaszfas', '0357757544', '', '2025-12-20 03:20:48', '2025-12-22 00:52:01'),
(6, 4, 1290000.00, 'cancelled', 'sfaszfas', '0357757544', '', '2025-12-20 03:21:05', '2025-12-22 00:51:56'),
(7, 4, 9990000.00, 'cancelled', 'sdasd', '0357757544 ', 'ÄÃ¢sdasd', '2025-12-21 10:24:01', '2025-12-22 00:52:26'),
(8, 4, 4320000.00, 'cancelled', '231312,sdasndjas,23123,123123', '0101020255', '23123123', '2025-12-21 10:55:47', '2025-12-22 00:52:23'),
(9, 4, 4320000.00, 'cancelled', '2323123123123123', '0101020255', 'sdasdasd', '2025-12-21 10:56:27', '2025-12-22 00:52:19'),
(10, 4, 20010000.00, 'cancelled', '23123123213', '0357757544', 'fsfdsfsfdsf', '2025-12-21 11:01:05', '2025-12-22 00:52:15'),
(21, 4, 4320000.00, 'cancelled', '123 ÄÆ°á»ng ABC, Quáº­n 1, TP HCM', '0357757544', 'Giao hÃ ng buá»i sÃ¡ng', '2025-12-21 19:37:39', '2025-12-22 00:51:52'),
(22, 4, 10020000.00, 'cancelled', '.20.12.12.12.', '0357757544', '12.12.12.12.12.', '2025-12-21 19:50:19', '2025-12-22 00:51:49');

-- --------------------------------------------------------

--
-- Table structure for table `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `nguoi_dung_id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `ho_ten` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `so_dien_thoai` varchar(20) DEFAULT NULL,
  `dia_chi` text DEFAULT NULL,
  `vai_tro` enum('customer','admin') DEFAULT 'customer',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`nguoi_dung_id`, `ten_dang_nhap`, `mat_khau`, `ho_ten`, `email`, `so_dien_thoai`, `dia_chi`, `vai_tro`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(4, 'ducmanh', 'nP1/XOXqnwdQgfqeYDecWA==:DvWaFteImckCUBYtU3vth2d/+AVUvqQ6Xbp/RxIwuzc=', 'Vipp01', '123@gmail.com', '0357757544', 'sfaszfas', 'admin', '2025-12-16 14:59:30', '2025-12-16 15:00:15');

-- --------------------------------------------------------

--
-- Table structure for table `san_pham`
--

CREATE TABLE `san_pham` (
  `san_pham_id` int(11) NOT NULL,
  `danh_muc_id` int(11) NOT NULL,
  `ten_san_pham` varchar(200) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `gia` decimal(10,2) NOT NULL,
  `so_luong_ton` int(11) NOT NULL DEFAULT 0,
  `duong_dan_anh` varchar(255) DEFAULT NULL,
  `trang_thai` enum('active','inactive') DEFAULT 'active',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp(),
  `ngay_cap_nhat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `san_pham`
--

INSERT INTO `san_pham` (`san_pham_id`, `danh_muc_id`, `ten_san_pham`, `mo_ta`, `gia`, `so_luong_ton`, `duong_dan_anh`, `trang_thai`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(2, 1, 'AMD Ryzen 5 5600X', 'CPU AMD Ryzen 5 5600X, 6 nhan 12 luong, xung nhip toi da 4.6GHz  22', 4290000.00, 45, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUcdklJnyGjKnNRErearXJunrood5DnOcLJQ&s', 'active', '2025-12-14 22:45:43', '2025-12-21 09:15:47'),
(3, 1, 'Intel Core i7-13700K', 'CPU Intel Core i7 the he 13, 16 nhan 24 luong, xung nhip toi da 5.4GHz', 9990000.00, 30, 'https://lagihitech.vn/wp-content/uploads/2024/07/CPU-Intel-Core-i7-13700K-hinh-1.jpg', 'active', '2025-12-14 22:45:43', '2025-12-21 09:16:32'),
(4, 2, 'ASUS TUF GAMING B660M-PLUS', 'Bo mach chu ASUS B660M, ho tro Intel Gen 12/13, DDR4, PCIe 4.0', 3590000.00, 40, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSbvntrPzcsFHE69jCdwWG6MR-jvgxcC45mQ&s', 'active', '2025-12-14 22:45:43', '2025-12-21 09:16:47'),
(5, 2, 'MSI MAG B550 TOMAHAWK', 'Bo mach chu MSI B550, ho tro AMD Ryzen, DDR4, PCIe 4.0', 4190000.00, 34, 'https://storage-asset.msi.com/global/picture/image/feature/mb/B550/MAG/TOMAHAWK/msi-mag-b550-tomahawk-hero-board01.png', 'active', '2025-12-14 22:45:43', '2025-12-21 09:17:08'),
(6, 3, 'Kingston Fury Beast 16GB (2x8GB) DDR4 3200MHz', 'RAM Kingston 16GB DDR4 3200MHz, CAS 16', 1290000.00, 99, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpx9zVeD3O7CxkYKUahOFDciN2e1uEdaYgAQ&s', 'active', '2025-12-14 22:45:43', '2025-12-21 09:17:29'),
(7, 3, 'Corsair Vengeance RGB 32GB (2x16GB) DDR4 3600MHz', 'RAM Corsair 32GB DDR4 3600MHz voi den RGB', 2990000.00, 60, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrqxc8bYBhsryehhm7w-OlSKrQUvV-0dmx_w&s', 'active', '2025-12-14 22:45:43', '2025-12-21 09:17:47'),
(8, 4, 'Samsung 970 EVO Plus 500GB NVMe', 'SSD Samsung 970 EVO Plus 500GB, toc do doc 3500MB/s', 1690000.00, 80, 'https://lagihitech.vn/wp-content/uploads/2019/01/o-cung-ssd-samsung-970-evo-plus-500gb-m2-2280.jpg', 'active', '2025-12-14 22:45:43', '2025-12-21 09:18:02'),
(9, 4, 'WD Blue SN570 1TB NVMe', 'SSD WD Blue SN570 1TB, toc do doc 3500MB/s', 2290000.00, 70, 'https://tuanphong.vn/upload_images/images/2021/12/O-cung-SSD-M2-PCIe-WD-Blue-SN570-NVMe-2280-4-.jpg', 'active', '2025-12-14 22:45:43', '2025-12-21 09:18:21'),
(10, 4, 'Seagate Barracuda 2TB HDD', 'O cung HDD Seagate 2TB, 7200 RPM, SATA3', 1390000.00, 90, 'https://product.hstatic.net/200000722513/product/hdd_seagate_baracuda_2tb_gearvn00_28582504c8d24597908c3a73effefa7a_e147c85ec46148acbdc7c7f8a729b68c_master.jpg', 'active', '2025-12-14 22:45:43', '2025-12-21 09:18:36'),
(11, 5, 'NVIDIA GeForce RTX 3060 Ti 8GB', 'Card do hoa NVIDIA RTX 3060 Ti 8GB GDDR6', 9990000.00, 24, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDj0ubGfvgtUXbsvtDKd9Gp5xu288BbWiG1g&s', 'active', '2025-12-14 22:45:43', '2025-12-21 09:18:55'),
(12, 5, 'AMD Radeon RX 6700 XT 12GB', 'Card do hoa AMD RX 6700 XT 12GB GDDR6', 10990000.00, 20, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDjdmxZqQ2owrfrTWZk2jaT87FdYjUfoj69g&s', 'active', '2025-12-14 22:45:43', '2025-12-21 09:19:10'),
(13, 6, 'Corsair CV650 650W 80 Plus Bronze', 'Nguon Corsair 650W, chuan 80 Plus Bronze', 1490000.00, 50, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK4PIdSR6OoCBroJYCMA1OjqV-y-RpRWGQ8g&s', 'active', '2025-12-14 22:45:43', '2025-12-21 09:19:25'),
(14, 6, 'Cooler Master MWE Gold 750W', 'Nguon Cooler Master 750W, chuan 80 Plus Gold, Full Modular', 2290000.00, 40, 'https://www.tncstore.vn/media/product/4013-nguon-corsair-cv650-80plus-bronze-1-1.jpg', 'active', '2025-12-14 22:45:43', '2025-12-21 09:19:47'),
(15, 7, 'Cooler Master Hyper 212 RGB', 'Tan nhiet khi Cooler Master Hyper 212 voi den RGB', 690000.00, 100, 'https://product.hstatic.net/1000129940/product/tan-nhiet-khi-cooler-master-hyper-212-rgb-black-edition_5c19b4beee11445ea1f19e97b0188be7_master.jpg', 'active', '2025-12-14 22:45:43', '2025-12-21 09:20:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD PRIMARY KEY (`chi_tiet_id`),
  ADD KEY `idx_don_hang` (`don_hang_id`),
  ADD KEY `idx_san_pham` (`san_pham_id`);

--
-- Indexes for table `danh_muc`
--
ALTER TABLE `danh_muc`
  ADD PRIMARY KEY (`danh_muc_id`);

--
-- Indexes for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`don_hang_id`),
  ADD KEY `idx_nguoi_dung` (`nguoi_dung_id`),
  ADD KEY `idx_trang_thai` (`trang_thai`);

--
-- Indexes for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`nguoi_dung_id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_ten_dang_nhap` (`ten_dang_nhap`),
  ADD KEY `idx_email` (`email`);

--
-- Indexes for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD PRIMARY KEY (`san_pham_id`),
  ADD KEY `idx_danh_muc` (`danh_muc_id`),
  ADD KEY `idx_trang_thai` (`trang_thai`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `chi_tiet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `danh_muc`
--
ALTER TABLE `danh_muc`
  MODIFY `danh_muc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `don_hang_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `nguoi_dung_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `san_pham_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`don_hang_id`) REFERENCES `don_hang` (`don_hang_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`san_pham_id`) REFERENCES `san_pham` (`san_pham_id`) ON DELETE CASCADE;

--
-- Constraints for table `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`nguoi_dung_id`) REFERENCES `nguoi_dung` (`nguoi_dung_id`) ON DELETE CASCADE;

--
-- Constraints for table `san_pham`
--
ALTER TABLE `san_pham`
  ADD CONSTRAINT `san_pham_ibfk_1` FOREIGN KEY (`danh_muc_id`) REFERENCES `danh_muc` (`danh_muc_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
