
# module "backup_role" {
#   source              = "./modules/iam_role"
#   role_name           = "backup-role"
#   assume_role_service = "backup.amazonaws.com"
#   policy_json         = file("policies/backup-policy.json")
# }
# resource "aws_iam_role_policy_attachment" "example" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
#   role       = module.backup_role.iam_role_name
# }

# resource "aws_backup_vault" "example" {
#   name          = "example_backup_vault"
#   force_destroy = true
#   tags          = var.tags
#   # kms_key_arn = aws_kms_key.example.arn
# }
# resource "aws_backup_plan" "example" {
#   name = "tf_example_backup_plan"


#   rule {
#     rule_name         = "tf_example_backup_rule"
#     target_vault_name = aws_backup_vault.example.name
#     schedule          = "cron(0 12 * * ? *)"
#     start_window      = 60  # Start window in minutes
#     completion_window = 120 # Completion window in minutes
#     recovery_point_tags = {
#       "Environment" = "Production"
#     }
#     lifecycle {
#       delete_after = 14
#     }
#     # copy_action {
#     #   destination_vault_arn = aws_backup_vault.example.arn
#     # }
#   }

#   # advanced_backup_setting {
#   #   backup_options = {
#   #     WindowsVSS = "enabled"
#   #   }
#   #   resource_type = "EC2"
#   # }
# }

# resource "aws_backup_selection" "example" {
#   iam_role_arn = module.backup_role.iam_role_arn
#   name         = "tf_example_backup_selection"
#   plan_id      = aws_backup_plan.example.id

#   selection_tag {
#     type  = "STRINGEQUALS"
#     key   = "Backup"
#     value = "true"
#   }
# }


# resource "aws_s3_bucket" "backup_test" {
#   bucket        = "my-tf-test-bucket-awedwdwkdfjk"
#   force_destroy = true
#   tags = {
#     Backup = "true"
#   }
# }
# resource "aws_s3_object" "index_html" {
#   bucket       = aws_s3_bucket.backup_test.id
#   key          = "index.html"
#   source       = "./index.html" # Ensure this file exists in your working directory
#   content_type = "text/html"
#   # tags = {
#   #   Backup = "true"
#   # }
# }
