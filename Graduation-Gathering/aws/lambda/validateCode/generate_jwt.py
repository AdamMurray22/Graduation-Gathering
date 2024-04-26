import validateCode.package.jwt as jwt
import time
import boto3
import json
import logging
from botocore.exceptions import ClientError
import os

logger = logging.getLogger()
logger.setLevel(logging.INFO)

key = os.environ['key']

# Generates a JWT token for the user to use to authenticate their request.
def generateToken(email, userID):
    
    payload = {
        'id': userID,
        'email': email,
        'created': time.time(),
        'expires': time.time() + (60*60*24) # Valid for 24 hours - stored in seconds from unix epoch
    }

    secret = get_secret()

    encoded_jwt = jwt.encode(payload, secret, algorithm="HS256")

    token = encoded_jwt
    return token

# Gets the key to sign the token.
def get_secret():
    return key