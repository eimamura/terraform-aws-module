# resource "aws_s3_bucket" "example" {
#   bucket        = "kfjfkjflkgflk"
#   force_destroy = true
# }

# # resource "aws_s3_object" "index_html" {
# #   bucket       = aws_s3_bucket.example.id
# #   key          = "index.html"
# #   source       = "./index.html" # Ensure this file exists in your working directory
# #   content_type = "text/html"
# # }

# # resource "aws_sns_topic" "example" {
# #   name = "example-topic"
# # }

# # resource "aws_sns_topic_subscription" "email_subscription" {
# #   topic_arn = aws_sns_topic.example.arn
# #   protocol  = "email" # Modify to your preferred protocol (e.g., lambda, sqs)
# #   endpoint  = var.email_address
# # }

# # resource "aws_sns_topic_subscription" "sqs_subscription" {
# #   topic_arn = aws_sns_topic.example.arn
# #   protocol  = "sqs"
# #   endpoint  = aws_sqs_queue.example.arn
# # }

# # resource "aws_sqs_queue" "example" {
# #   name = "example-queue"
# # }

# resource "aws_lambda_function" "example" {
#   function_name = "example-function"
#   s3_bucket     = "lambda-code-bucket" # Upload ZIP manually or use Terraform to upload
#   s3_key        = "lambda.zip"
#   runtime       = "python3.8"
#   handler       = "index.lambda_handler"
#   role          = aws_iam_role.lambda_exec_role.arn
#   depends_on    = [aws_s3_object.lambda_zip, aws_s3_bucket.lambda_bucket, aws_s3_bucket_policy.lambda_bucket_policy]
# }
# resource "aws_s3_bucket" "lambda_bucket" {
#   bucket        = "lambda-jfhsjefhsjehfj"
#   force_destroy = true
# }
# resource "aws_s3_bucket_policy" "lambda_bucket_policy" {
#   bucket = aws_s3_bucket.lambda_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Effect = "Allow"
#       Principal = {
#         # Service = "lambda.amazonaws.com"
#         AWS = aws_iam_role.lambda_exec_role.arn
#       }
#       Action   = "s3:GetObject"
#       Resource = "arn:aws:s3:::${aws_s3_bucket.lambda_bucket.bucket}/*" # Correct object ARN format
#     }]
#   })
# }
# resource "aws_s3_object" "lambda_zip" {
#   bucket = aws_s3_bucket.lambda_bucket.id
#   key    = "lambda.zip"
#   source = "./lambda.zip" # Ensure this file exists in your working directory
# }


# # resource "aws_s3_bucket_notification" "example" {
# #   bucket = aws_s3_bucket.example.id
# #   #   eventbridge = true

# #   # Configure notification for object creation (you can modify the event types)
# #   lambda_function {
# #     events = ["s3:ObjectCreated:*"]
# #     # filter_prefix       = "images/"
# #     # filter_suffix       = ".jpg"
# #     lambda_function_arn = aws_lambda_function.example.arn
# #   }

# #   # topic {
# #   #   events    = ["s3:ObjectCreated:*"]
# #   #   topic_arn = aws_sns_topic.example.arn
# #   #   # filter_suffix = ".log"
# #   # }

# #   # queue {
# #   #   events    = ["s3:ObjectCreated:*"]
# #   #   queue_arn = aws_sqs_queue.example.arn
# #   #   # filter_suffix = ".log"
# #   # }

# #   # depends_on = [aws_sns_topic_policy.allow_s3]
# #   # depends_on = [aws_sqs_queue_policy.sqs_policy]
# # }


# # # Fix SQS Policy: Allow S3 to send messages
# # data "aws_iam_policy_document" "sqs_policy" {
# #   version = "2012-10-17" # !!!! IMPORTANT to timeout issue
# #   # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy#timeout-problems-creatingupdating
# #   statement {
# #     sid    = "AllowS3ToSendMessages"
# #     effect = "Allow"

# #     principals {
# #       type        = "Service"
# #       identifiers = ["s3.amazonaws.com"]
# #     }

# #     actions   = ["sqs:SendMessage"]
# #     resources = [aws_sqs_queue.example.arn]

# #     condition {
# #       test     = "ArnEquals"
# #       variable = "aws:SourceArn"
# #       values   = [aws_s3_bucket.example.arn]
# #     }
# #   }
# # }

# # resource "aws_sqs_queue_policy" "sqs_policy" {
# #   queue_url = aws_sqs_queue.example.url
# #   policy    = data.aws_iam_policy_document.sqs_policy.json
# # }

# # # Fix SNS Policy: Allow S3 to publish messages
# # resource "aws_sns_topic_policy" "sns_policy" {
# #   arn = aws_sns_topic.example.arn

# #   policy = jsonencode({
# #     Version = "2012-10-17"
# #     Statement = [
# #       {
# #         Effect = "Allow"
# #         Principal = {
# #           Service = "s3.amazonaws.com"
# #         }
# #         Action   = "SNS:Publish"
# #         Resource = aws_sns_topic.example.arn
# #         Condition = {
# #           ArnLike = {
# #             "aws:SourceArn" = aws_s3_bucket.example.arn
# #           }
# #         }
# #       }
# #     ]
# #   })
# # }



# # IAM Role for Lambda execution
# resource "aws_iam_role" "lambda_exec_role" {
#   name = "lambda-exec-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# # IAM Policy to allow Lambda to read from S3 and publish to SNS
# resource "aws_iam_policy" "lambda_s3_policy" {
#   name        = "lambda-s3-policy"
#   description = "Policy for Lambda to access S3 and SNS"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "s3:GetObject",
#           "s3:ListBucket"
#         ]
#         Effect = "Allow"
#         Resource = [
#           "${aws_s3_bucket.example.arn}/*",
#           "${aws_s3_bucket.example.arn}",
#           "arn:aws:s3:::your-lambda-code-bucket/lambda.zip"
#         ]
#       },
#       # {
#       #   Action   = "sns:Publish"
#       #   Effect   = "Allow"
#       #   Resource = aws_sns_topic.example.arn
#       # }
#     ]
#   })
# }

# # Attach policy to the Lambda execution role
# resource "aws_iam_role_policy_attachment" "lambda_s3_policy_attachment" {
#   policy_arn = aws_iam_policy.lambda_s3_policy.arn
#   role       = aws_iam_role.lambda_exec_role.name
# }
