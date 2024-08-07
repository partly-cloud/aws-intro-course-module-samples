# Module 1 - Demo 1
## Interact with AWS - Get Caller identity in AWS with AWS CLI

### Introduction
In the following demo, you will interact with AWS through the AWS CLI to retrieve the current "caller-identity", commonly known as a "who am I" call to the AWS Secure Token Service to determine which account you are interacting with, and with whose credentials.

### Reference material
- [Official AWS documentation for AWS CLI](https://docs.aws.amazon.com/cli/)

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with access key and secret.
- Install the AWS CLI
    - See [AWS documentation - Install or update to the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

### Demo steps
1. Configure environment variables with AWS credentials in your local terminal session
    - For IAM Identity Center (SSO) credentials, see [AWS documentation - Getting and refreshing temporary credentials
](https://docs.aws.amazon.com/singlesignon/latest/userguide/howtogetcredentials.html).
    - For static IAM user access key and secret, export the environment variables manually with the following command, based on your Operating system:
        
        For Linux/MacOS:
        ````bash
        export AWS_ACCESS_KEY_ID=%yourawsaccesskeyid%
        export AWS_SECRET_ACCESS_KEY=%yourawsaccesskeysecret%
        `````
        For Windows, PowerShell:
        ````powershell
        $Env:AWS_ACCESS_KEY_ID="%yourawsaccesskeyid%"
        $Env:AWS_ACCESS_KEY_ID="%yourawsaccesskeysecret%"
        ````
        
> [!CAUTION]
> Note that exporting these values to environment variables make them exposed in memory on your local machine.
> Interacting with AWS locally like this should not be done in production environments, especially not with the static credentials that does not expire.


2. Execute the following command
    ```bash
    aws sts get-caller-identity
    ```

3. The AWS CLI should return log output which describes the username or access key was used, which AWS account ID was interacted with and the Amazon Resource Name (ARN) of the username.
    
    Example:
    ```json
    {
    "UserId": "AIDAYS......EBV6K",
    "Account": "59013421173",
    "Arn": "arn:aws:iam::59013421173:user/demo-cicd"
    }
    ```
