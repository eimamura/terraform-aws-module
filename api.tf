
# module "lambda_execution_role" {
#   source              = "./modules/iam_role"
#   role_name           = "lambda-execution-role"
#   assume_role_service = "lambda.amazonaws.com"
#   policy_json         = file("policies/lambda-execution-policy.json")
# }


# module "lambda" {
#   source               = "./modules/lambda"
#   lambda_function_name = "myLambdaFunction"
#   lambda_role_name     = "lambda-execution-role"
#   lambda_package       = "lambda.zip"
#   lambda_role_arn      = module.lambda_execution_role.iam_role_arn
# }

# module "api_gateway" {
#   source               = "./modules/api_gateway"
#   api_name             = "MyAPIGateway"
#   lambda_function_name = module.lambda.lambda_arn
#   lambda_invoke_arn    = module.lambda.lambda_invoke_arn
# }

# output "api_gateway_url" {
#   value = module.api_gateway.api_url
# }
