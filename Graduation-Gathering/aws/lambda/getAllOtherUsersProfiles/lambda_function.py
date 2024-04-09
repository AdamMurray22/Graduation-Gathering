import logging
import getAllOtherUsersProfiles.package.pymysql as pymysql
import os
import sys

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
    userID = event['requestContext']['authorizer']["lambda"]["userID"]

    users = []
    with conn.cursor() as cur:
        faculty_sql = "SELECT user_id, user_email, user_name, faculty_name, school_name, course_name, student_staff FROM user WHERE user_id != '{userID}' AND email_verified = true"
        cur.execute(faculty_sql.format(userID = userID))
        for row in cur:
            otherUserID = row[0]
            userEmail = row[1]
            userName = row[2]
            faculty = row[3]
            school = row[4]
            course = row[5]
            accountType = row[6]
            users.append({"userID": otherUserID, "userEmail": userEmail, "userName": userName, "faculty": faculty, "school": school, "course": course, "accountType": accountType})
    conn.commit()

    return users