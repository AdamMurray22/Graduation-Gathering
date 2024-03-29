import json
import logging
import boto3
import re
import random
import time
import os
import sys
import sendEmailCode.email_handler as email_handler
import sendEmailCode.package.pymysql as pymysql

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

    if not validEmail(email):
        return
    
    code = generateCode()

    userID = getUserID(email)

    if userID == None:
        writeCodeToRDSWIthoutUserID(email, code)
    else:
        writeCodeToRDSWIthUserID(userID, code)

    email_handler.sendEmail(email, code)

def getUserID(email):
    with conn.cursor() as cur:
        cur.execute(f"select user_id from user where user_email = '{email}'")
        userID = None
        for row in cur:
            userID = row[0]
        cur.close()
    conn.commit()
    return userID

def writeCodeToRDSWIthoutUserID(email, code):
    userID = createUserID()
    expires = getCodeExpireTime()
    studentStaff = getStudentStaff(email)
    with conn.cursor() as cur:
        try:
            sql_string = 'insert into user (user_id, user_email, login_code, login_code_expires, student_staff) values("{userID}", "{userEmail}", "{loginCode}", {expires}, "{studentStaff}")'
            cur.execute(sql_string.format(userID = escape_sql_string(userID), loginCode = escape_sql_string(code), expires = expires, userEmail = escape_sql_string(email), studentStaff = escape_sql_string(studentStaff)))
        except pymysql.MySQLError as e:
            logger.error(e)
        conn.commit()

def writeCodeToRDSWIthUserID(userID, code):
    expires = getCodeExpireTime()
    with conn.cursor() as cur:
        try:
            sql_string = 'update user set login_code = "{loginCode}", login_code_expires = {expires} where user_id = "{userID}"'
            cur.execute(sql_string.format(loginCode = escape_sql_string(code), expires = expires, userID = escape_sql_string(userID)))
        except pymysql.MySQLError as e:
            logger.error(e)
        conn.commit()

def createUserID():
    with conn.cursor() as cur:
        uniqueCodeCreated = False
        while uniqueCodeCreated == False:
            userID = generateUserID()
            cur.execute(f"select user_id from user where user_id = '{userID}'")
            id = None
            for row in cur:
                id = row[0]
            if id == None:
                uniqueCodeCreated = True
        cur.close()
    conn.commit()
    return userID

def validEmail(email):
    startOfRegEmail = '(?:[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")'
    studentReg = startOfRegEmail  + '@myport.ac.uk'
    staffReg = startOfRegEmail + '@port.ac.uk'
    return re.search(studentReg, email) or re.search(staffReg, email)

def getCodeExpireTime():
    return time.time() + (5 * 60)

def generateCode():
    codeList = [str(random.randint(0,9)) for _ in range(5)]
    return "".join(codeList)

def generateUserID():
    codeList = [str(random.randint(0,9)) for _ in range(10)]
    return "US-" + "".join(codeList)

def getStudentStaff(email):
    endOfEmail = email.split('@')[1]
    if endOfEmail == "myport.ac.uk":
        return "Student"
    elif endOfEmail == "port.ac.uk":
        return "Staff"

def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'", '"': r'\"'})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)