import json
import logging
import time
import boto3
import base64
import auth.package.jwt as jwt
from botocore.exceptions import ClientError


logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    token = event["headers"]["authorization"]
    
    decodedToken = decodeToken(token)
    validToken = validateToken(decodedToken)
    response = {
        "isAuthorized": False,
        "context": {
            "stuff": None,
        }
    }
    if validToken:
        response["isAuthorized"] = True
        response["context"]["email"] = getEmail(decodedToken)
    return response
    
def getEmail(token):
    return token["email"]

def decodeToken(token):
    secret = get_secret()
    try:
        decodedToken = jwt.decode(token, secret, algorithms="HS256")
    except:
        decodedToken = "Invalid Token"
    return decodedToken
        
def validateToken(token):
    return token != "Invalid Token"

def get_secret():

    secret_name = "Graduation-Gathering-API-key"
    region_name = "eu-west-2"

    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
    except ClientError as e:
        raise e

    secret = get_secret_value_response['SecretString']

    return json.loads(secret)["key"]