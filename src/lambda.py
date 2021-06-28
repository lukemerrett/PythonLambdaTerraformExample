"""
Handler for the events received by the Lambda
"""

import json
import boto3
import datetime


BUCKET_NAME = "bucket-writer-sample"


def get_timestamp_filename():
    """
    Returns a filename constructed of the current timestamp in the format:
    '2020-02-04_07.46.29.315237.json'
    """
    return str(datetime.datetime.now()).replace(" ", "_").replace(":", ".") + ".json"


def save_to_s3(content):
    """
    Saves the contents to S3 with a timestamped file name
    """
    key = get_timestamp_filename()
    s3 = boto3.client("s3")
    s3.put_object(Body=str(json.dumps(content, indent=2)), Bucket=BUCKET_NAME, Key=key)
    return key


def handler(event, context):
    content = json.dumps(event, indent=2)
    print(f"Received event: {content}")
    return save_to_s3(content)
