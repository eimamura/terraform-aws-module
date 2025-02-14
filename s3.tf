
# # Create an IAM role for EC2 to access S3
# module "ec2_access_s3_role" {
#   source              = "./modules/iam_role"
#   role_name           = "ec2-s3-access-role"
#   assume_role_service = "ec2.amazonaws.com"
#   policy_json         = file("policies/ec2-s3-policy.json")
# }

# # Create an instance profile for EC2 to access S3
# resource "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "ec2-s3-access-profile"
#   role = basename(module.ec2_access_s3_role.iam_role_arn)
# }

# # Create a S3 bucket and object
# resource "aws_s3_bucket" "example" {
#   bucket = "my-tf-test-bucket-awedwdwdfg"
# }
# resource "aws_s3_object" "index_html" {
#   bucket       = aws_s3_bucket.example.id
#   key          = "index.html"
#   source       = "./index.html" # Ensure this file exists in your working directory
#   content_type = "text/html"
# }

# # Create a VPC endpoint for S3 (Gateway type)
# resource "aws_vpc_endpoint" "s3_endpoint" {
#   vpc_id          = module.vpc.vpc_id
#   service_name    = "com.amazonaws.${var.region}.s3" # S3 service endpoint for your region
#   route_table_ids = [module.vpc.route_table_id]
#   tags            = var.tags
# }
