--
-- Database: `tomcat_realm`
--

DROP DATABASE IF EXISTS tomcat_realm;

CREATE DATABASE tomcat_realm;

USE tomcat_realm;

CREATE TABLE tomcat_users (
	user_name varchar(20) NOT NULL PRIMARY KEY,
	password varchar(32) NOT NULL
);

CREATE TABLE tomcat_roles (
	role_name varchar(20) NOT NULL PRIMARY KEY
);

CREATE TABLE tomcat_users_roles (
	user_name varchar(20) NOT NULL,
	role_name varchar(20) NOT NULL,
	PRIMARY KEY (user_name, role_name),
	CONSTRAINT tomcat_users_roles_foreign_key_1 FOREIGN KEY (user_name) REFERENCES tomcat_users (user_name),
	CONSTRAINT tomcat_users_roles_foreign_key_2 FOREIGN KEY (role_name) REFERENCES tomcat_roles (role_name)
);

--
-- Dumping data for table `tomcat_users`
--

INSERT INTO `tomcat_users` (`user_name`, `password`) VALUES
('admin', 'admin'),
('tomcat', '123'),
('user1', '123'),
('user2', '1234');

--
-- Dumping data for table `tomcat_roles`
--

INSERT INTO `tomcat_roles` (`role_name`) VALUES
('admin'),
('manager'),
('manager-gui'),
('manager-script'),
('user');

--
-- Dumping data for table `tomcat_users_roles`
--

INSERT INTO `tomcat_users_roles` (`user_name`, `role_name`) VALUES
('admin', 'admin'),
('admin', 'manager'),
('tomcat', 'manager-gui'),
('admin', 'manager-script'),
('user1', 'user'),
('user2', 'user');
