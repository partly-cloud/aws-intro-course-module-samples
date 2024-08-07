# Module 4 - Demo 1
## Create IAM user with inline IAM policy and IAM role with attached policy. Assume role as IAM user with AWS CLI.

### Introduction
In the following demo, you will create: 
- An IAM user with an access key for programmatic access
- An IAM role with an attached policy for managing EC2 resources. The IAM role's trust policy will allow the IAM user to assume the role.

You will then, using AWS CLI authenticate as the IAM user, and assume the role in order to perform EC2 actions.

### Reference material
- [AWS Identity and Access Management (IAM) - What is IAM?](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.
- Install the AWS CLI
    - See [AWS documentation - Install or update to the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

### Demo steps

#### Create an IAM user with assume-role permissions and an access key
1. Sign in to the Amazon Web Services console with your credentials
2. Open the IAM dashboard, and navigate to the `Users` page in the navigation-pane.
3. Click the `Create user` button.
4. Use the following configuration input (leave fields not mentioned to their default values)
    - User name: `demouser`
5. Skip the follwing steps by clicking `Next` and confirm the user creation by clicking `Create user`.
6. Open the created user and navigate to the `Permissions` tab.
7. Click the `Add permission` > `Create inline policy`
8. Using the visual policy editor:
    - Service: `STS`
    - Actions allowed: `AssumeRole`
    - Resources: `All`

    Alternatively to the visual editor, use the following JSON-code:
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": "sts:AssumeRole",
                "Resource": "*"
            }
        ]
    }
    ````
> [!CAUTION]
> Note that allowing the sts:AssumeRole permission to a wildcard resource value is an overly permissive statement which will allow assumption of any role in the account. 
> This is done only for purposes of this demo and should be avoided in a production environment.

9. Click `Next` Followed by giving the policy a name, for example `demopolicy-inline`.
10. Confirm the policy creation by clicking `Create policy`.
. Open the created user and navigate to `Security Credentials` > `Access keys` and click `Create access key`
    - Choose `Other` use case and click next, then confirm the access key creation by clicking `Create access key`.
11. Save the Access key and Secret access key values for later. You will not be able to retrieve the secret again once you navigate away from the page.


#### Create an IAM role with EC2 permissions
1. Open the IAM dashboard, and navigate to the `Roles` page in the navigation-pane.
2. Click the `Create role` button.
3. Use the following configuration input
    - Trusted entity type: `Custom trust policy`
4. In the custom trust policy editor, paste the following json code (replace `%ACCOUNTID%` with the ID of your AWS account):
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "Statement1",
                "Effect": "Allow",
                "Principal": {
                    "AWS": [
                        "arn:aws:iam::%ACCOUNTID%:user/demouser"
                    ]
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    ```
    The trust policy statement will allow user `demouser` to assume the role.
5. Click `Next`
6. In the `Add permissions page`, search for and select the AWS managed policy, `AmazonEC2FullAccess` and click `Next`.
7. Give the role a name: `demorole` and confirm the role creation by clicking `Create role`.

#### Assume IAM role as the IAM user
1. In local shell, export the access key and secret to local environment variables with the following commands. Replace `%ACCESSKEYID%` and `%SECRETACCESSKEY%` with previously saved values during access key creation.

    For Linux/Mac OS:
    ```bash
    export AWS_ACCESS_KEY_ID="%ACCESSKEYID%"
    export AWS_SECRET_ACCESS_KEY="%SECRETACCESSKEY%"
    ```

    For Windows/PowerShell:
    ```PowerShell
    $Env:AWS_ACCESS_KEY_ID="%ACCESSKEYID%"
    $Env:AWS_SECRET_ACCESS_KEY="%SECRETACCESSKEY%"
    ```

2. Execute the following AWS CLI command to verify your credentials.
    ```bash
    aws sts get-caller-identity
    ```

3. Execute the following AWS CLI command to attempt describing all EC2 security groups. It is expected that the attempt will fail due to no permissions for the user allows this action. Replace `%REGION%` with the region of your choice.
    ```bash
    aws ec2  describe-security-groups --region %REGION%
    ```

4. Execute the following AWS CLI command to assume role `demorole` and generate credentials for it. Replace `%ACCOUNTID%` with your AWS account ID.
    ```bash
    aws sts assume-role --role-arn arn:aws:iam::%ACCOUNTID%:role/demorole --role-session-name demorolesession
    ```
    The output of the command should include temporary credentials with `AccessKeyId`, `SecretAccessKey`. `SessionToken` for the assumed role.

5. Export the access key, secret and session token to local environment variables with the following commands. Replace `%ACCESSKEYID%`, `%SECRETACCESSKEY%` and `%SESSIONTOKEN$` with the values derived from the previous step.
    For Linux/Mac OS:
    ```bash
    export AWS_ACCESS_KEY_ID="%ACCESSKEYID%"
    export AWS_SECRET_ACCESS_KEY="%SECRETACCESSKEY%"
    export AWS_SESSION_TOKEN="%SESSIONTOKEN$"

    ```

    For Windows/PowerShell:
    ```PowerShell
    $Env:AWS_ACCESS_KEY_ID="%ACCESSKEYID%"
    $Env:AWS_SECRET_ACCESS_KEY="%SECRETACCESSKEY%"
    $Env:AWS_SESSION_TOKEN="%SESSIONTOKEN$"
    ```

    By doing this, you instruct AWS CLI to use the assumed role credentials rather than the previously used IAM user access key and secret.

6. Execute the following AWS CLI command to verify your credentials. The credentials should now be in the context of the role.
    ```bash
    aws sts get-caller-identity
    ```

7. Execute the following AWS CLI command to describe all EC2 security groups. It is now expected that the execution will succeed, due to the role having the appropriate IAM permissions in place. Replace `%REGION%` with the region of your choice.
    ```bash
    aws ec2  describe-security-groups --region %REGION%
    ```

Once you're done with the demo, clean up the AWS resources by deleting the IAM role and the IAM user.