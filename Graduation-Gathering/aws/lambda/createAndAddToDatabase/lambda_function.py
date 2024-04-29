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

logger.info("SUCCESS: Connection to RDS for MySQL instance succeeded")

def lambda_handler(event, context):
    #deleteDatabase() # Used to reload the database during testing
    #createDatabase()

    """
    This function creates a new RDS database and writes records to it
    """

    # Gets the database to put inserted into the database.
    message = event['body']
    FacultyData = message['Faculty']
    SchoolData = message['School']
    CourseData = message['Course']
    UserData = message['User']
    LocationPermissions = message['LocationPermissions']
    GraduationZones = message['GraduationZones']
    UserZones = message['UserZones']

    # Creates the sql string templates.
    faculty_sql_string = 'insert into faculty (faculty_name) values("{FacultyName}")'
    school_sql_string = 'insert into school (school_name, faculty_name) values("{SchoolName}", "{FacultyName}")'
    course_sql_string = 'insert into course (course_name, school_name) values("{CourseName}", "{SchoolName}")'
    user_sql_string = 'insert into user (user_id, user_email, user_name, login_code, login_code_expires, faculty_name, school_name, course_name, latitude, longitude, location_set, has_logged_in, email_verified, student_staff) values("{UserID}", "{UserEmail}", "{UserName}", "{LoginCode}", {LoginCodeExpires}, "{FacultyName}", "{SchoolName}", "{CourseName}", {Latitude}, {Longitude}, {LocationSet}, {HasLoggedIn}, {EmailVerified}, "{StudentStaff}")'
    location_permission_sql_string = 'insert into location_permission (from_user,to_user,permission_granted) values("{FromUser}", "{ToUser}", "{PermissionGranted}")'
    graduation_zones_sql_string = 'insert into graduation_zones (zone_id,zone_name) values("{ZoneID}", "{ZoneName}")'
    graduation_zones_text_sql_string = 'insert into graduation_zones_text (zone_id,geojson) values("{ZoneID}", "{GeoJson}")'
    user_zones_sql_string = 'insert into user_zones (user_id,zone_id) values("{UserID}","{ZoneID}")'

    create_schema() # Creates the schema if it doesnt already exist.

    item_count = 0

    with conn.cursor() as cur:
        for faculty in FacultyData: # Adds the faculty data to the database.
            try:
                cur.execute(faculty_sql_string.format(FacultyName = escape_sql_string(faculty['faculty_name'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for school in SchoolData: # Adds the school data to the database.
            try:
                cur.execute(school_sql_string.format(SchoolName = escape_sql_string(school['school_name']), FacultyName = escape_sql_string(school['faculty_name'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for course in CourseData: # Adds the course data to the database.
            try:
                cur.execute(course_sql_string.format(CourseName = escape_sql_string(course['course_name']), SchoolName = escape_sql_string(course['school_name'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for user in UserData: # Adds the user data to the database.
            try:
                cur.execute(user_sql_string.format(UserID = escape_sql_string(user['user_id']), UserEmail = escape_sql_string(user['user_email']), UserName = escape_sql_string(user['user_name']), LoginCode = escape_sql_string(user['login_code']), LoginCodeExpires = user['login_code_expires'], FacultyName = escape_sql_string(user['faculty_name']), SchoolName = escape_sql_string(user['school_name']), CourseName = escape_sql_string(user['course_name']), Latitude = user['latitude'], Longitude = user['longitude'], LocationSet = user['location_set'], HasLoggedIn = user['has_logged_in'], EmailVerified = user['email_verified'], StudentStaff = escape_sql_string(user['student_staff'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for locationPermission in LocationPermissions: # Adds the location permission data to the database.
            try:
                cur.execute(location_permission_sql_string.format(FromUser = escape_sql_string(locationPermission['from_user']), ToUser = escape_sql_string(locationPermission['to_user']), PermissionGranted = escape_sql_string(locationPermission['permission_granted'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for zone in GraduationZones: # Adds the grad zones data to the database.
            try:
                cur.execute(graduation_zones_sql_string.format(ZoneID = escape_sql_string(zone['zone_id']), ZoneName = escape_sql_string(zone['zone_name'])))
            except pymysql.MySQLError as e:
                logger.error(e)
            try:
                cur.execute(graduation_zones_text_sql_string.format(ZoneID = escape_sql_string(zone['zone_id']), GeoJson = escape_sql_string(zone['geojson'])))
                item_count += 1
            except pymysql.MySQLError as e:
                logger.error(e)
            conn.commit()

        for userZone in UserZones: # Adds the user zones data to the database.
            try:
                cur.execute(user_zones_sql_string.format(UserID = escape_sql_string(userZone['user_id']), ZoneID = escape_sql_string(userZone['zone_id'])))
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
        # Creates the location_permission table
        cur.execute(get_location_permission_table_sql())
        # Creates the graduation_zones table
        cur.execute(get_graduation_zones_table_sql())
        # Creates the graduation_zones_text table
        cur.execute(get_graduation_zones_text_table_sql())
        # Creates the user_zones table
        cur.execute(get_user_zones_table_sql())
        conn.commit()
    conn.commit()

# Gets the faculty table sql
def get_faculty_table_sql():
    return "create table if NOT EXISTS faculty ( faculty_name varchar(255) NOT NULL, PRIMARY KEY (faculty_name))"

# Gets the school table sql
def get_school_table_sql():
    return "create table if NOT EXISTS school ( school_name  varchar(255) NOT NULL, faculty_name varchar(255) NOT NULL, PRIMARY KEY (school_name), FOREIGN KEY (faculty_name) REFERENCES faculty(faculty_name) ON DELETE CASCADE ON UPDATE CASCADE)"

# Gets the course table sql
def get_course_table_sql():
    return "create table if NOT EXISTS course ( course_name  varchar(255) NOT NULL, school_name varchar(255) NOT NULL, PRIMARY KEY (course_name), FOREIGN KEY (school_name) REFERENCES school(school_name) ON DELETE CASCADE ON UPDATE CASCADE)"

# Gets the user table sql
def get_user_table_sql():
    sql_string = "create table if NOT EXISTS user ( {userID}, {userEmail}, {userName}, {loginCode}, {loginCodeExpires}, {userFaculty}, {userSchool}, {userCourse}, {longitude}, {latitude}, {locationSet}, {hasLoggedIn}, {emailVerified}, {studentStaff}, {uniqueUserEmail}, {primaryKey}, {foreignKey1}, {foreignKey2}, {foreignKey3})"
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
    location_Set = "location_set double"
    has_Logged_In = "has_logged_in bool NOT NULL DEFAULT false"
    email_verified = "email_verified bool NOT NULL DEFAULT false"
    student_staff = "student_staff ENUM('Student', 'Staff') NOT NULL"
    unique_User_Email = "UNIQUE (user_email)"
    primary_Key = "PRIMARY KEY (user_id)"
    foreign_Key1 = "FOREIGN KEY (faculty_name) REFERENCES faculty(faculty_name) ON DELETE SET NULL ON UPDATE CASCADE"
    foreign_Key2 = "FOREIGN KEY (school_name) REFERENCES school(school_name) ON DELETE SET NULL ON UPDATE CASCADE"
    foreign_Key3 = "FOREIGN KEY (course_name) REFERENCES course(course_name) ON DELETE SET NULL ON UPDATE CASCADE"
    return sql_string.format(userID = user_ID, userEmail = user_Email, userName = user_Name, loginCode = login_Code, loginCodeExpires = login_Code_expires, userFaculty = user_Faculty, userSchool = user_School, userCourse = user_Course, longitude = longitude, latitude = latitude, locationSet = location_Set, hasLoggedIn = has_Logged_In, emailVerified = email_verified, studentStaff = student_staff, uniqueUserEmail = unique_User_Email, primaryKey = primary_Key, foreignKey1 = foreign_Key1, foreignKey2 = foreign_Key2, foreignKey3 = foreign_Key3)

# Gets the location_permission table sql
def get_location_permission_table_sql():
    return "CREATE table if NOT EXISTS location_permission ( from_user varchar(255) NOT NULL, to_user varchar(255) NOT NULL, permission_granted ENUM('Granted', 'Requested', 'Denied') NOT NULL, FOREIGN KEY (from_user) REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (to_user) REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE, PRIMARY KEY (from_user,to_user))"

# Gets the graduation_zones table sql
def get_graduation_zones_table_sql():
    return "create table if NOT EXISTS graduation_zones ( zone_id varchar(255) NOT NULL, zone_name varchar(255) NOT NULL, UNIQUE (zone_name), PRIMARY KEY (zone_id))"

# Gets the graduation_zones_text table sql
def get_graduation_zones_text_table_sql():
    return "create table if NOT EXISTS graduation_zones_text ( zone_id varchar(255) NOT NULL, geojson text NOT NULL, FOREIGN KEY (zone_id) REFERENCES graduation_zones(zone_id) ON DELETE CASCADE ON UPDATE CASCADE, PRIMARY KEY (zone_id))"

# Gets the user_zones table sql
def get_user_zones_table_sql():
    return "create table if NOT EXISTS user_zones ( user_id varchar(255) NOT NULL, zone_id varchar(255) NOT NULL, FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY (zone_id) REFERENCES graduation_zones(zone_id) ON DELETE CASCADE ON UPDATE CASCADE, PRIMARY KEY (user_id,zone_id))"

# Escaspes a string that is to be put into the database to protect the database.
def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'", '"': r'\"'})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)

# Deletes the database schema
def deleteDatabase():
    with conn.cursor() as cur:
        try:
            cur.execute("DROP DATABASE 	GraduationGathering")
        except pymysql.MySQLError as e:
            logger.error(e)
        conn.commit()

# Creates the database
def createDatabase():
    with conn.cursor() as cur:
        try:
            cur.execute("CREATE DATABASE 	GraduationGathering")
        except pymysql.MySQLError as e:
            logger.error(e)
        conn.commit()