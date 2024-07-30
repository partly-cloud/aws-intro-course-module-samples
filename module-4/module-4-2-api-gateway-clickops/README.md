# Module 4 - Demo 2
## Create an example API Gateway deployment

### Introduction
In the following demo, you will create an example API Gateway deployment from AWS which in short shows you how API Gateway may function in a basic configuration.

### Reference material
- [What is Amazon API Gateway?](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

### Prerequisites
- You have credentials for an AWS sandbox account, either through IAM Identity Center (SSO) or an IAM user in the account with username and password.

### Demo steps

#### 
1. Sign in to the Amazon Web Services console with your credentials
2. Open the API Gateway dashboard, and click the "Build" button in the REST API section.
3. Select "Example API" from the selection of API deployment type to choose from
    - The Example API uses an OpenAPI definition to create the API. The example used creates a mock website based on GET requests, and it is also configured with POST request funtionality.
4. Click the "Create API" button.
5. In the newly created API page, click the "Deploy API" button.
6. Select "New stage" and give the stage any name you like.
7. Click the "Deploy" button.
8. In the newly created stage page, copy the `Invoke URL` and open it in your browser.
9. Confirm that you are able to open the `Welcome to your Pet Store API` page.
10. Experiment with the API and view it's configuration in the API Gateway dashboard as you see fit.

Once you are done with the demo, delete the `PetStore` API deployment in the API Gateway dashboard.