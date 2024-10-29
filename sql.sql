-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 24, 2024 at 12:10 AM
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
('-O6oUwFRYQhCX368_dDZ', '-O3D84iMqUa8iFJL5773', '-O6oUq8cFExGIviwsMBb', 'sdfgsdg', 1726383900),
('-O7Ou1T_VwIVIBwfZ3G7', '-O7NgNGyIupPwncHXWYP', '-O7Om536tZR92vxZesyD', 'dsfsdfsdf', 1727011498),
('-O7Ou2TK_j9QQoorUTVx', '-O7NgNGyIupPwncHXWYP', '-O7Om536tZR92vxZesyD', 'sdfsdf sdfs df', 1727011502),
('-O7OuN_CS5qBZy90co7I', '-O7NgNGyIupPwncHXWYP', '-O7O8wmMSM1VCEfRdufy', 'rtertert', 1727011588),
('-O7StSwQdS6naBtnqmsT', '-O3D84iMqUa8iFJL5773', '-O7O8wmMSM1VCEfRdufy', 'kkj kjk', 1727078457),
('-O7StUSXXxPC2m6YzC8S', '-O3D84iMqUa8iFJL5773', '-O7O8wmMSM1VCEfRdufy', 'yoo', 1727078463),
('-O7SuEHwswdKR9YLxXBd', '-O3D84iMqUa8iFJL5773', '-O7NxG32Le_8xAuZaxSi', 'sdfsd fdf sdfsd', 1727078659);

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
(36, '-O3ZqWiTy7BIdmEw_VSp', '-O35T8MSamFApqWPpw2C', 1722901470),
(37, '-O7NgNGyIupPwncHXWYP', '-O3vlzYV82unn4l544ks', 1727125310);

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
(73, '-O3D84iMqUa8iFJL5773', '-O6oUq8cFExGIviwsMBb', 1726384394),
(74, '-O7NgNGyIupPwncHXWYP', '-O7NzpMjklJVvoC2I8le', 1726996955),
(75, '-O7OkWyqUVS5K3LypcMV', '-O7O8wmMSM1VCEfRdufy', 1727009199);

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
('-O3ZvWS5Cb9xK5nF0-IP', '-O3ZqWiTy7BIdmEw_VSp', '-O3PE4OaF92Dde-pvfO5', '-O3PE4OaF92Dde-pvfO5', 'follow', 1722901469, 0),
('-O7VgBatH5Cpu_lu3MDr', '-O7NgNGyIupPwncHXWYP', '-O3vlzYV82unn4l544ks', '-O3vlzYV82unn4l544ks', 'follow', 1727125310, 0);

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
  `anonymous` int(6) NOT NULL DEFAULT 0,
  `doc_category` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ket_posts`
--

INSERT INTO `ket_posts` (`p_id`, `p_date`, `uid`, `p_type`, `commenting`, `sharing`, `on_camera`, `views`, `post_type`, `p_likes`, `anonymous`, `doc_category`) VALUES
('-O7NcNHlM3Kyrq7dlCg0', 1726990091, '-O70Hrobj3f8xxidwxQ7', 'normal', 0, 0, 0, 0, '1', 0, 1, NULL),
('-O7NSTGpiHwPiG7i49PW', 1726987232, '-O70Hrobj3f8xxidwxQ7', 'normal', 0, 0, 0, 0, '1', 0, 1, NULL),
('-O7NxG32Le_8xAuZaxSi', 1726995567, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '2', 0, 0, NULL),
('-O7NzpMjklJVvoC2I8le', 1726996240, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '2', 0, 0, NULL),
('-O7O-EaYyOpbs3bDchKu', 1726996347, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '1', 0, 1, NULL),
('-O7O2hL5bn2Fxvbp7uN7', 1726997256, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '1', 0, 1, NULL),
('-O7O8kUAReVJSO5tzXMf', 1726998841, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '2', 0, 0, NULL),
('-O7O8wmMSM1VCEfRdufy', 1726998892, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '2', 0, 0, NULL),
('-O7QtGSfl2jqE9h0YJ_j', 1727044852, '-O3D84iMqUa8iFJL5773', 'normal', 0, 0, 0, 0, '1', 0, 1, NULL),
('-O7T5U3toiZWLSKGkGme', 1727081870, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '2', 0, 0, NULL),
('-O7T67JdkIhc1HuKLGe9', 1727082039, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '2', 0, 0, 'Projects/Tenders'),
('-O7Vi6nW4I3QMigoz39x', 1727125814, '-O7NgNGyIupPwncHXWYP', 'normal', 0, 0, 0, 0, '1', 0, 1, NULL);

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
  `filetype` enum('img','vid','file') NOT NULL,
  `file_size` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ket_post_info`
