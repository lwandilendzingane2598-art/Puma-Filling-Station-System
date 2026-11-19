-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2026 at 09:23 AM
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
-- Database: `hloba_sneaker_wash`
--
CREATE DATABASE IF NOT EXISTS `hloba_sneaker_wash` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hloba_sneaker_wash`;

-- --------------------------------------------------------

--
-- Table structure for table `expenditures`
--

CREATE TABLE `expenditures` (
  `id` int(11) NOT NULL,
  `expense_title` varchar(150) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `category` varchar(100) DEFAULT 'Stock Purchase',
  `recorded_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expenditures`
--

INSERT INTO `expenditures` (`id`, `expense_title`, `amount`, `category`, `recorded_by`, `created_at`) VALUES
(1, 'Restocked 30x Soft Cleaning Brush from Wash Hub', 100.00, 'Stock Purchase', 9, '2026-10-29 11:02:25'),
(2, 'Restocked 20x Sneaker Cleaning Solution from Wash Hub', 50.00, 'Stock Purchase', 9, '2026-10-29 11:02:54');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `item_name` varchar(150) NOT NULL,
  `category` varchar(100) DEFAULT 'Cleaning Supplies',
  `stock_level` int(11) NOT NULL DEFAULT 0,
  `unit_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `supplier_store` varchar(100) NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `item_name`, `category`, `stock_level`, `unit_price`, `supplier_store`, `last_updated`) VALUES
(1, 'Soft Cleaning Brush', 'Cleaning Supplies', 33, 25.00, 'Wash Hub', '2026-10-29 11:02:25'),
(2, 'Sneaker Cleaning Solution', 'Cleaning Supplies', 20, 85.00, 'Wash Hub', '2026-10-29 11:02:54'),
(3, 'Microfiber Cloth', 'Cleaning Supplies', 20, 15.00, 'Build It', '2026-10-29 09:06:23'),
(4, 'Shoe Deodorizer', 'Cleaning Supplies', 12, 45.00, 'Ruchi', '2026-10-29 09:06:23');

-- --------------------------------------------------------

--
-- Table structure for table `material_tasks`
--

