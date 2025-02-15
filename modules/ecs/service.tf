resource "aws_ecs_service" "backend_service" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.backend_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
    # assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "fastapi-deploy"
    container_port   = 80
  }

  # service_registries {
  #   registry_arn = aws_service_discovery_service.my_service.arn
  # }
}

# # service discovery fpr dynamic architecture
# resource "aws_service_discovery_service" "my_service" {
#   name         = "my-service"
#   namespace_id = aws_service_discovery_namespace.my_namespace.id

#   dns_config {
#     namespace_id = aws_service_discovery_namespace.my_namespace.id
#     dns_records {
#       ttl  = 60
#       type = "A"
#     }
#   }
# }

# # namespace
# resource "aws_service_discovery_namespace" "my_namespace" {
#   name = "my-namespace"
#   type = "DNS"
# }
