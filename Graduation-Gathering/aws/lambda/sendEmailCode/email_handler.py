import boto3
import json

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