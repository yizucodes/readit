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


DELIMITER //

DROP PROCEDURE IF EXISTS delete_user;

CREATE PROCEDURE delete_user(
IN userName VARCHAR(255)
) 
BEGIN

DECLARE usexists VARCHAR(255);

SELECT userName INTO usexists from `user` as u WHERE u.userName = userName;

IF usexists IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Username Doesn't exist";

ELSE
	DELETE FROM `user` as u WHERE u.userName = userName;
END IF;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS getUserDetails;
DELIMITER //
-- Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 14

CREATE PROCEDURE getUserDetails (
userName VARCHAR(255)
)
BEGIN
DECLARE usexists VARCHAR(255);

SELECT userName INTO usexists from `user` as u WHERE u.userName = userName;

IF usexists IS NULL THEN SIGNAL sqlstate '45000' SET message_text = "Username Doesn't exist";

ELSE
	SELECT * FROM `user` AS u WHERE u.userName = userName;
END IF;
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS updateUser;
DELIMITER //
CREATE PROCEDURE updateUser(
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

END //
DELIMITER ;


-- call updateUser(
-- 'abcd',
-- null,
-- "Why",
-- null,
-- null,
-- null,
-- null,
-- null)

