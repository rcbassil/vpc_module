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

