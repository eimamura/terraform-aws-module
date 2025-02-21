# locals {
#   s3_origin_id = "myS3Origin"
# }

# resource "aws_cloudfront_distribution" "my_distribution" {
#   origin {
#     domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
#     origin_id   = local.s3_origin_id

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.s3_identity.cloudfront_access_identity_path
#     }
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   default_root_object = "index.html"
#   tags                = var.tags

#   default_cache_behavior {
#     # cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6" # Managed CachingOptimized policy
#     # origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf" # Managed AllViewerExceptHostHeader policy
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = local.s3_origin_id

#     forwarded_values {
#       query_string = false
#       #   headers      = ["Authorization", "Host"]
#       cookies {
#         forward = "none"
#       }
#     }

#     compress               = true
#     viewer_protocol_policy = "redirect-to-https"
#     # viewer_protocol_policy = "https-only"
#     # viewer_protocol_policy = "allow-all"
#     # min_ttl                = 0
#     # default_ttl            = 3600
#     # max_ttl                = 86400
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#       #   restriction_type = "whitelist"
#       #   locations        = ["US", "CA", "GB", "DE"]
#     }
#   }

#   #   viewer_certificate {
#   #     cloudfront_default_certificate = true
#   #   }
#   viewer_certificate {
#     acm_certificate_arn      = aws_acm_certificate.example.arn
#     ssl_support_method       = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2021"
#   }


#   #   logging_config {
#   #     include_cookies = false
#   #     bucket          = "mylogs.s3.amazonaws.com"
#   #     prefix          = "myprefix"
#   #   }

#   aliases = [local.subdomain]
# }

# output "cloudfront_url" {
#   value = aws_cloudfront_distribution.my_distribution.domain_name
# }
