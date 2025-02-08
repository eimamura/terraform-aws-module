resource "aws_iam_role" "this" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = var.assume_role_service }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "this" {
  name   = "${var.role_name}-policy"
  policy = var.policy_json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
