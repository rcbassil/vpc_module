### Network

# Internet VPC
resource "aws_vpc" "application_vpc" {
  cidr_block           = var.vpc_ciddrr_block
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags = {
    Name = "${var.environment}_application_vpc"
  }
}

# Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.application_vpc.id
  cidr_block              = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  count                   = length(var.public_subnet_cidr_blocks)

  tags = {
    Name = "${var.environment}_public_subnet_${substr(element(var.availability_zones, count.index), -1, 1)}"
  }
}

resource "aws_subnet" "private_subnets" {

  vpc_id                  = aws_vpc.application_vpc.id
  cidr_block              = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  count                   = length(var.private_subnet_cidr_blocks)

  tags = {
    Name = "${var.environment}_private_subnet_${substr(element(var.availability_zones, count.index), -1, 1)}"
  }

}

# Internet Gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.application_vpc.id

  tags = {
    Name = "${var.environment}_internet_gw"
  }
}

# public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.application_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }

  tags = {
    Name = "${var.environment}_public_rt"
  }
}


# public subnet route table associations
resource "aws_route_table_association" "public_rta" {
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
  count          = length(aws_subnet.public_subnets)
}


