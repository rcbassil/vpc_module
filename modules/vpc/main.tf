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

