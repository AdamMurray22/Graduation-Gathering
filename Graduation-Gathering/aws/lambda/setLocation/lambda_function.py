import json
import boto3
import logging
import re
import setLocation.package.pymysql as pymysql
from setLocation.package.shapely.geometry import shape, GeometryCollection, Point
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
    location = messageBody["location"]

    userZones = getUserZonesGeoJsons(userID)

    # If location not within one of the users zones then return without adding the user location to the database
    if not userLocationInZone(location, userZones):
        return

    sql_string = 'UPDATE user SET latitude = {latitude}, longitude = {longitude}, location_set = {locationSet} WHERE user_id = "{userID}"'

    with conn.cursor() as cur:
        try:
            cur.execute(sql_string.format(latitude = location["lat"], longitude = location["long"], locationSet = time.time(), userID = escape_sql_string(userID)))
        except pymysql.MySQLError as e:
            logger.error(e)
        cur.close()
    conn.commit()

def getUserZonesGeoJsons(userID):
    get_user_zones_sql_string = 'SELECT graduation_zones.zone_name, graduation_zones_text.geojson FROM user_zones JOIN graduation_zones ON user_zones.zone_id = graduation_zones.zone_id JOIN graduation_zones_text ON graduation_zones.zone_id = graduation_zones_text.zone_id WHERE user_zones.user_id = "{userID}"'
    with conn.cursor() as cur:
        try:
            cur.execute(get_user_zones_sql_string.format(userID = escape_sql_string(userID)))
            zones = []
            for row in cur:
                zones.append({"Zone Name": row[0], "GeoJson": row[1]})
        except pymysql.MySQLError as e:
            logger.error(e)
        cur.close()
    conn.commit()
    return zones

def userLocationInZone(location, zones):
    point = Point(location['long'], location['lat'])

    for zone in zones:

        polygon = shape(zone['GeoJson']['geometry'])

        if polygon.contains(point):
            return True
    # If location is not within any of the users selected zones then return false
    return False
    
def escape_sql_string(sql_string):
    translate_table = str.maketrans({"]": r"\]", "\\": r"\\",
                                 "^": r"\^", "$": r"\$", "*": r"\*", "'": r"\'"})
    if (sql_string is None):
        return sql_string
    return sql_string.translate(translate_table)