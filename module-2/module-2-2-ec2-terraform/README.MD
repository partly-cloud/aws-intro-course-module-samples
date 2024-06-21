# Module 2, demo 2
## Launch an EC2 instance with a public IP and defined user-data - With Terraform

### Introduction
In the following demo, you will launch an EC2 instance in AWS with a Public IP address and defined user-data script for installing and launching an Apache web server with Hello World content - With Terraform!

The purpose of this demo is primarily to showcase how the manual ClickOps steps from the first EC2 demo of this module can be written and deployed with Infrastructure as Code.

### Reference material
- [AWS Documentation - Launch your instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/LaunchingAndUsingInstances.html)
- [AWS Documentation - Run commands on your Amazon EC2 instance at launch](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

### Assumptions
- It is assumed that you have the default VPC (172.31.0.0/16) present in your AWS account.

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.
- You have created an EC2 Key pair in the AWS account.
    - See [AWS documentation - Create a key pair for your Amazon EC2 instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html).
- Terraform must be installed locally. See [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

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

2. Update the Terraform variable values in `module-2/module-2-1-ec2-terraform/terraform.tfvars`
    - `aws_primary_region`: Use the preferred region of your sandbox environment. Example: `eu-north-1`.
    - `allow_ssh_from_ip`: Use your current outbound public IP address. Tip: Find this by browsing to https://www.whatsmyip.org.
    - `ec2_key_pair_name`: Use the name of your EC2 key pair (see prerequisites). If unsure, check in the AWS Console, EC2 > Key pairs.

3. Change working directory in your local terminal session to `module-2/module-2-1-ec2-terraform` of this repository.
4. Initialize Terraform with the following command
    ```bash
    terraform init
    ````
5. Execute Terraform Plan with the following command to see the planned changes
    ```bash
    terraform plan
    ````
6. Verify that the plan output has the following resources
    - `+ resource "aws_instance" "web_server"`
    - `+ resource "aws_security_group" "web_sg"`
    - `resource "aws_key_pair" "sandbox"` (imported resource)

7. Execute Terraform apply with the follwing command to apply the planned changes.
    ```bash
    terraform apply
    ````
8. Once Terraform has applied the changes, copy the public IP address from the Terraform output and open it in a browser with HTTP. `http://<PUBLICIPADDRESS>`
9. Verify that you are seeing the Apache Web server's 'Hei Verden' text on the webpage. This confirms that the user-data script was executed on instance startup.

Once you're done with the demo, clean up the resources by executing the `terraform destroy` command. Tip! If you don't want to delete your EC2 key pair at the same time (since it is now imported to Terraform state), make sure to: 
- Remove it from state first with the following command:
    ```bash
    terraform state rm aws_key_pair.sandbox
    ```
- Comment out or remove the `import` block in `module-2/module-2-1-ec2-terraform/ec2-key-pair.tf`.

> [!WARNING]
> Using the default VPC and assigning public IP addresses to EC2 instances like this should be restricted to sandbox-activities only. In a production environment, EC2 instances should never be exposed directly to the internet. Instead use private subnets with a load balancer and WAF in front.
> Additionally, Terraform should not be used to apply configuration without storing the state in a remote location. Ideally, CI/CD is also used.