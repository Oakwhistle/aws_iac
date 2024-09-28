output "cluster_arns" {
  description = "ARNs of the MSK clusters."
  value = { for name, cluster in aws_msk_cluster.msk_cluster : name => cluster.arn }
}

output "cluster_names" {
  description = "Names of the MSK clusters."
  value = { for name, cluster in aws_msk_cluster.msk_cluster : name => cluster.cluster_name }
}