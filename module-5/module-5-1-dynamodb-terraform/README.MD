# Module 5 - Demo 1
## Create a DynamoDB example deployment

### Introduction
In the following demo, you will create an example deployment containing an Amazon DynamoDB table.

The purpose of this demo is primarily to showcase how DyanmoDB components.

### Reference material
- [Amazon DynamoDB - Core components of Amazon DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/HowItWorks.CoreComponents.html)


### Assumptions


### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.
- Terraform must be installed locally. See [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
- Clone repository https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table to your local computer.

### Demo steps
1. In a local terminal session, change working directory to `examples/basic` in the cloned repository `terraform-aws-dynamodb-table`.
2. Configure environment variables with AWS credentials in your local terminal session
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
3. Initialize Terraform with the following command
    ```bash
    terraform init
    ````
7. Execute Terraform apply with the follwing command to apply the planned changes.
    ```bash
    terraform apply
    ````

    This will deploy the sample infrastructure containing the DynamoDB table.

8. Once Terraform has applied the changes, you can browse the DynamoDB dashboard in the AWS console to look around and interact with the database table.

Once you're done with the demo, clean up the resources by executing the `terraform destroy` command. 