# resource "aws_api_gateway_rest_api" "api" {
#   name        = var.api_name
#   description = "API Gateway for Lambda"
#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# resource "aws_api_gateway_resource" "proxy" {
#   rest_api_id = aws_api_gateway_rest_api.api.id
#   parent_id   = aws_api_gateway_rest_api.api.root_resource_id
#   path_part   = "products"
# }

# resource "aws_api_gateway_method" "proxy" {
#   rest_api_id   = aws_api_gateway_rest_api.api.id
#   resource_id   = aws_api_gateway_resource.proxy.id
#   http_method   = "GET"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "lambda" {
#   rest_api_id = aws_api_gateway_rest_api.api.id
#   resource_id = aws_api_gateway_resource.proxy.id
#   http_method = aws_api_gateway_method.proxy.http_method
#   # integration_http_method = "POST" # For AWS integrations (except AWS_PROXY), it's always required.
#   type = "AWS_PROXY"
#   uri  = var.lambda_invoke_arn
# }

# resource "aws_api_gateway_deployment" "deployment" {
#   depends_on  = [aws_api_gateway_integration.lambda]
#   rest_api_id = aws_api_gateway_rest_api.api.id
#   triggers = {
#     redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api))
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_api_gateway_stage" "example" {
#   deployment_id = aws_api_gateway_deployment.deployment.id
#   rest_api_id   = aws_api_gateway_rest_api.api.id
#   stage_name    = "v1"
#   # https://{api-id}.execute-api.{region}.amazonaws.com/{stage_name}
# }

# resource "aws_lambda_permission" "apigw" {
#   action        = "lambda:InvokeFunction"
#   function_name = var.lambda_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
# }

# resource "aws_api_gateway_rest_api_policy" "restrict_to_iam_role" {
#   rest_api_id = aws_api_gateway_rest_api.api.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow"
#       Principal = { "AWS" = "arn:aws:iam::123456789012:role/MyApiRole" }
#       Action    = "execute-api:Invoke"
#       Resource  = "${aws_api_gateway_rest_api.api.execution_arn}/*"
#     }]
#   })
# }
