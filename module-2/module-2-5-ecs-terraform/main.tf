# Provider configuration
provider "aws" {
  region = var.aws_primary_region
}

# Terraform backend configuration
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
