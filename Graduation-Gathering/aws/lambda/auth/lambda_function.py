import json
import logging
import time
import boto3
import base64
import auth.package.jwt as jwt
from botocore.exceptions import ClientError
import os

key = os.environ['key']


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
        response["context"]["userID"] = getUserID(decodedToken)
    return response

def decodeToken(token):
    secret = get_secret()
    try:
        decodedToken = jwt.decode(token, secret, algorithms="HS256")
    except:
        decodedToken = "Invalid Token"
    return decodedToken
        
def validateToken(token):
    if token == "Invalid Token":
        return False
    return getExpires(token) >= time.time()

def get_secret():
    return key

def getEmail(token):
    return token["email"]

def getUserID(token):
    return token["id"]

def getExpires(token):
    return token["expires"]