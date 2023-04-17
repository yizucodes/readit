use readit;

drop procedure if exists create_img;

DELIMITER //

CREATE PROCEDURE create_img(
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
END //
DELIMITER ;

-- call create_img("url1", 12);


DROP PROCEDURE IF EXISTS delete_image_from_post;

DELIMITER //
CREATE PROCEDURE delete_image_from_post(
img VARCHAR(255),
postId INT)
BEGIN
IF postId IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "post ID cannot be null";
END IF;

IF img IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "URL cannot be null";
END IF;

DELETE FROM postcontainsimagelink WHERE postcontainsimagelink.postId = postId AND postcontainsimagelink.url = img;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS delete_img;

DELIMITER //
CREATE TRIGGER delete_img
AFTER DELETE ON postcontainsimagelink
FOR EACH ROW
BEGIN
	DECLARE postId1 INT;
    SELECT postId INTO postId1 FROM postcontainsimagelink as l WHERE l.url IN (SELECT url FROM image);
    
    IF postId1 IS NULL 
		THEN
			DELETE FROM image WHERE url NOT IN (SELECT url FROM postcontainsimagelink);
	end if;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS change_img;

DELIMITER //
CREATE PROCEDURE change_img(
img VARCHAR(255),
postId INT
)
BEGIN
DECLARE existing VARCHAR(255);
IF postId IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "post ID cannot be null";
END IF;

IF img IS NOT NULL THEN 
SELECT url INTO existing FROM image WHERE image.url = url;
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
END //
DELIMITER ;

-- SELECT url FROM postcontainsimagelink WHERE postId = 1;



