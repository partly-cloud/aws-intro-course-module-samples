# Key pair for the EC2 instance
resource "aws_key_pair" "sandbox" {
  key_name   = var.ec2_key_pair_name
  public_key = ""
}

import {
  to = aws_key_pair.sandbox
  id = var.ec2_key_pair_name
}