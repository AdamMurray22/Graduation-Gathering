import json
import logging
import time
import boto3
import base64
import auth.package.jwt as jwt
from botocore.exceptions import ClientError
import os

key = os.environ['key']

# Allows for AWS Logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context): # Entry point for AWS.
    response = {
        "isAuthorized": False,
        "context": {
            "stuff": None,
        }
    }
    try: 
        token = event["headers"]["authorization"] # Retrieves the auth token (String) passed with the request.
    except:
        return response
    
    decodedToken = decodeToken(token) # Turns the token String into either a Map<String, dynamic> (The token in json form) or returns invalid token.
    validToken = validateToken(decodedToken)

    if validToken:
        response["isAuthorized"] = True
        response["context"]["email"] = getEmail(decodedToken)
        response["context"]["userID"] = getUserID(decodedToken)
    return response

# Turns the token String into either a Map<String, dynamic> (The token in json form) if it was made by the server, or returns invalid token.
def decodeToken(token):
    secret = get_secret()
    try:
        decodedToken = jwt.decode(token, secret, algorithms="HS256")
    except:
        decodedToken = "Invalid Token"
    return decodedToken

# Checks if a token is valid by checking if it has expired.
def validateToken(token):
    if token == "Invalid Token":
        return False
    return getExpires(token) >= time.time()

# Returns the secret for signing and validating the tokens.
def get_secret():
    return key

# Returns the email contained in a token.
def getEmail(token):
    return token["email"]

# Returns the user id contained in a token.
def getUserID(token):
    return token["id"]

# Returns the expire time of the token.
def getExpires(token):
    return token["expires"]