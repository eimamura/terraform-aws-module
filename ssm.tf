# # SSM Integrated console - AWS Organization setup - prod account (delegated administrator account)
# # Setting up the Systems Manager unified console in the delegated administrator account performs the following actions across your organization. Learn more 
# # Configures Default Host Management Configuration and attaches instance profiles to ensure nodes have the required permissions to be managed by Systems Manager.
# # Enables automatic SSM Agent updates and inventory collection.
# # Configures the necessary dependent services for the unified console.
# # Replicates node data from all accounts to your delegated administrator home Region.

# resource "aws_ssm_parameter" "foo" {
#   name  = "foo"
#   type  = "String"
#   value = "bar"
# }
# resource "aws_ssm_parameter" "baz" {
#   name  = "baz"
#   type  = "String"
#   value = "qux"
# }

# resource "aws_ssm_document" "run_shell_script" {
#   name          = "MyRunShellScriptByTerraform"
#   document_type = "Command"

#   content = jsonencode({
#     schemaVersion = "2.2"
#     description   = "Run a shell script"
#     mainSteps = [
#       {
#         action = "aws:runShellScript"
#         name   = "runShellScript"
#         inputs = {
#           runCommand = [
#             "echo Hello, World! > /tmp/hello.txt"
#           ]
#         }
#       }
#     ]
#   })
# }

# resource "aws_ssm_association" "run_shell_script" {
#   name = aws_ssm_document.run_shell_script.name
#   targets {
#     key    = "InstanceIds"
#     values = [module.public_ec2.instance_id]
#   }
# }

# resource "aws_ssm_maintenance_window" "production" {
#   name     = "maintenance-window-application"
#   schedule = "cron(0 16 ? * TUE *)"
#   duration = 3
#   cutoff   = 1
# }

# resource "aws_ssm_maintenance_window_target" "target1" {
#   window_id     = aws_ssm_maintenance_window.window.id
#   name          = "maintenance-window-target"
#   description   = "This is a maintenance window target"
#   resource_type = "INSTANCE"

#   targets {
#     key    = "tag:Name"
#     values = ["acceptance_test"]
#   }
# }

# resource "aws_ssm_maintenance_window_task" "example" {
#   max_concurrency = 2
#   max_errors      = 1
#   priority        = 1
#   task_arn        = "AWS-RestartEC2Instance"
#   task_type       = "AUTOMATION"
#   window_id       = aws_ssm_maintenance_window.example.id

#   targets {
#     key    = "InstanceIds"
#     values = [aws_instance.example.id]
#   }

#   task_invocation_parameters {
#     automation_parameters {
#       document_version = "$LATEST"

#       parameter {
#         name   = "InstanceId"
#         values = [aws_instance.example.id]
#       }
#     }
#   }
# }
