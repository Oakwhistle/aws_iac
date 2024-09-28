output "security_group_ids" {
  value = { for key, sg in aws_security_group.security_group : "${var.name_prefix}-${key}" => sg.id }
}
