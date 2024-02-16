import json
import logging
import re
from urllib import response
import boto3
import time
import os
import sys
import validateCode.generate_jwt as jwt
import validateCode.package.pymysql as pymysql

# rds settings
user_name = os.environ['USER_NAME']
password = os.environ['PASSWORD']
rds_proxy_host = os.environ['RDS_PROXY_HOST']
db_name = os.environ['DB_NAME']


logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('s3')

# create the database connection outside of the handler to allow connections to be
# re-used by subsequent function invocations.
try:
        conn = pymysql.connect(host=rds_proxy_host, user=user_name, passwd=password, db=db_name, connect_timeout=5)
except pymysql.MySQLError as e:
    logger.error("ERROR: Unexpected error: Could not connect to MySQL instance.")
    logger.error(e)
    sys.exit()

logger.info("SUCCESS: Connection to RDS for MySQL instance succeeded")

def lambda_handler(event, context):

    messageBodyJson = event["body"]
    messageBody = json.loads(messageBodyJson)
    email = messageBody["email"]
    code = messageBody["code"]

    response = {
        "validated": False,
        "token": None
    }
    
    if verifyCode(email, code):
        response["validated"] = True
        response["token"] = jwt.generateToken(email)
    return response

def verifyCode(email, code):
    with conn.cursor() as cur:
        cur.execute(f"select login_code, login_code_expires from user where user_email = '{email}'")
        loginCode = None
        for row in cur:
            loginCodeId = row[0]
            expires = row[1]
        cur.close()
    conn.commit()

    if loginCodeId == None:
        return False
    
    if loginCode == code:
        return float(expires) >= time.time()
    else:
        return False