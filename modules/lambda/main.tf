resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  role          = var.lambda_role_arn
  runtime       = "python3.9"
  handler       = "index.lambda_handler"
  filename      = var.lambda_package
}
