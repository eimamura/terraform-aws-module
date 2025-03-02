
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
