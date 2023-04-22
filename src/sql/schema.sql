
CREATE DATABASE IF NOT EXISTS readit;

USE readit;

CREATE TABLE IF NOT EXISTS `user` (
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

CREATE TABLE IF NOT EXISTS `post` (
	id INT PRIMARY KEY AUTO_INCREMENT,
    userName varchar(255),
    title varchar(255),
    body varchar(2000),
	createdTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedTime DATETIME DEFAULT CURRENT_TIMESTAMP, -- modified by trigger
    CONSTRAINT userCreates FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `UserVotePostLink` (

	userName varchar(255) NOT NULL,
    postId INT NOT NULL,
    FOREIGN KEY (userName) REFERENCES `user` (userName) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (postId) REFERENCES `post` (id) ON DELETE CASCADE ON UPDATE CASCADE,
    
	primary key (userName, postId)
);

CREATE TABLE IF NOT EXISTS `image` (
	 url varchar(255) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS `postContainsImageLink` (
	url varchar(255),
	postId INT AUTO_INCREMENT NOT NULL,
    FOREIGN KEY (`url`) REFERENCES `image` (url) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`postId`) REFERENCES `post` (id) ON DELETE CASCADE ON UPDATE CASCADE,
	primary key (url, postId)
);

CREATE TABLE IF NOT EXISTS `comment` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    textBody VARCHAR(2000),
    parentId INT,
    postId INT,
    userName VARCHAR(255),
    FOREIGN KEY (parentId) REFERENCES comment (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (postId) REFERENCES post (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (userName) REFERENCES user (userName) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT postCommentUnique UNIQUE (postId, id)
);

CREATE TABLE IF NOT EXISTS `postHasCommentLink` ( 
	commentId INT NOT NULL,
    postId INT NOT NULL,
    FOREIGN KEY (`postId`) REFERENCES `post` (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`commentId`) REFERENCES `comment` (id) ON DELETE CASCADE ON UPDATE CASCADE,
    primary key (commentId, postId)
);


