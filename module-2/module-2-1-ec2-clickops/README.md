# Module 2, demo 1
## Launch an EC2 instance with a public IP and defined user-data

### Introduction
In the following demo, you will launch an EC2 instance in AWS with a Public IP address and defined user-data script for installing and launching an Apache web server with Hello World content.
Once the Instance is launched, you will connect to it with SSH.

### Reference material
- [AWS Documentation - Launch your instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/LaunchingAndUsingInstances.html)
- [AWS Documentation - Run commands on your Amazon EC2 instance at launch](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

### Assumptions
- It is assumed that you have the default VPC (172.31.0.0/16) present in your AWS account.

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.
- You have created an EC2 Key pair in the AWS account.
    - See [AwS documentation - Create a key pair for your Amazon EC2 instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html).

### Demo steps
1. Sign in to the Amazon Web Services console with your credentials
2. Open the EC2 dashboard, and click the "Launch instance" button
3. Use the following configuration input
    - Application and OS Images (Amazon Machine Image): Ubuntu (use defaults)
    - Instance type: t2.micro (default)
    - Key pair (login): Select your key pair (see prerequisites)
    - Network settings: Use defaults, but create a new security group
        - Allow SSH traffic from: `My IP` (Your public IP address)
        - Allow HTTP traffic from the internet
    - Configure storage:
        - 8 GiB gp3 (default)
    - Advanced details
        - User data: Input the following script
        ```bash
        #!/bin/bash
        sudo apt-get update
        sudo apt-get install apache2 -y
        sudo systemctl start apache2
        sudo systemctl enable apache2
        sudo echo "<h1>Hei Verden" > /var/www/html/index.html
        ```
4. Click "Launch instance" to complete the creation of the EC2 instance.
5. Navigate to the EC2 `Instances` dashboard and select the newly created instance
6. In the Networking tab of the instance's details, copy the `Public IPv4 address`
7. Browse to the instance with url `http://<PUBLICIPADDRESS>` (Replace <PUBLICIPADDRESS> with the one you copied in the previous step.)
8. Verify that you are seeing the Apache Web server's 'Hei Verden' text on the webpage. This confirms that the user-data script was executed on instance startup.
9. Connect to the instance with SSH with the following command (command may vary based on your operating system or SSH client)
    ```bash
    ssh ubuntu@<PUBLICIPADDRESS>
    ```
    Replace <PUBLICIPADDRESS> with the public IP address of the instance.
    At this point, you will use your existing SSH key pair to authenticate the SSH session on your local machine (see prerequisites).

Once you're done with the demo, clean up the resources by terminating the EC2 instance and removing the Security Group that was created as part of the EC2 launch wizard. The Security group name will be something along the lines of `launch-wizard-%number%`.

> [!WARNING]
> Using the default VPC and assigning public IP addresses to EC2 instances like this should be restricted to sandbox-activities only. In a production environment, EC2 instances should never be exposed directly to the internet. Instead use private subnets with a load balancer and WAF in front.
> Additionally, SSH directly to instances should not be opened or allowed. Use of AWS Systems Manager Session Manager should be preferred. It is more secure by enforcing authorization in AWS, does not expose SSH publicly and it keeps an audit of all connections in CloudTrail.