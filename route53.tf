# locals {
#   subdomain = "aws.${var.domain_name}"
# }

# resource "aws_route53_zone" "subdomain" {
#   name = local.subdomain
#   #   force_destroy = true
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


# # resource "aws_route53_record" "subdomain-ns" {
# #   zone_id = aws_route53_zone.subdomain.zone_id
# #   name    = local.subdomain
# #   type    = "NS"
# #   ttl     = "30"
# # #   records = aws_route53_zone.subdomain.name_servers
# # }
