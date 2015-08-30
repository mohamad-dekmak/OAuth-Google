--
-- Database: `SMB215`
--

DROP DATABASE IF EXISTS SMB215;

CREATE DATABASE SMB215;

USE SMB215;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `role_name` varchar(20) NOT NULL,
  PRIMARY KEY (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_name`) VALUES
('System Administrator'),
('User');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_name` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `isGoogleAuth` char(3) DEFAULT 'no',
  `email` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `userGoogleId` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `isBanned` char(3) DEFAULT 'no',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_name`, `password`, `isGoogleAuth`, `email`, `userGoogleId`, `isBanned`) VALUES
('mdekmak', '123', 'no', NULL, NULL, 'no'),
('user1', '1', 'no', NULL, NULL, 'no'),
('user2', '12', 'no', NULL, NULL, 'no'),
('user3', '123', 'no', NULL, NULL, 'no');

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE IF NOT EXISTS `users_roles` (
  `user_name` varchar(20) NOT NULL,
  `role_name` varchar(20) NOT NULL,
  PRIMARY KEY (`user_name`,`role_name`),
  KEY `users_roles_foreign_key_2` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`user_name`, `role_name`) VALUES
('mdekmak', 'System Administrator'),
('user1', 'User'),
('user2', 'User'),
('user3', 'User');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `users_roles_foreign_key_1` FOREIGN KEY (`user_name`) REFERENCES `users` (`user_name`),
  ADD CONSTRAINT `users_roles_foreign_key_2` FOREIGN KEY (`role_name`) REFERENCES `roles` (`role_name`);