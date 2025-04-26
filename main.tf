module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr
}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  cluster_role_arn = ""
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.subnet_ids
}


module "ecr" {
  source = "./modules/ecr"
  repository_name = var.repository_name
}

