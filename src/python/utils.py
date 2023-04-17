import pymysql
import json

# TODO for grader: Change your user and password field based on your MySQL credentials in config.json file
def load_config():
    with open("config.json", "r") as file:
        return json.load(file)

config = load_config()

def create_connection():
    return pymysql.connect(
        host=config["database"]["host"],
        user=config["database"]["user"],
        password=config["database"]["password"],
        database=config["database"]["database_name"]
    )
