import json
import boto3
import logging
import re
import grantFollowerRequest.package.pymysql as pymysql
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

    messageBodyJson = event["body"]
    messageBody = json.loads(messageBodyJson)
    otherUserID = messageBody["userId"]

    sql_string = 'UPDATE location_permission SET permission_granted = "Granted" WHERE from_user = "{otherUserID}" AND to_user = "{userID}"'

    with conn.cursor() as cur:
        try:
            cur.execute(sql_string.format(otherUserID = escape_sql_string(otherUserID), userID = escape_sql_string(userID)))
        except pymysql.MySQLError as e:
            logger.error(e)
        cur.close()
    conn.commit()
    
def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'", '"': r'\"'})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)