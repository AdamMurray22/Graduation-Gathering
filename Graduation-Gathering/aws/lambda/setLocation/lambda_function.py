import json
import boto3
import logging
import re
import setLocation.package.pymysql as pymysql
import os
import sys
import time
from datetime import datetime

# rds settings
user_name = os.environ['USER_NAME']
password = os.environ['PASSWORD']
rds_proxy_host = os.environ['RDS_PROXY_HOST']
db_name = os.environ['DB_NAME']

# Allows for AWS Logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# create the database connection outside of the handler to allow connections to be
# re-used by subsequent function invocations.
try:
    conn = pymysql.connect(host=rds_proxy_host, user=user_name, passwd=password, db=db_name, connect_timeout=5)
except pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)
    sys.exit()

def lambda_handler(event, context): # Entry point for AWS.
    email = event['requestContext']['authorizer']["lambda"]["email"]
    userID = event['requestContext']['authorizer']["lambda"]["userID"]

    if not isGraduationDay():
        return

    messageBodyJson = event["body"]
    messageBody = json.loads(messageBodyJson)
    location = messageBody["location"]

    sql_string = 'UPDATE user SET latitude = {latitude}, longitude = {longitude}, location_set = {locationSet} WHERE user_id = "{userID}"'

    with conn.cursor() as cur:
        try:
            cur.execute(sql_string.format(latitude = location["lat"], longitude = location["long"], locationSet = time.time(), userID = escape_sql_string(userID)))
        except pymysql.MySQLError as e:
            logger.error(e)
        cur.close()
    conn.commit()

# Escapes a string to be given to the database to protect the database.
def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'", '"': r'\"'})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)

# Checks if it is currently during graduation time
def isGraduationDay():
    datesStrings = getDates()
    dates = []
    for dateString in datesStrings:
        dates.append(datetime.strptime(dateString, '%y/%m/%d').date())

    today = datetime.today().date()

    for date in dates:
        if today == date:
            if today.time() >= datetime.strptime("08", "%H"):
                return True
        else: 
            tomorrowDate = datetime.strftime(date - datetime.timedelta(1), '%Y-%m-%d')
            if today == tomorrowDate:
                if today.time() < datetime.strptime("01", "%H"):
                    return True

    return False

# Gets the graduation dates from the database
def getDates():
    dates = []
    with conn.cursor() as cur:
        # Gets the graduation dates
        sql = "SELECT date FROM graduation_date"
        cur.execute(sql)
        for row in cur:
            date = row[0]
            dates.append(date)
    conn.commit()

    return dates