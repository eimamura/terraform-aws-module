# resource "aws_sns_topic" "example" {
#   name = "example-topic"
# }

# resource "aws_sns_topic_subscription" "email_subscription" {
#   topic_arn = aws_sns_topic.example.arn
#   protocol  = "email" # Modify to your preferred protocol (e.g., lambda, sqs)
#   endpoint  = var.email_address
# }

# resource "aws_sns_topic_subscription" "sqs_subscription" {
#   topic_arn = aws_sns_topic.example.arn
#   protocol  = "sqs"
#   endpoint  = aws_sqs_queue.example.arn
# }

# resource "aws_sns_topic_policy" "sns_policy" {
#   arn = aws_sns_topic.example.arn

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "s3.amazonaws.com"
#         }
#         Action   = "SNS:Publish"
#         Resource = aws_sns_topic.example.arn
#         Condition = {
#           ArnLike = {
#             "aws:SourceArn" = aws_s3_bucket.example.arn
#           }
#         }
#       }
#     ]
#   })
# }
