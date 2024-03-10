import json
import logging
import boto3
import getUserProfile.package.pymysql as pymysql
import os
import sys
import time

# rds settings
user_name = os.environ['USER_NAME']
password = os.environ['PASSWORD']
rds_proxy_host = os.environ['RDS_PROXY_HOST']
db_name = os.environ['DB_NAME']

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

def lambda_handler(event, context):
    email = event['requestContext']['authorizer']["lambda"]["email"]
    userID = event['requestContext']['authorizer']["lambda"]["userID"]

    with conn.cursor() as cur:
        sql = "SELECT user_email, user_id, user_name, faculty_name, school_name, course_name, student_staff, has_logged_in FROM user WHERE user_id = '{userID}'"
        cur.execute(sql.format(userID = userID))
        for row in cur:
            userEmail = row[0]
            userID = row[1]
            userName = row[2]
            userFaculty = row[3]
            userSchool = row[4]
            userCourse = row[5]
            userStudentStaff = row[6]
            userHasLoggedIn = row[7]
            user = {
                'email': userEmail,
                'id': userID,
                'name': userName,
                'faculty': userFaculty,
                'school': userSchool,
                'course': userCourse,
                'accountType': userStudentStaff,
                'hasLoggedInBefore': userHasLoggedIn
            }
        cur.close()
    conn.commit()

    return user

def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'"})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)