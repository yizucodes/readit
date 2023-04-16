USE readit;

DROP PROCEDURE IF EXISTS createComment;

DELIMITER //
CREATE PROCEDURE createComment (
    IN post_id INT,
    IN parent_id INT,
    IN userName VARCHAR(255),
    IN text_body VARCHAR(1000)
)
BEGIN
    DECLARE parent_post_id INT;
    
    -- Check if post exists
    SELECT id INTO parent_post_id FROM post WHERE id = post_id;

    IF parent_post_id IS NULL THEN 
        SIGNAL SQLSTATE '45000' SET message_text = 'Post does not exist with that id.';
    ELSE
        -- Insert into comment table
        INSERT INTO `comment` (textBody, parentId) 
        VALUES (text_body, parent_id, userName);

        -- Get last automatically generated ID based on AUTO_INCREMENT column
        SET @comment_id = LAST_INSERT_ID();
        
        SELECT @comment_id AS comment_id;
    END IF;
END //
DELIMITER ;
