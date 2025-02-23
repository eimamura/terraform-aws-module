# resource "aws_securityhub_account" "example" {
#   enable_default_standards = true
# }

# resource "aws_s3_bucket" "config_records" {
#   bucket        = "my-tf-config-records-awedwdwddf"
#   force_destroy = true
# }

# resource "aws_s3_bucket_policy" "config_policy" {
#   bucket = aws_s3_bucket.config_records.id
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect : "Allow",
#         Principal : {
#           Service : "config.amazonaws.com"
#         },
#         Action : "s3:GetBucketAcl",
#         Resource : "arn:aws:s3:::${aws_s3_bucket.config_records.bucket}" # withou /* at the end
#       },
#       {
#         Effect : "Allow",
#         Principal : {
#           Service : "config.amazonaws.com"
#         },
#         Action : "s3:PutObject",
#         Resource : "arn:aws:s3:::${aws_s3_bucket.config_records.bucket}/*"
#       }
#     ]
#   })
# }

# resource "aws_iam_service_linked_role" "config_role" {
#   aws_service_name = "config.amazonaws.com"
# }

# resource "aws_config_configuration_recorder" "recorder" {
#   name     = "example-recorder"
#   role_arn = aws_iam_service_linked_role.config_role.arn
#   recording_group {
#     all_supported                 = true
#     include_global_resource_types = true
#   }
# }

# resource "aws_config_delivery_channel" "foo" {
#   name           = "example-delivery-channel"
#   s3_bucket_name = aws_s3_bucket.config_records.bucket
#   depends_on     = [aws_config_configuration_recorder.recorder]
# }

# resource "aws_config_configuration_recorder_status" "recorder_status" {
#   name       = aws_config_configuration_recorder.recorder.name
#   is_enabled = true
#   depends_on = [aws_config_delivery_channel.foo]
# }

# # resource "aws_config_config_rule" "s3_public_read" {
# #   name = "s3-public-read-prohibited"

# #   source {
# #     owner             = "AWS"
# #     source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
# #   }
# # }

# # resource "aws_config_config_rule" "iam_password_policy" {
# #   name = "iam-password-policy"

# #   source {
# #     owner             = "AWS"
# #     source_identifier = "IAM_PASSWORD_POLICY"
# #   }
# # }


# # resource "aws_securityhub_standards_subscription" "aws_foundational_security_best_practices" {
# #   depends_on    = [aws_securityhub_account.example]
# #   standards_arn = "arn:aws:securityhub:${var.region}::standards/aws-foundational-security-best-practices/v/1.0.0"
# # }

# # resource "aws_securityhub_standards_subscription" "cis" {
# #   depends_on    = [aws_securityhub_account.example]
# #   standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
# # }

# # resource "aws_securityhub_standards_subscription" "pci_321" {
# #   depends_on    = [aws_securityhub_account.example]
# #   standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/pci-dss/v/3.2.1"
# # }

# # resource "aws_guardduty_detector" "example" {
# #   enable = true
# # }

# # resource "aws_sns_topic" "security_hub_findings" {
# #   name = "security-hub-findings-topic"
# # }

# # resource "aws_securityhub_action_target" "sns_target" {
# #   action_target_arn = aws_sns_topic.security_hub_findings.arn
# #   action_target_name = "SNS Findings Notification"
# # }

