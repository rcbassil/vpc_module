module "sandbox_vpc" {
  source = "../modules/vpc"

  availability_zones         = var.availability_zones
  environment                = var.environment
  vpc_ciddrr_block           = var.vpc_ciddrr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
}
