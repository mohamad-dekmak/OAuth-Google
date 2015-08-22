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
('admin', '21232f297a57a5a743894a0e4a801fc3'), -- admin
('tomcat', '202cb962ac59075b964b07152d234b70'), -- 123 
('user1', '202cb962ac59075b964b07152d234b70'), -- 123
('user2', '202cb962ac59075b964b07152d234b70'); -- 123
('curly', '5ebe2294ecd0e0f08eab7690d2a6ee69'); -- secret

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
('curly', 'manager-gui'),
('curly', 'manager-script'),
('curly', 'user'),
('user1', 'user'),
('user2', 'user');
