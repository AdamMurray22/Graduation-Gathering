import json
import logging
import boto3
import getOthersLocations.package.pymysql as pymysql
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
    email = event['requestContext']['authorizer']["lambda"]["email"]
    userID = event['requestContext']['authorizer']["lambda"]["userID"]

    otherUsers = []
    with conn.cursor() as cur:
        cur.execute(escape_sql_string(f"select user_email, latitude, longitude from user where user_id != '{userID}'"))
        for row in cur:
            otherUserEmail = row[0]
            otherUserLatitude = row[1]
            otherUserLongitude = row[2]
            otherUser = {
                'email': otherUserEmail,
                'latitude': otherUserLatitude,
                'longitude': otherUserLongitude
            }
            otherUsers.append(otherUser)
        cur.close()
    conn.commit()

    return otherUsers

def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'"})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)