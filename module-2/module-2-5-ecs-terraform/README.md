# Module 2 - Demo 5
## Launch a Docker container service with Elastic Container Service and AWS Fargate - With Terraform

### Introduction
In the following demo, you will create an Elastic Container Service (ECS) cluster, an ECS task definition and an ECS service running the docker image which previously published to Elastic Container Registry in module 2 - demo 3.

The purpose of this demo is primarily to showcase how the manual ClickOps steps from the previous ECS demo of this module can be written and deployed with Infrastructure as Code.

### Reference material
- [AWS Documentation - What is Amazon Elastic Container Service?](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
- [AWS Documentation - AWS Fargate for Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)

### Assumptions
- It is assumed that you have a VPC with public subnet (with routing to an Internet Gateway) in your AWS account.

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.
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

2. Update the Terraform variable values in `module-2/module-2-5-ecs-terraform/terraform.tfvars`
    - `aws_primary_region`: Use the preferred region of your sandbox environment. Example: `eu-north-1`.
    - `ecr_image_uri`: Use the image URI of your container image in ECR from module 2 - demo 3. Remember to include the tag, i.e. `:latest`!
    - `vpc_id`: Use the ID of the VPC in your account that you wish to deploy the ECS cluster in.
    - `public_subnet_ids`: Use the IDs of at least two public subnets from the VPC. 

3. Change working directory in your local terminal session to `module-2/module-2-5-ecs-terraform` of this repository.
4. Initialize Terraform with the following command
    ```bash
    terraform init
    ````
5. Execute Terraform Plan with the following command to see the planned changes
    ```bash
    terraform plan
    ````
6. Verify that the plan output has the following resources
    - `+ resource "aws_ecs_cluster" "default"`
    - `+ resource "aws_ecs_service" "module_2_ecs_service""`
    - `+ resource "aws_ecs_task_definition" "module_2_ecr_container"`
    - `+ resource "aws_iam_role" "ecs_task_execution_role"`
    - `+ resource "aws_iam_role_policy" "ecs_task_execution_policy"`
    - `+ resource "aws_security_group" "module_2_ecs_service" `

7. Execute Terraform apply with the follwing command to apply the planned changes.
    ```bash
    terraform apply
    ````
8. Once Terraform has applied the changes, get the public IP address of the container by navigating to (in the AWS Console): `Elastic Container Service` > `<yourcluster>` > `Tasks` > `<yourtask>` > `Network bindings` and open the address in the browser with HTTP.
9. Verify that you are seeing the Apache Web server's 'Hei Verden' text on the webpage. This confirms that the container service was successfully deployed and is running.

Once you're done with the demo, clean up the resources by executing the `terraform destroy` command.

> [!WARNING]
> ECS Container tasks should never be exposed directly to the internet. Instead use private subnets with a load balancer and WAF in front.
> Additionally, Terraform should not be used to apply configuration without storing the state in a remote location. Ideally, CI/CD is also used.