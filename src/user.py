import pymysql
import re
import json
import bcrypt
# from src.utils import is_valid_date
from datetime import datetime

# Utils
def is_valid_date(date_string, date_format="%Y-%m-%d"):
    try:
        datetime.strptime(date_string, date_format)
        return True
    except ValueError:
        return False

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

# kwargs is short for "keyword arguments."
# Pass a variable number of named or keyword arguments to a function
def update_user(username, **kwargs):
    connection = create_connection()
    
    new_username = kwargs.get('new_username', None)
    new_first_name = kwargs.get('new_first_name', None)
    new_last_name = kwargs.get('new_last_name', None)
    new_password = kwargs.get('new_password', None)
    new_email = kwargs.get('new_email', None)
    new_date_of_birth = kwargs.get('new_date_of_birth', None)
    new_about = kwargs.get('new_about', None)

    try:
        with connection.cursor() as cursor:
            cursor.callproc('updateUser', (username, new_username, new_first_name, new_last_name,
                                           new_password, new_email, new_date_of_birth, new_about))
            connection.commit()
            print("User updated successfully.")
    except pymysql.err.InternalError as e:
        print("Error:", e)
    finally:
        connection.close()

def update_user_interactive():

    # TODO: Get the current username that is logged in VIA GLOBAL VARIABLE
    username = input("Enter your current username: ").strip()
    
    update_fields = {}
    update_another_field = True
    
    while update_another_field:
        print("Which field do you want to update?")
        print("1. Username")
        print("2. First Name")
        print("3. Last Name")
        print("4. Password")
        print("5. Email")
        print("6. Date of Birth")
        print("7. About")
        
        choice = int(input("Enter the number corresponding to the field you want to update: "))
        
        if choice == 1:
            new_username = input("Enter new username: ").strip()
            update_fields['new_username'] = new_username
        elif choice == 2:
            new_first_name = input("Enter new first name: ").strip()
            update_fields['new_first_name'] = new_first_name
        elif choice == 3:
            new_last_name = input("Enter new last name: ").strip()
            update_fields['new_last_name'] = new_last_name
        elif choice == 4:
            new_password = input("Enter new password: ").strip()
            # Hash the new password
            new_password_bytes = new_password.encode('utf-8')
            salt = bcrypt.gensalt()
            hashed_new_password = bcrypt.hashpw(new_password_bytes, salt)

            update_fields['new_password'] = hashed_new_password

        elif choice == 5:
            new_email = input("Enter new email: ").strip()
            while not is_valid_email(new_email):
                print("Invalid email address. Please try again.")
                new_email = input("Enter new email: ").strip()
            update_fields['new_email'] = new_email
        elif choice == 6:
            new_date_of_birth = input("Enter new date of birth (YYYY-MM-DD): ").strip()
            while not is_valid_date(new_date_of_birth):
                 print("Invalid date format. Please try again in YYYY-MM-DD format.")
                 new_date_of_birth = input("Enter new date of birth (YYYY-MM-DD): ").strip()
            update_fields['new_date_of_birth'] = new_date_of_birth
        elif choice == 7:
            new_about = input("Enter new about: ").strip()
            update_fields['new_about'] = new_about
        else:
            print("Invalid choice. Please try again.")
            continue
        
        should_continue = input("Do you want to update another field? (yes/no): ").strip().lower()
        update_another_field = should_continue == "yes"
    
    update_user(username, **update_fields)

if __name__ == "__main__":
    # Call the update_user_interactive function to start the update process
    update_user_interactive()
