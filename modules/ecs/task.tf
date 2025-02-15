resource "aws_ecs_task_definition" "backend_task_definition" {
  family                   = "backend-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc" # Each task gets its own IP
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_execution_role_arn

  container_definitions = jsonencode([{
    name         = "fastapi-deploy"
    image        = var.ecr_repository_url
    essential    = true
    portMappings = [{ containerPort = 80, hostPort = 80 }]
    # logConfiguration = {
    #   logDriver = "awslogs"
    #   options = {
    #     awslogs-group         = "/ecs/my-service"
    #     awslogs-region        = "us-east-1"
    #     awslogs-stream-prefix = "ecs"
    #   }
    # }
    # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/healthcheck.html
    # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definition_healthcheck
    healthCheck = {
      command     = ["CMD-SHELL", "curl -f http://127.0.0.1/ || exit 1"]
      interval    = 30
      timeout     = 5
      retries     = 3
      startPeriod = 60
    }
  }])
}
