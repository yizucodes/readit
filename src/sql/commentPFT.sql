USE readit;

DROP PROCEDURE IF EXISTS createComment;

DELIMITER //
CREATE PROCEDURE createComment
(
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
END //

DELIMITER ;


USE readit;

DROP PROCEDURE IF EXISTS updateComment;

DELIMITER //
CREATE PROCEDURE updateComment
(
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
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS deleteComment;

DELIMITER //
CREATE PROCEDURE deleteComment
(
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
END //
DELIMITER ;


-- Testing 

SELECT
    p.id AS post_id,
    p.title AS post_title,
    p.body AS post_body,
    c.id AS comment_id,
    c.textBody AS comment_body,
    c.parentId AS comment_parent_id
FROM
    post AS p
JOIN
    postHasCommentLink AS pcl
ON
    p.id = pcl.postId
JOIN
    comment AS c
ON
    pcl.commentId = c.id;
    



DROP PROCEDURE IF EXISTS readComment;

DELIMITER //
CREATE PROCEDURE readComment
(
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
END //
DELIMITER ;


