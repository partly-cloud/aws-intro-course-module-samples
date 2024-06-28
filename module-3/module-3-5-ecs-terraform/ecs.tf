# ECS Cluster with default configuration
resource "aws_ecs_cluster" "default" {
  name = "democluster"
}

# Task definition using an ECR image on fargate (not json)
resource "aws_ecs_task_definition" "module_2_ecr_container" {
  family                   = "module-3-ecr-container"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name      = "module-3-demo-docker-container"
      image     = var.ecr_image_uri
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  network_mode       = "awsvpc"
}

# ECS Service in the ecs cluster, using the ecr image
resource "aws_ecs_service" "module_2_ecs_service" {
  name            = "module-3-demo-docker-container-service"
  cluster         = aws_ecs_cluster.default.id
  launch_type     = "FARGATE"
  desired_count   = 1
  task_definition = aws_ecs_task_definition.module_2_ecr_container.arn
  network_configuration {
    subnets          = toset(var.public_subnet_ids)
    security_groups  = [aws_security_group.module_2_ecs_service.id]
    assign_public_ip = true
  }
}
