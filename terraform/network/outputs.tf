output "subnet_ids" {
  value = length(module.subnet.subnet_ids) > 0 ? module.subnet.subnet_ids : null
}

output "module_network_acl_ids" {
  value = length(module.network_acl.network_acl_ids) > 0 ? module.network_acl.network_acl_ids : null
}

output "dhcp_option_sets_output" {
  value = length(module.dhcp_option_set.module_dhcp_option_sets) > 0 ? module.dhcp_option_set.module_dhcp_option_sets : null
}

output "internet_gateway_ids" {
  value = length(module.internet_gateways.internet_gateway_ids) > 0 ? module.internet_gateways.internet_gateway_ids : null
}

output "nat_gateway_ids" {
  value = length(module.nat_gw.nat_gateway_ids) > 0 ? module.nat_gw.nat_gateway_ids : null
}

output "security_group_ids" {
  value = length(module.security_group.security_group_ids) > 0 ? module.security_group.security_group_ids : null
}

output "transit_gateway_attachment_ids" {
  value = length(module.transit_gateway_attachment.transit_gateway_attachment_ids) > 0 ? module.transit_gateway_attachment.transit_gateway_attachment_ids : null
}

output "route_table_ids" {
  value = length(module.subnet_route_table.route_table_ids) > 0 ? module.subnet_route_table.route_table_ids : null
}

output "transit_gateway_ids" {
  value = length(module.transit_gateway.transit_gateway_ids) > 0 ? module.transit_gateway.transit_gateway_ids : null
}

output "transit_gateway_route_table_ids" {
  value = length(module.transit_gateway_route_table) > 0 ? flatten([for table in module.transit_gateway_route_table : table.transit_gateway_route_table_ids]) : null
}

output "MGMTPublicIP" {
  value = length(module.forti_gate_ha) > 0 ? module.forti_gate_ha[0].FGTActiveMGMTPublicIP : null
}

output "ClusterPublicFQDN" {
  value = length(module.forti_gate_ha) > 0 ? module.forti_gate_ha[0].FGTClusterPublicFQDN : null
}

output "ClusterPublicIP" {
  value = length(module.forti_gate_ha) > 0 ? module.forti_gate_ha[0].FGTClusterPublicIP : null
}

output "PassiveMGMTPublicIP" {
  value = length(module.forti_gate_ha) > 0 ? module.forti_gate_ha[0].FGTPassiveMGMTPublicIP : null
}

output "AdminUsername" {
  value = length(module.forti_gate_ha) > 0 ? module.forti_gate_ha[0].Username : null
}

output "AdminPasswordID" {
  value = length(module.forti_gate_ha) > 0 ? module.forti_gate_ha[0].Password : null
}

output "db_subnet_group_name" {
value = length(module.db_subnet_group) > 0 ? module.db_subnet_group[0].db_subnet_group_name : null
}

# output "db_subnet_group_subnet_ids" {
#   value = module.db_subnet_group.db_subnet_group_subnet_ids
# }