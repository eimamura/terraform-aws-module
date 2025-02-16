# resource "aws_directory_service_directory" "bar" {
#   name     = "corp.notexample.com" # valid domain name
#   password = "SuperSecretPassw0rd"
#   tags     = var.tags

#   # Simple AD
#   type = "SimpleAD"
#   size = "Small"

#   # MS AD
#   #   type    = "MicrosoftAD"
#   #   edition = "Standard"

#   vpc_settings {
#     vpc_id     = module.vpc.vpc_id
#     subnet_ids = module.vpc.public_subnet_ids
#   }

#   # MS Connect
#   #   type = "ADConnector"
#   #   size = "Small"
#   #   connect_settings {
#   #     customer_dns_ips  = ["A.B.C.D"]
#   #     customer_username = "Admin"
#   #     vpc_id            = module.vpc.vpc_id
#   #     subnet_ids        = module.vpc.public_subnet_ids
#   #   }
# }
