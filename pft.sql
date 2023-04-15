USE READIT;

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

-- Call createUser(
-- "Chirag_Mal",
-- "Chirag",
-- "Malhotra",
-- "This",
-- "emil@email.com",
-- Null,
-- Null);

Call createUser(
"yi",
"yI",
null,
"This",
"emil2@email.com",
Null,
Null);
