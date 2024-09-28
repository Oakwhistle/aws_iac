output "transit_gateway_route_table_ids" {
  description = "IDs of the created Transit Gateway Route Tables"
  value       = { for k, rt in aws_ec2_transit_gateway_route_table.transit_gw_route_table : k => rt.id }
}
