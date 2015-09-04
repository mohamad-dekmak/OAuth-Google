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


--
-- Table structure for table `system_preferences`
--

CREATE TABLE IF NOT EXISTS `system_preferences` (
  `sysKey` text NOT NULL,
  `sysValue` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `system_preferences`
--

INSERT INTO `system_preferences` (`sysKey`, `sysValue`) VALUES
('smtpUsername', 'mohamad.dekmak0912@gmail.com'),
('smtpPassword', 'e625339adbead56af24ef793abc735ee3071fbba7a6296ed5589db84e7cfb7dd');


-
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `jobTitle` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dateOfBirth` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `comments` text,
  `createdBy` varchar(255) NOT NULL,
  `createdOn` date NOT NULL,
  `modifiedOn` date DEFAULT NULL,
  `modifiedBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  KEY `modifiedBy` (`modifiedBy`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

--
-- Constraints for table `contacts`
--
ALTER TABLE `contacts`
  ADD CONSTRAINT `contacts_ibfk_2` FOREIGN KEY (`modifiedBy`) REFERENCES `users` (`user_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `users` (`user_name`) ON DELETE NO ACTION ON UPDATE NO ACTION;