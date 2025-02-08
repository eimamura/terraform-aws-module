resource "aws_ecs_task_definition" "backend_task_definition" {
  family = "backend-task"
  container_definitions = jsonencode([
    {
      name      = "fastapi-deploy"
      image     = aws_ecr_repository.my_repository.repository_url
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/healthcheck.html
      # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definition_healthcheck
      # "healthCheck" : {
      #   "command" : ["CMD-SHELL", "curl -f http://127.0.0.1/ || exit 1"],
      #   "interval" : 30, # seconds
      #   "timeout" : 5,   # seconds
      #   "retries" : 3,
      #   "startPeriod" : 60 # seconds
      # }
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_execution_role_arn
}
