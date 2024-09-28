output "transit_gateway_ids" {
  description = "IDs of the created Transit Gateways"
  value       = { for k, tg in aws_ec2_transit_gateway.transit-gw : k => tg.id }
}
