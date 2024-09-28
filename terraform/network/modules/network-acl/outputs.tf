output "network_acl_ids" {
  description = "Map of network ACL IDs"
  value       = { for name, acl in aws_network_acl.network_acl : name => acl.id }
}