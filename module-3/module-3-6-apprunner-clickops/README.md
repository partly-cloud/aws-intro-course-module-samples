# Module 3 - Demo 6
## Launch a Docker container with AWS App Runner

### Introduction
In the following demo, you will launch a Docker Container with AWS App Runnner using the Docker image which previously published to Elastic Container Registry in module 3 - demo 3.

### Reference material
- [AWS Documentation - What is AWS App Runner?](https://docs.aws.amazon.com/apprunner/latest/dg/what-is-apprunner.html)

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.

### Demo steps

1. Sign in to the Amazon Web Services console with your credentials
2. Open the AWS App Runner dashboard, and click the "Create an App Runner Service" button
3. Use the following configuration input
    - Repository type: `Container registry`
    - Provider: `Amazon ECR`
    - Container image URI: Use the image URI of your container image in ECR from module 3 - demo 3. Remember to include the tag, i.e. `:latest`!
    - Deployment settings
        - ECR access role: Create new service role
    - Service settings:    
        - Service name: `demoservice`
        - Port: `80`
4. Proceed to the next page and click the `Create & deploy` button to create the App Runner Service.
5. In the created App Runner Service page, open the `Default domain` link on on http:// (port 80)
6. Verify that you are seeing the Apache Web server's 'Hei Verden' text on the webpage. This confirms that the container service was successfully deployed and is running.


Once you're done with the demo, clean up the resources by removing the AWS App Runner Service