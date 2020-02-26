-- phpMyAdmin SQL Dump
-- version 3.5.8.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 26, 2020 at 07:18 PM
-- Server version: 5.7.29
-- PHP Version: 5.6.27

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `nodeapp_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group_name`) VALUES
(1, 'Group 1'),
(2, 'Group 2'),
(3, 'Group 3'),
(4, 'Group 4'),
(5, 'Group 5');

-- --------------------------------------------------------

--
-- Table structure for table `ranks`
--

CREATE TABLE IF NOT EXISTS `ranks` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `rank_name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `ranks`
--

INSERT INTO `ranks` (`id`, `rank_name`) VALUES
(1, 'Techical Team'),
(2, 'Assistant Manag'),
(3, 'Admin Assistant'),
(4, 'CMS Assistant M'),
(5, 'Purchase Assist'),
(6, 'Data Entry Oper'),
(7, 'Finance Manager');

-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `type` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `types`
--

INSERT INTO `types` (`id`, `type`) VALUES
(1, 'Internal'),
(2, 'Owner'),
(3, 'Agent'),
(4, 'Owner user'),
(5, 'Agent user');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(250) NOT NULL,
  `date_of_joining` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` varchar(1) NOT NULL,
  `report_to` int(11) NOT NULL,
  `ex_seafarer` varchar(1) NOT NULL,
  `group_id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `mobile_number` varchar(10) NOT NULL,
  `contact_number` varchar(12) NOT NULL,
  `permanent_address` text NOT NULL,
  `temporary_address` text NOT NULL,
  `active` varchar(2) NOT NULL,
  `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`,`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `date_of_joining`, `type`, `report_to`, `ex_seafarer`, `group_id`, `rank`, `mobile_number`, `contact_number`, `permanent_address`, `temporary_address`, `active`, `last_updated`) VALUES
(1, 'sreekala', '$2a$08$h0skRp4zqeofGIe/LrSgMe3hblXU2plFGcRWs75FitKhC2Re.r34a', 'sreekala@tricta.com', '2020-02-26 17:17:59', '1', 1, '1', 1, 1, '43', '43', '', '', '1', '2020-02-26 17:17:59'),
(8, 'sree', '$2a$08$1YFeHNpp1oP14xEEuiVB1OBeWzuY65ofyd1V1pvtr2JTiqfOfm9JC', 'sreekala1@tricta.com', '2020-02-26 17:17:59', '1', 1, '1', 1, 1, '9944949494', '9944949494', 'field.permanent_address', ' field.permanent_address 2', '1', '2020-02-26 18:35:20'),
(10, 'sree', '$2a$08$A6yMQMV22R/cRt5y8PeqBeMFxAG4m6k431Cp2qXzdlAcrjjTp2SJq', 'sreekala11@tricta.com', '2020-02-26 17:17:59', '1', 1, '1', 1, 1, '9944949494', '9944949494', 'field.permanent_address', ' field.permanent_address 2', '1', '2020-02-26 18:36:41');

-- --------------------------------------------------------

--
-- Table structure for table `user_profile`
--

CREATE TABLE IF NOT EXISTS `user_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `middlename` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `employee_type` varchar(2) NOT NULL COMMENT '1- regular , 2 contract',
  `sourcing_office` int(11) NOT NULL,
  `nationality` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `place_of_birth` varchar(150) NOT NULL,
  `gender` smallint(6) NOT NULL COMMENT '1 M, 2 F',
  `probation_status` smallint(6) NOT NULL COMMENT 'Conf,On Hold,Probation',
  `date_of_confirmation` date NOT NULL,
  `date_of_relieving` date NOT NULL,
  `date_of_resignation` date NOT NULL,
  `ctc` varchar(10) NOT NULL,
  `profile_image` varchar(100) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user_profile`
--

INSERT INTO `user_profile` (`id`, `user_id`, `firstname`, `middlename`, `lastname`, `employee_type`, `sourcing_office`, `nationality`, `dob`, `place_of_birth`, `gender`, `probation_status`, `date_of_confirmation`, `date_of_relieving`, `date_of_resignation`, `ctc`, `profile_image`, `updated_at`) VALUES
(1, 1, 'sre', 'k', 'k', '1', 1, 'INDIAN', '1989-02-05', 'Kottayam', 0, 1, '2020-02-06', '0000-00-00', '0000-00-00', '1000', '', '2020-02-26 19:05:37');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
