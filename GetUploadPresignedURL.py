import json
import boto3
from datetime import datetime

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    
    try:
        response = s3.list_objects_v2(Bucket="bayanet")
        objects = []
        
        if 'Contents' in response:
            for obj in response['Contents']:
                objects.append({
                    'Key': obj['Key'],
                    'LastModified': obj['LastModified'].isoformat(),
                    'Size': obj['Size'],
                    'ETag': obj['ETag'].strip('"')
                })
        
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET,OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'
            },
            'body': json.dumps({'objects': objects})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({'error': str(e)})
        }
