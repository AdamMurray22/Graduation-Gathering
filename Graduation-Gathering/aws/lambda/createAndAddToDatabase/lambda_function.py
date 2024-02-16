import sys
import logging
import createAndAddToDatabase.package.pymysql as pymysql
import json
import os
import re

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

logger.info("SUCCESS: Connection to RDS for MySQL instance succeeded")

def lambda_handler(event, context):
    """
    This function creates a new RDS database table and writes records to it
    """
    message = event['body']
    FacultyData = message['Faculty']
    SchoolData = message['School']
    CourseData = message['Course']
    UserData = message['User']


    faculty_sql_string = 'insert into faculty (faculty_name) values("{FacultyName}")'
    school_sql_string = 'insert into school (school_name, faculty_name) values("{SchoolName}", "{FacultyName}")'
    course_sql_string = 'insert into course (course_name, school_name) values("{CourseName}", "{SchoolName}")'
    user_sql_string = 'insert into user (user_id, user_email, user_name, login_code, login_code_expires, faculty_name, school_name, course_name, latitude, longitude) values("{UserID}", "{UserEmail}", "{UserName}", "{LoginCode}", {LoginCodeExpires}, "{FacultyName}", "{SchoolName}", "{CourseName}", {latitude}, {longitude})'

    create_schema()

    item_count = 0

    with conn.cursor() as cur:
        for faculty in FacultyData:
            try:
                cur.execute(faculty_sql_string.format(FacultyName = escape_sql_string(faculty['faculty_name'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for school in SchoolData:
            try:
                cur.execute(school_sql_string.format(SchoolName = escape_sql_string(school['school_name']), FacultyName = escape_sql_string(school['faculty_name'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for course in CourseData:
            try:
                cur.execute(course_sql_string.format(CourseName = escape_sql_string(course['course_name']), SchoolName = escape_sql_string(course['school_name'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for user in UserData:
            try:
                cur.execute(user_sql_string.format(UserID = escape_sql_string(user['user_id']), UserEmail = escape_sql_string(user['user_email']), UserName = escape_sql_string(user['user_name']), LoginCode = escape_sql_string(user['login_code']), LoginCodeExpires = user['login_code_expires'], FacultyName = escape_sql_string(user['faculty_name']), SchoolName = escape_sql_string(user['school_name']), CourseName = escape_sql_string(user['course_name']), latitude = user['latitude'], longitude = user['longitude']))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        conn.commit()
    conn.commit()


    logger.info("Added %d items to RDS for MySQL database" %(item_count))
    return "Added %d items to RDS for MySQL database" %(item_count)

def create_schema():
    with conn.cursor() as cur:
        # Creates the faculty table
        cur.execute(get_faculty_table_sql())
        # Creates the school table
        cur.execute(get_school_table_sql())
        # Creates the course table
        cur.execute(get_course_table_sql())
        # Creates the user table
        cur.execute(get_user_table_sql())
        conn.commit()
    conn.commit()

# Gets the faculty table sql
def get_faculty_table_sql():
    return "create table if not exists faculty ( faculty_name varchar(255) NOT NULL, PRIMARY KEY (faculty_name))"

# Gets the school table sql
def get_school_table_sql():
    return "create table if not exists school ( school_name  varchar(255) NOT NULL, faculty_name varchar(255) NOT NULL, PRIMARY KEY (school_name), FOREIGN KEY (faculty_name) REFERENCES faculty(faculty_name) ON DELETE CASCADE ON UPDATE CASCADE)"

# Gets the course table sql
def get_course_table_sql():
    return "create table if not exists course ( course_name  varchar(255) NOT NULL, school_name varchar(255) NOT NULL, PRIMARY KEY (course_name), FOREIGN KEY (school_name) REFERENCES school(school_name) ON DELETE CASCADE ON UPDATE CASCADE)"

# Gets the user table sql
def get_user_table_sql():
    sql_string = "create table if not exists user ( {userID}, {userEmail}, {userName}, {loginCode}, {loginCodeExpires}, {userFaculty}, {userSchool}, {userCourse}, {longitude}, {latitude}, {primaryKey}, {foreignKey1}, {foreignKey2}, {foreignKey3})"
    user_ID = "user_id varchar(255) NOT NULL"
    user_Email = "user_email varchar(255) NOT NULL"
    user_Name = "user_name varchar(255)"
    login_Code = "login_code varchar(255)"
    login_Code_expires = "login_code_expires double"
    user_Faculty = "faculty_name varchar(255)"
    user_School = "school_name varchar(255)"
    user_Course = "course_name varchar(255)"
    longitude = "longitude double"
    latitude = "latitude double"
    primary_Key = "PRIMARY KEY (user_id)"
    foreign_Key1 = "FOREIGN KEY (faculty_name) REFERENCES faculty(faculty_name) ON DELETE SET NULL ON UPDATE CASCADE"
    foreign_Key2 = "FOREIGN KEY (school_name) REFERENCES school(school_name) ON DELETE SET NULL ON UPDATE CASCADE"
    foreign_Key3 = "FOREIGN KEY (course_name) REFERENCES course(course_name) ON DELETE SET NULL ON UPDATE CASCADE"
    return sql_string.format(userID = user_ID, userEmail = user_Email, userName = user_Name, loginCode = login_Code, loginCodeExpires = login_Code_expires, userFaculty = user_Faculty, userSchool = user_School, userCourse = user_Course, longitude = longitude, latitude = latitude, primaryKey = primary_Key, foreignKey1 = foreign_Key1, foreignKey2 = foreign_Key2, foreignKey3 = foreign_Key3)

def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'"})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)