--

INSERT INTO `ket_post_info` (`id`, `p_id`, `status`, `category`, `location`, `filename`, `filetype`, `file_size`) VALUES
(112, '-O7NSTGpiHwPiG7i49PW', 'jhvjhkj', '', '', 'Ch-18.pdf', 'file', '200/800'),
(113, '-O7NcNHlM3Kyrq7dlCg0', 'dwfds fdfdf', '', '', 'KEye_Documentation_1.pdf', 'file', '200/800'),
(116, '-O7NxG32Le_8xAuZaxSi', '', 'Office of the Governor', '', 'KEye_Documentation_1.pdf', 'file', '200/800'),
(117, '-O7NzpMjklJVvoC2I8le', 'ergergervb 43rt3', 'Office of the Governor', '', 'Progress_Milestones_1.pdf', 'file', '200/800'),
(118, '-O7O-EaYyOpbs3bDchKu', 'fwerf 3r rf erf 45y45y4 4rgt __hash__@jhjfwfkn __hash__#kjkfjebv __link__http://192.168.1.101:8000/ jhgr2k3jb 2fk2jebf2f', 'Health', 'Machakos , Wote road', 'FOURIER_SERIES_notes.pdf', 'file', '200/800'),
(119, '-O7O2hL5bn2Fxvbp7uN7', '7uio5urik5', '', '', 'feedImg-ngkff3tk-2024-09-22.jpg', 'img', '700/525'),
(120, '-O7O8kUAReVJSO5tzXMf', '', 'Office of the Governor', '', 'CONVOLUTION_LECTURE_1_1.pdf', 'file', '200/800'),
(121, '-O7O8wmMSM1VCEfRdufy', 'fdsfdgfd gfgfdsg fg dsfg fg fgfg fg gfg ', 'Office of the Governor', '', 'FOURIER_SERIES_notes.pdf', 'file', '200/800'),
(125, '-O7QtGSfl2jqE9h0YJ_j', '', '', '', 'feedImg-1ig7o04q-2024-09-23.png', 'img', '700/535'),
(126, '-O7T5U3toiZWLSKGkGme', '65yu5tuy', '', '', 'Kenyans_Eye.pdf', 'file', '200/800'),
(127, '-O7T67JdkIhc1HuKLGe9', 'jy bijbikjn j', '', '', 'CONVOLUTION_LECTURE_1_1.pdf', 'file', '200/800'),
(128, '-O7Vi6nW4I3QMigoz39x', '4r rtertf rgtrg 3rge rg', '', 'Webuye', 'feedVid-d0ebhsqa-2024-09-24.mp4', 'vid', '200/800');

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
  `account_type` enum('p','n','w','cecm','mng') NOT NULL DEFAULT 'n',
  `account_category` varchar(100) DEFAULT NULL,
  `parent` varchar(100) DEFAULT NULL,
  `name_alias` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ket_users`
--

INSERT INTO `ket_users` (`uid`, `uname`, `fullname`, `phone`, `email`, `bio`, `password`, `admin`, `county`, `constituency`, `gender`, `joined`, `profile_pic`, `account_type`, `account_category`, `parent`, `name_alias`) VALUES
('-O3D84iMqUa8iFJL5773', 'allisonmolly', 'allison molly', NULL, 'allisonmolly@gmail.com', NULL, '$2b$12$9MhJP3rb9r4514l5ddShheMxL1byHi7pVyIgEN97kbLRrRh6gICiO', 1, 'Nairobi', 'Kibra Sub County', 'female', 1722519149, 'placeholder.jpg', 'n', NULL, NULL, NULL),
('-O3PCVF0cPHkYdskcJyq', 'dtewtwetrwet', 'dtewt wetrwet', NULL, 'jamjam@gmail.comt', NULL, '$2b$12$ifCbmufCygiA5cWsHNBzOu6sbW/MRdfF7AXoNQ0G5HAlhA1Pr2OmS', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721633, 'placeholder.jpg', 'n', NULL, NULL, NULL),
('-O3PD0tQkxgcvvLcPWNB', 'sddfsdf', 'sd dfsdf', NULL, 'jamjam@gmail.comdtss', NULL, '$2b$12$KU2uMpORjmws3Sv9xDNVzuNbBE639ibK2mQy7IHFZGClC1MBUhqIq', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721771, 'placeholder.jpg', 'n', NULL, NULL, NULL),
('-O3PDCmPNeG8hhImnugw', 'dsadasdasd', 'dsad asdasd', NULL, 'jamjam@gmail.comdtssd', NULL, '$2b$12$Po8P8vAa64TtYWYKlEVTtu7xUcQtqgNiCFJtT/TBoX/TIa9cDHNJO', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721820, 'placeholder.jpg', 'n', NULL, NULL, NULL),
('-O3PDmA0E0mGUP-fU1cP', 'wefwefwefwef', 'wefwef wefwef', NULL, 'jamjam@gmail.fcomdtssd', NULL, '$2b$12$WYkjho8hN2DoaqWQ3raPBOs28y.rbYKb2OrxE1DHLVEdOaO/m7LNu', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722721969, 'placeholder.jpg', 'n', NULL, NULL, NULL),
('-O3PE4OaF92Dde-pvfO5', 'ui', 'ytuj64 u456u', NULL, 'jamjam@gmaikjil.fcomdtssd', NULL, '$2b$12$8kCXfX5SpDSo2JI1gMXu/unluodyUhDUzVUrvM9Ktth3UaKhEWblO', 0, 'Nairobi', 'Kibra Sub County', 'other', 1722722048, 'avatarImg-5ieru8d3-2024-08-06.png', 'n', NULL, NULL, NULL),
('-O3uheUEMzbcZi32fY5P', 'Swingsmauno', 'Swings  Mauno', NULL, 'swings@mauno.com', NULL, '$2b$12$7zBqeggmXUJ0CMXKsdiod.to64el27IKf0ceAgsyYai6HM1Aq2e4a', 0, 'Busia (040)', 'Butula', 'male', 1723266935, 'avatarImg-30z06965-2024-08-10.png', 'n', NULL, NULL, NULL),
('-O3vlzYV82unn4l544ks', 'lom', 'Abisalom Okoth', NULL, 'abisalomokoth1@gmail.com', NULL, '$2b$12$VseAfffzjtEq9KTMAjCKbuvjss/tkBMqHhJccNyJ127uxJhe3uAs2', 0, 'Kisumu (042)', 'Mohoroni', 'male', 1723284847, 'placeholder.jpg', 'n', NULL, NULL, NULL),
('-O480g3Xc6a5oJ0p6b3o', 'MinistryofEducation', 'Ministry of Education', NULL, 'edu@edu.com', 'ubi iuoi ', '$2b$12$TupyooW43JTVODeHvkUvR.x8PtwTJ50TzsN7TcYIbcFMCVRcfgZj6', 0, '', '', 'other', 1723507065, 'placeholder.jpg', 'p', NULL, NULL, NULL),
('-O480Np3w5wyCvlLfJ3U', 'MinistryofHealth', 'Ministry of Health', NULL, 'health@go.com', 'sjhskjbs', '$2b$12$It5APy7HFuHCEOMibbduH.g2HasroApmyNcvRFrr.kWMtoaxK/HiO', 0, '', '', 'other', 1723506986, 'avatarImg-fs9ew4xx-2024-08-13.png', 'p', NULL, NULL, NULL),
('-O48CDq_EKp7l72Pifb_', 'Jimijimy😘', 'Jimmy Wanjigi', NULL, 'jimi@wanjigi.com', NULL, '$2b$12$BukQTwBuf6YcPgLQl7SGA.Zr4suYeg3a6dK6XWFZEVBQ/aRoRO6nC', 0, 'Bomet (036)', 'Bomet central', 'male', 1723510091, 'placeholder.jpg', 'n', NULL, NULL, NULL),
('-O70Hrobj3f8xxidwxQ7', 'president', 'president', NULL, 'info@presidency.com', 'no desc', '$2b$12$PA90NadlOIp1VBRy0cQ4KO41N02qh.3mF2OHUhY1HNdGYzjSoyY4m', 0, '', '', 'other', 1726598577, 'placeholder.jpg', 'p', NULL, NULL, NULL),
('-O7NgNGyIupPwncHXWYP', 'airobigovernoroffice', 'Office of the Governor', NULL, 'info@nairobigovernor.com', NULL, '$2b$12$K84.7ueb75BbReVUaCQ.tOcNvkt9bvzJD/6FoEal6yxJWnATMGy8i', 0, 'Nairobi (047)', 'Starehe Sub County', 'other', 1726991140, 'avatarImg-ywtd6rsv-2024-09-22.png', 'p', '1', NULL, 'Nairobi County'),
('-O7OoDkmp0auxfb_HBws', 'jsahdbsdjaskdsdmca', 'jsahdb sdjask dsd mca', NULL, 'info@waicecm.com', NULL, '$2b$12$KASJ5nIsGetrg6xnkCIBhudBnzaRvyIHWJLqB1/0W0yZPeVym4J6m', 0, '', '', 'other', 1727009975, 'placeholder.jpg', 'cecm', NULL, '-O7NgNGyIupPwncHXWYP', NULL),
('-O7OS1QurVNXjVuD7NwO', 'TANONone', 'TANO None', NULL, 'fgfd@sdgffs.gfhfgh', NULL, '$2b$12$eDoUjPJxbeI2cDiV5B0fzuMPsMUKlEr4HHPC3KytV816xw0z1.Slq', 0, '', '', 'other', 1727003896, 'placeholder.jpg', 'n', NULL, '-O7NgNGyIupPwncHXWYP', NULL),
('-O7OSFPQixx3VgeZ59eq', 'weqwsdqwsdNone', 'weqwsd qwsd None', NULL, 'qsds@dfdf.ghgfh', NULL, '$2b$12$RhV2VMvdJ2pXjQgvMc61COGaQKduucHy5ONom0VBWg5xI8nGlFWiO', 0, '', '', 'other', 1727003953, 'placeholder.jpg', 'n', NULL, '-O7OS1QurVNXjVuD7NwO', NULL),
('-O7OSXeo1FHxM1h07ZO2', 'rtferergtrgNone', 'rtfer ergt rg None', NULL, 'wdfwdf@fedgsdfg.hjhgj', NULL, '$2b$12$Cvzg98EKkRHWQIRXsPoz5.xpr9KQ5oM9tnANX2HPG3bbIFWdoNXA6', 0, '', '', 'other', 1727004028, 'placeholder.jpg', 'n', NULL, '-O7OSFPQixx3VgeZ59eq', NULL),
('-O7Vod2EfsIktbXGDiZv', 'mbithimbi', 'mbithimbi', NULL, 'info@mbithimbi.com', NULL, '$2b$12$DqvEAiR9bJBPnyMyt9QicubPPKM1AP8plSMX6uVww6ajdeLGZI5T6', 0, '', '', 'other', 1727127524, 'placeholder.jpg', 'mng', 'manager', NULL, NULL),
('-O7VoKJ3_9OpKspubRQ1', 'Ipoa', 'Ipoa', NULL, 'info@ipoa.com', NULL, '$2b$12$EPyYFi/BF6tW39JwLpJ.euvUHp8qqRVMZ8yYAZdUWmgCRF7GY9nzS', 0, '', '', 'other', 1727127443, 'avatarImg-t27h58az-2024-09-24.png', 'mng', 'manager', NULL, NULL),
('-O7VveDIgsZCS0lcfcpu', 'WaithakaWardmca', 'Waithaka Ward mca', NULL, 'info@waithakaward.com', NULL, '$2b$12$rQZTVfUIjdYT92nbQ4LDyOiahvUKUOnTMKM9/O.Kz.wy/i/F1tw5m', 0, '', '', 'other', 1727129363, 'placeholder.jpg', 'w', NULL, '-O7NgNGyIupPwncHXWYP', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ket_views`
--