CREATE TABLE `material_tasks` (
  `id` int(11) NOT NULL,
  `item_description` text NOT NULL,
  `supplier_store` varchar(150) NOT NULL,
  `pickup_address` text NOT NULL,
  `driver_id` int(11) NOT NULL,
  `assigned_by` int(11) NOT NULL,
  `status` enum('Assigned','In Transit','Collected') DEFAULT 'Assigned',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `material_tasks`
--

INSERT INTO `material_tasks` (`id`, `item_description`, `supplier_store`, `pickup_address`, `driver_id`, `assigned_by`, `status`, `notes`, `created_at`) VALUES
(1, 'solution', 'build it', 'mbabane', 2, 6, 'Assigned', NULL, '2026-10-29 10:01:49'),
(2, 'solution', 'build it', 'mbabane', 7, 6, 'Collected', NULL, '2026-10-29 10:24:22');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `service_type` varchar(100) NOT NULL,
  `price_per_unit` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `total_amount` decimal(10,2) NOT NULL,
  `pickup_address` text NOT NULL,
  `pickup_date` date NOT NULL,
  `payment_mode` enum('Cash on Pickup','Mobile Money / EFT','Card on Delivery') NOT NULL,
  `order_type` enum('online','phone_walkin') DEFAULT 'online',
  `status` enum('Pending Pickup','In Wash','Ready for Delivery','Delivered') DEFAULT 'Pending Pickup',
  `driver_id` int(11) DEFAULT NULL,
  `estimated_delivery` date DEFAULT NULL,
  `receptionist_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `customer_name`, `customer_phone`, `service_type`, `price_per_unit`, `quantity`, `total_amount`, `pickup_address`, `pickup_date`, `payment_mode`, `order_type`, `status`, `driver_id`, `estimated_delivery`, `receptionist_notes`, `created_at`) VALUES
(1, 5, 'Sethu', '786555445', 'Arbiter (Respray)', 120.00, 5, 600.00, 'Nkoyoyo', '2026-10-30', 'Card on Delivery', 'online', 'In Wash', 7, '2026-12-12', '', '2026-10-29 09:37:05'),
(2, 5, 'Sethu', '786656654', 'Basic Sneaker Wash', 80.00, 1, 80.00, 'nkoyoyo', '2026-11-20', 'Mobile Money / EFT', 'online', 'In Wash', 2, '2026-11-12', '', '2026-10-29 09:38:32'),
(3, NULL, 'Sphiwe', '76544554', 'Timberland Wash & Care', 150.00, 1, 150.00, 'Sandla', '2026-10-29', 'Cash on Pickup', 'phone_walkin', 'Ready for Delivery', 2, '2026-11-03', '', '2026-10-29 09:43:50');

-- --------------------------------------------------------

--
-- Table structure for table `role_communications`
--

CREATE TABLE `role_communications` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `sender_id` int(11) NOT NULL,
  `recipient_role` enum('customer','driver','washer','manager','receptionist') NOT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('Unread','Read','Actioned') DEFAULT 'Unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_communications`
--

INSERT INTO `role_communications` (`id`, `order_id`, `sender_id`, `recipient_role`, `recipient_id`, `message`, `status`, `created_at`) VALUES
(1, 1, 5, 'receptionist', NULL, 'I hope my orders are successfully placed', 'Unread', '2026-10-29 09:40:36'),
(2, NULL, 6, 'customer', NULL, 'yes', 'Unread', '2026-10-29 09:59:14'),
(3, 2, 6, 'customer', NULL, 'yes', 'Unread', '2026-10-29 10:00:02'),
(4, NULL, 6, 'manager', NULL, 'hello sir', 'Unread', '2026-10-29 10:00:26'),
(5, NULL, 6, 'driver', NULL, 'hello sir', 'Unread', '2026-10-29 10:00:38'),
(6, NULL, 6, 'washer', NULL, 'hello sir', 'Unread', '2026-10-29 10:00:46'),
(7, NULL, 6, 'driver', NULL, 'collect', 'Unread', '2026-10-29 10:24:50'),
(8, NULL, 7, 'receptionist', NULL, 'collected', 'Unread', '2026-10-29 10:27:46'),
(9, NULL, 8, 'manager', NULL, 'SHORTAGE ALERT: Shoe Deodorizer is running low. Note: short', 'Unread', '2026-10-29 10:34:46'),
(10, NULL, 8, 'receptionist', NULL, 'SHORTAGE ALERT: Shoe Deodorizer is running low. Note: short', 'Unread', '2026-10-29 10:34:46'),
(11, NULL, 8, 'receptionist', NULL, 'Washer used 4x Sneaker Cleaning Solution. Stock deducted.', 'Unread', '2026-10-29 10:57:03'),
(12, NULL, 8, 'receptionist', NULL, 'Washer used 4x Soft Cleaning Brush. Stock deducted.', 'Unread', '2026-10-29 10:57:26'),
(13, 3, 8, 'receptionist', NULL, 'Washer updated Order #3 status to: Ready for Delivery', 'Unread', '2026-10-29 10:57:52'),
(14, 1, 8, 'receptionist', NULL, 'Washer updated Order #1 status to: In Wash', 'Unread', '2026-10-29 10:58:05'),
(15, 2, 8, 'receptionist', NULL, 'Washer updated Order #2 status to: In Wash', 'Unread', '2026-10-29 10:58:07'),
(16, NULL, 9, 'receptionist', NULL, 'come to my office asap', 'Unread', '2026-10-29 11:11:46');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('customer','receptionist','driver','manager','washer') DEFAULT 'customer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password`, `role`, `created_at`) VALUES
(1, 'Receptionist Desk', 'receptionist@hloba.com', '79369657', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11e6p.J043X/Z9Hq8T880z8vEGGK4Kq', 'receptionist', '2026-10-29 09:06:23'),
(2, 'Driver Express', 'driver@hloba.com', '76000001', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11e6p.J043X/Z9Hq8T880z8vEGGK4Kq', 'driver', '2026-10-29 09:06:23'),
(3, 'Master Washer', 'washer@hloba.com', '76000002', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11e6p.J043X/Z9Hq8T880z8vEGGK4Kq', 'washer', '2026-10-29 09:06:23'),
(4, 'Store Manager', 'manager@hloba.com', '76000003', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11e6p.J043X/Z9Hq8T880z8vEGGK4Kq', 'manager', '2026-10-29 09:06:23'),
(5, 'Sethu', 'sethu@gmail.com', '76455234', '$2y$10$VmJOYkmugq.iM4aWuoffLuOIrZcgyr/m8ckxMNFE50ATJP.tBAmmG', 'customer', '2026-10-29 09:34:33'),
(6, 'Bonisile Tsabedze', 'boni@gmail.com', '766486890', '$2y$10$.eJs.Ivq3cnalnL3NJLHeue1lWO9kuoelpoyi0FRBEInhYGke0mBK', 'receptionist', '2026-10-29 09:42:05'),
(7, 'Spha', 'spha@gmail.com', '78342212', '$2y$10$K5ihPXxD40NNZw.zHP4tJ.xGgn9SvIySbrN6A/ecEYg3Tgf7F2QOC', 'driver', '2026-10-29 10:23:21'),
(8, 'Senzo', 'senzo@gmail.com', '76352112', '$2y$10$RHCkJtBeT3AHW5hE4wH4UeWDomA1w4LbWwCMMXE3.lfG1/SRzOwxC', 'washer', '2026-10-29 10:32:03'),
(9, 'Sbonelo', 'sbo@gmail.com', '76554433', '$2y$10$jeAcDBACYR9pwo9hDsiCWepQ/krnTtURRe6MfH43dBWpuH7ANGMBq', 'manager', '2026-10-29 10:59:58');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `expenditures`
--
ALTER TABLE `expenditures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recorded_by` (`recorded_by`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `material_tasks`
--
ALTER TABLE `material_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_id` (`driver_id`),
  ADD KEY `assigned_by` (`assigned_by`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `driver_id` (`driver_id`);

--
-- Indexes for table `role_communications`
--
ALTER TABLE `role_communications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `expenditures`
--
ALTER TABLE `expenditures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `material_tasks`
--
ALTER TABLE `material_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role_communications`
--
ALTER TABLE `role_communications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `expenditures`
--
ALTER TABLE `expenditures`
  ADD CONSTRAINT `expenditures_ibfk_1` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `material_tasks`
--
ALTER TABLE `material_tasks`
  ADD CONSTRAINT `material_tasks_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `material_tasks_ibfk_2` FOREIGN KEY (`assigned_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `role_communications`
--
ALTER TABLE `role_communications`
  ADD CONSTRAINT `role_communications_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_communications_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `interiorfunn`
--
CREATE DATABASE IF NOT EXISTS `interiorfunn` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `interiorfunn`;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `ContactNumber` varchar(20) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustomerID`, `FirstName`, `LastName`, `ContactNumber`, `Address`) VALUES
(0, 'Smanga', 'Motsa', '78343222', 'Zone 3'),
(1, 'Alice', 'Smith', '123-456-7890', '101 Main St'),
(2, 'Bob', 'Johnson', '234-567-8901', '102 Oak Ave'),
(3, 'Carol', 'Williams', '345-678-9012', '103 Pine Rd'),
(4, 'David', 'Brown', '456-789-0123', '104 Maple Dr'),
(5, 'Eve', 'Jones', '567-890-1234', '105 Elm St'),
(6, 'Frank', 'Garcia', '678-901-2345', '106 Cedar Ln'),
(7, 'Grace', 'Martinez', '789-012-3456', '107 Birch Blvd'),
(8, 'Hank', 'Rodriguez', '890-123-4567', '108 Spruce Ct'),
(9, 'Ivy', 'Lee', '901-234-5678', '109 Walnut St'),
(10, 'Jack', 'Walker', '012-345-6789', '110 Chestnut Ave'),
(11, 'Lwandile', 'Ndzingane', '123-456-7890', '123 Main St'),
(12, 'Lwex', 'Banks', '79369657', 'Mkhonubovu St'),
(20, 'SAMKE', 'STHOLE', '76445443', 'CHECKERS');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Position` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`EmployeeID`, `FirstName`, `LastName`, `Position`) VALUES
(1, 'Michael', 'Scott', 'Manager'),
(2, 'Jim', 'Halpert', 'Sales'),
(3, 'Pam', 'Beesly', 'Receptionist'),
(4, 'Dwight', 'Schrute', 'Sales'),
(5, 'Stanley', 'Hudson', 'Sales'),
(6, 'Angela', 'Martin', 'Accountant'),
(7, 'Kevin', 'Malone', 'Accountant'),
(8, 'Oscar', 'Martinez', 'Accountant'),
(9, 'Phyllis', 'Vance', 'Sales'),
(10, 'Ryan', 'Howard', 'Temp'),
(11, 'Cebo', 'Thokazi', 'CEO'),
(12, 'Nkosenhle ', 'Dlamini', 'Cashier'),
(13, 'MR', 'GININDZA', 'MANAGER'),
(14, 'mamsy', 'dlamini', 'cashier'),
(17, 'SIPHIWO', 'SIMELANE', 'cashier'),
(19, 'MANAKA', 'GAMA', 'cashier'),
(21, 'SENZO', 'MANANA', 'cashier'),
(22, 'Anele', 'Ngwenya', 'MANAGER'),
(24, 'THOKAZI', 'NDZINGANE', 'MANAGER');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `InvoiceID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `ProductCode` varchar(4) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `PriceEach` decimal(10,2) DEFAULT NULL,
  `DiscountApplied` int(11) DEFAULT NULL,
  `TotalCost` decimal(10,2) DEFAULT NULL,
  `DateIssued` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`InvoiceID`, `OrderID`, `ProductCode`, `Quantity`, `PriceEach`, `DiscountApplied`, `TotalCost`, `DateIssued`) VALUES
(1, 0, 'P001', 3, 2300.00, NULL, 6900.00, '2025-11-29 12:41:15'),
(2, 1011, 'P002', 2, 20.00, NULL, 40.00, '2025-11-29 14:17:16'),
(3, 1012, 'P009', 10, 260.00, NULL, 2600.00, '2025-11-29 14:20:44'),
(4, 1013, 'P006', 10, 300.00, NULL, 3000.00, '2025-11-29 15:56:02'),
(5, 1014, 'P006', 10, 300.00, NULL, 3000.00, '2025-11-29 15:56:04'),
(6, 1015, 'P007', 4, 2400.00, NULL, 9600.00, '2025-11-29 16:46:46'),
(7, 1016, 'P007', 2, 2400.00, NULL, 4800.00, '2025-11-30 18:15:15'),
(8, 1017, 'P005', 2, 2500.00, NULL, 5000.00, '2025-11-30 18:15:47'),
(9, 1018, 'P005', 1, 2500.00, NULL, 2500.00, '2025-11-30 18:20:09'),
(10, 1019, 'P005', 1, 2500.00, NULL, 2500.00, '2025-11-30 18:22:45'),
(11, 1020, 'P008', 3, 280.00, NULL, 840.00, '2025-11-30 18:23:03'),
(12, 1021, 'P002', 1, 20.00, NULL, 20.00, '2025-11-30 18:44:21'),
(13, 1022, 'P007', 8, 2400.00, NULL, 19200.00, '2025-11-30 19:51:12'),
(14, 1023, 'P001', 10, 2300.00, NULL, 23000.00, '2025-12-01 07:05:36'),
(15, 1024, '02', 10, 1300.00, NULL, 13000.00, '2025-12-02 10:15:06'),
(16, 1025, '2331', 10, 2500.00, NULL, 25000.00, '2025-12-02 10:19:42'),
(17, 1026, '02', 10, 1300.00, NULL, 13000.00, '2025-12-02 10:21:40'),
(18, 1027, '02', 10, 1300.00, NULL, 13000.00, '2025-12-02 10:22:19'),
(19, 1028, '02', 100, 1300.00, NULL, 130000.00, '2025-12-02 10:43:14'),
(20, 1029, 'P004', 100, 2030.00, NULL, 203000.00, '2025-12-02 21:29:57'),
(21, 1030, 'P004', 100, 2030.00, NULL, 203000.00, '2025-12-02 21:29:57'),
(22, 1031, 'P005', 100, 2500.00, NULL, 250000.00, '2025-12-02 23:31:18'),
(23, 1032, '02', 100, 1300.00, NULL, 130000.00, '2025-12-03 18:22:45'),
(24, 1033, '02', 50, 1300.00, NULL, 65000.00, '2025-12-03 23:19:23'),
(25, 1034, '2331', 10, 2500.00, NULL, 25000.00, '2025-12-07 18:17:04'),
(26, 1035, 'P001', 10, 2300.00, NULL, 23000.00, '2025-12-07 20:00:15'),
(27, 1036, '2331', 10, 2500.00, NULL, 25000.00, '2025-12-07 22:05:02'),
(28, 1037, 'P003', 10, 500.00, NULL, 5000.00, '2025-12-08 07:57:32'),
(29, 1038, '2331', 10, 2500.00, NULL, 25000.00, '2026-01-12 13:50:01'),
(30, 1039, '2331', 10, 2500.00, NULL, 25000.00, '2026-01-14 23:39:29'),
(31, 1040, '2331', 50, 2500.00, NULL, 125000.00, '2026-01-15 06:51:00'),
(32, 1041, 'P004', 100, 2030.00, NULL, 203000.00, '2026-01-15 06:51:29'),
(33, 1042, 'P008', 100, 280.00, NULL, 28000.00, '2026-01-15 06:52:06'),
(34, 1043, '2331', 10, 2500.00, NULL, 25000.00, '2026-01-15 06:59:53'),
(35, 1044, 'P001', 1, 2300.00, NULL, 2300.00, '2026-01-15 07:05:39'),
(36, 1045, 'P003', 10, 500.00, NULL, 5000.00, '2026-01-15 07:38:50'),
(37, 1046, 'P002', 10, 20.00, NULL, 200.00, '2026-01-15 07:47:41'),
(38, 1047, 'P002', 10, 20.00, NULL, 200.00, '2026-01-15 07:51:29'),
(39, 1048, '2331', 100, 2500.00, NULL, 250000.00, '2026-01-15 08:37:42'),
(40, 1049, '2331', 100, 2500.00, NULL, 250000.00, '2026-01-15 08:37:58'),
(41, 1050, 'P002', 20, 20.00, NULL, 400.00, '2026-01-15 08:43:31'),
(42, 1051, 'P001', 9, 2300.00, NULL, 20700.00, '2026-01-15 08:50:54');

--
-- Triggers `invoices`
--
DELIMITER $$
CREATE TRIGGER `Before_Invoice_Insert` BEFORE INSERT ON `invoices` FOR EACH ROW BEGIN
    DECLARE v_Stock INT;
    
    SELECT QuantityAvailable INTO v_Stock 
    FROM products 
    WHERE ProductCode = NEW.ProductCode;

    IF v_Stock < NEW.Quantity THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Insufficient stock for this product.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `EmployeeID` int(11) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL,
  `TotalOrderCost` decimal(10,2) DEFAULT NULL,
  `Status` varchar(20) NOT NULL DEFAULT 'Pending',
  `ApprovalStatus` varchar(20) DEFAULT 'Pending',
  `Feedback` text DEFAULT NULL,
  `ApprovedDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`OrderID`, `CustomerID`, `EmployeeID`, `OrderDate`, `TotalOrderCost`, `Status`, `ApprovalStatus`, `Feedback`, `ApprovedDate`) VALUES
(1, 1, NULL, '2025-11-29', 6900.00, 'Pending', 'Pending', NULL, NULL),
(1001, 1, 2, '2025-11-01', 2300.00, 'Pending', 'Pending', NULL, NULL),
(1002, 2, 1, '2025-11-02', 500.00, 'Pending', 'Pending', NULL, NULL),
(1003, 3, 3, '2025-11-03', 150.00, 'Pending', 'Pending', NULL, NULL),
(1004, 4, 4, '2025-11-04', 2500.00, 'Pending', 'Pending', NULL, NULL),
(1005, 5, 5, '2025-11-05', 2030.00, 'Pending', 'Pending', NULL, NULL),
(1006, 6, 6, '2025-11-06', 45.00, 'Pending', 'approved', NULL, NULL),
(1007, 7, 7, '2025-11-07', 260.00, 'Pending', 'Pending', NULL, NULL),
(1008, 8, 8, '2025-11-08', 280.00, 'Pending', 'Pending', NULL, NULL),
(1009, 9, 9, '2025-11-09', 300.00, 'Pending', 'Pending', NULL, NULL),
(1010, 10, 10, '2025-11-10', 20.00, 'Pending', 'Pending', NULL, NULL),
(1011, 1, NULL, '2025-11-29', 40.00, 'Pending', 'Pending', NULL, NULL),
(1012, 1, NULL, '2025-11-29', 2600.00, 'Pending', 'Pending', NULL, NULL),
(1013, 4, NULL, '2025-11-29', 3000.00, 'Pending', 'Pending', NULL, NULL),
(1014, 4, NULL, '2025-11-29', 3000.00, 'Pending', 'Pending', NULL, NULL),
(1015, 4, NULL, '2025-11-29', 9600.00, 'Pending', 'Pending', NULL, NULL),
(1016, 20, NULL, '2025-11-30', 4800.00, 'Pending', 'Pending', NULL, NULL),
(1017, 20, NULL, '2025-11-30', 5000.00, 'Pending', 'Pending', NULL, NULL),
(1018, 20, NULL, '2025-11-30', 2500.00, 'Pending', 'Pending', NULL, NULL),
(1019, 20, NULL, '2025-11-30', 2500.00, 'Pending', 'Pending', NULL, NULL),
(1020, 20, NULL, '2025-11-30', 840.00, 'Pending', 'Approved', 'order approved', '2025-12-02 22:08:51'),
(1021, 20, NULL, '2025-11-30', 20.00, 'Pending', 'Pending', NULL, NULL),
(1022, 20, NULL, '2025-11-30', 19200.00, 'Pending', 'Pending', NULL, NULL),
(1023, 20, NULL, '2025-12-01', 23000.00, 'Pending', 'Pending', NULL, NULL),
(1024, 20, NULL, '2025-12-02', 13000.00, 'Pending', 'rejected', NULL, NULL),
(1025, 20, NULL, '2025-12-02', 25000.00, 'Pending', 'approved', 'order approved', NULL),
(1026, 20, NULL, '2025-12-02', 13000.00, 'Pending', 'approved', 'approved', NULL),
(1027, 20, NULL, '2025-12-02', 13000.00, 'Pending', 'approved', '0rder successfully', NULL),
(1028, 20, NULL, '2025-12-02', 130000.00, 'Pending', 'rejected', NULL, NULL),
(1029, 20, NULL, '2025-12-02', 203000.00, 'Pending', 'approved', NULL, NULL),
(1030, 20, NULL, '2025-12-02', 203000.00, 'Pending', 'approved', 'order approved', NULL),
(1031, 20, NULL, '2025-12-02', 250000.00, 'Pending', 'Pending', NULL, NULL),
(1032, 20, NULL, '2025-12-03', 130000.00, 'Pending', 'rejected', NULL, NULL),
(1033, 20, NULL, '2025-12-03', 65000.00, 'Pending', 'approved', NULL, NULL),
(1034, 20, NULL, '2025-12-07', 25000.00, 'Pending', 'approved', NULL, NULL),
(1035, 20, NULL, '2025-12-07', 23000.00, 'Pending', 'approved', NULL, NULL),
(1036, 20, NULL, '2025-12-07', 25000.00, 'Pending', 'Pending', NULL, NULL),
(1037, 20, NULL, '2025-12-08', 5000.00, 'Pending', 'Pending', NULL, NULL),
(1038, 20, NULL, '2026-01-12', 25000.00, 'Pending', 'Pending', NULL, NULL),
(1039, 20, NULL, '2026-01-14', 25000.00, 'Pending', 'Pending', NULL, NULL),
(1040, 20, NULL, '2026-01-15', 125000.00, 'Pending', 'Pending', NULL, NULL),
(1041, 20, NULL, '2026-01-15', 203000.00, 'Pending', 'Pending', NULL, NULL),
(1042, 20, NULL, '2026-01-15', 28000.00, 'Rejected', 'Rejected', 'weee', NULL),
(1043, 20, NULL, '2026-01-15', 25000.00, 'Pending', 'Pending', NULL, NULL),
(1044, 20, NULL, '2026-01-15', 2300.00, 'Pending', 'Pending', NULL, NULL),
(1045, 20, NULL, '2026-01-15', 5000.00, 'Pending', 'Pending', NULL, NULL),
(1046, 20, NULL, '2026-01-15', 200.00, 'Pending', 'Pending', NULL, NULL),
(1047, 20, NULL, '2026-01-15', 200.00, 'Rejected', 'Rejected', 'no money', NULL),
(1048, 20, NULL, '2026-01-15', 250000.00, 'Pending', 'Pending', NULL, NULL),
(1049, 20, NULL, '2026-01-15', 250000.00, 'Pending', 'Pending', NULL, NULL),
(1050, 20, NULL, '2026-01-15', 400.00, 'Pending', 'Pending', NULL, NULL),
(1051, 20, NULL, '2026-01-15', 20700.00, 'Pending', 'Pending', NULL, NULL);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `After_Order_Approved` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    
    IF NEW.ApprovalStatus = 'approved' AND OLD.ApprovalStatus != 'approved' THEN
        UPDATE products p
        JOIN invoices i ON i.OrderID = NEW.OrderID
        SET p.QuantityAvailable = p.QuantityAvailable - i.Quantity
        WHERE p.ProductCode = i.ProductCode;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ProductCode` varchar(4) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `QuantityAvailable` int(11) DEFAULT NULL,
  `SellingPrice` decimal(10,2) DEFAULT NULL,
  `Image` varchar(200) DEFAULT NULL,
  `DiscountPercentage` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ProductCode`, `Name`, `Description`, `QuantityAvailable`, `SellingPrice`, `Image`, `DiscountPercentage`) VALUES
('2331', 'WALL UNIT', 'FITTED', 0, 2500.00, 'img/wall-unit.jpg', 0),
('P001', 'SOFA', 'leather-sofa', 80, 2300.00, 'img/sofa.jpg', 0),
('P002', 'SPOON', '5-SETS', 60, 20.00, 'img/spoon.jpg', 0),
('P003', 'TABLE', 'COFFY TABLE', 80, 500.00, 'img/table.jpg', 0),
('P004', 'WARDROPE', 'WOODEN', 0, 2030.00, 'img/wardrope.jpg', 0),
('P005', 'BED', 'KING-SIZE', 281, 2500.00, 'img/bed.jpg', 0),
('P006', 'PLATES', '5-SETS', 100, 300.00, 'img/plates.jpg', 0),
('P007', 'DOOR', 'WOODEN', 100, 2400.00, 'img/door.jpg', 0),
('P008', 'STOVE', 'DIAMOND', 0, 280.00, 'img/stove.jpg', 0),
('P009', 'SPEAKER', 'BLUETOOTH', 100, 260.00, 'img/speaker.jpg', 0),
('P011', 'CHAIR', 'WOODEN', 199, 500.00, 'img/chair.jpg', 0),
('P231', 'TV STAND', 'BLACK', 50, 1300.00, 'img/tv-stand.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `PurchaseID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  `EmployeeID` int(11) DEFAULT NULL,
  `ProductCode` varchar(50) NOT NULL,
  `PurchaseDate` datetime NOT NULL,
  `Quantity` int(11) NOT NULL,
  `CostOfOneItem` decimal(10,2) NOT NULL,
  `TotalCost` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`PurchaseID`, `OrderID`, `EmployeeID`, `ProductCode`, `PurchaseDate`, `Quantity`, `CostOfOneItem`, `TotalCost`) VALUES
(1, 1020, NULL, 'P008', '2025-11-30 00:00:00', 3, 280.00, 840.00),
(2, 1025, NULL, '2331', '2025-12-02 00:00:00', 10, 2500.00, 25000.00),
(3, 1030, NULL, 'P004', '2025-12-02 00:00:00', 100, 2030.00, 203000.00),
(4, 1034, NULL, '2331', '2025-12-07 00:00:00', 10, 2500.00, 25000.00),
(5, 1035, NULL, 'P001', '2025-12-07 00:00:00', 10, 2300.00, 23000.00),
(6, 1029, NULL, 'P004', '2025-12-02 00:00:00', 100, 2030.00, 203000.00);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_requests`
--

CREATE TABLE `purchase_requests` (
  `RequestID` int(11) NOT NULL,
  `SupplierID` int(11) NOT NULL,
  `ProductCode` varchar(4) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `CostOfOneItem` decimal(10,2) NOT NULL,
  `Status` varchar(50) DEFAULT 'Pending Manager Approval'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `SupplierID` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `ContactNumber` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`SupplierID`, `Name`, `Address`, `ContactNumber`) VALUES
(0, 'BUILD IT', 'MBABANE', '76544332'),
(1, 'Simphiwe', 'Manzini', '76061545'),
(2, 'Senzo', 'Nhlangano', '76098678'),
(3, 'Thabo', 'Mbabane', '76123456'),
(4, 'Lindiwe', 'Hhohho', '76234567'),
(5, 'Sibusiso', 'Lubombo', '76345678'),
(6, 'Nomsa', 'Manzini', '76456789'),
(7, 'Musa', 'Nhlangano', '76567890'),
(8, 'Zanele', 'Mbabane', '76678901'),
(10, 'Susan', 'Lubombo', '76890123'),
(11, 'Simphiwe', 'Manzini', '76061545');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_orders`
--

CREATE TABLE `supplier_orders` (
  `OrderID` int(11) NOT NULL,
  `ProductCode` varchar(255) NOT NULL,
  `QuantityAdded` int(11) NOT NULL,
  `OrderDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier_orders`
--

INSERT INTO `supplier_orders` (`OrderID`, `ProductCode`, `QuantityAdded`, `OrderDate`) VALUES
(1, 'P005', 8, '2025-12-01 05:35:41'),
(2, 'P011', 9, '2025-12-01 05:35:41'),
(3, 'P007', 9, '2025-12-01 05:35:41'),
(4, 'P001', 3, '2025-12-01 05:35:41'),
(5, 'P002', 1, '2025-12-01 05:35:41'),
(6, 'P003', 2, '2025-12-01 05:35:41'),
(7, 'P005', 10, '2025-12-01 05:39:05'),
(8, 'P005', 40, '2025-12-01 06:49:36'),
(9, 'P011', 30, '2025-12-01 06:49:36'),
(10, 'P007', 50, '2025-12-01 06:49:36'),
(11, 'P006', 60, '2025-12-01 06:49:36'),
(12, 'P001', 60, '2025-12-01 06:49:36'),
(13, 'P002', 60, '2025-12-01 06:49:36'),
(14, 'P008', 20, '2025-12-01 06:49:36'),
(15, 'P003', 50, '2025-12-01 06:49:36'),
(16, 'P004', 60, '2025-12-01 06:49:36');

--
-- Triggers `supplier_orders`
--
DELIMITER $$
CREATE TRIGGER `After_Supplier_Order` AFTER INSERT ON `supplier_orders` FOR EACH ROW BEGIN
    UPDATE products 
    SET QuantityAvailable = QuantityAvailable + NEW.QuantityAdded
    WHERE ProductCode = NEW.ProductCode;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'lwandile17lwex', '$2y$10$FwO4dzAMUt.2inhDGu.GY.1xonYjnMVCSHIkhQOo.vaYMG7MBi9ha', 'customer'),
(2, 'Lwakhile', '$2y$10$lUvbPGTfwWpphdhBEk7TxOcyJt7L9ymEcsZGZSblZ9F77RHyGz7HS', 'customer'),
(3, 'Smangs', '$2y$10$wR29fzDPmgUwd3VnDeXET.L4BmXGMQt6H82qCWx0vkE9OPw3qUnAa', 'customer'),
(4, 'NGAGARA', '$2y$10$u4t231HW18pyjWvBVnu4A.vTRjcfa1vIRVl/8S2Rd38ihtcIKaNP2', 'customer'),
(5, 'LOMPHOFU', '$2y$10$kBkSXQ7aQpzdINkJDIaAT.Mj3aewsb0zbwO1aUWnF.4g28X1TXdKG', 'employee'),
(6, 'Khosi', '$2y$10$ADHzwr4VYUVDvMQvqAc0wOUBO5QyYC2KhP4dwKmnqYivgnKHN2nHq', 'customer'),
(7, 'mamsy', '$2y$10$WHWdSjQuusHx/l/t8T9O7u1Cn..PpiSPTnYtBiWw4.Fcw.unjG3dy', 'employee'),
(8, 'lwethu', '$2y$10$XKReDAZdm1uLP3MXkO.ePe7rTS3biWyelgQydxowLkCk3rGRmTsbO', 'customer'),
(9, 'selu', '$2y$10$02npf2oc68IAVakTzerZEO2kg7CCVFfafP8JwiMmhyS/ZAsZDj5VK', 'customer'),
(10, 'yoyo', '$2y$10$BnSyr0K8hMrIMWswHH9uNuIOsvvF8w15j.EqSy/hiVO/E9L8kVMhW', 'employee'),
(11, 'thot', '$2y$10$u1cq1Yqiqmz/QEseEuivv.W1BNNWGJHlo6Xj4UXmu7WjNu1CqYzu2', 'customer'),
(12, 'sese', '$2y$10$l2RfBYGnbSciTjF60GX1p.LHLb4bpx6MA6sUpZFuqIBYxldo3ExYm', 'customer'),
(13, 'seer', '$2y$10$D3Qtg2LBFXBl0STx/rPPdODPZKUhKzW8MZwocHDweiZ4RxpPciqVu', 'employee'),
(14, 'lwaa', '$2y$10$pHh2o/MuEUsF154lb4F9Tu5oixOtvfZjPrI5KQvra6U3AG3i1y75O', 'employee'),
(15, 'we', '$2y$10$p9x6a0vZ6RGFVgSeRAJcPOLP7DAMX/9ac4.pRO1VXzNoBZCnrEwNK', 'customer'),
(16, 'SENA', '$2y$10$HVTXKlmlaGLTS.oz3Sj3j.wH2X0SB6H9S70bhMUBMtJ1kXdZbVu6W', 'customer'),
(17, 'SIPHO', '$2y$10$MxceOW8b5K.tYBhHVEje/eOU4iUwQl/gAMgYi5DR1BIi7SSesXKNC', 'employee'),
(18, 'SENE', '$2y$10$W7bswZ086UeBbiYGrlZ5DeIHWqvRi8BvHjSwfJgluSDLco09X8VGi', 'customer'),
(19, 'MANAKA', '$2y$10$Y2uZ/wUYvMPuUelTaTtAFurB6fNohRGueB9mjExnXTcYbD9KqMhWK', 'employee'),
(20, 'SAMKE', '$2y$10$c01zkfIuXioJ0v4uhLkHjexa0G1BShs4zNtKZ8x2Nx4dXNV8EPvf6', 'customer'),
(21, 'SENZO', '$2y$10$UfZVI6Urbfv7p4y5xptTEevj/bvQDhk6CFn8IkIXcpLneOb.HXgFi', 'employee'),
(22, 'Ane', '$2y$10$DIhe8lHWa7I.KoSdAeOw/OjVjW9iY.kJfJJ846DCVUR77bxRqNU02', 'employee'),
(23, 'LWA', '$2y$10$6FXeqmBGThOIKObsMjXjfe/yu/TBm96jypO5vRzXJbUYVFAHQXIkq', 'customer'),
(24, 'THOKAZI', '$2y$10$usiEVLksmU.BoLGJxtNioO5zdCj5iK1lBiCKZnv9Uoz/HbxUU70WK', 'employee'),
(25, 'MR FUNN', 'funn', 'ceo'),
(26, 'LWAKHILE', 'lwah', 'ceo'),
(27, 'MaMntimande', '79510192', 'supervisor');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`InvoiceID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductCode`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`PurchaseID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `ProductCode` (`ProductCode`);

--
-- Indexes for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD PRIMARY KEY (`RequestID`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SupplierID`);

--
-- Indexes for table `supplier_orders`
--
ALTER TABLE `supplier_orders`
  ADD PRIMARY KEY (`OrderID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `EmployeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `InvoiceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1052;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `PurchaseID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  MODIFY `RequestID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier_orders`
--
ALTER TABLE `supplier_orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`);

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`ProductCode`) REFERENCES `products` (`ProductCode`);
--
-- Database: `limkokwing_student_loan`
--
CREATE DATABASE IF NOT EXISTS `limkokwing_student_loan` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `limkokwing_student_loan`;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `description`, `ip_address`, `created_at`) VALUES
(1, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 06:01:25'),
(2, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 06:01:50'),
(3, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 06:12:45'),
(4, 5, 'REGISTRATION_STATUS', 'Student #1 set to FULLY REGISTERED', '::1', '2026-11-08 06:13:03'),
(5, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 06:13:29'),
(6, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 06:13:49'),
(7, 1, 'LOAN_APPLICATION', 'Application #1', '::1', '2026-11-08 06:41:21'),
(8, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 06:41:34'),
(9, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 06:41:39'),
(10, 5, 'REGISTRATION_STATUS', 'Student #1 set to FULLY REGISTERED', '::1', '2026-11-08 06:41:45'),
(11, 5, 'LOAN_APPROVED', 'Application #1 approved for E 400.00', '::1', '2026-11-08 06:42:04'),
(12, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 06:42:09'),
(13, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 06:42:14'),
(14, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 06:43:49'),
(15, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 06:43:54'),
(16, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 06:50:31'),
(17, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 06:50:36'),
(18, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 07:10:04'),
(19, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 07:10:10'),
(20, 5, 'REPAYMENT', 'Loan #1 repayment E400.00', '::1', '2026-11-08 07:10:58'),
(21, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 07:11:17'),
(22, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 07:11:25'),
(23, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 07:26:10'),
(24, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 07:26:15'),
(25, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 07:37:48'),
(26, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 07:37:55'),
(27, 1, 'LOAN_APPLICATION', 'Application #2', '::1', '2026-11-08 07:39:31'),
(28, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 07:39:37'),
(29, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 07:39:42'),
(30, 5, 'LOAN_APPROVED', 'Application #2 approved for E 500.00', '::1', '2026-11-08 07:40:04'),
(31, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 07:40:08'),
(32, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 07:40:12'),
(33, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 08:05:51'),
(34, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 08:05:56'),
(35, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 08:07:33'),
(36, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 08:07:44'),
(37, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 08:09:59'),
(38, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 08:10:30'),
(39, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 08:12:26'),
(40, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 08:12:39'),
(41, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 08:12:52'),
(42, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 08:13:08'),
(43, 5, 'REGISTRATION_STATUS', 'Student #1 set to FULLY REGISTERED', '::1', '2026-11-08 08:17:16'),
(44, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 08:22:00'),
(45, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 08:23:24'),
(46, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 08:23:44'),
(47, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 09:04:22'),
(48, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 09:06:21'),
(49, 5, 'LOGIN', 'Successful login', '::1', '2026-11-08 09:08:22'),
(50, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-08 09:09:31'),
(51, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 09:09:40'),
(52, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 09:15:30'),
(53, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 09:24:48'),
(54, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 09:26:47'),
(55, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 09:26:58'),
(56, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-08 09:29:02'),
(57, 1, 'LOGIN', 'Successful login', '::1', '2026-11-08 10:02:41'),
(58, 1, 'LOGIN', 'Successful login', '::1', '2026-11-09 08:20:41'),
(59, 1, 'LOAN_APPLICATION', 'Application #3', '::1', '2026-11-09 08:49:31'),
(60, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-09 08:50:07'),
(61, 5, 'LOGIN', 'Successful login', '::1', '2026-11-09 08:50:16'),
(62, 5, 'LOAN_APPROVED', 'Application #3 approved for E 100.00', '::1', '2026-11-09 08:50:45'),
(63, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-09 08:50:56'),
(64, 1, 'LOGIN', 'Successful login', '::1', '2026-11-09 08:51:03'),
(65, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-09 09:00:18'),
(66, 5, 'LOGIN', 'Successful login', '::1', '2026-11-09 09:00:24'),
(67, 5, 'REGISTRATION_STATUS', 'Student #1 set to FULLY REGISTERED', '::1', '2026-11-09 09:00:36'),
(68, 5, 'LOGOUT', 'User logged out', '::1', '2026-11-09 09:32:14'),
(69, 1, 'LOGIN', 'Successful login', '::1', '2026-11-09 09:32:19'),
(70, 1, 'LOGOUT', 'User logged out', '::1', '2026-11-09 09:50:45'),
(71, 5, 'LOGIN', 'Successful login', '::1', '2026-11-09 09:50:51');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `approved_amount` decimal(12,2) NOT NULL,
  `term_months` int(11) NOT NULL,
  `monthly_installment` decimal(12,2) NOT NULL,
  `disbursement_method` enum('MTN_MOBILE_MONEY','BANK_ACCOUNT') NOT NULL,
  `mtn_number` varchar(40) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `account_holder_name` varchar(150) DEFAULT NULL,
  `disbursement_status` enum('PENDING','DISBURSED') DEFAULT 'PENDING',
  `disbursed_at` timestamp NULL DEFAULT NULL,
  `repayment_start_date` date DEFAULT NULL,
  `repayment_end_date` date DEFAULT NULL,
  `outstanding_balance` decimal(12,2) NOT NULL,
  `status` enum('ACTIVE','COMPLETED') DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `application_id`, `student_id`, `approved_amount`, `term_months`, `monthly_installment`, `disbursement_method`, `mtn_number`, `bank_name`, `account_number`, `account_holder_name`, `disbursement_status`, `disbursed_at`, `repayment_start_date`, `repayment_end_date`, `outstanding_balance`, `status`, `created_at`) VALUES
(1, 1, 1, 400.00, 3, 133.33, 'MTN_MOBILE_MONEY', '76981306', NULL, NULL, NULL, 'PENDING', NULL, '2026-12-01', '2027-02-01', 0.00, 'COMPLETED', '2026-11-08 06:42:04'),
(2, 2, 1, 500.00, 1, 500.00, 'MTN_MOBILE_MONEY', '76444224', NULL, NULL, NULL, 'PENDING', NULL, '2026-12-01', '2026-12-01', 0.00, 'COMPLETED', '2026-11-08 07:40:04'),
(3, 3, 1, 100.00, 3, 33.33, 'MTN_MOBILE_MONEY', '76981306', NULL, NULL, NULL, 'PENDING', NULL, '2026-12-01', '2027-02-01', 0.00, 'COMPLETED', '2026-11-09 08:50:45');

-- --------------------------------------------------------

--
-- Table structure for table `loan_applications`
--

CREATE TABLE `loan_applications` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `loan_type` enum('Tuition Fees','Accommodation','Learning Materials','Transport','Emergency') NOT NULL,
  `requested_amount` decimal(12,2) NOT NULL,
  `reason` text NOT NULL,
  `collateral` text DEFAULT NULL,
  `guarantor_name` varchar(150) DEFAULT NULL,
  `guarantor_relation` varchar(100) DEFAULT NULL,
  `disbursement_method` enum('MTN_MOBILE_MONEY','BANK_ACCOUNT') NOT NULL,
  `mtn_number` varchar(40) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_number` varchar(100) DEFAULT NULL,
  `account_holder_name` varchar(150) DEFAULT NULL,
  `status` enum('PENDING','APPROVED','REJECTED') DEFAULT 'PENDING',
  `admin_comment` text DEFAULT NULL,
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `guarantor_phone` varchar(30) DEFAULT NULL,
  `guarantor_relationship` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_applications`
--

INSERT INTO `loan_applications` (`id`, `student_id`, `loan_type`, `requested_amount`, `reason`, `collateral`, `guarantor_name`, `guarantor_relation`, `disbursement_method`, `mtn_number`, `bank_name`, `account_number`, `account_holder_name`, `status`, `admin_comment`, `applied_at`, `reviewed_at`, `guarantor_phone`, `guarantor_relationship`) VALUES
(1, 1, 'Tuition Fees', 400.00, 'tuition fees', 'laptop', 'Lungile Dlamini', 'parent', 'MTN_MOBILE_MONEY', '76981306', NULL, NULL, NULL, 'APPROVED', '', '2026-11-08 06:41:21', '2026-11-08 06:42:04', '+26876444223', NULL),
(2, 1, 'Accommodation', 500.00, 'accomodation', 'laptop', 'Nkosenhle Hlatshwako', 'parent', 'MTN_MOBILE_MONEY', '76444224', NULL, NULL, NULL, 'APPROVED', '', '2026-11-08 07:39:31', '2026-11-08 07:40:04', '+26876981306', NULL),
(3, 1, 'Transport', 100.00, 'for transport', 'phone', 'Khaya Bhembe', 'parent', 'MTN_MOBILE_MONEY', '76981306', NULL, NULL, NULL, 'APPROVED', '', '2026-11-09 08:49:31', '2026-11-09 08:50:45', '+26876444223', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `is_read`, `created_at`) VALUES
(1, 1, 'Loan Approved', 'Your loan application #1 was approved.', 1, '2026-11-08 06:42:04'),
(2, 1, 'Loan Approved', 'Your loan application #2 was approved.', 1, '2026-11-08 07:40:04'),
(3, 1, 'Loan Approved', 'Your loan application #3 was approved.', 1, '2026-11-09 08:50:45');

-- --------------------------------------------------------

--
-- Table structure for table `repayments`
--

CREATE TABLE `repayments` (
  `id` int(11) NOT NULL,
  `loan_id` int(11) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_date` date NOT NULL,
  `reference` varchar(100) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('PENDING','VERIFIED','REJECTED') NOT NULL DEFAULT 'VERIFIED'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `repayments`
--

INSERT INTO `repayments` (`id`, `loan_id`, `amount`, `payment_date`, `reference`, `notes`, `created_at`, `status`) VALUES
(1, 1, 400.00, '2026-11-08', '', '', '2026-11-08 07:10:58', 'VERIFIED'),
(2, 2, 500.00, '2026-11-08', NULL, NULL, '2026-11-08 07:51:24', 'VERIFIED'),
(3, 3, 33.33, '2026-11-09', NULL, NULL, '2026-11-09 08:51:56', 'VERIFIED'),
(4, 3, 66.67, '2026-11-09', NULL, NULL, '2026-11-09 08:52:48', 'VERIFIED');

-- --------------------------------------------------------

--
-- Table structure for table `service_earnings`
--

CREATE TABLE `service_earnings` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `service_title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_reference` varchar(100) DEFAULT NULL,
  `status` enum('PENDING','CREDITED','REJECTED') NOT NULL DEFAULT 'PENDING',
  `credited_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `uncredited_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `admin_notes` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `service_earnings`
--

INSERT INTO `service_earnings` (`id`, `student_id`, `service_title`, `description`, `amount`, `payment_reference`, `status`, `credited_amount`, `uncredited_amount`, `admin_notes`, `submitted_at`, `reviewed_by`, `reviewed_at`) VALUES
(1, 1, 'web development', 'designed the web', 400.00, '12', 'PENDING', 0.00, 0.00, NULL, '2026-11-08 07:44:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `student_number` varchar(60) NOT NULL,
  `first_name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `programme` varchar(150) NOT NULL,
  `year_level` varchar(40) NOT NULL,
  `registration_status` enum('PENDING','FULLY REGISTERED','NOT REGISTERED') NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `student_number`, `first_name`, `last_name`, `phone`, `programme`, `year_level`, `registration_status`, `created_at`) VALUES
(1, 1, '902012628', 'Sethu', 'Dlamini', '76981305', 'IT', '3', 'FULLY REGISTERED', '2026-11-08 06:01:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(80) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('student','admin') NOT NULL DEFAULT 'student',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `created_at`) VALUES
(1, 'sethu', 'sethu@gmail.com', '$2y$10$a/TSQNLp0dTyfgfxCWwKyuW7/fJjsIuWmiaBoHWJs.lZruXLRmerC', 'student', '2026-11-08 06:01:20'),
(2, 'admin', 'admin@example.com', '$2y$10$iwFprytV.m6SIE8pwl1U6utXC5MRflKZQFDsVdD22VP5C4kRdqDR6', 'admin', '2026-11-08 06:10:15'),
(5, 'Kimmich', 'admin@gmail.com', '$2y$10$cUnDPJ2O5Q8tugnk9PM7o.lP22yW10mKxa.9zQKed0EJ7AhSMA4fq', 'admin', '2026-11-08 06:12:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `application_id` (`application_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `loan_applications`
--
ALTER TABLE `loan_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `repayments`
--
ALTER TABLE `repayments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `service_earnings`
--
ALTER TABLE `service_earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_service_student` (`student_id`),
  ADD KEY `idx_service_status` (`status`),
  ADD KEY `fk_service_earning_admin` (`reviewed_by`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `student_number` (`student_number`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `loan_applications`
--
ALTER TABLE `loan_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `repayments`
--
ALTER TABLE `repayments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `service_earnings`
--
ALTER TABLE `service_earnings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`application_id`) REFERENCES `loan_applications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `loans_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `loan_applications`
--
ALTER TABLE `loan_applications`
  ADD CONSTRAINT `loan_applications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `repayments`
--
ALTER TABLE `repayments`
  ADD CONSTRAINT `repayments_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `service_earnings`
--
ALTER TABLE `service_earnings`
  ADD CONSTRAINT `fk_service_earning_admin` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_service_earning_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `mihla`
--
CREATE DATABASE IF NOT EXISTS `mihla` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mihla`;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--
-- Error reading structure for table mihla.bookings: #1932 - Table &#039;mihla.bookings&#039; doesn&#039;t exist in engine
-- Error reading data for table mihla.bookings: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `mihla`.`bookings`&#039; at line 1
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Dumping data for table `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'server', 'hloba_sneaker_wash', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"db_select[]\":[\"hloba_sneaker_wash\",\"mihla\",\"phpmyadmin\",\"student_db\",\"student_management\",\"test\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@SERVER@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_columns\":\"something\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Structure of table @TABLE@\",\"latex_structure_continued_caption\":\"Structure of table @TABLE@ (continued)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Content of table @TABLE@\",\"latex_data_continued_caption\":\"Content of table @TABLE@ (continued)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"yaml_structure_or_data\":\"data\",\"\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_simple_view_export\":null,\"sql_view_current_user\":null,\"sql_or_replace_view\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"limkokwing_student_loan\",\"table\":\"repayments\"},{\"db\":\"limkokwing_student_loan\",\"table\":\"loans\"},{\"db\":\"limkokwing_student_loan\",\"table\":\"loan_applications\"},{\"db\":\"hloba_sneaker_wash\",\"table\":\"student\"},{\"db\":\"hloba_sneaker_wash\",\"table\":\"Student\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-11-08 09:31:47', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `puma_db`
--
CREATE DATABASE IF NOT EXISTS `puma_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `puma_db`;

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `user_id`, `check_in`, `check_out`) VALUES
(1, 3, '2026-11-19 10:16:37', '2026-11-19 10:16:41');

-- --------------------------------------------------------

--
-- Table structure for table `payroll_history`
--

CREATE TABLE `payroll_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `employee_name` varchar(100) DEFAULT NULL,
  `bank_account` varchar(50) DEFAULT NULL,
  `total_hours` decimal(10,2) DEFAULT NULL,
  `gross_pay` decimal(10,2) DEFAULT NULL,
  `deductions` decimal(10,2) DEFAULT NULL,
  `net_pay` decimal(10,2) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `pay_period` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('employee','hr','admin') NOT NULL DEFAULT 'employee',
  `bank_account` varchar(50) DEFAULT 'Not Provided',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `bank_account`, `created_at`) VALUES
(1, 'admin', '$2y$10$sIzMwSENck7YpY8H5/QlA.0CdUpgGMgeSc6SkYIklgSpQ34d4c7MS', 'hr', '80700020', '2026-10-29 22:36:57'),
(2, 'Kimmich', '$2y$10$HJM2slZOVr1xAKvxBdY8cu1VibKSN/BnfqGn/wrBXFs0DjkbJ2bUq', 'hr', '903023', '2026-11-19 08:15:25'),
(3, 'sethu', '$2y$10$tf/Y5pX5NwPQUT7ri7ZWj.fQtpeWRjbucT8qbro3hH1Xmt6YOLcIi', 'employee', '6765554', '2026-11-19 08:16:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `payroll_history`
--
ALTER TABLE `payroll_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payroll_history`
--
ALTER TABLE `payroll_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `student_db`
--
CREATE DATABASE IF NOT EXISTS `student_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `student_db`;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--
-- Error reading structure for table student_db.students: #1932 - Table &#039;student_db.students&#039; doesn&#039;t exist in engine
-- Error reading data for table student_db.students: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `student_db`.`students`&#039; at line 1
--
-- Database: `student_grading_db`
--
CREATE DATABASE IF NOT EXISTS `student_grading_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `student_grading_db`;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_code` varchar(15) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `credits` int(11) NOT NULL CHECK (`credits` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_code`, `course_name`, `credits`) VALUES
('AIDM3108', 'Data Models and Algorithms', 4),
('BICT3102', 'Database Management Systems', 3),
('BICT3105', 'Object Oriented Programming', 4);

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `grade_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  `course_code` varchar(15) NOT NULL,
  `marks` double NOT NULL CHECK (`marks` >= 0 and `marks` <= 100),
  `grade_point` double NOT NULL,
  `letter_grade` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`grade_id`, `student_id`, `course_code`, `marks`, `grade_point`, `letter_grade`) VALUES
(1, '901012345', 'AIDM3108', 85, 4, 'A'),
(2, '901012345', 'BICT3102', 74, 3.3, 'B+'),
(3, '901012341', 'AIDM3108', 62, 2.7, 'C+'),
(4, '901012349', 'BICT3105', 91, 4, 'A+'),
(5, '901012342', 'AIDM3108', 70, 3.3, 'B+');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `first_name`, `last_name`, `email`, `phone`) VALUES
('901012341', 'Sipho', 'Nkosi', 'sipho.nkosi@student.ac.sz', '78234567'),
('901012342', 'Lindo', 'Mamba', 'lindo@gmail.com', '79866656'),
('901012345', 'Thabo', 'Dlamini', 'thabo.dlamini@student.ac.sz', '76123456'),
('901012349', 'Nomsa', 'Mamba', 'nomsa.mamba@student.ac.sz', '76345678');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_code`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`grade_id`),
  ADD UNIQUE KEY `student_id` (`student_id`,`course_code`),
  ADD KEY `course_code` (`course_code`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `grade_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`course_code`) REFERENCES `courses` (`course_code`) ON DELETE CASCADE;
--
-- Database: `student_management`
--
CREATE DATABASE IF NOT EXISTS `student_management` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `student_management`;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--
-- Error reading structure for table student_management.students: #1932 - Table &#039;student_management.students&#039; doesn&#039;t exist in engine
-- Error reading data for table student_management.students: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `student_management`.`students`&#039; at line 1
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Database: `user_admin_chat`
--
CREATE DATABASE IF NOT EXISTS `user_admin_chat` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `user_admin_chat`;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('USER','ADMIN') NOT NULL DEFAULT 'USER',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
