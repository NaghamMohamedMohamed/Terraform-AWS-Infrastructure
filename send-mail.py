import boto3
import os

def lambda_handler(event, context):
    ses = boto3.client('ses')
    response = ses.send_email(
        Source=os.environ['SOURCE_EMAIL'],
        Destination={
            'ToAddresses': [os.environ['DESTINATION_EMAIL']],
        },
        Message={
            'Subject': {'Data': 'Terraform State File Changed!'},
            'Body': {'Text': {'Data': 'Hey Shaimaa, your Terraform state file was updated.'}},
        }
    )
    return response