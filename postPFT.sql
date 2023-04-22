USE readit;


-- The procedure is responsible for both creating a new post if it doesn't exists already or Updating it if it does.
DROP FUNCTION IF EXISTS CUPost;

DELIMITER // 
CREATE FUNCTION CUPost
(id INT,
userName varchar(255), 
title varchar(255), 
`body` varchar(1000)
)
RETURNS INT
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
END // 
DELIMITER ;

USE readit;

-- The procedure is responsible for updating an existing post.
DROP PROCEDURE IF EXISTS UpdatePost;

DELIMITER //
CREATE PROCEDURE UpdatePost(
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

-- CALL user_votes_post("bobsmith",12);


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
    -- CALL undo_vote(userName, postId);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS undo_vote;

DELIMITER //
CREATE PROCEDURE undo_vote(userName VARCHAR (255), id INT)
BEGIN
	IF (SELECT userName FROM uservotepostlink WHERE postId = id) IS NULL
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "You haven't voted this post";
	END IF;
    
    DELETE FROM uservotepostlink WHERE userName = uservotepostlink.userName and uservotepostlink.postId = id;
END //

DELIMITER ;


