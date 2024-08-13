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
1. Sign in to the Amazon Web Services console with your credentials
2. Open the DynamoDB dashboard, and click the "Create table" button
3. Use the following configuration input
    - Table name: `Pets`
    - Partition key: `PetId`
    - Sort key: `PetType`
4. Click the `Create table` button to proceed with creating the table.

Experiment with the DynamoDB table created as you wish. For example create a new table item to understand the primary key and function and role.

Once you're done with the demo, clean up the resources by removing the DynamoDB table you created.