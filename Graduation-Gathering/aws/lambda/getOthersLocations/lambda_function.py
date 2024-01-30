import json
import logging
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    s3_Bucket_Name = "graduation-gathering"
    s3_File_Name = "User Locations/location.json"
    
    email = event['requestContext']['authorizer']["lambda"]["email"]
    
    return removeEmail(getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name), email)

def getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name):
    
    try:
        object = s3_client.get_object(Bucket=s3_Bucket_Name, Key=s3_File_Name)
        body = object['Body']
        jsonString = body.read().decode('utf-8')
        return json.loads(jsonString)
    except:
        logger.error("Could not find file: " + s3_Bucket_Name + "/" + s3_File_Name)
    return []
    
def removeEmail(bucket, email):
    for i in reversed(range(len(bucket))):
        emailCode = bucket[i]
        if emailCode["email"] == email:
            bucket.pop(i)
    return bucket