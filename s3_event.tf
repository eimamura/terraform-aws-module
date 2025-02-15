resource "aws_s3_bucket" "example" {
  bucket        = "kfjfkjflkgflk"
  force_destroy = true
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.example.id
  key          = "index.html"
  source       = "./index.html" # Ensure this file exists in your working directory
  content_type = "text/html"
}

resource "aws_sns_topic" "example" {
  name = "example-topic"
}

resource "aws_sns_topic_subscription" "my_subscription" {
  topic_arn = aws_sns_topic.example.arn
  protocol  = "email" # Modify to your preferred protocol (e.g., lambda, sqs)
  endpoint  = var.email_address
}

# Optional: Create SQS queue if you want to use SQS
# resource "aws_sqs_queue" "example" {
#   name = "example-queue"
# }

# Create a Lambda function (assuming you already have a Lambda function)
# resource "aws_lambda_function" "example" {
#   function_name = "example-function"
#   s3_bucket     = "lambda-code-bucket"
#   s3_key        = "lambda-function.zip"
#   handler       = "index.handler"
#   runtime       = "nodejs14.x"
#   role          = aws_iam_role.lambda_exec_role.arn
# }

# Create S3 event notification
resource "aws_s3_bucket_notification" "example" {
  bucket = aws_s3_bucket.example.id
  #   eventbridge = true

  # Configure notification for object creation (you can modify the event types)
  #   lambda_function {
  #     events              = ["s3:ObjectCreated:*"]
  #     filter_prefix       = "images/"
  #     filter_suffix       = ".jpg"
  #     lambda_function_arn = aws_lambda_function.example.arn
  #   }

  topic {
    events    = ["s3:ObjectCreated:*"]
    topic_arn = aws_sns_topic.example.arn
    # filter_suffix = ".log"
  }

  #   queue {
  #     events    = ["s3:ObjectCreated:*"]
  #     queue_arn = aws_sqs_queue.example.arn
  #     # filter_suffix = ".log"
  #   }

  depends_on = [aws_sns_topic_policy.allow_s3]
}

resource "aws_sns_topic_policy" "allow_s3" {
  arn = aws_sns_topic.example.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "SNS:Publish"
        Resource  = aws_sns_topic.example.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = "arn:aws:s3:::${aws_s3_bucket.example.bucket}"
          }
        }
      }
    ]
  })
}




# IAM Role for Lambda execution
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

# IAM Policy to allow Lambda to read from S3 and publish to SNS
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
#           "${aws_s3_bucket.example.arn}"
#         ]
#       },
#       {
#         Action   = "sns:Publish"
#         Effect   = "Allow"
#         Resource = aws_sns_topic.example.arn
#       }
#     ]
#   })
# }

# Attach policy to the Lambda execution role
# resource "aws_iam_role_policy_attachment" "lambda_s3_policy_attachment" {
#   policy_arn = aws_iam_policy.lambda_s3_policy.arn
#   role       = aws_iam_role.lambda_exec_role.name
# }
