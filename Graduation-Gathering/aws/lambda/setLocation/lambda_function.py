import json
import boto3
import logging
import re

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    s3_Bucket_Name = "graduation-gathering"
    s3_File_Name = "User Locations/location.json"
    
    bucketContent = getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name)

    messageBodyJson = event["body"]
    messageBody = json.loads(messageBodyJson)
    email = event['requestContext']['authorizer']["lambda"]["email"]
    
    if not validEmail(email):
        return
    
    location = messageBody["location"]
    
    writeJsonToS3Bucket(s3_Bucket_Name, s3_File_Name, bucketContent, email, location)
    
    
def getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name):
    
    try:
        object = s3_client.get_object(Bucket=s3_Bucket_Name, Key=s3_File_Name)
        body = object['Body']
        jsonString = body.read().decode('utf-8')
        return json.loads(jsonString)
    except:
        logger.error("Could not find file: " + s3_Bucket_Name + "/" + s3_File_Name)
    return []

def writeJsonToS3Bucket(s3_Bucket_Name, s3_File_Name, bucketContent, email, location):
    newContent = {"email": email, "location": location}
    bucketContent = removeEmail(bucketContent, email)
    bucketContent.append(newContent)

    bucketContentAsString = json.dumps(bucketContent)
    encoded_string = bucketContentAsString.encode("utf-8")

    s3 = boto3.resource("s3")
    s3.Bucket(s3_Bucket_Name).put_object(Key=s3_File_Name, Body=encoded_string)

def removeEmail(bucket, email):
    for i in reversed(range(len(bucket))):
        emailCode = bucket[i]
        if emailCode["email"] == email:
            bucket.pop(i)
    return bucket

def validEmail(email):
    startOfRegEmail = '(?:[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")'
    studentReg = startOfRegEmail  + '@myport.ac.uk'
    staffReg = startOfRegEmail + '@port.ac.uk'
    return re.search(studentReg, email) or re.search(staffReg, email)