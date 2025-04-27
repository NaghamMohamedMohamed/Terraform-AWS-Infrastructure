module "network" {
  source          = "./network"
  vpc_cidr        = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  region          = var.region
  azs             = var.azs
  env_name        = var.env_name
}

