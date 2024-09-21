-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 17, 2024 at 09:58 PM
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
-- Table structure for table `evaluations`
--

CREATE TABLE `evaluations` (
  `id` int(100) NOT NULL,
  `ev_type` text NOT NULL,
  `userId` varchar(100) NOT NULL,
  `status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Dumping data for table `ket_comments`
--

INSERT INTO `ket_comments` (`c_id`, `uid`, `target`, `status`, `date`) VALUES
('-O6FqwfilCExzqZGbFl9', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'sdddd', 1725785951),
('-O6Fr-Jjjb_ngn8PmlEy', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'dddd', 1725785966),
('-O6Fr-jTyM94ugnwiSn7', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'ddd', 1725785968),
('-O6Fr0nzWoGDTL09PRC5', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'dddd dd d dwdqd', 1725785972),
('-O6FrKlEB4nDrpY7aCZ3', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'wadau', 1725786054),
('-O6Gb5D8fy4TlrSveaRm', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'gfsgfwrgwv w ', 1725798573),
('-O6GbeBOhDIN6MzLWawg', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'ewfqef', 1725798720),
('-O6GbG18fhq6Lo21R8VE', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'yoo', 1725798617),
('-O6Gbx4ljQcc9mTKYGcF', '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 'ss', 1725798798),
('-O6oUt9rcZrUUYyhCExC', '-O3D84iMqUa8iFJL5773', '-O6oUq8cFExGIviwsMBb', 'rtefgerg', 1726383887),
('-O6oUv-I26i6GX7UYTEg', '-O3D84iMqUa8iFJL5773', '-O6oUq8cFExGIviwsMBb', 'efsdfdfds sdwdf', 1726383895),
('-O6oUvjm6nyUdkvRLuHR', '-O3D84iMqUa8iFJL5773', '-O6oUq8cFExGIviwsMBb', 'sdfsdfs', 1726383898),
('-O6oUwFRYQhCX368_dDZ', '-O3D84iMqUa8iFJL5773', '-O6oUq8cFExGIviwsMBb', 'sdfgsdg', 1726383900);

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

--
-- Dumping data for table `ket_likes`
--

INSERT INTO `ket_likes` (`id`, `uid`, `target`, `l_date`) VALUES
(64, '-O3D84iMqUa8iFJL5773', '-O49UuSR6Rx_Ja9Ke_ao', 1725630307),
(65, '-O3D84iMqUa8iFJL5773', '-O49UobO4m9mKQxKyVvo', 1725630310),
(71, '-O3D84iMqUa8iFJL5773', '-O3ui6jdOwFB8nhRPmcS', 1725773526),
(73, '-O3D84iMqUa8iFJL5773', '-O6oUq8cFExGIviwsMBb', 1726384394);

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
  `p_likes` int(100) NOT NULL DEFAULT 0,
  `anonymous` int(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ket_posts`
--

INSERT INTO `ket_posts` (`p_id`, `p_date`, `uid`, `p_type`, `commenting`, `sharing`, `on_camera`, `views`, `post_type`, `p_likes`, `anonymous`) VALUES
('-O6qionZzyNzsB3HuebS', 1726421356, '-O3D84iMqUa8iFJL5773', 'normal', 0, 0, 0, 0, '1', 0, 0),
('-O6qkMWKbDuAOPLgl2HL', 1726421760, '-O3D84iMqUa8iFJL5773', 'normal', 0, 0, 0, 0, '1', 0, 1);

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

--
-- Dumping data for table `ket_post_info`
--

INSERT INTO `ket_post_info` (`id`, `p_id`, `status`, `category`, `location`, `filename`, `filetype`, `file_size`) VALUES
(104, '-O6qionZzyNzsB3HuebS', '', 'Health', 'Machakos , Wote road', 'feedImg-eyibdp06-2024-09-15.png', 'img', '373/240'),
(105, '-O6qkMWKbDuAOPLgl2HL', 'jhyvj jhjh kjbk ', 'Education', 'ssss', 'feedImg-qutgmj5c-2024-09-15.png', 'img', '296/222');

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
('-O3D84iMqUa8iFJL5773', 'allisonmolly', 'allison molly', NULL, 'allisonmolly@gmail.com', NULL, '$2b$12$9MhJP3rb9r4514l5ddShheMxL1byHi7pVyIgEN97kbLRrRh6gICiO', 1, 'Nairobi', 'Kibra Sub County', 'female', 1722519149, 'placeholder.jpg', 'n', NULL),
('-O3PCVF0cPHkYdskcJyq', 'dtewtwetrwet', 'dtewt wetrwet', NULL, 'jamjam@gmail.comt', NULL, '$2b$12$ifCbmufCygiA5cWsHNBzOu6sbW/MRdfF7AXoNQ0G5HAlhA1Pr2OmS', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721633, 'placeholder.jpg', 'n', NULL),
('-O3PD0tQkxgcvvLcPWNB', 'sddfsdf', 'sd dfsdf', NULL, 'jamjam@gmail.comdtss', NULL, '$2b$12$KU2uMpORjmws3Sv9xDNVzuNbBE639ibK2mQy7IHFZGClC1MBUhqIq', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721771, 'placeholder.jpg', 'n', NULL),
('-O3PDCmPNeG8hhImnugw', 'dsadasdasd', 'dsad asdasd', NULL, 'jamjam@gmail.comdtssd', NULL, '$2b$12$Po8P8vAa64TtYWYKlEVTtu7xUcQtqgNiCFJtT/TBoX/TIa9cDHNJO', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721820, 'placeholder.jpg', 'n', NULL),
('-O3PDmA0E0mGUP-fU1cP', 'wefwefwefwef', 'wefwef wefwef', NULL, 'jamjam@gmail.fcomdtssd', NULL, '$2b$12$WYkjho8hN2DoaqWQ3raPBOs28y.rbYKb2OrxE1DHLVEdOaO/m7LNu', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721969, 'placeholder.jpg', 'n', NULL),
('-O3PE4OaF92Dde-pvfO5', 'ui', 'ytuj64 u456u', NULL, 'jamjam@gmaikjil.fcomdtssd', NULL, '$2b$12$8kCXfX5SpDSo2JI1gMXu/unluodyUhDUzVUrvM9Ktth3UaKhEWblO', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722722048, 'avatarImg-5ieru8d3-2024-08-06.png', 'n', NULL),
('-O3uheUEMzbcZi32fY5P', 'Swingsmauno', 'Swings  Mauno', NULL, 'swings@mauno.com', NULL, '$2b$12$7zBqeggmXUJ0CMXKsdiod.to64el27IKf0ceAgsyYai6HM1Aq2e4a', 0, 'Busia (040)', 'Butula', 'male', 1723266935, 'avatarImg-30z06965-2024-08-10.png', 'n', NULL),
('-O3vlzYV82unn4l544ks', 'lom', 'Abisalom Okoth', NULL, 'abisalomokoth1@gmail.com', NULL, '$2b$12$VseAfffzjtEq9KTMAjCKbuvjss/tkBMqHhJccNyJ127uxJhe3uAs2', 0, 'Kisumu (042)', 'Mohoroni', 'male', 1723284847, 'placeholder.jpg', 'n', NULL),
('-O480g3Xc6a5oJ0p6b3o', 'MinistryofEducation', 'Ministry of Education', NULL, 'edu@edu.com', 'ubi iuoi ', '$2b$12$TupyooW43JTVODeHvkUvR.x8PtwTJ50TzsN7TcYIbcFMCVRcfgZj6', 0, '', '', 'other', 1723507065, 'placeholder.jpg', 'p', NULL),
('-O480Np3w5wyCvlLfJ3U', 'MinistryofHealth', 'Ministry of Health', NULL, 'health@go.com', 'sjhskjbs', '$2b$12$It5APy7HFuHCEOMibbduH.g2HasroApmyNcvRFrr.kWMtoaxK/HiO', 0, '', '', 'other', 1723506986, 'avatarImg-fs9ew4xx-2024-08-13.png', 'p', NULL),
('-O48CDq_EKp7l72Pifb_', 'Jimijimy😘', 'Jimmy Wanjigi', NULL, 'jimi@wanjigi.com', NULL, '$2b$12$BukQTwBuf6YcPgLQl7SGA.Zr4suYeg3a6dK6XWFZEVBQ/aRoRO6nC', 0, 'Bomet (036)', 'Bomet central', 'male', 1723510091, 'placeholder.jpg', 'n', NULL),
('-O70Hrobj3f8xxidwxQ7', 'president', 'president', NULL, 'info@presidency.com', 'no desc', '$2b$12$PA90NadlOIp1VBRy0cQ4KO41N02qh.3mF2OHUhY1HNdGYzjSoyY4m', 0, '', '', 'other', 1726598577, 'placeholder.jpg', 'p', NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `ket_post_info`
--
ALTER TABLE `ket_post_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

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