CREATE TABLE `ket_views` (
  `id` int(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `source` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ke_views`
--

CREATE TABLE `ke_views` (
  `id` int(11) NOT NULL,
  `uid` varchar(100) DEFAULT NULL,
  `ip_address` text NOT NULL,
  `target` varchar(100) NOT NULL,
  `platform` enum('web','android','desktop') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ke_views`
--

INSERT INTO `ke_views` (`id`, `uid`, `ip_address`, `target`, `platform`) VALUES
(4, '-O3D84iMqUa8iFJL5773', '192.168.1.101', '-O6qionZzyNzsB3HuebS', 'web'),
(5, '-O3D84iMqUa8iFJL5773', '192.168.1.101', '-O6qkMWKbDuAOPLgl2HL', 'web'),
(6, '-O3D84iMqUa8iFJL5773', '192.168.1.100', '-O6qionZzyNzsB3HuebS', 'web'),
(7, '-O3D84iMqUa8iFJL5773', '192.168.1.100', '-O6qkMWKbDuAOPLgl2HL', 'web'),
(8, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O6qionZzyNzsB3HuebS', 'web'),
(9, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O6qkMWKbDuAOPLgl2HL', 'web'),
(10, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O7NHPa-Ev0jYXCk7t9D', 'web'),
(11, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O7NHaB33yOCq8m3JaOM', 'web'),
(12, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O7NKBCgUIaYbXJgr-6s', 'web'),
(13, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O7NLnSMjRerHQpOjJQk', 'web'),
(14, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O7NMYBJ32XlkUfFDPpx', 'web'),
(15, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O7NPQ5SRowJ3zphrIJV', 'web'),
(16, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O7NSTGpiHwPiG7i49PW', 'web'),
(17, '-O70Hrobj3f8xxidwxQ7', '192.168.1.101', '-O7NcNHlM3Kyrq7dlCg0', 'web'),
(18, '-O3D84iMqUa8iFJL5773', '192.168.1.100', '-O7NcNHlM3Kyrq7dlCg0', 'web'),
(19, '-O3D84iMqUa8iFJL5773', '192.168.1.100', '-O7NSTGpiHwPiG7i49PW', 'web'),
(20, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7NcNHlM3Kyrq7dlCg0', 'web'),
(21, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7NSTGpiHwPiG7i49PW', 'web'),
(22, '-O3D84iMqUa8iFJL5773', '192.168.1.101', '-O7NcNHlM3Kyrq7dlCg0', 'web'),
(23, '-O3D84iMqUa8iFJL5773', '192.168.1.101', '-O7NSTGpiHwPiG7i49PW', 'web'),
(24, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7NwXvIM2683maQRrFT', 'web'),
(25, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7NvOw7LK2f-18yNSKY', 'web'),
(26, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7NxG32Le_8xAuZaxSi', 'web'),
(27, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7NzpMjklJVvoC2I8le', 'web'),
(28, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7O-EaYyOpbs3bDchKu', 'web'),
(29, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7O2hL5bn2Fxvbp7uN7', 'web'),
(30, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7O8kUAReVJSO5tzXMf', 'web'),
(31, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7O8wmMSM1VCEfRdufy', 'web'),
(32, '-O7OSXeo1FHxM1h07ZO2', '192.168.1.101', '-O7O2hL5bn2Fxvbp7uN7', 'web'),
(33, '-O7OSXeo1FHxM1h07ZO2', '192.168.1.101', '-O7O-EaYyOpbs3bDchKu', 'web'),
(34, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7O2hL5bn2Fxvbp7uN7', 'web'),
(35, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7O-EaYyOpbs3bDchKu', 'web'),
(36, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7NSTGpiHwPiG7i49PW', 'web'),
(37, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7NcNHlM3Kyrq7dlCg0', 'web'),
(38, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7O8kUAReVJSO5tzXMf', 'web'),
(39, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7O8wmMSM1VCEfRdufy', 'web'),
(40, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7NzpMjklJVvoC2I8le', 'web'),
(41, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7NxG32Le_8xAuZaxSi', 'web'),
(42, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7OlMYGbd903Q3TyKW0', 'web'),
(43, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7OlZql8-30ZP_4KrFJ', 'web'),
(44, '-O7OkWyqUVS5K3LypcMV', '192.168.1.101', '-O7Om536tZR92vxZesyD', 'web'),
(45, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7Om536tZR92vxZesyD', 'web'),
(46, '-O7NgNGyIupPwncHXWYP', '192.168.1.101', '-O7OlZql8-30ZP_4KrFJ', 'web'),
(47, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7OlZql8-30ZP_4KrFJ', 'web'),
(48, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7Om536tZR92vxZesyD', 'web'),
(49, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7O2hL5bn2Fxvbp7uN7', 'web'),
(50, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7O-EaYyOpbs3bDchKu', 'web'),
(51, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7NSTGpiHwPiG7i49PW', 'web'),
(52, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7NcNHlM3Kyrq7dlCg0', 'web'),
(53, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7O8wmMSM1VCEfRdufy', 'web'),
(54, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7O8kUAReVJSO5tzXMf', 'web'),
(55, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7NzpMjklJVvoC2I8le', 'web'),
(56, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7NxG32Le_8xAuZaxSi', 'web'),
(57, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7QtGSfl2jqE9h0YJ_j', 'web'),
(58, '-O3D84iMqUa8iFJL5773', '192.168.1.102', 'http://192.168.1.102:8000//file_manager/app_files/ket_images/feeds/l/FOURIER_SERIES_notes.pdf', 'web'),
(59, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7Om536tZR92vxZesyD', 'web'),
(60, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7QtGSfl2jqE9h0YJ_j', 'web'),
(61, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7OlZql8-30ZP_4KrFJ', 'web'),
(62, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7O2hL5bn2Fxvbp7uN7', 'web'),
(63, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7O-EaYyOpbs3bDchKu', 'web'),
(64, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7NxG32Le_8xAuZaxSi', 'web'),
(65, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7O8wmMSM1VCEfRdufy', 'web'),
(66, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7NSTGpiHwPiG7i49PW', 'web'),
(67, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7Vi6nW4I3QMigoz39x', 'web'),
(68, '-O7NgNGyIupPwncHXWYP', '192.168.1.102', '-O7NcNHlM3Kyrq7dlCg0', 'web'),
(69, '-O3D84iMqUa8iFJL5773', '192.168.1.102', '-O7Vi6nW4I3QMigoz39x', 'web'),
(70, '-O7VoKJ3_9OpKspubRQ1', '192.168.1.102', '-O7QtGSfl2jqE9h0YJ_j', 'web'),
(71, '-O7VoKJ3_9OpKspubRQ1', '192.168.1.102', '-O7Vi6nW4I3QMigoz39x', 'web'),
(72, '-O7VoKJ3_9OpKspubRQ1', '192.168.1.102', '-O7O8wmMSM1VCEfRdufy', 'web'),
(73, '-O7VoKJ3_9OpKspubRQ1', '192.168.1.102', '-O7NxG32Le_8xAuZaxSi', 'web');

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
-- Indexes for table `ke_views`
--
ALTER TABLE `ke_views`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ket_follow`
--
ALTER TABLE `ket_follow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `ket_likes`
--
ALTER TABLE `ket_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `ket_post_info`
--
ALTER TABLE `ket_post_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT for table `ket_views`
--
ALTER TABLE `ket_views`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ke_views`
--
ALTER TABLE `ke_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

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
