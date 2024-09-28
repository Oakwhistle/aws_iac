output "key_pair_names" {
  value       = { for k, v in aws_key_pair.keypair : v.key_name => v.arn }
  description = "A map of key pair names to their ARNs"
}

output "ssm_parameters" {
  value       = { for k, v in aws_ssm_parameter.parameter : v.name => v.arn }
  description = "A map of SSM parameter ARNs"
}