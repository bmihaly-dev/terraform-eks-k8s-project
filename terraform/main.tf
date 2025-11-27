module "vpc" {
  source = "./modules/vpc"

  project    = var.project
  env        = var.env
  aws_region = var.aws_region
}

module "eks" {
  source = "./modules/eks"

  project    = var.project
  env        = var.env
  aws_region = var.aws_region

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
 
 
}