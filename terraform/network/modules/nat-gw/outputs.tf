output "nat_gateway_ids" {
  description = "IDs of the created NAT Gateways"
  value       = { for k, v in aws_nat_gateway.nat_gateway : k => v.id }
}