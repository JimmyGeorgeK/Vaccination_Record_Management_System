-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 27, 2021 at 02:22 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `did` int(11) NOT NULL,
  `demail` varchar(50) NOT NULL,
  `dept` varchar(50) NOT NULL,
  `doctorname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`did`, `demail`, `dept`, `doctorname`) VALUES
(1, 'jim@gmail.com', 'Ortho', 'Jimmy'),
(2, 'anki@gnail.com', 'corona', 'ankitha'),
(3, 'doctor@123', 'dermatology', 'doctor');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `id` int(11) NOT NULL,
  `pname` varchar(20) NOT NULL,
  `pcity` varchar(20) NOT NULL,
  `pgender` varchar(10) NOT NULL,
  `page` varchar(10) NOT NULL,
  `pphone` varchar(20) NOT NULL,
  `pemail` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`id`, `pname`, `pcity`, `pgender`, `page`, `pphone`, `pemail`) VALUES
(1, 'Jimmy', 'Manglore', 'Male', '21', '9483034670', 'jim@gmail.com'),
(2, 'varun', 'bangle', 'Male', '23', '22626663', 'varun@gmail.com'),
(3, 'nandini', 'mysore', 'Female', '19', '456777', 'nandini@123'),
(4, 'gk', 'Manglore', 'Male', '30', '123456', 'gk@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `slot` varchar(50) NOT NULL,
  `disease` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `vaccine` varchar(50) NOT NULL,
  `number` varchar(12) NOT NULL,
  `cost` varchar(50) NOT NULL,
  `pemail` varchar(50) NOT NULL,
  `doctor` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`pid`, `email`, `name`, `gender`, `slot`, `disease`, `time`, `date`, `vaccine`, `number`, `cost`, `pemail`, `doctor`) VALUES
(2, 'anvitha@gmail.com', 'james', 'Male', 'evening', 'corona', '08:13:00', '2021-01-23', 'corona vaccine', '8670837690', '4005', 'jim@gmail.com', 'Jimmy'),
(5, 'sanjay@123', 'nandini', 'Male', 'evening', 'rashes', '14:29:00', '2021-01-21', 'peroclin', '5757575757', '3999', 'nandini@123', 'ankitha');

--
-- Triggers `patients`
--
DELIMITER $$
CREATE TRIGGER `patdel` BEFORE DELETE ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,OLD.pid,OLD.email,OLD.name,'PATIENT DELETED',NOW(),OLD.pemail)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patins` AFTER INSERT ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.name,'PATIENT INSERTED',NOW(),NEW.pemail)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `patup` AFTER UPDATE ON `patients` FOR EACH ROW INSERT INTO trigr VALUES(null,NEW.pid,NEW.email,NEW.name,'PATIENT UPDATED',NOW(),NEW.pemail)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trigr`
--

CREATE TABLE `trigr` (
  `tid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL,
  `pemail` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trigr`
--

INSERT INTO `trigr` (`tid`, `pid`, `email`, `name`, `action`, `timestamp`, `pemail`) VALUES
(1, 12, 'anees@gmail.com', 'ANEES', 'PATIENT INSERTED', '2020-12-02 16:35:10', ''),
(2, 11, 'anees@gmail.com', 'anees', 'PATIENT INSERTED', '2020-12-02 16:37:34', ''),
(3, 10, 'anees@gmail.com', 'anees', 'PATIENT UPDATED', '2020-12-02 16:38:27', ''),
(4, 11, 'anees@gmail.com', 'anees', 'PATIENT UPDATED', '2020-12-02 16:38:33', ''),
(5, 12, 'anees@gmail.com', 'ANEES', 'Patient Deleted', '2020-12-02 16:40:40', ''),
(6, 11, 'anees@gmail.com', 'anees', 'PATIENT DELETED', '2020-12-02 16:41:10', ''),
(7, 13, 'testing@gmail.com', 'testing', 'PATIENT INSERTED', '2020-12-02 16:50:21', ''),
(8, 13, 'testing@gmail.com', 'testing', 'PATIENT UPDATED', '2020-12-02 16:50:32', ''),
(9, 13, 'testing@gmail.com', 'testing', 'PATIENT DELETED', '2020-12-02 16:50:57', ''),
(10, 2, 'anvitha@gmail.com', 'james', 'PATIENT INSERTED', '2021-01-24 07:12:11', 'jim@gmail.com'),
(11, 2, 'anvitha@gmail.com', 'james', 'PATIENT UPDATED', '2021-01-24 07:12:36', 'jim@gmail.com'),
(12, 1, 'anvitha@gmail.com', 'Jimmy', 'PATIENT DELETED', '2021-01-24 07:12:44', 'jim@gmail.com'),
(13, 3, 'sah@gmail.com', 'varun', 'PATIENT INSERTED', '2021-01-25 10:12:55', 'varun@gmail.com'),
(14, 3, 'sah@gmail.com', 'varun', 'PATIENT UPDATED', '2021-01-25 10:13:17', 'varun@gmail.com'),
(15, 3, 'sah@gmail.com', 'varun', 'PATIENT DELETED', '2021-01-25 10:14:06', 'varun@gmail.com'),
(16, 2, 'anvitha@gmail.com', 'james', 'PATIENT UPDATED', '2021-01-25 10:16:58', 'jim@gmail.com'),
(17, 4, 'anvitha@gmail.com', 'james', 'PATIENT INSERTED', '2021-01-25 10:17:24', 'jim@gmail.com'),
(18, 4, 'anvitha@gmail.com', 'james', 'PATIENT DELETED', '2021-01-25 10:17:32', 'jim@gmail.com'),
(19, 5, 'sanjay@123', 'nandini', 'PATIENT INSERTED', '2021-01-25 10:26:26', 'nandini@123'),
(20, 5, 'sanjay@123', 'nandini', 'PATIENT UPDATED', '2021-01-25 10:27:17', 'nandini@123');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`) VALUES
(11, 'Anvitha', 'anvitha@gmail.com', 'pbkdf2:sha256:150000$cRLsHr5M$b930596052cfb630ed3b3b18c373f02ee8a10d9bc0b77e7b00b0fda1e3ffd0e7'),
(12, 'sahana', 'sah@gmail.com', 'pbkdf2:sha256:150000$OsoAPa5L$145bfb14f49b12ad52546e99f2b151f1418bd8a7550577e7ffef2aff5255e21c'),
(13, 'anns', 'ann@gmail.com', 'pbkdf2:sha256:150000$bEqACEiB$9f057130d687a89f0434cd5f2b829f131b29741d3f147c8072626a86e8089176'),
(14, 'sanjay', 'sanjay@123', 'pbkdf2:sha256:150000$CvAq3VZ8$f9fa413ffe9204faecad4f0c295be0475eec19df5d17b57c7eeaff9c79e0f0fd'),
(15, 'ashk', 'ash@gmal.com', 'pbkdf2:sha256:150000$qdZsz3ok$843d61996637556234aa6e8e9b459293eee5c819cdd22c0697f97e9467973011'),
(16, 'anvi', 'anvi@1', 'pbkdf2:sha256:150000$7hFDWEas$43c0db7fe9c71eb47994d2fa49098889274d28f62306a6e85a058b08ee803320'),
(17, 'aish', 'aish@gmail.com', 'pbkdf2:sha256:150000$wrTNtluO$e5bb1318a0d19a431143765f88207459fb9eb10f8f78a9056bd2de6fcf26450f');

-- --------------------------------------------------------

--
-- Table structure for table `vaccine`
--

CREATE TABLE `vaccine` (
  `vid` int(11) NOT NULL,
  `disease` varchar(50) NOT NULL,
  `vacname` varchar(50) NOT NULL,
  `cost` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vaccine`
--

INSERT INTO `vaccine` (`vid`, `disease`, `vacname`, `cost`) VALUES
(1, 'corona', 'corona vaccine', '3000'),
(2, 'ulcer', 'ulcerodia', '2999'),
(3, 'rashes', 'peroclin', '3999');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `trigr`
--
ALTER TABLE `trigr`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `vaccine`
--
ALTER TABLE `vaccine`
  ADD PRIMARY KEY (`vid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `trigr`
--
ALTER TABLE `trigr`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `vaccine`
--
ALTER TABLE `vaccine`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
