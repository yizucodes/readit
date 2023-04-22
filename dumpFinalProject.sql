CREATE DATABASE  IF NOT EXISTS `readit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `readit`;
-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: readit
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `textBody` varchar(2000) DEFAULT NULL,
  `parentId` int DEFAULT NULL,
  `postId` int DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `postCommentUnique` (`postId`,`id`),
  KEY `parentId` (`parentId`),
  KEY `userName` (`userName`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'comment by a',NULL,NULL,'a'),(2,'',NULL,NULL,'b'),(3,'b is commenting on comment by a',1,NULL,'b'),(4,'comment on third level',3,NULL,'b');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES ('www.helloworld.com');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `body` varchar(2000) DEFAULT NULL,
  `createdTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userCreates` (`userName`),
  CONSTRAINT `userCreates` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'a','first post of a','hello world','2023-04-22 01:46:14','2023-04-22 01:46:14');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postContainsImageLink`
--

DROP TABLE IF EXISTS `postContainsImageLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postContainsImageLink` (
  `url` varchar(255) NOT NULL,
  `postId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`url`,`postId`),
  KEY `postId` (`postId`),
  CONSTRAINT `postcontainsimagelink_ibfk_1` FOREIGN KEY (`url`) REFERENCES `image` (`url`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `postcontainsimagelink_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postContainsImageLink`
--

LOCK TABLES `postContainsImageLink` WRITE;
/*!40000 ALTER TABLE `postContainsImageLink` DISABLE KEYS */;
INSERT INTO `postContainsImageLink` VALUES ('www.helloworld.com',1);
/*!40000 ALTER TABLE `postContainsImageLink` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `delete_img` AFTER DELETE ON `postcontainsimagelink` FOR EACH ROW BEGIN
	DECLARE postId1 INT;
    SELECT postId INTO postId1 FROM postcontainsimagelink as l WHERE l.url IN (SELECT url FROM image);
    
    IF postId1 IS NULL 
		THEN
			DELETE FROM image WHERE url NOT IN (SELECT url FROM postcontainsimagelink);
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `postHasCommentLink`
--

DROP TABLE IF EXISTS `postHasCommentLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postHasCommentLink` (
  `commentId` int NOT NULL,
  `postId` int NOT NULL,
  PRIMARY KEY (`commentId`,`postId`),
  KEY `postId` (`postId`),
  CONSTRAINT `posthascommentlink_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `posthascommentlink_ibfk_2` FOREIGN KEY (`commentId`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postHasCommentLink`
--

LOCK TABLES `postHasCommentLink` WRITE;
/*!40000 ALTER TABLE `postHasCommentLink` DISABLE KEYS */;
INSERT INTO `postHasCommentLink` VALUES (1,1),(2,1),(3,1),(4,1);
/*!40000 ALTER TABLE `postHasCommentLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userName` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `about` varchar(1000) DEFAULT NULL,
  `numPosts` int DEFAULT '0',
  `timeJoined` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userName`),
  UNIQUE KEY `uniquemail` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('a','a','a','$2b$12$jI6vqBETaiFi0ecByzN7ROgposi9/SePv.qEONA4dhhGjWuX9m2bu','a@a.a','1111-11-11','a',0,'2023-04-22 01:44:17'),('b','b','b','$2b$12$cOcv89DnRpRByixllmhZ0OaqKWlTIoYxm1JWLhDDrcn6ual6J/hLa','b@b.b','1111-11-11','b',0,'2023-04-22 01:44:47');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserVotePostLink`
--

DROP TABLE IF EXISTS `UserVotePostLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserVotePostLink` (
  `userName` varchar(255) NOT NULL,
  `postId` int NOT NULL,
  PRIMARY KEY (`userName`,`postId`),
  KEY `postId` (`postId`),
  CONSTRAINT `uservotepostlink_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uservotepostlink_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserVotePostLink`
--

LOCK TABLES `UserVotePostLink` WRITE;
/*!40000 ALTER TABLE `UserVotePostLink` DISABLE KEYS */;
INSERT INTO `UserVotePostLink` VALUES ('a',1),('b',1);
/*!40000 ALTER TABLE `UserVotePostLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'readit'
--
/*!50003 DROP FUNCTION IF EXISTS `CUPost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CUPost`(id INT,
userName varchar(255), 
title varchar(255), 
`body` varchar(1000)
) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE current_t DATETIME;
    DECLARE current_title varchar(255);
    DECLARE current_body VARCHAR(1000);
    DECLARE final_id INT;
	IF userName IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Username cannot be null";
	end if;
	IF id IS NULL
    -- Create the post
		THEN
			SELECT NOW() INTO current_t;
			INSERT INTO post (userName, title, body, createdTime, updatedTime)
			VALUES (userName, title, body, current_t, current_t);
            
            SELECT post.id INTO final_id FROM post WHERE post.userName = userName AND post.createdTime = current_t;
            RETURN final_id;
            
	ELSE
			-- Update the post
            
            IF `body` IS NULL
				THEN
                SELECT post.body INTO current_body FROM post WHERE post.id = id;
			ELSE
				SELECT body INTO current_body;
			END IF;
            IF `title` IS NULL
				THEN 
                SELECT post.title INTO current_title FROM post WHERE post.id = id;
			ELSE
				SELECT title INTO current_title;
			END IF;
            
            SELECT id INTO final_id;
            
            IF (SELECT userName FROM post WHERE post.userName = username) IS NULL
				THEN SIGNAL sqlstate '45000' SET message_text = "You can only edit your own post!";
			END IF;	
            SELECT NOW() INTO current_t;
			UPDATE post
            
            SET
				post.`body` = current_body,
                post.title = current_title,
                post.updatedTime = current_t
			WHERE post.id = id;
            
            RETURN final_id;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `num_votes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `num_votes`(id INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE votes int;
	SELECT count(userName) INTO votes FROM UserVotePostLink WHERE postId = id GROUP BY postId;
	return votes;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_img` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_img`(
img VARCHAR(255),
postId INT
)
BEGIN
DECLARE existing VARCHAR(255);
IF postId IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "post ID cannot be null";
END IF;

IF img IS NOT NULL THEN 
-- SELECT url INTO existing FROM image WHERE image.url = url;

SELECT url INTO existing FROM image WHERE image.url = img;

IF existing IS NULL 
	THEN
    CALL create_img(img, postId);
ELSE
	UPDATE postcontainsimagelink
    SET
		url = existing
	WHERE postcontainsimagelink.postId = postId;
END IF;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createComment`(
    IN post_id INT,
    IN parent_id INT,
    IN userName VARCHAR(255),
    IN text_body VARCHAR(1000)
)
BEGIN
    -- Declare a variable to hold the ID of the parent post
    DECLARE parent_post_id INT;
    DECLARE parent_comment_id INT;

    -- Check if the parent post exists
    SELECT id INTO parent_post_id FROM post WHERE id = post_id;

    IF parent_post_id IS NULL THEN
        -- Signal an error if the post doesn't exist
        SIGNAL SQLSTATE '45000' SET message_text = 'Post does not exist with that ID.';
    ELSE
        -- If a parent comment ID was provided, check if it exists
        IF parent_id IS NOT NULL THEN
            -- Check if the parent comment exists and belongs to the same post
            SELECT commentId INTO parent_comment_id FROM postHasCommentLink WHERE commentId = parent_id AND postId = post_id;

            IF parent_comment_id IS NULL THEN
                -- Signal an error if the parent comment doesn't exist or doesn't belong to the same post
                SIGNAL SQLSTATE '45000' SET message_text = 'Parent comment does not exist or does not belong to the same post.';
            END IF;

            -- Insert the comment with the provided parent ID
            INSERT INTO `comment` (textBody, parentId, userName) VALUES (text_body, parent_id, userName);


        ELSE
            -- Insert the comment as a top-level comment
            INSERT INTO `comment` (textBody, parentId, userName) VALUES (text_body, NULL, userName);

        END IF;

        -- Get the ID of the inserted comment
        SET @comment_id = LAST_INSERT_ID();

        -- Insert a record in the postHasCommentLink table to link the comment to the post
        INSERT INTO postHasCommentLink (commentId, postId) VALUES (@comment_id, parent_post_id);

        -- Return the ID of the inserted comment
        SELECT @comment_id AS comment_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser`( 
userName varchar(255), 
firstName varchar(255), 
lastName varchar(255), 
`password` varchar(255), 
email varchar(255), 
dateOfBirth DATE, 
about varchar(1000)
)
BEGIN
	DECLARE user_check Varchar(255);
	DECLARE current_t DATETIME;
	SELECT userName INTO user_check FROM user WHERE userName = user.userName;
    
	IF user_check IS NULL
		THEN
			IF firstName IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "First name cannot be null";
            end if;
			IF lastName IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Last name cannot be null";
            END IF;
			IF email IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Email cannot be null";
            END IF;
			SELECT NOW() INTO current_t;
            
			INSERT INTO user (userName, firstName, lastName, `password`, email, dateOfBirth, about, timeJoined)
			VALUES (userName, firstName, lastName, `password`, email, dateOfBirth, about, current_t);
	ELSE
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'UserName already Exists!';
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_img` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_img`(
img_url VARCHAR(255),
postId INT
)
BEGIN
-- As this procedure can only be called from inside the post, I am not checking for the valid post ID as it will be auto generated and given to the procedure
IF postId IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "post ID cannot be null";
END IF;

IF img_url IS NOT NULL 
THEN
IF (SELECT url FROM image WHERE url = img_url) IS NULL
	THEN 
		INSERT INTO image(url)
        VALUES( img_url);
END IF;

INSERT INTO postcontainsimagelink(url, postId)
	VALUES(img_url, postId);
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteComment`(
    IN comment_id INT
)
BEGIN
    -- Check if the comment exists
    DECLARE comment_exists INT;
    SELECT COUNT(*) INTO comment_exists FROM comment WHERE id = comment_id;

    IF comment_exists = 0 THEN
        -- Signal an error if the comment doesn't exist
        SIGNAL SQLSTATE '45000' SET message_text = 'Comment does not exist with that ID.';
    ELSE
        -- Delete the comment from the postHasCommentLink table
        DELETE FROM postHasCommentLink WHERE commentId = comment_id;

        -- Delete the comment
        DELETE FROM comment WHERE id = comment_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_image_from_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_image_from_post`(
img VARCHAR(255),
postId INT)
BEGIN
IF postId IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "post ID cannot be null";
END IF;

IF img IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "URL cannot be null";
END IF;

DELETE FROM postcontainsimagelink WHERE postcontainsimagelink.postId = postId AND postcontainsimagelink.url = img;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_post`(
postId int,
userName varchar(255)
)
BEGIN
	DECLARE user_post VARCHAR(255);
    SELECT post.userName INTO user_post FROM post WHERE post.id = postId;
    IF user_post != userName THEN SIGNAL sqlstate '45000' SET message_text = "Not authorized to delete this post.";
    END IF;	
	DELETE FROM post WHERE post.id = postId AND post.userName = userName;
    -- CALL undo_vote(userName, postId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(
IN userName VARCHAR(255)
)
BEGIN

DECLARE usexists VARCHAR(255);

SELECT userName INTO usexists from `user` as u WHERE u.userName = userName;

IF usexists IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Username Doesn't exist";

ELSE
	DELETE FROM `user` as u WHERE u.userName = userName;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserDetails`(
userName VARCHAR(255)
)
BEGIN
DECLARE usexists VARCHAR(255);

SELECT userName INTO usexists from `user` as u WHERE u.userName = userName;

IF usexists IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Username Doesn't exist";

ELSE
	SELECT * FROM `user` AS u WHERE u.userName = userName;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `readComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `readComment`(
    IN comment_id INT,
    IN UserName VARCHAR(255)
)
BEGIN
    -- Check if the comment exists
    DECLARE comment_exists INT;
    SELECT COUNT(*) INTO comment_exists FROM comment WHERE id = comment_id;

    IF comment_exists = 0 THEN
        -- Signal an error if the comment doesn't exist
        SIGNAL SQLSTATE '45000' SET message_text = 'Comment does not exist with that ID.';
    ELSE
        -- Fetch the comment along with the associated post information and user information
        SELECT
			c.id AS comment_id_c,
			c.textBody AS comment_text_body,
			c.parentId AS comment_parent_id,
			p.id AS post_id,
			p.title AS post_title,
			p.body AS post_body
	FROM
		post AS p
	JOIN
		postHasCommentLink AS pcl
	ON
		p.id = pcl.postId
	JOIN
		`comment` AS c
	ON
		pcl.commentId = c.id
	where c.id = comment_id
	and 
	c.userName = UserName;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `undo_vote` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `undo_vote`(userName VARCHAR (255), id INT)
BEGIN
	IF (SELECT userName FROM uservotepostlink WHERE postId = id) IS NULL
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "You haven't voted this post";
	END IF;
    
    DELETE FROM uservotepostlink WHERE userName = uservotepostlink.userName and uservotepostlink.postId = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateComment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateComment`(
    IN comment_id INT,
    IN new_text_body VARCHAR(1000)
)
BEGIN
    -- Check if the comment exists
    DECLARE comment_exists INT;
    SELECT COUNT(*) INTO comment_exists FROM comment WHERE id = comment_id;

    IF comment_exists = 0 THEN
        -- Signal an error if the comment doesn't exist
        SIGNAL SQLSTATE '45000' SET message_text = 'Comment does not exist with that ID.';
    ELSE
        -- Update the textBody of the comment
        UPDATE comment SET textBody = new_text_body WHERE id = comment_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdatePost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePost`(
IN id INT,
IN userName VARCHAR(255),
IN title VARCHAR(255),
IN body TEXT
)
BEGIN
    IF id IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Post ID cannot be null";
    END IF;

    IF userName IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Username cannot be null";
    END IF;

    IF (SELECT post.userName FROM post WHERE post.id = id) != userName THEN
        SIGNAL sqlstate '45000' SET message_text = "You can only edit your own post!";
    END IF;

    UPDATE post
    --  To update the title and body of the post only if the new values provided are not null
    SET
        title = COALESCE(title, post.title),
        body = COALESCE(body, post.body),
        updatedTime = NOW()
    WHERE post.id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUser`(
username VARCHAR (255), 
new_username VARCHAR (255), 
new_first_name VARCHAR (255), 
new_last_name VARCHAR (255),
new_password VARCHAR (255), 
new_email VARCHAR (255), 
new_date_of_birth DATE, 
new_about VARCHAR (1000)
)
BEGIN
DECLARE current_first VARCHAR(255);
DECLARE current_last VARCHAR(255);
DECLARE current_pass VARCHAR(255);
DECLARE current_email VARCHAR(255);
DECLARE current_about VARCHAR(255);
DECLARE current_date_db DATE;
DECLARE current_userName VARCHAR(255);
DECLARE joined DATETIME;


IF (SELECT userName FROM `user` WHERE `user`.userName = username) IS NULL
			THEN SIGNAL sqlstate '45000' SET message_text = "User not found!";
			END IF;	
            
            
 IF `new_username` IS NULL
		THEN 
		SELECT `username` INTO current_userName;
	ELSE
		SELECT `new_username` INTO current_userName;
	END IF;

 IF `new_first_name` IS NULL
		THEN 
		SELECT `firstName` INTO current_first FROM `user` as u WHERE u.userName = `username`;
	ELSE
		SELECT `new_first_name` INTO current_first;
	END IF;
    
 IF `new_last_name` IS NULL
		THEN 
		SELECT `lastName` INTO current_last FROM `user` as u WHERE u.userName = `username`;
	ELSE
		SELECT `new_last_name` INTO current_last;
	END IF;
    
    
IF `new_password` IS NULL
	THEN 
		SELECT `password` INTO current_pass FROM `user` as u WHERE u.userName = `username`;
	ELSE
		SELECT `new_password` INTO current_pass;
	END IF;

IF `new_email` IS NULL
	THEN 
		SELECT `email` INTO current_email FROM `user` as u WHERE u.userName = `username`;
	ELSE
		SELECT `new_email` INTO current_email;
	END IF;

IF `new_date_of_birth` IS NULL
	THEN 
		SELECT `dateOfBirth` INTO current_date_db FROM `user` as u WHERE u.userName = `username`;
	ELSE
		SELECT `new_date_of_birth` INTO current_date_db;
	END IF;

IF `new_about` IS NULL
	THEN 
		SELECT `about` INTO current_about FROM `user` as u WHERE u.userName = `username`;
	ELSE
		SELECT `new_about` INTO current_about;
	END IF;




UPDATE `user`

SET 
	userName = current_userName,
    firstName = current_first,
    lastName = current_last,
    `password` = current_pass,
    email = current_email,
    dateOfBirth = current_date_db,
    about = current_about
WHERE username = `user`.userName;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_votes_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_votes_post`(
userName VARCHAR(255),
postId INT
)
BEGIN
	INSERT INTO uservotepostlink (userName, postId)
		VALUES (userName, postId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-22  1:52:25
