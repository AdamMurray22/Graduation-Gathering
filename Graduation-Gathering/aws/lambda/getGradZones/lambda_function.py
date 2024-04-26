import json
import logging
import boto3
import getGradZones.package.pymysql as pymysql
import os
import sys
import time

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

def lambda_handler(event, context): # Entry point for AWS.
    zones = []
    with conn.cursor() as cur:
        sql = "SELECT graduation_zones.zone_id, graduation_zones.zone_name, graduation_zones_text.geojson FROM graduation_zones INNER JOIN graduation_zones_text ON graduation_zones.zone_id = graduation_zones_text.zone_id"
        cur.execute(sql)
        for row in cur:
            id = row[0]
            name = row[1]
            geojsonString = row[2]
            geojson = json.loads(geojsonString)
            zones.append({"id": id,"name": name, "geojson": geojson})
    conn.commit()

    return zones