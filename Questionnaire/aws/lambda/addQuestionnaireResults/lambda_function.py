import json
import logging
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    s3_Bucket_Name = "graduation-gathering-questionnaire-results"
    s3_File_Name = "Questionnaire Results.json"

    bucketContent = getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name)

    surveyResponse = event["body"]

    writeJsonToS3Bucket(s3_Bucket_Name, s3_File_Name, bucketContent, surveyResponse)

def getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name):
    
    try:
        object = s3_client.get_object(Bucket=s3_Bucket_Name, Key=s3_File_Name)
        body = object['Body']
        jsonString = body.read().decode('utf-8')
        return json.loads(jsonString)
    except:
        logger.error("Could not find file: " + s3_Bucket_Name + "/" + s3_File_Name)
    return []

def writeJsonToS3Bucket(s3_Bucket_Name, s3_File_Name, bucketContent, surveyResponse):
    surveyResponse = surveyResponse.replace("'", "")
    surveyResponse = json.loads(surveyResponse)

    surveyResponse = removeDoubleQuote(surveyResponse)

    bucketContent["Responses"].append(surveyResponse)
    bucketContentAsString = str(bucketContent)
    bucketContentAsString = bucketContentAsString.replace("'", '"')
    encoded_string = bucketContentAsString.encode("utf-8")

    s3 = boto3.resource("s3")
    s3.Bucket(s3_Bucket_Name).put_object(Key=s3_File_Name, Body=encoded_string)

def removeDoubleQuote(json_input):
    if isinstance(json_input, dict):
        d = {}
        for k, v in json_input.items():
            k = k.replace('"', "")
            d[k] = removeDoubleQuote(v)
        return d
    elif isinstance(json_input, list):
        l = []
        for item in json_input:
            l.append(removeDoubleQuote(item))
        return l
    elif isinstance(json_input, str):
        return json_input.replace('"', "")
    else:
        return json_input