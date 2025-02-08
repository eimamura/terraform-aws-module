
# resource "aws_s3_bucket" "website_bucket" {
#   bucket        = "my-host-bucket-${random_id.suffix.hex}"
#   force_destroy = true
#   tags          = var.tags
# }

# resource "aws_s3_bucket_website_configuration" "website_config" {
#   bucket = aws_s3_bucket.website_bucket.id
#   index_document {
#     suffix = "index.html"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "public_access" {
#   bucket                  = aws_s3_bucket.website_bucket.id
#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket_policy" "public_read" {
#   bucket = aws_s3_bucket.website_bucket.id
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect    = "Allow",
#         Principal = "*",
#         Action    = "s3:GetObject",
#         Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
#       }
#     ]
#   })
# }

# resource "aws_s3_object" "index_html" {
#   bucket       = aws_s3_bucket.website_bucket.id
#   key          = "index.html"
#   source       = "./index.html" # Ensure this file exists in your working directory
#   content_type = "text/html"
# }

# output "website_url" {
#   value = aws_s3_bucket_website_configuration.website_config.website_endpoint
# }
