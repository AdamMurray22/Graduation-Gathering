import validateCode.package.jwt as jwt
import time
import boto3
import json
import logging
import base64

client = boto3.client('kms')

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def generateToken(email):
    
    header = {
    'alg': 'RS256',
    'typ': 'JWT'
    }
    payload = {
        'email': email,
        'created': time.time(),
        'expires': time.time() + (60*60*24)
    }

    message = json.dumps(header).encode() + '.'.encode() + json.dumps(payload).encode()
    
    sign_response = client.sign(
        KeyId='e452d056-1194-44fd-9b9c-4cb775c10abb',
        Message=message,
        MessageType='RAW',
        SigningAlgorithm='RSASSA_PSS_SHA_256',
    )
    
    header = base64.urlsafe_b64encode(json.dumps(header).encode()).decode('utf-8')
    payload = base64.urlsafe_b64encode(json.dumps(payload).encode()).decode('utf-8')
    signature = base64.urlsafe_b64encode(sign_response['Signature']).decode('utf-8')

    token = header + '.' + payload + '.' + signature
    return token