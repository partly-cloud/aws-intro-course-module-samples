variable "aws_primary_region" {
  type        = string
  description = "AWS primary region"
  default     = ""
}

variable "allow_ssh_from_ip" {
  type = string
}

variable "ec2_key_pair_name" {
  type        = string
  description = "Name of the EC2 key pair to import to Terraform"
}
