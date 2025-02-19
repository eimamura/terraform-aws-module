# data "aws_caller_identity" "current" {}

# resource "aws_kms_key" "example" {
#   description             = "An example symmetric encryption KMS key"
#   enable_key_rotation     = true
#   deletion_window_in_days = 7
#   tags                    = var.tags
# }

# resource "aws_kms_key_policy" "example" {
#   key_id = aws_kms_key.example.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Id      = "key-default-1"
#     Statement = [
#       {
#         Sid    = "Enable IAM User Permissions"
#         Effect = "Allow"
#         Principal = {
#           AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#         },
#         Action   = "kms:*"
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_kms_alias" "my_kms_alias" {
#   name          = "alias/my-key"
#   target_key_id = aws_kms_key.example.key_id
# }

# resource "aws_s3_bucket" "my_bucket" {
#   bucket        = "my-secure-bucket-${random_id.suffix.hex}"
#   force_destroy = true
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
#   bucket = aws_s3_bucket.my_bucket.bucket

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm     = "aws:kms"
#       kms_master_key_id = aws_kms_key.example.arn
#     }
#   }
# }
