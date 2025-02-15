# resource "aws_route53_zone" "subdomain" {
#   name = "ec2.${var.domain_name}"
# }
# resource "aws_route53_zone" "dev" {
#   name = "dev.${var.domain_name}"
#   tags = {
#     Environment = "dev"
#   }
# }
# resource "aws_route53_record" "dev-ns" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "dev.${var.domain_name}"
#   type    = "NS"
#   ttl     = "30"
#   records = aws_route53_zone.dev.name_servers
# }
# resource "aws_route53_record" "alb" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "www.${var.domain_name}"
#   type    = "A"

#   alias {
#     name                   = module.load_balancer.alb_dns_name
#     zone_id                = module.load_balancer.zone_id
#     evaluate_target_health = true
#   }
# }
# resource "aws_route53_record" "ns_record" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = var.domain_name
#   type    = "NS"
#   ttl     = 172800 # 48 hours
#   records = var.name_servers
# }
# resource "aws_route53_record" "ec2_record" {
#   zone_id = aws_route53_zone.subdomain.zone_id
#   name    = "ec2.${var.domain_name}"
#   type    = "A"
#   ttl     = 300
#   records = [module.public_ec2.instance_public_ip]
# }
