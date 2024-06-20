# Module 1 demo
## Get Caller identity in AWS with AWS SDK (Boto3 for Python)

### Introduction
In the following demo, you will interact with AWS through the AWS SDK, specifically with Boto3 for Python to retrieve the current "caller-identity", commonly known as a "who am I" call to the AWS Secure Token Service to determine which account you are interacting with, and with whose credentials.

See [official AWS documentation for Boto3](https://docs.aws.amazon.com/pythonsdk/) for more information.

### Assumptions
It is assumed that you have installed Python and Pip and have the basic knowledge of how to work with Python.

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with access key and secret.
- Optional, but recommended: In directory `module-1/module-1-aws-sdk` Create a virtual Python environment and activate it with the following command to avoid installing packages globally on your machine, but rather install them in an isolated virtual environment only.
    - `python3 -m venv .venv`
    - `source .venv/bin/activate`
        - This command may vary based on the operating system runtime. For Windows/PowerShell it may be `.venv/Scripts/Activate.ps1`
- Install the requirements from the `requirements.txt` file, with the following command.
    - `pip install -r requirements.txt`

### Demo steps
- Configure environment variables with AWS credentials in your local terminal session
    - For IAM Identity Center (SSO) credentials, see [AWS Docs - Getting and refreshing temporary credentials
](https://docs.aws.amazon.com/singlesignon/latest/userguide/howtogetcredentials.html).
    - For static IAM user access key and secret, export the environment variables manually with the following command, based on your Operating system:
        - Linux/MacOS:
        ````bash
        export AWS_ACCESS_KEY_ID=%yourawsaccesskeyid%
        export AWS_SECRET_ACCESS_KEY=%yourawsaccesskeysecret%
        `````
        - Windows, PowerShell:
        ````powershell
        $Env:AWS_ACCESS_KEY_ID="%yourawsaccesskeyid%"
        $Env:AWS_ACCESS_KEY_ID="%yourawsaccesskeysecret%"
        ````
    Note that exporting these values to environment variables make them exposed in memory on your local machine. Interacting with AWS locally like this should not be done in production environments, especially not with the static credentials that does not expire.

- Execute the Python script `main.py` with the following command in the `module-1/module-1-aws-sdk` directory.
    - `python3 main.py`

- The python script should retur log output which describes the username or access key was used, and which AWS account ID was interacted with.
    - Example:
    ````log
    2024-06-20 12:40:39.302 | INFO     | functions.aws.get_aws_sts_caller_identity:get_aws_sts_caller_identity:11 - Retrieving AWS Security Token Service (STS) caller identity
    2024-06-20 12:40:39.823 | INFO     | functions.aws.get_aws_sts_caller_identity:get_aws_sts_caller_identity:24 - AWS STS Caller identity details were successfully retrieved with the credentials configured.
    2024-06-20 12:40:39.826 | INFO     | __main__:<module>:11 - AWS username of current credential configuration: AIDAYS2NU4B2WR6IEBV6K
    2024-06-20 12:40:39.827 | INFO     | __main__:<module>:12 - AWS account ID of current credential configuration: 590183981173
    ````