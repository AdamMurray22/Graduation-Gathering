import validateCode.package.jwt as jwt
import time
import boto3
import json
import logging
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def generateToken(email, userID):
    
    header = {
    'alg': 'HS256',
    'typ': 'JWT'
    }
    payload = {
        'id': userID,
        'email': email,
        'created': time.time(),
        'expires': time.time() + (60*60*24)
    }

    message = (json.dumps(header) + '.' + json.dumps(payload)).encode('utf-8')

    secret = get_secret()

    encoded_jwt = jwt.encode(payload, secret, algorithm="HS256")

    token = encoded_jwt
    return token

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