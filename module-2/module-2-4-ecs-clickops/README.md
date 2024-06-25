# Module 2 - Demo 4
## Launch a Docker container service with Elastic Container Service and AWS Fargate

### Introduction
In the following demo, you will create an Elastic Container Service (ECS) cluster, an ECS task definition and an ECS service running the docker image which previously published to Elastic Container Registry in module 2 - demo 3.

### Reference material
- [AWS Documentation - What is Amazon Elastic Container Service?](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
- [AWS Documentation - AWS Fargate for Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)

### Assumptions
- It is assumed that you have the default VPC (172.31.0.0/16) present in your AWS account. If you do not have this, a VPC with public subnet (with routing to an Internet Gateway) will suffice.

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

#### Create an ECS Task defintion
1. Open the Elastic Container Service dashboard, and Task Defintions in the sidebar menu.
2. Click the `Create new task definition` button.
3. Use the following configuration input
    - Task definition family: `<yourtaskdefinitionname>` (anything)
    - Launch type: `AWS Fargate`
    - Task execution role: `Create new role`
    - Container details - Name: `module-2-demo-docker-container-image`
    - Container details - URI: `<Get the URI of the latest image of the repository that was created in module 2, demo 1.>`
    - Container port: `80`
    - Protocol: `TCP`
    - App protocol: `HTTP`
    - Leave rest default.
4. Click the `Create` button to complete the task definition creation.

#### Launch a Docker container service in the Elastic Container Service cluster
1. In the newly created ECS cluster, click the `Create` button in the `Services` tab.
2. Use the following configuration input
    - Compute options: `Capacity provider strategy`
    - Capacity provider: `FARGATE`
    - Platform version: `LATEST`
    - Application type: `Service`
    - Task definition - Family: `<yourtaskdefinition>`
    - Service name: `<yourservicename>` Example: Apache-service
    - Networking, Security group: `Create a new security group`
        - Inbound rule:
             - Protocol: `TCP`
             - Port range: `80`
             - Source: `Anywhere`

    - Leave the rest of the configuration it's default values.
        - Note: If you don' have the AWS default VPC in your account, select your VPC and public subnet(s) within it in the Networking configuration.
    - Click the `Create` button to complete the service creation.
3. Get the public IP address of the container by navigating to: `Elastic Container Service` > `<yourcluster>` > `Tasks` > `<yourtask>` > `Network bindings`
4. Browse to the address with HTTP and verify that the `Hei Verden` example message is shown on the web page. Example: `http://<containerpublicip>`.

Once you're done with the demo, clean up the resources by removing the ECS service, the ECS cluster, the Security Group that was created as part of the task definition creation and the task definition itself.

> [!WARNING]
> Using the default VPC and assigning public IP addresses to ECS containers like this should be restricted to sandbox-activities only. In a production environment, ECS containers should never be exposed directly to the internet. Instead use private subnets with a load balancer and WAF in front.