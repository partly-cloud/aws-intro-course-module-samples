# Module 3 - Demo 6
## Launch a Docker container with AWS App Runner

### Introduction
In the following demo, you will launch a Docker Container with AWS App Runnner using the Docker image which previously published to Elastic Container Registry in module 3 - demo 3.

### Reference material
- [AWS Documentation - What is AWS App Runner?](https://docs.aws.amazon.com/apprunner/latest/dg/what-is-apprunner.html)

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.

### Demo steps

#### Create Elastic Container Service cluster
1. Sign in to the Amazon Web Services console with your credentials
2. Open the Elastic Container Service dashboard, and click the "Create Cluster" button
3. Use the following configuration input
    - Cluster name: `<yourclustername>` (anything)
    - Infrastructure: `AWS Fargate (serverless)`
4. Click the `Create` button to create the cluster.



Once you're done with the demo, clean up the resources by removing the ECS service, the ECS cluster, the Security Group that was created as part of the task definition creation and the task definition itself.

> [!WARNING]
> Using the default VPC and assigning public IP addresses to ECS containers like this should be restricted to sandbox-activities only. In a production environment, ECS containers should never be exposed directly to the internet. Instead use private subnets with a load balancer and WAF in front.