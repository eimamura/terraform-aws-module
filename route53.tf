# locals {
#   subdomain = "aws.${var.domain_name}"
# }

# resource "aws_route53_zone" "subdomain" {
#   name          = local.subdomain
#   force_destroy = true
# }
# output "name_servers" {
#   value = aws_route53_zone.subdomain.name_servers
# }
# # resource "aws_route53_record" "aws_record" {
# #   zone_id = aws_route53_zone.subdomain.zone_id
# #   name    = local.subdomain
# #   type    = "A"
# #   ttl     = 300
# #   records = [module.public_ec2.instance_public_ip]
# # }

# resource "aws_route53_record" "alb" {
#   zone_id = aws_route53_zone.subdomain.zone_id
#   name    = local.subdomain
#   type    = "A"

#   alias {
#     name                   = module.load_balancer.alb_dns_name
#     zone_id                = module.load_balancer.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_acm_certificate" "example" {
#   domain_name       = local.subdomain
#   validation_method = "DNS"
# }

# resource "aws_route53_record" "example" {
#   for_each = {
#     for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = aws_route53_zone.subdomain.zone_id
# }

# resource "aws_acm_certificate_validation" "example" {
#   certificate_arn         = aws_acm_certificate.example.arn
#   validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
# }
