import json
import urllib3
import boto3

def lambda_handler(event, context):
    STREAM_NAME = "extracao"
    beer,status = buscar_dados()
    generate(STREAM_NAME, boto3.client('kinesis'), beer)
    return {
        'statusCode': status,
        'body': beer
    }

def buscar_dados():
    http = urllib3.PoolManager()
    request = http.request('GET', 'https://api.punkapi.com/v2/beers/random')
    data = json.loads(request.data)
    return data, request.status

def generate(stream_name, kinesis_client, data):
    data = data
    print(data)
    kinesis_client.put_record(
        StreamName=stream_name,
        Data=json.dumps(data),
        PartitionKey="partitionkey")
