

def logout(connection):
    connection.cursor().close()
    connection.close()

    print("You can close the application now!")
    exit(0)
    # login.login()
