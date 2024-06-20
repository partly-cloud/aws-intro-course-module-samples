# Default EC2 instance with Ubuntu based AMI and user data to launch apache

# Create the EC2 instance
resource "aws_instance" "web_server" {
  ami           = "ami-00ac45f3035ff009e" # ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20240423
  instance_type = "t2.micro"
  key_name      = "op-thomas-sandbox"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              sudo echo "<h1>Hei Verden" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Web Server"
  }
}

# Create a security group for the EC2 instance
resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.allow_ssh_from_ip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Key pair for the EC2 instance
resource "aws_key_pair" "op_thomas_sandbox" {
  key_name   = "op-thomas-sandbox"
  public_key = ""
}

import {
  to = aws_key_pair.op_thomas_sandbox
  id = "op-thomas-sandbox"
}
