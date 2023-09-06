# Lambda functions for mynotes application 
Terraform AWS Lambda and API Gateway Deployment
This Terraform repository contains code to create and manage AWS Lambda functions along with an API Gateway.
This infrastructure allows you to expose serverless endpoints via an API Gateway that trigger Lambda functions.

## Prerequisites
Before you begin, make sure you have the following prerequisites installed and configured:
  1. Terraform
  2. AWS CLI with appropriate IAM credentials configured (aws configure)
  3. An AWS account
## Getting Started
 1. Clone this repository to your local machine:

  ```shell
   git clone <repository-url>
   cd terraform-lambda-api-gateway
  ```

 2. Initialize the Terraform working directory:
  ```shell
  terraform init
  ```
 3. Configure your AWS credentials using aws configure if you haven't already.

## Configuration
Before applying the Terraform configuration, you'll need to customize it to your specific needs. Here are the steps to configure the deployment:

 1. Open the terraform.tfvars file and update the variables with your desired values. Here's an example of what you may need to configure:

  ```shell
region            = "us-east-1"
function_name     = "my-lambda-function"
api_gateway_name  = "my-api-gateway"
stage_name        = "dev"
handler           = "index.handler"
runtime           = "nodejs14.x"
  ```
 2. Create your Lambda function code in a directory, and update the source_code_path variable in lambdas.tf to point to your function code.



## Usage
Once you've configured the Terraform variables and customized the code as needed, you can deploy your Lambda function and API Gateway:

1. Execute the following commands to create and apply the Terraform resources:

  ```shell
terraform plan
terraform apply
  ```
Review the plan and confirm the changes when prompted.

 2. After successfully applying the Terraform configuration, you will receive output containing the API Gateway URL, Lambda ARN, and other relevant information.

## Testing
You can test your API Gateway and Lambda function using tools like curl or Postman. Use the API Gateway URL provided in the Terraform output to make requests to your endpoints.

## Cleanup
To destroy the resources created by Terraform when you no longer need them, run:

  ```shell
terraform destroy
  ```

## Contributing
Contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments
Terraform
AWS Lambda
Amazon API Gateway


Feel free to expand or modify this README to include any additional information or specific instructions relevant to your project.