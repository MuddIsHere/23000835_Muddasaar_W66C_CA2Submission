-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 17, 2024 at 07:01 AM
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
-- Database: `webapplication_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `fav_locations`
--

CREATE TABLE `fav_locations` (
  `fav_locationId` int(200) NOT NULL,
  `locationId` int(200) NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations_table`
--

CREATE TABLE `locations_table` (
  `locationId` int(200) NOT NULL,
  `location_name` varchar(2000) DEFAULT NULL,
  `weather_condition` varchar(100) NOT NULL,
  `temperature` decimal(5,0) NOT NULL,
  `humidity` int(100) NOT NULL,
  `wind` int(100) NOT NULL,
  `proverb` varchar(300) NOT NULL,
  `image` varchar(200) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations_table`
--

INSERT INTO `locations_table` (`locationId`, `location_name`, `weather_condition`, `temperature`, `humidity`, `wind`, `proverb`, `image`, `last_updated`) VALUES
(1, 'Woodlands North', 'Windy', 28, 55, 25, 'The best thing about rain showers is that they wash away all the gossip from the streets', 'location1.png', '2024-07-15 04:42:47'),
(2, 'Woodlands ', 'Sunny', 34, 15, 5, 'Sunshine is the best disinfectant, especially for a bad mood', 'location2.png', '2024-07-06 10:58:13'),
(3, 'WoodLands South', 'Sunny', 27, 78, 10, 'A strong wind is just nature\'s way of reminding you that you\'re not in charge', 'location3.png', '2024-07-15 09:15:35'),
(7, 'Location A', 'Cloudy', 31, 68, 13, 'Don\'t be a cloud follower, be a sunshine maker! But maybe bring an umbrella, just in case', 'location4.png', '2024-07-17 05:00:17'),
(12, 'Location B', 'Windy', 19, 80, 10, 'When it rains cats and dogs, don\'t forget to put out a bowl of milk. They get thirsty too, you know', 'location6.png', '2024-07-15 03:34:12'),
(13, 'Location C', 'Cloudy', 34, 66, 25, 'Hold onto your hats, and maybe your dignity, because it\'s a real hair-raising day out there', 'location5.png', '2024-07-15 01:10:50');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_table`
--

CREATE TABLE `quiz_table` (
  `quizId` int(10) NOT NULL,
  `question` varchar(500) NOT NULL,
  `answer1` varchar(500) NOT NULL,
  `answer2` varchar(500) NOT NULL,
  `correct_answer` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_table`
--

INSERT INTO `quiz_table` (`quizId`, `question`, `answer1`, `answer2`, `correct_answer`) VALUES
(1, 'What is generally TRUE about the hottest recorded temperature on Earth?', 'It occurs most frequently in tropical rainforests', 'It has been measured in desert regions', 'It has been measured in desert regions'),
(2, 'Which of the following is typically NOT a major factor influencing wind speed?', ' Atmospheric pressure differences', 'The rotation of the Earth', ' Atmospheric pressure differences'),
(3, 'Does wind speed increase or decrease with higher altitude in the atmosphere?', 'Increase', 'Decrease', 'Increase'),
(4, 'What is the name for the layer of the atmosphere closest to Earth\'s surface?', 'Troposphere', 'Stratosphere', 'Troposphere'),
(5, 'What instrument is used to measure wind speed?', 'Anemometer', 'Barometer', 'Anemometer'),
(6, 'Which receives more precipitation (rain/snow), a hot and dry desert or a tropical rainforest? ', 'Tropical rainforest', 'Desert', 'Tropical rainforest'),
(7, 'High air pressure is generally associated with clear skies or cloudy skies?', 'Cloudy skies', 'Clear skies', 'Clear skies'),
(8, 'Condensation occurs when water vapor ___', 'cools', 'heats', 'cools'),
(9, 'Do hurricanes form over warm or cold ocean waters?', 'cold', 'warm', 'warm'),
(10, 'How do weather forecasts become less accurate?', 'As the air pressure increases', 'The further out they predict', 'The further out they predict'),
(11, 'What seasonal winds bring heavy rainfall in some regions?', 'Trade winds', 'Monsoons', 'Monsoons'),
(12, 'Which part of the atmosphere protects us from harmful ultraviolet radiation? (which part the ozone resides in?)', 'stratosphere', 'Mesosphere', 'stratosphere'),
(13, 'What is the name for a large storm system that forms over warm ocean waters and has a central low-pr', 'Tropical cyclone', 'Blizzard', 'Tropical cyclone');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fav_locations`
--
ALTER TABLE `fav_locations`
  ADD PRIMARY KEY (`fav_locationId`),
  ADD KEY `locationId` (`locationId`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `locations_table`
--
ALTER TABLE `locations_table`
  ADD PRIMARY KEY (`locationId`),
  ADD UNIQUE KEY `location_name_2` (`location_name`) USING HASH,
  ADD KEY `weather_condition` (`weather_condition`),
  ADD KEY `location_name` (`location_name`(768));

--
-- Indexes for table `quiz_table`
--
ALTER TABLE `quiz_table`
  ADD PRIMARY KEY (`quizId`),
  ADD UNIQUE KEY `correct_answer` (`correct_answer`),
  ADD UNIQUE KEY `correct_answer_4` (`correct_answer`),
  ADD UNIQUE KEY `correct_answer_6` (`correct_answer`),
  ADD UNIQUE KEY `correct_answer_8` (`correct_answer`),
  ADD KEY `correct_answer_2` (`correct_answer`),
  ADD KEY `correct_answer_7` (`correct_answer`);
ALTER TABLE `quiz_table` ADD FULLTEXT KEY `correct_answer_3` (`correct_answer`);
ALTER TABLE `quiz_table` ADD FULLTEXT KEY `correct_answer_5` (`correct_answer`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fav_locations`
--
ALTER TABLE `fav_locations`
  MODIFY `fav_locationId` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `locations_table`
--
ALTER TABLE `locations_table`
  MODIFY `locationId` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `quiz_table`
--
ALTER TABLE `quiz_table`
  MODIFY `quizId` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fav_locations`
--
ALTER TABLE `fav_locations`
  ADD CONSTRAINT `fav_locations_ibfk_1` FOREIGN KEY (`locationId`) REFERENCES `locations_table` (`locationId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
