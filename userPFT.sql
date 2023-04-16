USE readit;

DROP PROCEDURE IF EXISTS createUser;

DELIMITER // 
CREATE PROCEDURE createUser
( 
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
END // 

DELIMITER ;


DROP PROCEDURE IF EXISTS getUserDetails;
DELIMITER //
CREATE PROCEDURE getUserDetails(usernameInput VARCHAR(255))
BEGIN
 SELECT userName, firstName, lastName, email, dateOfBirth, about, numPosts, timeJoined
 FROM `user`
 WHERE `user`.userName = usernameInput;
END //

DROP PROCEDURE IF EXISTS updateUser;

DELIMITER //

CREATE PROCEDURE updateUser (
    IN p_userName VARCHAR(255),
    IN p_newUserName VARCHAR(255),
    IN p_newFirstName VARCHAR(255),
    IN p_newLastName VARCHAR(255),
    IN p_newPassword VARCHAR(255),
    IN p_newEmail VARCHAR(255),
    IN p_newDateOfBirth DATE,
    IN p_newAbout VARCHAR(1000)
)
BEGIN
    DECLARE username_exists INT DEFAULT 0;
    DECLARE email_exists INT DEFAULT 0;
    DECLARE errorMessage VARCHAR(255);

    IF p_newUserName IS NOT NULL THEN
        SELECT COUNT(*) INTO username_exists
        FROM `user`
        WHERE userName = p_newUserName;

        IF username_exists > 0 THEN
            SET errorMessage = 'The new username is already taken.';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
        END IF;
    END IF;

    IF p_newEmail IS NOT NULL THEN
        SELECT COUNT(*) INTO email_exists
        FROM `user`
        WHERE email = p_newEmail;

        IF email_exists > 0 THEN
            SET errorMessage = 'The new email is already taken.';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errorMessage;
        END IF;
    END IF;

    UPDATE `user`
    SET
        userName = IF(p_newUserName IS NULL, userName, p_newUserName),
        firstName = IF(p_newFirstName IS NULL, firstName, p_newFirstName),
        lastName = IF(p_newLastName IS NULL, lastName, p_newLastName),
        `password` = IF(p_newPassword IS NULL, `password`, p_newPassword),
        email = IF(p_newEmail IS NULL, email, p_newEmail),
        dateOfBirth = IF(p_newDateOfBirth IS NULL, dateOfBirth, p_newDateOfBirth),
        about = IF(p_newAbout IS NULL, about, p_newAbout)
    WHERE
        userName = p_userName;

    SET errorMessage = 'User updated successfully.';
    SELECT errorMessage AS Message; -- Display the message as a result set to see message as an output
END //

DELIMITER ;