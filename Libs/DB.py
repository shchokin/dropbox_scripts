import pymssql
from termcolor import colored

from Data import QA1_DB, QA1_CRS
from Data import UAT_DB, UAT_CRS


def db_connect(env_name):
    if str(env_name).lower().strip() == "qa1":
        conn = pymssql.connect(server=QA1_DB.host,
                               user=QA1_DB.user,
                               password=QA1_DB.password,
                               database=QA1_DB.database
                               )
    elif str(env_name).lower().strip() == "uat":
        conn = pymssql.connect(server=UAT_DB.host,
                               user=UAT_DB.user,
                               password=UAT_DB.password,
                               database=UAT_DB.database
                               )
    else:
        print(colored("\nWrong environment name is specified for DB", "red"))
        conn = None
    return conn
