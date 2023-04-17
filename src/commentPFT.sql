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
            INSERT INTO `comment` (textBody, parentId) VALUES (text_body, parent_id);

        ELSE
            -- Insert the comment as a top-level comment
            INSERT INTO `comment` (textBody, parentId) VALUES (text_body, NULL);
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


