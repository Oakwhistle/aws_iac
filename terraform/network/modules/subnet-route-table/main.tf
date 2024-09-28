resource "aws_route_table" "this" {
  for_each = var.subnet_route_tables

  vpc_id = var.vpc_ids[each.value.vpc_name]
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.value.name}"
    }
  )
}
resource "aws_route" "this" {
  for_each = { for idx, route in local.routes : route.key => route }

  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.cidr_block

  transit_gateway_id = each.value.transit_gateway_id != null ? each.value.transit_gateway_id : null
  gateway_id         = each.value.gateway_id != null ? each.value.gateway_id : null
}

resource "aws_route_table_association" "this" {
  for_each = local.route_table_associations

  subnet_id      = each.value.subnet_id
  route_table_id = each.value.route_table_id
}