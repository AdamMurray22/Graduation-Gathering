import json
import logging
import boto3
import getOthersLocations.package.pymysql as pymysql
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
        return []

    otherUsers = []
    with conn.cursor() as cur:
        sql = "SELECT user_email, latitude, longitude, user_id, user_name, faculty_name, school_name, course_name, student_staff FROM user WHERE user_id != '{userID}' AND location_set > {time} AND '{userID}' in (SELECT from_user FROM location_permission WHERE '{userID}' = from_user AND user_id = to_user AND permission_granted = 'Granted')"
        locationValidTime = time.time() - 60
        cur.execute(sql.format(userID = userID, time = locationValidTime))
        for row in cur:
            otherUserEmail = row[0]
            otherUserLatitude = row[1]
            otherUserLongitude = row[2]
            otherUserID = row[3]
            otherUserName = row[4]
            otherUserFaculty = row[5]
            otherUserSchool = row[6]
            otherUserCourse = row[7]
            otherUserStudentStaff = row[8]
            otherUser = {
                'email': otherUserEmail,
                'latitude': otherUserLatitude,
                'longitude': otherUserLongitude,
                'id': otherUserID,
                'name': otherUserName,
                'faculty': otherUserFaculty,
                'school': otherUserSchool,
                'course': otherUserCourse,
                'student/staff': otherUserStudentStaff
            }
            otherUsers.append(otherUser)
        cur.close()
    conn.commit()

    return otherUsers

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
        dates.append(datetime.strptime(dateString, '%Y/%m/%d').date())

    todayDate = datetime.today().date()
    todayTime = datetime.today().time()

    for date in dates:
        if todayDate == date:
            if todayTime >= datetime.strptime("08", "%H").time():
                return True
        else: 
            tomorrowDate = datetime.strftime(date - datetime.timedelta(1), '%Y-%m-%d')
            if todayDate == tomorrowDate:
                if todayTime < datetime.strptime("01", "%H").time():
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