# Module 1 demo
## Interact with AWS - Get Caller identity in AWS with AWS SDK (Boto3 for Python)

### Introduction
In the following demo, you will interact with AWS through the AWS SDK, specifically with Boto3 for Python to retrieve the current "caller-identity", commonly known as a "who am I" call to the AWS Secure Token Service to determine which account you are interacting with, and with whose credentials.

### Reference material
- [Official AWS documentation for Boto3](https://docs.aws.amazon.com/pythonsdk/)

### Assumptions
It is assumed that you have installed Python and Pip and have the basic knowledge of how to work with Python.

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with access key and secret.
- Optional, but recommended: In directory `module-1/module-1-aws-sdk` Create a virtual Python environment and activate it with the following command to avoid installing packages globally on your machine, but rather install them in an isolated virtual environment only.
    - `python3 -m venv .venv`
    - `source .venv/bin/activate`
        - This command may vary based on the operating system runtime or Python version. For Windows/PowerShell it may be `.venv/Scripts/Activate.ps1`
- Install the requirements from the `requirements.txt` file, with the following command.
    - `pip install -r requirements.txt`
    - All the requirements in the file, except for `loguru` are direct, or indirect dependencies for the Boto3 AWS SDK.

### Demo steps
1. Configure environment variables with AWS credentials in your local terminal session
    - For IAM Identity Center (SSO) credentials, see [AWS documentation - Getting and refreshing temporary credentials
](https://docs.aws.amazon.com/singlesignon/latest/userguide/howtogetcredentials.html).
    - For static IAM user access key and secret, export the environment variables manually with the following command, based on your Operating system:
        
        Linux/MacOS:
        ````bash
        export AWS_ACCESS_KEY_ID=%yourawsaccesskeyid%
        export AWS_SECRET_ACCESS_KEY=%yourawsaccesskeysecret%
        `````
        Windows, PowerShell:
        ````powershell
        $Env:AWS_ACCESS_KEY_ID="%yourawsaccesskeyid%"
        $Env:AWS_ACCESS_KEY_ID="%yourawsaccesskeysecret%"
        ````
> [!CAUTION]
> Note that exporting these values to environment variables make them exposed in memory on your local machine.
> Interacting with AWS locally like this should not be done in production environments, especially not with the static credentials that does not expire.

2. Execute the Python script `main.py` with the following command in the `module-1/module-1-aws-sdk` directory.
    - `python3 main.py`

3. The python script should return log output which describes the username or access key was used, which AWS account ID was interacted with and the Amazon Resource Name (ARN) of the username.
    Example:
    ````log
    2024-06-20 12:40:39.302 | INFO     | functions.aws.get_aws_sts_caller_identity:get_aws_sts_caller_identity:11 - Retrieving AWS Security Token Service (STS) caller identity
    2024-06-20 12:40:39.823 | INFO     | functions.aws.get_aws_sts_caller_identity:get_aws_sts_caller_identity:24 - AWS STS Caller identity details were successfully retrieved with the credentials configured.
    2024-06-20 12:40:39.826 | INFO     | __main__:<module>:11 - AWS username of current credential configuration: AIDAYS......EBV6K
    2024-06-20 12:40:39.827 | INFO     | __main__:<module>:12 - AWS account ID of current credential configuration: 59013421173
    2024-06-20 12:40:39.828 | INFO     | __main__:<module>:13 - Amazon Resource Name (ARN) for the username of the current credential configuration is: 'arn:aws:iam::59013421173:user/demo-cicd'
    ````