variable "aws_primary_region" {
  type        = string
  description = "AWS primary region"
  default     = ""
}

variable "ecr_image_uri" {
  type        = string
  description = "URI of the ECR image to use in ECS container service"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC to launch ECS Container in"
}

variable "public_subnet_ids" {
  type        = list(any)
  description = "Subnet IDs of existing public subnets in VPC"
}
