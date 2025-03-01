resource "aws_iam_role" "cross_account_role" {
  name = "cross_account_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id_prod}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# resource "aws_iam_role_policy" "cross_account_policy" {
#   role = aws_iam_role.cross_account_role.name
#   name = "cross_account_policy"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "s3:ListBucket",
#           "s3:GetObject"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }
