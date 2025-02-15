# module "dlm_lifecycle_role" {
#   source              = "./modules/iam_role"
#   role_name           = "dlm-lifecycle-role"
#   assume_role_service = "dlm.amazonaws.com"
#   policy_json         = file("policies/ecs-task-policy.json")
# }

# resource "aws_dlm_lifecycle_policy" "example" {
#   description        = "example DLM lifecycle policy"
#   execution_role_arn = module.dlm_lifecycle_role.iam_role_arn
#   state              = "ENABLED"

#   policy_details {
#     resource_types = ["VOLUME"]

#     schedule {
#       name = "2 weeks of daily snapshots"
#       create_rule {
#         interval      = 24
#         interval_unit = "HOURS"
#         times         = ["23:45"]
#       }
#       retain_rule {
#         count = 14
#       }
#       tags_to_add = { SnapshotCreator = "DLM" }
#     }

#     target_tags = { Snapshot = "true" }
#   }
#   tags = var.tags
# }
