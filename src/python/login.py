import bcrypt
import user
import post
import utils

currentUser = None

conn = utils.create_connection()
user.connection = conn

def get_password_column_index(cursor):
    for index, column_info in enumerate(cursor.description):
        if column_info[0].lower() == 'password':
            return index
    return None


def verify_credentials(username, password):
    
    cursor = conn.cursor()

    try:
        query = "SELECT * FROM user WHERE username = %s"
        cursor.execute(query, (username,))
        
        user = cursor.fetchone()
        if user == None:
            return False

        password_index = get_password_column_index(cursor)
        # print(user)

        # Check for hashed password
        password_to_check = password.encode('utf-8')  # hashed db password
        hashed_password_bytes = user[password_index].encode('utf-8')
        is_correct_password = bcrypt.checkpw(
            password_to_check, hashed_password_bytes)
        # Error handling for hashed passwords
        if user and password_index is not None and is_correct_password:
            return True
        else:
            return False
    except:
        print("Validation Error")
    finally:
        cursor.close()
   


def login():
    isLogged = False
    while isLogged == False:

        print("1. Login")
        print("2. Create a new account")
        print("3. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            username = input("Enter your username: ")
            password = input("Enter your password: ")

            if verify_credentials(username, password):
                currentUser = username
                
                print("Login successful!")
                # Go to the main page
                post.main(currentUser)
                isLogged = True
                break
            else:
                print("Invalid username or password. Please try again.")
        elif choice == '2':
            user.create_user()
        elif choice == '3':
            
            conn.close()
            break
        else:
            print("Invalid choice. Please try again.")


if __name__ == "__main__":
    login()
