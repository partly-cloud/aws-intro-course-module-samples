# ECS security group for inbound HTTP on TCP 80 and outbound internet access
resource "aws_security_group" "module_2_ecs_service" {
  name        = "module-2-ecs-service"
  vpc_id      = var.vpc_id
  description = "ECS Service for Module 2"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
