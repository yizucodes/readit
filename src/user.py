import pymysql
import re
import json
import bcrypt


def is_valid_email(email):
    email_regex = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return bool(re.match(email_regex, email))


def get_column_index(cursor, colName):
    for index, column_info in enumerate(cursor.description):
        if column_info[0].lower() == colName.lower():
            return index
    return -1

# Load configuration from JSON file


def load_config():
    with open("config.json", "r") as file:
        return json.load(file)


config = load_config()

# Create a connection to the MySQL database
def create_connection():
    return pymysql.connect(
        host=config["database"]["host"],
        user=config["database"]["user"],
        password=config["database"]["password"],
        database=config["database"]["database_name"]
    )


def create_user_input(username, first_name, last_name, password, email, date_of_birth, about):
    # Hash the password
    password_bytes = password.encode('utf-8')
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password_bytes, salt)

    # Connect to the MySQL database
    connection = create_connection()

    try:
        with connection.cursor() as cursor:
            # Execute the stored procedure with the hashed password
            cursor.callproc('createUser', (username, first_name,
                            last_name, hashed_password, email, date_of_birth, about))

        # Commit the transaction so that user created by the createUser stored procedure is saved to the database permanently.
        connection.commit()
    except pymysql.err.InternalError as e:
        print("Error:", e)
    finally:
        connection.close()


def create_user():
    while True:
        print("Creating an account")
        username = input("Username: ").strip()
        first_name = input("First Name: ").strip()
        last_name = input("Last Name: ").strip()
        password = input("Password: ").strip()

        email = input("Email: ").strip()
        while (is_valid_email(email) == False):
            print("Invalid email address. Please try again.")
            email = input("Email: ").strip()

        date_of_birth = input("Date of Birth (YYYY-MM-DD): ").strip()
        about = input("About: ").strip()

        try:
            create_user(username, first_name, last_name,
                        password, email, date_of_birth, about)
            print("User created successfully!")
            break

        except Exception as e:
            print(f"Error creating user: {e}")


def get_user():
    # Connect to the MySQL database
    connection = create_connection()
    cur = connection.cursor()

    while True:

        # Current implementation requires currently logged in user to input his user name to read his details
        username_Input = username = input("Enter username that you want to read info about (type 'exit' to quit): ")

        try:
           

            if username_Input.lower() == 'exit':
                break
            
             # Call the stored procedure to retrieve user details
            cur.callproc('getUserDetails', [username_Input])

            # Get the result set from the stored procedure
            resUser = cur.fetchone()

            # Print the user details
            username = resUser[get_column_index(cur, "username")]
            first_name = username = resUser[get_column_index(cur, "firstName")]
            last_name = resUser[get_column_index(cur, "lastName")]
            email = resUser[get_column_index(cur, "email")]
            date_of_birth = resUser[get_column_index(cur, "dateOfBirth")]
            about = resUser[get_column_index(cur, "about")]
            num_posts = resUser[get_column_index(cur, "numPosts")]
            time_joined = resUser[get_column_index(cur, "timeJoined")]

            print("Username:", username)
            print("First Name:", first_name)
            print("Last Name:", last_name)
            print("Email:", email)
            print("Date of Birth:", date_of_birth)
            print("About:", about)
            print("Number of Posts:", num_posts)
            print("Time Joined:", time_joined)

        except Exception as e:
            print(f"Error retrieving user: {e}")

        finally:
            cur.close()
            connection.close()


if __name__ == "__main__":
    get_user()
