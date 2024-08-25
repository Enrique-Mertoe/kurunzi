-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 09, 2024 at 07:31 AM
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
-- Database: `kenya_today`
--

-- --------------------------------------------------------

--
-- Table structure for table `ket_comments`
--

CREATE TABLE `ket_comments` (
  `c_id` varchar(100) NOT NULL,
  `uid` varchar(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `date` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ket_follow`
--

CREATE TABLE `ket_follow` (
  `id` int(11) NOT NULL,
  `uid` varchar(100) NOT NULL,
  `follows` varchar(100) NOT NULL,
  `date` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ket_follow`
--

INSERT INTO `ket_follow` (`id`, `uid`, `follows`, `date`) VALUES
(30, '-O35T8MSamFApqWPpw2C', '-O35U90NAg8ObWPXxaLV', 1722408821),
(31, '-O35T8MSamFApqWPpw2C', '-O35T8MSamFApqWPpw2C', 1722408824),
(32, '-O3D84iMqUa8iFJL5773', '-O35U90NAg8ObWPXxaLV', 1722519189),
(33, '-O3D84iMqUa8iFJL5773', '-O35T8MSamFApqWPpw2C', 1722519190),
(34, '-O3D84iMqUa8iFJL5773', '-O3D84iMqUa8iFJL5773', 1722715467),
(35, '-O3ZqWiTy7BIdmEw_VSp', '-O3PE4OaF92Dde-pvfO5', 1722901469),
(36, '-O3ZqWiTy7BIdmEw_VSp', '-O35T8MSamFApqWPpw2C', 1722901470);

-- --------------------------------------------------------

--
-- Table structure for table `ket_likes`
--

CREATE TABLE `ket_likes` (
  `id` int(11) NOT NULL,
  `uid` varchar(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `l_date` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ket_notifications`
--

CREATE TABLE `ket_notifications` (
  `note_id` varchar(100) NOT NULL,
  `note_from` varchar(100) NOT NULL,
  `note_to` varchar(100) NOT NULL,
  `target` varchar(100) DEFAULT NULL,
  `note_type` enum('like','follow','message','post') NOT NULL,
  `note_time` int(6) NOT NULL,
  `note_status` int(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ket_notifications`
--

INSERT INTO `ket_notifications` (`note_id`, `note_from`, `note_to`, `target`, `note_type`, `note_time`, `note_status`) VALUES
('-O36ZD0xBO6JjSMtkiuv', '-O35T8MSamFApqWPpw2C', '-O35U90NAg8ObWPXxaLV', '-O35U90NAg8ObWPXxaLV', 'follow', 1722408821, 0),
('-O36ZDfYgUB5V9zh3odF', '-O35T8MSamFApqWPpw2C', '-O35T8MSamFApqWPpw2C', '-O35T8MSamFApqWPpw2C', 'follow', 1722408824, 0),
('-O3D8Edp-XS5FI1QUwy8', '-O3D84iMqUa8iFJL5773', '-O35T8MSamFApqWPpw2C', '-O35T8MSamFApqWPpw2C', 'follow', 1722519190, 0),
('-O3D8EOXRtKok31CUlux', '-O3D84iMqUa8iFJL5773', '-O35U90NAg8ObWPXxaLV', '-O35U90NAg8ObWPXxaLV', 'follow', 1722519189, 0),
('-O3Opyiq5K6qwXe3o70j', '-O3D84iMqUa8iFJL5773', '-O3D84iMqUa8iFJL5773', '-O3D84iMqUa8iFJL5773', 'follow', 1722715467, 0),
('-O3ZvWj8nzdI5FqjZ4vs', '-O3ZqWiTy7BIdmEw_VSp', '-O35T8MSamFApqWPpw2C', '-O35T8MSamFApqWPpw2C', 'follow', 1722901470, 0),
('-O3ZvWS5Cb9xK5nF0-IP', '-O3ZqWiTy7BIdmEw_VSp', '-O3PE4OaF92Dde-pvfO5', '-O3PE4OaF92Dde-pvfO5', 'follow', 1722901469, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ket_posts`
--

CREATE TABLE `ket_posts` (
  `p_id` varchar(100) NOT NULL,
  `p_date` int(6) NOT NULL,
  `uid` varchar(100) NOT NULL,
  `p_type` enum('ad','normal') NOT NULL,
  `commenting` int(6) NOT NULL DEFAULT 1,
  `sharing` int(6) NOT NULL DEFAULT 1,
  `on_camera` int(6) NOT NULL DEFAULT 0,
  `views` int(100) NOT NULL DEFAULT 0,
  `post_type` enum('1','2','3','4','5') NOT NULL DEFAULT '1',
  `p_likes` int(100) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ket_post_info`
--

CREATE TABLE `ket_post_info` (
  `id` int(11) NOT NULL,
  `p_id` varchar(100) NOT NULL,
  `status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `category` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `filetype` enum('img','vid') NOT NULL,
  `file_size` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ket_users`
--

CREATE TABLE `ket_users` (
  `uid` varchar(100) NOT NULL,
  `uname` varchar(100) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `bio` varchar(200) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `admin` int(6) NOT NULL DEFAULT 0,
  `county` varchar(100) NOT NULL,
  `constituency` varchar(100) NOT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `joined` int(100) NOT NULL,
  `profile_pic` varchar(150) NOT NULL DEFAULT 'placeholder.jpg',
  `account_type` enum('p','n') NOT NULL DEFAULT 'n',
  `account_category` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ket_users`
--

INSERT INTO `ket_users` (`uid`, `uname`, `fullname`, `phone`, `email`, `bio`, `password`, `admin`, `county`, `constituency`, `gender`, `joined`, `profile_pic`, `account_type`, `account_category`) VALUES
('-O35T8MSamFApqWPpw2C', 'imatiss', 'ima tiss', NULL, 'imatiss@gmail.com', NULL, '$2b$12$q2hkkfdUG.uRmpPECKcUB.XkSFcDcgS74NRZkz4q58h26SfalU/3G', 0, 'Nairobi', 'Kibra Sub County', 'female', 1722390452, 'placeholder.jpg', 'n', NULL),
('-O3D84iMqUa8iFJL5773', 'allisonmolly', 'allison molly', NULL, 'allisonmolly@gmail.com', NULL, '$2b$12$9MhJP3rb9r4514l5ddShheMxL1byHi7pVyIgEN97kbLRrRh6gICiO', 1, 'Nairobi', 'Kibra Sub County', 'female', 1722519149, 'placeholder.jpg', 'n', NULL),
('-O3OqrPmXCU9QbHUuGpg', 'dsjfsdjfbskdjfskjdfksjdbfksjbdfksjdbkfsjdsdfsdlknflsdkfnskdnflskdnflsdf', 'dsjf sdjfbskdjf skjdf ksjdbfk sjbd fksjdb kfsjd sdfsdlknfls dkfn skdnfls kdnf lsdf', NULL, 'jamjam@gmail.com', NULL, '$2b$12$bE4yv/AMA78YCl/IyYaBdO5r6Ks.V.3dXpMjR7KqB3jdZWivJE5yu', 0, 'Nairobi', 'Kibra Sub County', 'male', 1722715699, 'placeholder.jpg', 'n', NULL),
('-O3PCrAX0I0D5_W2z0_Y', 'sdasdasdasd', 'sdasd asdasd', NULL, 'jamjam@gmail.comtss', NULL, '$2b$12$syBe3Pg/OBXG4HlHqITYgOlE117wJbW/z.9.7g9u29ht.mCC/kEti', 0, 'Nairobi', 'Kibra Sub County', 'female', 1722721727, 'placeholder.jpg', 'n', NULL),
('-O3PCVF0cPHkYdskcJyq', 'dtewtwetrwet', 'dtewt wetrwet', NULL, 'jamjam@gmail.comt', NULL, '$2b$12$ifCbmufCygiA5cWsHNBzOu6sbW/MRdfF7AXoNQ0G5HAlhA1Pr2OmS', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721633, 'placeholder.jpg', 'n', NULL),
('-O3PD0tQkxgcvvLcPWNB', 'sddfsdf', 'sd dfsdf', NULL, 'jamjam@gmail.comdtss', NULL, '$2b$12$KU2uMpORjmws3Sv9xDNVzuNbBE639ibK2mQy7IHFZGClC1MBUhqIq', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721771, 'placeholder.jpg', 'n', NULL),
('-O3PDCmPNeG8hhImnugw', 'dsadasdasd', 'dsad asdasd', NULL, 'jamjam@gmail.comdtssd', NULL, '$2b$12$Po8P8vAa64TtYWYKlEVTtu7xUcQtqgNiCFJtT/TBoX/TIa9cDHNJO', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721820, 'placeholder.jpg', 'n', NULL),
('-O3PDmA0E0mGUP-fU1cP', 'wefwefwefwef', 'wefwef wefwef', NULL, 'jamjam@gmail.fcomdtssd', NULL, '$2b$12$WYkjho8hN2DoaqWQ3raPBOs28y.rbYKb2OrxE1DHLVEdOaO/m7LNu', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721969, 'placeholder.jpg', 'n', NULL),
('-O3PE4OaF92Dde-pvfO5', 'ui', 'ytuj64 u456u', NULL, 'jamjam@gmaikjil.fcomdtssd', NULL, '$2b$12$8kCXfX5SpDSo2JI1gMXu/unluodyUhDUzVUrvM9Ktth3UaKhEWblO', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722722048, 'avatarImg-5ieru8d3-2024-08-06.png', 'n', NULL),
('-O3ZqWiTy7BIdmEw_VSp', 'umo_wa_ungem', 'umo marko', NULL, 'umomarko@marko.com', NULL, '$2b$12$xLmKWBwpXsMoRYROJNulR.pnaefzhrfqHG5tqwKGL/7NUCsaZQAFa', 0, 'Nairobi', 'Kibra Sub County', 'male', 1722900159, 'avatarImg-wijjbsz7-2024-08-06.png', 'n', NULL),
('-O3_ACSz_DcuPRsJI8sL', 'security', 'security', NULL, '', 'ss0', '$2b$12$vgJfPSFJTSJ9/aywpl61cuNpD7eA8EAgBUVktG/cp.WJRfpQffwGK', 0, '', '', 'other', 1722905581, 'placeholder.jpg', 'p', 'Ministry of Education'),
('-O3_BKMupgjWf6N25YMU', 'Assasins', 'Assasins', NULL, 'assasins@gmail.com', 'kjnl', '$2b$12$NfbmjYN82r/X35z5o33S7.quO5Jd0SWJGtMJI6t4mqm1BnDUJKD0u', 0, '', '', 'other', 1722905876, 'placeholder.jpg', 'p', '');

-- --------------------------------------------------------

--
-- Table structure for table `ket_views`
--

CREATE TABLE `ket_views` (
  `id` int(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `source` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ket_comments`
--
ALTER TABLE `ket_comments`
  ADD PRIMARY KEY (`c_id`);

--
-- Indexes for table `ket_follow`
--
ALTER TABLE `ket_follow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `follows` (`follows`);

--
-- Indexes for table `ket_likes`
--
ALTER TABLE `ket_likes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ket_notifications`
--
ALTER TABLE `ket_notifications`
  ADD PRIMARY KEY (`note_id`);

--
-- Indexes for table `ket_posts`
--
ALTER TABLE `ket_posts`
  ADD PRIMARY KEY (`p_id`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `ket_post_info`
--
ALTER TABLE `ket_post_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `p_id` (`p_id`);

--
-- Indexes for table `ket_users`
--
ALTER TABLE `ket_users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `ket_views`
--
ALTER TABLE `ket_views`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ket_follow`
--
ALTER TABLE `ket_follow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `ket_likes`
--
ALTER TABLE `ket_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `ket_post_info`
--
ALTER TABLE `ket_post_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `ket_views`
--
ALTER TABLE `ket_views`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ket_posts`
--
ALTER TABLE `ket_posts`
  ADD CONSTRAINT `ket_posts_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `ket_users` (`uid`) ON DELETE CASCADE;

--
-- Constraints for table `ket_post_info`
--
ALTER TABLE `ket_post_info`
  ADD CONSTRAINT `ket_post_info_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `ket_posts` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ket_post_info_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `ket_posts` (`p_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
