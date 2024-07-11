# Module 3 - Demo 3
## Publish Docker image to a private Elastic Container Registry (ECR) with CI/CD

### Introduction
In the following demo, you will first create a private Elastic Container Registry in AWS and then build and publish a Docker image to the registry with an automated Continuous Integration(CI)/Continuous Deployment(CD) pipeline in GitHub Actions.

### Reference material
- [AWS Documentation - Creating an Amazon ECR private repository to store images](https://docs.aws.amazon.com/AmazonECR/latest/userguide/repository-create.html)
- [GitHub - aws-actions/amazon-ecr-login](https://github.com/aws-actions/amazon-ecr-login)
- [GitHub - aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials)

### Assumptions
It is assumed that you have basic knowledge of how to use Git and GitHub, i.e. forking, cloning, commiting and pushing.

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.
- A personal GitHub user account

### Demo steps

#### Create ECR repository
1. Sign in to the Amazon Web Services console with your credentials
2. Open the Elastic Container Registry dashboard, and click the "Create repository" button
3. Use the following configuration for the repository
    - Visibility settings: `Private`
    - Repository name: `module3-demo-docker-container-image`
    - Tag immutability: `Disabled`
    - Scan on push: `Disabled`
    - KMS encryption: `Disabled`
4. Proceed with the the repository creating by clicking the `Create repository button`

#### Build and publish Docker image to ECR repository
1. Create a fork of the course GitHub repository https://github.com/partly-cloud/module-3-demo-docker-container-image
2. In your forked repository, add your AWS-credentials (access key) as GitHub Actions secrets at `Settings` > `Secrets and variables` > `Actions` > `Repository secrets`. See prerequisites.
    - `AWS_ACCESS_KEY_ID`
    - `AWS_ACCESS_KEY_SECRET`
    
    Note that if you use AWS IAM Identity Center credentials for this, the access key and secret are temporary and will expire.

3. Clone your forked repository to local machine
4. Inspect the repository content
    - `dockerfile`
        - Docker configuration for a Ubuntu-based image with Apache2 installed and configured to be launched.
    
    - `.github/workflows/publish-to-ecr.yml`
        - GitHub Actions workflow for building and publishing the Docker image to the ECR repository. In short, the workflow, triggered by push to branch `main` will use the configured AWS credentials from GitHub Actions repository secrets to authenticate with AWS and generate login details for the ECR repository. The Docker image will then be built and pushed to the ECR repository with the same name as the repository and tag `latest`.
5. Make necessary changes to `.github/workflows/publish-to-ecr.yml`
    - Line 24 - Change value of `aws-region` to the same region you created the ECR repository in.
    - Line 31 - Change value of `registries` to your AWS Account ID
6. Commit and push the changes to branch `main` in your fork of the demo repository.
7. Open your forked repository in GitHub and navigate to the `Actions` tab.
8. Open the workflow that was triggered on the push to branch `main` and inspect that all jobs completed succesfully.
9. Navigate to your ECR repository in the AWS Console and verify that an image with tag `latest` now exists in the repository.

If you are continuing with other demo modules of this course, keep the Elastic Container Registry repository for now, as the Docker image you have pushed to the repository will be used by other modules.
