output "subnet_ids" {
  value = { for k, s in aws_subnet.subnet : k => s.id }
}