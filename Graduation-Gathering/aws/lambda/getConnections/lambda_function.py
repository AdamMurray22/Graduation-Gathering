import json
import logging
import boto3
import getConnections.package.pymysql as pymysql
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
    userID = event['requestContext']['authorizer']["lambda"]["userID"]

    connections = []
    with conn.cursor() as cur:
        faculty_sql = "SELECT to_user, permission_granted FROM location_permission WHERE from_user = '{userID}' AND permission_granted != 'Denied'"
        cur.execute(faculty_sql.format(userID = userID))
        for row in cur:
            toUser = row[0]
            permission = row[1]
            connections.append({"toUser": toUser, "permission": permission})
    conn.commit()

    return connections