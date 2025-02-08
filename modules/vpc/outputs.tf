output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = values(aws_subnet.subnet_public)[*].id # Extract the IDs from the map
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = values(aws_subnet.subnet_private)[*].id # Extract the IDs from the map
}

output "igw_id" {
  description = "The ID of the Internet Gateway."
  value       = aws_internet_gateway.igw.id
}

# output "nat_gateway_id" {
#   description = "The ID of the NAT Gateway."
#   value       = aws_nat_gateway.nat_gw.id
# }

output "route_table_id" {
  description = "The ID of the route table"
  value       = aws_route_table.private.id
}
