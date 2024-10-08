output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "eks_cluster_id" {
  value = aws_eks_cluster.this.id
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.this.arn
}

output "eks_cluster_security_group" {
  value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}
