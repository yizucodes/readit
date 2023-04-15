import pymysql
import re
import json
import bcrypt


def is_valid_email(email):
    email_regex = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return bool(re.match(email_regex, email))

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

def create_user(username, first_name, last_name, password, email, date_of_birth, about):
    # Hash the password
    password_bytes = password.encode('utf-8')
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password_bytes, salt)

    # Connect to the MySQL database
    connection = create_connection()

    try:
        with connection.cursor() as cursor:
            # Execute the stored procedure with the hashed password
            cursor.callproc('createUser', (username, first_name, last_name, hashed_password, email, date_of_birth, about))
        
        # Commit the transaction so that user created by the createUser stored procedure is saved to the database permanently.
        connection.commit()
    except pymysql.err.InternalError as e:
        print("Error:", e)
    finally:
        connection.close()

def get_user_details():
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
            create_user(username, first_name, last_name, password, email, date_of_birth, about)
            print("User created successfully!")
            break

        except Exception as e:
            print(f"Error creating user: {e}")

if __name__ == "__main__":
    get_user_details()


# Example usage
# create_user("pw", "pw", "pw", "pw", "john.doe@example.com", "1995-01-01", "I'm pw")
