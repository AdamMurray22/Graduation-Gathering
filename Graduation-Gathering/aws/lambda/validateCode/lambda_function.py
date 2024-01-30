import json
import logging
import re
from urllib import response
import boto3
import time
import validateCode.generate_jwt as jwt

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    s3_Bucket_Name = "graduation-gathering"
    s3_File_Name = "Email Verification/codes.json"

    bucketContent = getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name)

    messageBodyJson = event["body"]
    messageBody = json.loads(messageBodyJson)
    email = messageBody["email"]
    code = messageBody["code"]

    response = {
        "validated": False,
        "token": None
    }
    
    if verifyCode(bucketContent, email, code):
        response["validated"] = True
        response["token"] = jwt.generateToken(email)
    return response

def getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name):
    
    try:
        object = s3_client.get_object(Bucket=s3_Bucket_Name, Key=s3_File_Name)
        body = object['Body']
        jsonString = body.read().decode('utf-8')
        return json.loads(jsonString)
    except:
        logger.error("Could not find file: " + s3_Bucket_Name + "/" + s3_File_Name)
    return []

def verifyCode(bucketContent, email, code):
    for emailCode in bucketContent:
        bucketEmail = emailCode["email"]
        if bucketEmail == email:
            bucketCode = emailCode["code"]
            if bucketCode == code:
                expireTime = emailCode["expire"]
                return float(expireTime) >= time.time()
            else:
                return False
    return False
