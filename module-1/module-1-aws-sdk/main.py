# Functions
from loguru import logger
from functions.aws.get_aws_sts_caller_identity import get_aws_sts_caller_identity

# 

if __name__ == "__main__":
    # Get STS identity of current session with AWS
    username, aws_account_id, arn = get_aws_sts_caller_identity()
    
    logger.info(f"AWS username or access key of current credential configuration: {username}")
    logger.info(f"AWS account ID of current credential configuration: {aws_account_id}")
