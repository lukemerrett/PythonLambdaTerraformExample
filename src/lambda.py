"""
Handler for the events received by the Lambda
"""

import json


def handler(event, context):
    content = json.dumps(event, indent=2)
    print(f"Received event: {content}")
