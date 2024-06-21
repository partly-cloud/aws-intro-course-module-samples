# ECR repository
resource "aws_ecr_repository" "module_2_demo_docker_container_image" {
  name                 = "module-2-demo-docker-container-image"
  image_tag_mutability = "MUTABLE"
}

import {
  to = aws_ecr_repository.module_2_demo_docker_container_image
  id = "module-2-demo-docker-container-image"
}
