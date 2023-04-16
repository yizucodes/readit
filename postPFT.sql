USE readit;


-- The procedure is responsible for both creating a new post if it doesn't exists already or Updating it if it does.
DROP PROCEDURE IF EXISTS CUPost;

DELIMITER // 
CREATE PROCEDURE CUPost
(id INT,
userName varchar(255), 
title varchar(255), 
`body` varchar(1000)
)
BEGIN
	
	DECLARE current_t DATETIME;
    DECLARE current_title varchar(255);
    DECLARE current_body VARCHAR(1000);
    
	IF userName IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Username cannot be null";
	end if;
	IF id IS NULL
    -- Create the post
		THEN
			SELECT NOW() INTO current_t;
			INSERT INTO post (userName, title, body, createdTime, updatedTime)
			VALUES (userName, title, body, current_t, current_t);
            
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
	END IF;
END // 
DELIMITER ;

DROP PROCEDURE IF EXISTS user_votes_post;

DELIMITER // 
CREATE PROCEDURE user_votes_post(
userName VARCHAR(255),
postId INT
)
BEGIN
	INSERT INTO uservotepostlink (userName, postId)
		VALUES (userName, postId);
END //
DELIMITER ;

CALL user_votes_post("bobsmith",12);


-- CALL CUPost(
-- null,
-- "amandasmith",
-- "title",
-- "body");
-- CALL CUPost(
-- null,
-- "amandasmith",
-- "tit",
-- "tititit");

-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`readit`.`post`, CONSTRAINT `userCreates` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE)


DELIMITER //
CREATE FUNCTION num_votes(id INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE votes int;
	SELECT count(userName) INTO votes FROM UserVotePostLink WHERE postId = id GROUP BY postId;
	return votes;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS delete_post;

DELIMITER //
CREATE PROCEDURE delete_post(
postId int,
userName varchar(255)
)
BEGIN
	DECLARE user_post VARCHAR(255);
    SELECT post.userName INTO user_post FROM post WHERE post.id = postId;
    IF user_post != userName THEN SIGNAL sqlstate '45000' SET message_text = "Not authorized to delete this post.";
    END IF;	
	DELETE FROM post WHERE post.id = postId AND post.userName = userName;
END //
DELIMITER ;


