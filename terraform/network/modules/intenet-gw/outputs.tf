output "internet_gateway_ids" {
  value = { for k, v in aws_internet_gateway.internet_gateway : k => v.id }
}