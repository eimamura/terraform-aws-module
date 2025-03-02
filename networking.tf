# module "vpc" {
#   source          = "./modules/vpc"     # Path to the VPC module
#   cidr_block      = var.cidr_block      # CIDR block for the VPC
#   public_subnets  = var.public_subnets  # Public subnets CIDR
#   private_subnets = var.private_subnets # Private subnets CIDR
#   vpc_name        = var.vpc_name        # VPC name
#   tags            = var.tags            # Tags for resources
#   enable_nat      = false
# }

# module "sg" {
#   source  = "./modules/security_group"
#   vpc_id  = module.vpc.vpc_id
#   project = var.project
# }

# locals {
#   vpcs = {
#     "vpc1" = {
#       cidr_block = "10.1.0.0/16"
#       public_subnets = {
#         "subnet-1" = { cidr = "10.1.0.0/24", az = "us-east-1a" }
#         "subnet-2" = { cidr = "10.1.2.0/24", az = "us-east-1b" }
#       }
#       private_subnets = {
#         "subnet-3" = { cidr = "10.1.1.0/24", az = "us-east-1a" }
#         "subnet-4" = { cidr = "10.1.3.0/24", az = "us-east-1b" }
#       }
#     }
#     "vpc2" = {
#       cidr_block = "10.2.0.0/16"
#       public_subnets = {
#         "subnet-1" = { cidr = "10.2.0.0/24", az = "us-east-1a" }
#         "subnet-2" = { cidr = "10.2.2.0/24", az = "us-east-1b" }
#       }
#       private_subnets = {
#         "subnet-3" = { cidr = "10.2.1.0/24", az = "us-east-1a" }
#         "subnet-4" = { cidr = "10.2.3.0/24", az = "us-east-1b" }
#       }
#     }
#   }
# }

# module "vpc_for_peering" {
#   for_each        = local.vpcs
#   source          = "./modules/vpc"
#   cidr_block      = each.value.cidr_block
#   public_subnets  = each.value.public_subnets
#   private_subnets = each.value.private_subnets
#   vpc_name        = each.key
#   tags            = var.tags
#   enable_nat      = false
# }

# module "sg_for_peering" {
#   for_each = module.vpc_for_peering
#   source   = "./modules/security_group"
#   vpc_id   = each.value.vpc_id
#   project  = var.project
# }

### VPC Peering
# resource "aws_vpc_peering_connection" "peer" {
#   vpc_id      = module.vpc_for_peering["vpc1"].vpc_id # Requester: charges when inter-region peering
#   peer_vpc_id = module.vpc_for_peering["vpc2"].vpc_id # Accepter
#   auto_accept = true                      # Works only in the same AWS account
#   tags        = { Name = "VPC-Peering" }
# }
# resource "aws_route" "route_vpc1_to_vpc2" {
#   route_table_id            = module.vpc_for_peering["vpc1"].public_route_table_id
#   destination_cidr_block    = module.vpc_for_peering["vpc2"].cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
# }
# resource "aws_route" "route_vpc2_to_vpc1" {
#   route_table_id            = module.vpc_for_peering["vpc2"].private_route_table_id
#   destination_cidr_block    = module.vpc_for_peering["vpc1"].cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
# }

### Transit Gateway
# resource "aws_ec2_transit_gateway" "example" {
#   description     = "Example Transit Gateway"
#   amazon_side_asn = 64512
#   tags            = { Name = "MyTransitGateway" }
# }
# resource "aws_ec2_transit_gateway_vpc_attachment" "example_attachment_vpc1" {
#   transit_gateway_id = aws_ec2_transit_gateway.example.id
#   vpc_id             = module.vpc_for_peering["vpc1"].vpc_id
#   subnet_ids         = module.vpc_for_peering["vpc1"].private_subnet_ids
#   tags               = { Name = "VPC1-Transit-Gateway-Attachment" }
# }
# resource "aws_ec2_transit_gateway_vpc_attachment" "example_attachment_vpc2" {
#   transit_gateway_id = aws_ec2_transit_gateway.example.id
#   vpc_id             = module.vpc_for_peering["vpc2"].vpc_id
#   subnet_ids         = module.vpc_for_peering["vpc2"].private_subnet_ids
#   tags               = { Name = "VPC2-Transit-Gateway-Attachment" }
# }
# resource "aws_route" "vpc1_route" {
#   route_table_id         = module.vpc_for_peering["vpc1"].private_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   transit_gateway_id     = aws_ec2_transit_gateway.example.id
# }
# resource "aws_route" "vpc2_route" {
#   route_table_id         = module.vpc_for_peering["vpc2"].private_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   transit_gateway_id     = aws_ec2_transit_gateway.example.id
# }
# resource "aws_ec2_transit_gateway_route_table" "tgw_rt" {
#   transit_gateway_id = aws_ec2_transit_gateway.example.id
#   tags               = { Name = "TGW-Route-Table" }
# }
# resource "aws_ec2_transit_gateway_route_table_association" "vpc1_assoc" {
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.example_attachment_vpc1.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
# }
# resource "aws_ec2_transit_gateway_route_table_association" "vpc2_assoc" {
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.example_attachment_vpc2.id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
# }
# resource "aws_ec2_transit_gateway_route" "route_vpc1_to_vpc2" {
#   destination_cidr_block         = module.vpc_for_peering["vpc2"].cidr_block
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.example_attachment_vpc2.id
# }
# resource "aws_ec2_transit_gateway_route" "route_vpc2_to_vpc1" {
#   destination_cidr_block         = module.vpc_for_peering["vpc1"].cidr_block
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgw_rt.id
#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.example_attachment_vpc1.id
# }
