variable "aws_primary_region" {
  type        = string
  description = "AWS primary region"
  default     = ""
}

variable "allow_ssh_from_ip" {
  type = string
}
