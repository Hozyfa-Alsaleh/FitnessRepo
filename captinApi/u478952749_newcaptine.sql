-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 30, 2023 at 10:34 PM
-- Server version: 10.6.15-MariaDB-cll-lve
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u478952749_newcaptine`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `acc_id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `nickname` varchar(50) DEFAULT '_',
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `status` int(2) NOT NULL DEFAULT 0,
  `stopwatch` date DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`acc_id`, `name`, `nickname`, `email`, `password`, `phone`, `status`, `stopwatch`, `type`) VALUES
(1, 'admin', 'adm', 'admin@gmail.com', 'admin123', '0991076973', 1, NULL, 'admin'),
(20, 'Ali', 'White', 'alialhusaini01@gmail.com', 'good99bad00', '07729716540000', 2, NULL, 'user'),
(21, 'Ali', 'Alosh', 'alisuariz99ali@gmail.com', 'good99bad00', '9647729716540+', 0, NULL, 'user'),
(22, 'yousf', 'duraed', 'yousfgym@gmail.com', 'yousfyousf', '+9647730249202', 2, NULL, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `bodyimages`
--

CREATE TABLE `bodyimages` (
  `body_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL,
  `imgUrl` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `bodyimages`
--

INSERT INTO `bodyimages` (`body_id`, `acc_id`, `imgUrl`) VALUES
(54, 21, 'IMG_20231130_113555.jpg'),
(55, 21, 'IMG_20231130_113619.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `contactinfo`
--

CREATE TABLE `contactinfo` (
  `con_id` int(10) NOT NULL,
  `barcodeurl` text NOT NULL,
  `phone` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `days`
--

CREATE TABLE `days` (
  `day_id` int(10) NOT NULL,
  `dayname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `days`
--

INSERT INTO `days` (`day_id`, `dayname`) VALUES
(1, 'الأحد'),
(2, 'الإثنين'),
(3, 'الثلاثاء'),
(4, 'الأربعاء'),
(5, 'الخميس'),
(6, 'الجمعة'),
(7, 'السبت');

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

CREATE TABLE `exercises` (
  `exe_id` int(10) NOT NULL,
  `details` text NOT NULL,
  `day_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `food_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL,
  `meal` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `information`
--

CREATE TABLE `information` (
  `info_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL,
  `weight` varchar(50) NOT NULL,
  `height` varchar(50) NOT NULL,
  `age` varchar(50) NOT NULL,
  `hall` varchar(50) NOT NULL,
  `area` varchar(50) NOT NULL,
  `sleephours` varchar(50) NOT NULL,
  `workhours` varchar(50) NOT NULL,
  `workstrees` varchar(50) NOT NULL,
  `gamehistory` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `usehormon` varchar(50) NOT NULL,
  `cannon` varchar(50) NOT NULL,
  `unlikedfood` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `information`
--

INSERT INTO `information` (`info_id`, `acc_id`, `weight`, `height`, `age`, `hall`, `area`, `sleephours`, `workhours`, `workstrees`, `gamehistory`, `target`, `usehormon`, `cannon`, `unlikedfood`) VALUES
(55, 21, '83', '185', '19', 'ديزل ', 'بعقوبة', '8', '10', 'متوسط', '١٢شهر ', 'زيادة وزن وحجم', 'لا', 'لا يوجد ', 'لا يوجد ');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notify_id` int(11) NOT NULL,
  `acc_id` int(11) NOT NULL,
  `notic_title` text DEFAULT NULL,
  `notice_text` text DEFAULT NULL,
  `notic_date` date DEFAULT NULL,
  `notic_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE `package` (
  `package_id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL,
  `price` varchar(50) NOT NULL,
  `details` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`package_id`, `name`, `time`, `price`, `details`) VALUES
(4, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `profilephoto`
--

CREATE TABLE `profilephoto` (
  `profile_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL,
  `imgUrl` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `profilephoto`
--

INSERT INTO `profilephoto` (`profile_id`, `acc_id`, `imgUrl`) VALUES
(17, 21, 'Snapchat-1107099938_edit_683351925845727.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `subscribe`
--

CREATE TABLE `subscribe` (
  `subscribe_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL,
  `package_id` int(10) NOT NULL,
  `imgurl` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `subscribe`
--

INSERT INTO `subscribe` (`subscribe_id`, `acc_id`, `package_id`, `imgurl`) VALUES
(65, 21, 4, 'Screenshot_20231228_110818_com.instagram.android.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `supplements`
--

CREATE TABLE `supplements` (
  `supp_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL,
  `supp` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testlist`
--

CREATE TABLE `testlist` (
  `img_id` int(11) NOT NULL,
  `image` text NOT NULL,
  `acc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `vid_id` int(10) NOT NULL,
  `videourl` text NOT NULL,
  `exe_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`acc_id`);

--
-- Indexes for table `bodyimages`
--
ALTER TABLE `bodyimages`
  ADD PRIMARY KEY (`body_id`);

--
-- Indexes for table `contactinfo`
--
ALTER TABLE `contactinfo`
  ADD PRIMARY KEY (`con_id`);

--
-- Indexes for table `days`
--
ALTER TABLE `days`
  ADD PRIMARY KEY (`day_id`);

--
-- Indexes for table `exercises`
--
ALTER TABLE `exercises`
  ADD PRIMARY KEY (`exe_id`),
  ADD KEY `exe_acc` (`acc_id`),
  ADD KEY `exe_day` (`day_id`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`food_id`),
  ADD KEY `food_acc` (`acc_id`);

--
-- Indexes for table `information`
--
ALTER TABLE `information`
  ADD PRIMARY KEY (`info_id`),
  ADD KEY `information_account` (`acc_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notify_id`),
  ADD KEY `notic_user` (`acc_id`);

--
-- Indexes for table `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`package_id`);

--
-- Indexes for table `profilephoto`
--
ALTER TABLE `profilephoto`
  ADD PRIMARY KEY (`profile_id`),
  ADD KEY `profile_account` (`acc_id`);

--
-- Indexes for table `subscribe`
--
ALTER TABLE `subscribe`
  ADD PRIMARY KEY (`subscribe_id`),
  ADD KEY `subscribe_account` (`acc_id`),
  ADD KEY `sunscribe_package` (`package_id`);

--
-- Indexes for table `supplements`
--
ALTER TABLE `supplements`
  ADD PRIMARY KEY (`supp_id`),
  ADD KEY `supp_acc` (`acc_id`);

--
-- Indexes for table `testlist`
--
ALTER TABLE `testlist`
  ADD PRIMARY KEY (`img_id`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`vid_id`),
  ADD KEY `video_exe` (`exe_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `acc_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `bodyimages`
--
ALTER TABLE `bodyimages`
  MODIFY `body_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `contactinfo`
--
ALTER TABLE `contactinfo`
  MODIFY `con_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `days`
--
ALTER TABLE `days`
  MODIFY `day_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `exercises`
--
ALTER TABLE `exercises`
  MODIFY `exe_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `food_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `information`
--
ALTER TABLE `information`
  MODIFY `info_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notify_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `package_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `profilephoto`
--
ALTER TABLE `profilephoto`
  MODIFY `profile_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `subscribe`
--
ALTER TABLE `subscribe`
  MODIFY `subscribe_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `supplements`
--
ALTER TABLE `supplements`
  MODIFY `supp_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `testlist`
--
ALTER TABLE `testlist`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `vid_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `exercises`
--
ALTER TABLE `exercises`
  ADD CONSTRAINT `exe_acc` FOREIGN KEY (`acc_id`) REFERENCES `accounts` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `exe_day` FOREIGN KEY (`day_id`) REFERENCES `days` (`day_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `food`
--
ALTER TABLE `food`
  ADD CONSTRAINT `food_acc` FOREIGN KEY (`acc_id`) REFERENCES `accounts` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `information`
--
ALTER TABLE `information`
  ADD CONSTRAINT `information_account` FOREIGN KEY (`acc_id`) REFERENCES `accounts` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notic_user` FOREIGN KEY (`acc_id`) REFERENCES `accounts` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `profilephoto`
--
ALTER TABLE `profilephoto`
  ADD CONSTRAINT `profile_account` FOREIGN KEY (`acc_id`) REFERENCES `accounts` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subscribe`
--
ALTER TABLE `subscribe`
  ADD CONSTRAINT `subscribe_account` FOREIGN KEY (`acc_id`) REFERENCES `accounts` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sunscribe_package` FOREIGN KEY (`package_id`) REFERENCES `package` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `supplements`
--
ALTER TABLE `supplements`
  ADD CONSTRAINT `supp_acc` FOREIGN KEY (`acc_id`) REFERENCES `accounts` (`acc_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `video_exe` FOREIGN KEY (`exe_id`) REFERENCES `exercises` (`exe_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
