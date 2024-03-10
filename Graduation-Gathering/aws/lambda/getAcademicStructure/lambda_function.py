import json
import logging
import boto3
import getAcademicStructure.package.pymysql as pymysql
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
    structure = {}
    with conn.cursor() as cur:
        faculty_sql = "SELECT faculty_name FROM faculty"
        cur.execute(faculty_sql)
        for row in cur:
            faculty = row[0]
            structure[faculty] = {}

        school_sql = "SELECT school_name, faculty_name FROM school"
        cur.execute(school_sql)
        for row in cur:
            school = row[0]
            faculty = row[1]
            structure[faculty][school] = []

        course_sql = "SELECT course_name, school_name FROM course"
        cur.execute(course_sql)
        for row in cur:
            course = row[0]
            school = row[1]
            structure[faculty][school].append(course)
        cur.close()
    conn.commit()

    return structure