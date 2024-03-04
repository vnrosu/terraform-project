#Creates a VPC 
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true

  tags = {
    Name      = var.vpc_name
    ManagedBy = "Terraform"
  }
}

#Creates an internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-igw"
    ManagedBy = "Terraform"
  }
}

#Creates public subnets 
resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name      = format("${var.vpc_name}-public-subnet-%s", element(var.availability_zones, count.index))
    ManagedBy = "Terraform"
  }
}

#Creates private subnets 
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name      = format("${var.vpc_name}-private-subnet-%s", element(var.availability_zones, count.index))
    ManagedBy = "Terraform"
  }
}

#Creates public route table 
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-public-route-table"
    ManagedBy = "Terraform"
  }
}

#Associates  public routes to public subnets
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

#Routes traffic from public subnets to the IGW
resource "aws_route" "public_internet_gateway" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

#Creates an elastic ip address needed for the NAT gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

#Creates a NAT gateway 
resource "aws_nat_gateway" "NAT" {
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.nat.id
  tags = {
    Name      = "NAT gw"
    ManagedBy = "Terraform"
  }
}
# Creates a private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-private-route-table"
    ManagedBy = "Terraform"
  }
}

#Associates private routes to private subnets
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

# Routes traffic from private subnets to the NAT gateway
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NAT.id
}
