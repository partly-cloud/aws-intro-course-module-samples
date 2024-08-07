# Module 4 - Demo 1
## Distribute EC2 instance HTTP server with CloudFront (Terraform + ClickOps)

### Introduction
In the following demo, you will distribute an EC2 instance's web content globally with Amazon CloudFront. The demo requires the EC2 environment from module 3 - demo 2 to be deployed first.

### Reference material
- [AWS Documentation - What is Amazon CloudFront?](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.
- You have deployed module 3 - demo 2 of this repository.
    - See [Module 3 - Demo 2 - Launch an EC2 instance with a public IP and defined user-data - With Terraform](./module-3/module-3-2-ec2-terraform/README.MD).

### Demo steps

#### Create a CloudFront distribution, using the EC2 instance address as origin
1. Sign in to the Amazon Web Services console with your credentials
2. Open the CloudFront dashboard, and click the "Create Distribution" button
3. Use the following configuration input (leave fields not mentioned to their default values)
    - Origin domain: Use the Publiv IPv4 DNS address of the EC2 instance found under it's Networking tab. Example: `ec2-13-38-82-253.eu-west-3.compute.amazonaws.com`
    - Protocol: HTTP only
    - Web Application Firewall: Do not enable security protecions
4. Click the "Create Distribution" button.
5. Once the distribution is deployed successfully (may take a few minutes), open the distribution address/domain name and confirm that the "Hei Verden" page is displayed. Example address: `https://d1ljv5b0kgn82i.cloudfront.net`.
    - If the page is displayed, you will know that you are accessing the web content through a CloudFront Edge location. Subsequent requests to the same page will likely display the Edge location's cached version of the origin content.

Once you're done with the demo, clean up the EC2 resources as described in Module 3 - Demo 2 and manually disable and delete the CloudFront Distribution.

> [!WARNING]
> Directly distributing an EC2 instance by it's public IPv4 DNS address is not a good practice and is only used in this demo for simplicity purposes. When distributing an EC2 instance, use a load balancer DNS address or Route 53 CNAME (or both combined) as origin instead, as it is less likely to change in the future due to deployment changes.