resource "aws_ec2_transit_gateway_route_table" "transit_gw_route_table" {
  for_each = var.transit_gateway_route_tables

  transit_gateway_id = var.transit_gateway_ids[each.value.transit_gateway_name]

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.value.name}"
    }
  )
}
