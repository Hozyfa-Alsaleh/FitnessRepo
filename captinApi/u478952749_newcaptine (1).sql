-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 25, 2023 at 01:00 PM
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
(3, 'Mualla', NULL, 'mualla@gmail.com', 'mualla123', '099100000', 0, NULL, 'user'),
(4, 'saleh', NULL, 'saleh@gmail.com', '12345678', '', 0, NULL, 'user'),
(5, 'Hozyfa', NULL, 'hozyfa.sm@gmail.com', '12345678', '09910769730000', 1, '0000-00-00', 'user'),
(7, 'Ahmad', 'Abbas', 'ahmad@gmail.com', 'ahmad123', '+9639876532123', 1, '0000-00-00', 'user'),
(8, 'Hozyfa', 'Al-Saleh', 'hozyfa@gmail.com', 'hozyfa123', '+9639874563211', 1, '2023-12-10', 'user'),
(10, 'sleman', 'mhmad', 'sleman11@gmail.com', '123451234', '91234567899122', 1, '0000-00-00', 'user');

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
(9, 5, 'IMG_20231204_152946.jpg'),
(10, 5, 'IMG_20231204_152939.jpg'),
(11, 4, 'IMG_20231204_152946.jpg'),
(12, 4, 'IMG_20231204_152939.jpg'),
(13, 4, 'IMG_20231204_152954.jpg'),
(14, 4, 'IMG_20231213_044440.jpg'),
(15, 7, 'IMG_20231204_152946.jpg'),
(16, 7, 'IMG_20231204_152954.jpg'),
(17, 10, 'FB_IMG_4969726832997845992.jpg'),
(18, 10, 'FB_IMG_4969726832997845992.jpg'),
(19, 10, 'FB_IMG_4969726832997845992.jpg'),
(20, 11, 'Screenshot_20231222-185212.png'),
(21, 11, 'IMG-20231221-WA0022.jpg'),
(22, 11, 'IMG-20231221-WA0021.jpg'),
(23, 5, 'IMG-20231221-WA0022.jpg'),
(24, 5, 'IMG-20231221-WA0021.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `contactinfo`
--

CREATE TABLE `contactinfo` (
  `con_id` int(10) NOT NULL,
  `barcodeurl` text NOT NULL,
  `phone` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `contactinfo`
--

INSERT INTO `contactinfo` (`con_id`, `barcodeurl`, `phone`) VALUES
(6, 'FB_IMG_1703131674230.jpg', '933333333333');

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

--
-- Dumping data for table `exercises`
--

INSERT INTO `exercises` (`exe_id`, `details`, `day_id`, `acc_id`) VALUES
(2, 'new first course', 1, 5),
(3, 'new second course', 1, 5),
(4, 'new third course', 1, 5),
(5, 'first for Monday', 2, 5),
(6, 'first exe for ahmad', 1, 7),
(8, 'التمرين الأول لليوم الأول لسليمان', 1, 10),
(9, 'test for notify add exe', 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `food_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL,
  `meal` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`food_id`, `acc_id`, `meal`) VALUES
(7, 7, 'First Food Course For Ahmad'),
(8, 10, 'كول كول بطاطا لقلك');

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
(27, 7, '63', '179', '22', 'third hall', 'homs', '3', '8', 'عالي', 'tow years', 'زيادة وزن وحجم', 'الخيار للمدرب', 'ddddd', 'fffffff'),
(31, 10, '90', '180', '28', '1', 'homs', '9', '10', 'متوسط', 'سنة', 'خسارة وزن', 'لا', 'لا', 'لا'),
(32, 10, '90', '180', '28', '1', 'homs', '9', '10', 'متوسط', 'سنة', 'خسارة وزن', 'لا', 'لا', 'لا'),
(33, 10, '90', '180', '28', '1', 'homs', '9', '10', 'متوسط', 'سنة', 'خسارة وزن', 'لا', 'لا', 'لا'),
(35, 5, '62', '183', '22', 'القاعة الاولى', 'حمص', '٧', '٢٣', 'عالي', 'منذ شهرين', 'زيادة وزن وحجم', 'لا', 'لا يوجد اطعمة', 'لايوجد');

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

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notify_id`, `acc_id`, `notic_title`, `notice_text`, `notic_date`, `notic_time`) VALUES
(1, 8, 'إشعار الإشتراك', 'للأسف تم رفض طلبك ', '2023-12-25', '02:10:00'),
(2, 8, 'إشعار الإشتراك', 'تم قبول طلبك سيقوم الكابتن شعيب بإضافة الكورسات اللازمة', '2023-12-25', '02:36:00'),
(3, 1, 'طلب إشتراك', 'المستخدم Hozyfa قام بإرسال طلب اشتراك', '2023-12-10', '03:15:00');

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
(1, 'باقة صغيرة', '30', '1000', 'هذه الباقة لا تحوي كورس'),
(2, 'باقة متوسطة', '50', '15$', 'هذه الباقة المتوسطة');

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
(2, 3, 'IMG_20231223_024529.jpg'),
(5, 4, 'IMG_20231221_142508.jpg'),
(8, 5, 'IMG_20231221_142508.jpg'),
(10, 7, 'IMG_20231223_024523.jpg'),
(11, 8, 'IMG_20231221_182130_369.jpg'),
(12, 10, '1000014581.jpg');

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

-- --------------------------------------------------------

--
-- Table structure for table `supplements`
--

CREATE TABLE `supplements` (
  `supp_id` int(10) NOT NULL,
  `acc_id` int(10) NOT NULL,
  `supp` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `supplements`
--

INSERT INTO `supplements` (`supp_id`, `acc_id`, `supp`) VALUES
(4, 7, 'First Hormon Course For Ahmad'),
(5, 10, 'أخي لا مكملات ولا شي \nالكمال لله وحده');

-- --------------------------------------------------------

--
-- Table structure for table `testlist`
--

CREATE TABLE `testlist` (
  `img_id` int(11) NOT NULL,
  `image` text NOT NULL,
  `acc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `testlist`
--

INSERT INTO `testlist` (`img_id`, `image`, `acc_id`) VALUES
(16, 'IMG_20231204_152946.jpg', 5),
(17, 'IMG_20231204_152939.jpg', 5),
(18, 'IMG_20231213_044440.jpg', 5),
(19, 'IMG_20231204_152954.jpg', 5);

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
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`vid_id`, `videourl`, `exe_id`) VALUES
(2, 'VID_20231216_025117.mp4', 5),
(3, 'VID_20231216_025128.mp4', 5),
(4, 'VID_20231216_025100.mp4', 5),
(5, 'VID_20231216_025117.mp4', 6),
(6, 'VID_20231216_025128.mp4', 6);

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
  MODIFY `acc_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `bodyimages`
--
ALTER TABLE `bodyimages`
  MODIFY `body_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `contactinfo`
--
ALTER TABLE `contactinfo`
  MODIFY `con_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `days`
--
ALTER TABLE `days`
  MODIFY `day_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `exercises`
--
ALTER TABLE `exercises`
  MODIFY `exe_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `food_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `information`
--
ALTER TABLE `information`
  MODIFY `info_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notify_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `package_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `profilephoto`
--
ALTER TABLE `profilephoto`
  MODIFY `profile_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `subscribe`
--
ALTER TABLE `subscribe`
  MODIFY `subscribe_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `supplements`
--
ALTER TABLE `supplements`
  MODIFY `supp_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `testlist`
--
ALTER TABLE `testlist`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `vid_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
