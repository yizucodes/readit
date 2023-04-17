import pymysql
import json
import bcrypt
import post
import utils

currentUser = None


def get_password_column_index(cursor):
    for index, column_info in enumerate(cursor.description):
        if column_info[0].lower() == 'password':
            return index
    return None

def verify_credentials(username, password):
    conn = utils.create_connection()
    cursor = conn.cursor()
    
    try:
        query = "SELECT * FROM user WHERE username = %s"
        cursor.execute(query, (username,))
        user = cursor.fetchone()

        password_index = get_password_column_index(cursor)

        # Check for hashed password
        password_to_check = password.encode('utf-8') # hashed db password
        hashed_password_bytes = user[password_index].encode('utf-8')
        is_correct_password = bcrypt.checkpw(password_to_check, hashed_password_bytes)
        # Error handling for hashed passwords 
        if user and password_index is not None and is_correct_password:
            currentUser = username
            return True
        else:
            return False
    finally:
        cursor.close()
        conn.close()

def login():
    isLogged = False
    while isLogged == False:
        username = input("Enter your username (type 'exit' to quit): ")
        if username.lower() == 'exit':
            if userName:
                userName = None
            break
        
        password = input("Enter your password: ")

        if verify_credentials(username, password):
            print("Login successful!")
            # Go to the main page
            post.main()
            isLogged = True
            break
        else:
            print("Invalid username or password. Please try again.")

if __name__ == "__main__":
    login()
