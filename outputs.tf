output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "ecr_repository_url" {
  value = module.ecr.repository_url
}

