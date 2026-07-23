import json
import logging

# Configure logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    """
    AWS Lambda handler function triggered by AWS Lambda Function URL
    """
    logger.info("Received event: %s", json.dumps(event))

    # Extract HTTP method and query parameters safely
    request_context = event.get('requestContext', {})
    http_info = request_context.get('http', {})
    method = http_info.get('method', 'GET')

    body_response = {
        "status": "success",
        "message": "Hello from Serverless Lambda Function!",
        "method": method,
        "Service": "AWS Lambda via Function URL"
    }

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(body_response)
    }