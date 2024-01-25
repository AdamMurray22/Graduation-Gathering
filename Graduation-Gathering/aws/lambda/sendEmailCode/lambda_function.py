import json
import logging
import boto3

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
    
    code = "0000"

    writeJsonToS3Bucket(s3_Bucket_Name, s3_File_Name, bucketContent, email, code)
    
    sendEmail(email, code)

def getJsonFromS3Bucket(s3_Bucket_Name, s3_File_Name):
    
    try:
        object = s3_client.get_object(Bucket=s3_Bucket_Name, Key=s3_File_Name)
        body = object['Body']
        jsonString = body.read().decode('utf-8')
        return json.loads(jsonString)
    except:
        logger.error("Could not find file: " + s3_Bucket_Name + "/" + s3_File_Name)
    return []

def writeJsonToS3Bucket(s3_Bucket_Name, s3_File_Name, bucketContent, email, code):
    newContent = {"email": email, "code": code}
    bucketContent.append(newContent)

    bucketContentAsString = json.dumps(bucketContent)
    encoded_string = bucketContentAsString.encode("utf-8")

    s3 = boto3.resource("s3")
    s3.Bucket(s3_Bucket_Name).put_object(Key=s3_File_Name, Body=encoded_string)

client = boto3.client('ses', region_name='eu-west-2')

def sendEmail(receiver_email, code):
        
    response = client.send_email(
    Destination={
        'ToAddresses': [receiver_email]
    },
    Message={
        'Body': {
            'Text': {
                'Charset': 'UTF-8',
                'Data': "Your code is " + code + ". This will expire in 5 minutes.",
            }
        },
        'Subject': {
            'Charset': 'UTF-8',
            'Data': 'Login Code',
        },
    },
    Source='graduation.gathering.login@gmail.com'
    )
        
    print(response)
    
    return {
    'statusCode': 200,
    'body': json.dumps("Email Sent Successfully. MessageId is: " + response['MessageId'])
    }