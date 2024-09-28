output "cluster_id" {
  value = module.eks_cluster.eks_cluster_id
}

output "cluster_endpoint" {
  value = module.eks_cluster.eks_cluster_endpoint
}


output "subnet_ids" {
  value = data.aws_subnets.filtered_subnets.ids
}