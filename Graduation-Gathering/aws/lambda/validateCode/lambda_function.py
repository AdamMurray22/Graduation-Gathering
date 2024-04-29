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

# Allows for AWS Logging
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

def lambda_handler(event, context): # Entry point for AWS.

    messageBodyJson = event["body"]
    messageBody = json.loads(messageBodyJson)
    email = messageBody["email"]
    code = messageBody["code"]

    response = {
        "validated": False,
        "token": None
    }
    
    if verifyCode(email, code):
        with conn.cursor() as cur:
            cur.execute(f"UPDATE user SET email_verified = true WHERE user_email = '{email}'")
            cur.close()
        conn.commit()
        response["validated"] = True
        response["token"] = jwt.generateToken(email, getUserId(email))
    return response

# Verifies whether the given code is correct and with the time constraint for the given email.
def verifyCode(email, code):
    with conn.cursor() as cur:
        cur.execute(f"select login_code, login_code_expires from user where user_email = '{escape_sql_string(email)}'")
        loginCode = None
        for row in cur:
            loginCode = row[0]
            expires = row[1]
        cur.close()
    conn.commit()
    if loginCode == None:
        return False
    
    if loginCode == code:
        return float(expires) >= time.time()
    else:
        return False

# Gets the user id for the account with the given email.
def getUserId(email):
    with conn.cursor() as cur:
        cur.execute(f"select user_id from user where user_email = '{email}'")
        for row in cur:
            userID = row[0]
        cur.close()
    conn.commit()
    return userID

# Escapes a string to be given to the database to protect the database.
def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'", '"': r'\"'})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)