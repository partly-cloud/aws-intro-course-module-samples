import boto3
from loguru import logger


def get_aws_sts_caller_identity():
    # Create an STS client
    sts = boto3.client("sts")

    try:
        # Call the get_caller_identity method
        logger.info("Retrieving AWS Security Token Service (STS) caller identity")
        response = sts.get_caller_identity()

        # Extract the caller identity details
        user_id, account_id, arn = response['UserId'], response['Account'], response['Arn']

        # Extract the username from the user ID
        user_id_parts = user_id.split(':')
        if len(user_id_parts) > 1:
            username = user_id_parts[1]
        else:
            username = user_id

        logger.info(
            "AWS STS Caller identity details were successfully retrieved with the credentials configured."
        )

        # Return all details including the extracted username
        return username, account_id, arn
    except Exception as e:
        logger.error(f"Error retrieving STS caller identity: {e}.")
        return None, None, None
        exit(1)

