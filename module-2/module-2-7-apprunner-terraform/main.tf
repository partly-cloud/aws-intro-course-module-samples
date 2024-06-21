# Provider configuration
provider "aws" {
  region = var.aws_primary_region
}

# Terraform backend configuration
terraform {
  #backend "s3" {
  #  bucket         = ""
  #  key            = "terraform_state"
  #  region         = ""
  #  encrypt        = true
  #  dynamodb_table = ""
  #}
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
