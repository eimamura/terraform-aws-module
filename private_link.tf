# resource "aws_lb" "nlb" {
#   name               = "privatelink-nlb"
#   internal           = true # Private NLB
#   load_balancer_type = "network"
#   subnets            = module.vpc.public_subnet_ids
# }

# # Service Provider (Creates PrivateLink Service)
# resource "aws_vpc_endpoint_service" "pl_service" {
#   acceptance_required        = false
#   network_load_balancer_arns = [aws_lb.nlb.arn]
#   tags                       = { Name = "privatelink-service" }
# }

# # Service Consumer (Requests the PrivateLink Service)
# resource "aws_vpc_endpoint" "pl_consumer" {
#   vpc_id             = module.vpc.vpc_id
#   service_name       = aws_vpc_endpoint_service.pl_service.service_name
#   vpc_endpoint_type  = "Interface"
#   subnet_ids         = module.vpc.private_subnet_ids
#   security_group_ids = [module.sg.http_only_sg]
#   tags               = { Name = "privatelink-endpoint" }
# }

# PrivateLink Setup
# Key Components:
# 1. Service Provider (Owner of the Service)

# Creates a PrivateLink Service inside their VPC.
# Attaches it to a Network Load Balancer (NLB).
# Shares the service with other AWS accounts or VPCs.

# 2. Service Consumer (Requester of the Service)

# Creates a VPC Endpoint (Interface Endpoint) in their own VPC.
# Connects to the service provider’s PrivateLink endpoint.

# 3. VPC Endpoint Types (Related to PrivateLink)

# Interface Endpoint (AWS PrivateLink-based) → Uses ENIs inside the consumer’s VPC.
# Gateway Load Balancer Endpoint (GLB-based PrivateLink) → Used for security appliances like firewalls.


# Recommendation
# If you want VPC-to-VPC communication without Peering or Transit Gateway:

# For service-to-service communication → Use PrivateLink.
# For AWS service access (e.g., S3, DynamoDB) → Use VPC Gateway Endpoints.
# For full VPC connectivity but encrypted → Use VPN.
