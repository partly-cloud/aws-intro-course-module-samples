# Module 5 - Demo 1
## Deploy a Hello World Lambda function and trigger it with an API call through a function URL

### Introduction
In the following demo, you will create a simple Hello World AWS Lambda function.

The purpose of this demo is primarily to showcase how the Database Migration Service works and which components it is consists of.

### Reference material
- [AWS Lambda - What is AWS Lambda?](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)


### Assumptions


### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.

### Demo steps
1. Sign in to the Amazon Web Services console with your credentials
2. Open the Lambda dashboard, and click the "Create function" button
3. Use the following configuration input (leave all fields not mentioned to their default values)
    - Function name: `hello-world-function`
    - Runtime: `Python 3.12`
    - Advanced settings
        - Emable function url: Checked
        - Auth type: `NONE`
4. Click the `Create function` button to create the function.
5. In the newly created function, edit the source code by overwriting with the python code found in `module-3/module-3-7-lambda/lambda-helloworld.py`.
6. Click the "Deploy" button to deploy the function with the updated code.
7. In the functions page, copy the "Function URL" value
8. With Postman or your web browser, make a GET request to the copied function URL.
8. Verify that the function returns the text `Hei Verden`.
9. Optional: Explore the Lambda function configuration options.

Once you're done with the demo, clean up the resources created by deleting the Lambda function.

> [!WARNING]
> Creating a function with a function url and no authentication method will leave your function publicly available. This is only done for simplicity of the demo and it should be carefully considered in real-world situations.