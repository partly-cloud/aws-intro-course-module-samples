# Module 5 - Demo 2
## Create a Database Migration Service serverless migration between Aurora PostgreSQL and Aurora MySQL

### Introduction
In the following demo, you will create an example deployment containing an Amazon Aurora PostgreSQL and Amazon Aurora MySQL databases, in addition to a Database Migration Service serverless configuration for migrating the from the PostgreSQL database to the MySQL database.

The purpose of this demo is primarily to showcase how the Database Migration Service works and which components it is consists of.

### Reference material
- [AWS Database Migration System - What is AWS Database Migration Service?](	https://docs.aws.amazon.com/dms/latest/userguide/Welcome.html)


### Assumptions


### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.
- Terraform must be installed locally. See [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
- Clone repository https://github.com/terraform-aws-modules/terraform-aws-dms to your local computer.

### Demo steps
1. In a local terminal session, change working directory to `examples/serverless` in the cloned repository `terraform-aws-dms`.
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

    This will deploy the sample infrastructure containing the databases and the DMS resources.

8. Once Terraform has applied the changes, you can browse the RDS and DMS dashboard in AWS and inspect the resources. Note: Starting the serverless replication will result in failure due to no tables being present in the source database.

Once you're done with the demo, clean up the resources by executing the `terraform destroy` command. 