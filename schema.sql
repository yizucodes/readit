CREATE DATABASE IF NOT EXISTS readit;

USE readit;

CREATE TABLE IF NOT EXISTS `User` (
	userName varchar(255) PRIMARY KEY,
	firstName varchar(255) NOT NULL,
    lastName varchar(255) NOT NULL,
    `password` varchar(255) NOT NULL, -- use function to encrypt password
    email varchar(255) NOT NULL,
	CONSTRAINT uniquemail UNIQUE(email),
    dateOfBirth DATE,
    about varchar(1000),
    numPosts INT DEFAULT 0,
    timeJoined DATETIME DEFAULT CURRENT_TIMESTAMP -- done by triggers when user joins for first time
);

CREATE TABLE IF NOT EXISTS post (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title varchar(255),
    body varchar(2000),
	createdTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedTime DATETIME DEFAULT CURRENT_TIMESTAMP -- modified by trigger
);