import json
import logging
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    return getGeoJsonFromS3Bucket()

def getGeoJsonFromS3Bucket():
    s3_Bucket_Name = "graduation-gathering-questionnaire-results"
    s3_File_Name = "Questionnaire Results.txt"
    
    try:
        object = s3_client.get_object(Bucket=s3_Bucket_Name, Key=s3_File_Name)
        body = object['Body']
        jsonString = body.read().decode('utf-8')
        routeGeoJsons = []
        routeGeoJsons.append(json.loads(jsonString))
        return routeGeoJsons
    except:
        logger.error("Could not find file: " + s3_Bucket_Name + "/" + s3_File_Name)
    return []