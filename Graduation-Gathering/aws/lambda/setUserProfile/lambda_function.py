import json
import boto3
import logging
import re
import setUserProfile.package.pymysql as pymysql
import os
import sys
import time

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

    messageBodyJson = event["body"]
    messageBody = json.loads(messageBodyJson)
    hasLoggedInBefore = messageBody["hasLoggedInBefore"]
    name = messageBody["name"]
    faculty = messageBody["faculty"]
    school = messageBody["school"]
    course = messageBody["course"]
    zones = messageBody["userGradZoneIds"]
    
    if name == None:
        name = "Null"
    else:
        name = '"' + escape_sql_string(name) + '"'
    if faculty == None:
        faculty = "Null"
    else:
        faculty = '"' + escape_sql_string(faculty) + '"'
    if school == None:
        school = "Null"
    else:
        school = '"' + escape_sql_string(school) + '"'
    if course == None:
        course = "Null"
    else:
        course = '"' + escape_sql_string(course) + '"'

    sql_string = 'UPDATE user SET has_logged_in = {hasLoggedInBefore}, user_name = {name}, faculty_name = {faculty}, school_name = {school}, course_name = {course} WHERE user_id = "{userID}"'

    with conn.cursor() as cur:
        try:
            cur.execute(sql_string.format(hasLoggedInBefore = hasLoggedInBefore, name = name, faculty = faculty, school = school, course = course, userID = escape_sql_string(userID)))
        except pymysql.MySQLError as e:
            logger.error(e)

        delete_sql = 'DELETE FROM user_zones WHERE user_id = "{userID}"'
        try:
            cur.execute(delete_sql.format(userID = escape_sql_string(userID)))
        except pymysql.MySQLError as e:
            logger.error(e)

        insert_sql = 'INSERT INTO user_zones (user_id, zone_id) VALUES ("{userID}", "{zone}")'
        for zone in zones:
            try:
                cur.execute(insert_sql.format(userID = escape_sql_string(userID), zone = zone))
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