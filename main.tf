provider "aws" {
  region = var.region
}

# Create the VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Create the Internet Gateway for public access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create public subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
  # Add lifecycle block to allow forced deletion
  lifecycle {
    prevent_destroy = false
  }
}

# Create private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
   # Add lifecycle block to allow forced deletion
  lifecycle {
    prevent_destroy = false
  }
}

# Create route table for public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Create NAT Gateway for private subnets to access the internet
resource "aws_eip" "nat_eip" {
  count  = 1
  domain = "vpc"  # Corrected line: Replaces 'vpc = true'
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip[0].id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "${var.vpc_name}-nat"
  }
}

# Create route table for private subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

# Associate private subnets with the private route table
resource "aws_route_table_association" "private_association" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}