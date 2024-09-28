# output "vpc_id" {
#   value = data.aws_vpcs.vpc_id.ids[0]
# }
# output "subnet_ids" {
#   value = local.subnets
# }
# output "security_group_ids" {
#    value = merge(module.security_groups.security_group_ids, local.security_groups)
# }

output "key_pair_names" {
  value = length(module.keypairs.key_pair_names) > 0 ? module.keypairs.key_pair_names : null
  description = "A map of key pair names to their ARNs"
}

output "ssm_parameters" {
  value = length(module.keypairs.ssm_parameters) > 0 ? module.keypairs.ssm_parameters : null
  description = "A map of SSM parameter ARNs"
}

output "security_groups" {
  value = length(local.security_groups) > 0 ? local.security_groups : null
  description = "A map of security groups"
}

 output "subnet" {
   value = length(local.subnets) > 0 ? local.subnets : null
   description = "A list of subnets"
 }

output "instances" {
  value = length(module.ec2) > 0 && length(try(module.ec2[0].instances, [])) > 0 ? module.ec2[0].instances : null
  description = "A map of instances"
}
output "buckets" {
      value = length(var.s3) > 0 ? local.all_buckets : null
}
output "rds_identifiers" {
  value       = [for mod in module.rds : length(keys(mod.rds_instance_identifiers)) > 0 ? mod.rds_instance_identifiers : null]
  description = "Identifiers of the RDS instances from the module"
}

output "rds_usernames" {
  value       = [for mod in module.rds : length(keys(mod.rds_instance_usernames)) > 0 ? mod.rds_instance_usernames : null]
  description = "Usernames for the RDS instances from the module"
}

output "db_password_parameter_names" {
  value       = [for mod in module.rds : length(keys(mod.db_password_parameters)) > 0 ? mod.db_password_parameters : null]
  description = "SSM Parameter names storing DB passwords from the module"
}

# output "msk_cluster_names" {
#   description = "Names of the MSK clusters."
#   value       = length(module.msk_cluster.cluster_names) > 0 ? module.msk_cluster.cluster_names : null
# }

# output "msk_cluster_arns" {
#   description = "ARNs of the MSK clusters."
#   value       = length(module.msk_cluster.cluster_arns) > 0 ? module.msk_cluster.cluster_arns : null
# }