resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block # Define the CIDR block for the new VPC
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

# Create public subnets
resource "aws_subnet" "subnet_public" {
  for_each                = var.public_subnets # Iterate through public subnet IDs
  vpc_id                  = aws_vpc.main.id    # Reference the newly created VPC
  cidr_block              = each.value.cidr    # Subnet CIDR block from the list
  availability_zone       = each.value.az      # Availability zone for the subnet
  map_public_ip_on_launch = true               # Public subnet setting
  tags = merge(var.tags, {
    Name = "public-subnet-${each.value.cidr}"
  })
}

# Create private subnets
resource "aws_subnet" "subnet_private" {
  for_each                = var.private_subnets # Iterate through private subnet IDs
  vpc_id                  = aws_vpc.main.id     # Reference the newly created VPC
  cidr_block              = each.value.cidr     # Subnet CIDR block from the list
  availability_zone       = each.value.az       # Availability zone for the subnet
  map_public_ip_on_launch = false               # private subnet setting
  tags = merge(var.tags, {
    Name = "private-subnet-${each.value.cidr}"
  })
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id # Attach the IGW to the newly created VPC
  tags = merge(var.tags, {
    Name = "${var.vpc_name}-internet-gateway"
  })
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_public[keys(aws_subnet.subnet_public)[0]].id # Dynamically select first public subnet
  tags = merge(var.tags, {
    Name = "${var.vpc_name}-nat-gateway"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id # Reference the newly created VPC

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-route-table"
  })
}

resource "aws_route_table_association" "public_association" {
  for_each       = aws_subnet.subnet_public  # Iterate over the public subnets
  subnet_id      = each.value.id             # Get the subnet ID for each public subnet
  route_table_id = aws_route_table.public.id # Associate with the public route table
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id # Reference the newly created VPC

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-private-route-table"
  })
}

resource "aws_route_table_association" "private_association" {
  for_each       = aws_subnet.subnet_private  # Iterate over the private subnets
  subnet_id      = each.value.id              # Get the subnet ID for each private subnet
  route_table_id = aws_route_table.private.id # Associate with the private route table
}

