variable "vpc_ciddrr_block" {
  type        = string
  default     = "172.33.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type = list
  default = [
    "172.33.10.0/24",
    "172.33.20.0/24",
    "172.33.30.0/24",
  ]
}

variable "private_subnet_cidr_blocks" {
  type = list
  default = [
    "172.33.100.0/24",
    "172.33.110.0/24",
    "172.33.120.0/24",
  ]
}

variable "availability_zones" {
  type = list
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_account_ids" {
  type    = list
  default = null
}

variable "environment" {
  type    = string
  default = null
}

