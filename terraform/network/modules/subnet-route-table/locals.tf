locals {
  routes = flatten([
    for rt_key, rt_value in var.subnet_route_tables : [
      for route_key, route_value in rt_value.routes : {
        key                = "${rt_key}-${route_key}"
        route_table_id     = aws_route_table.this[rt_key].id
        cidr_block         = route_value.destiny
        transit_gateway_id = lookup(var.transit_gateway_attachment_ids, route_value.target, null) != null ? var.transit_gateway_id : null
        gateway_id         = lookup(var.transit_gateway_attachment_ids, route_value.target, null) == null ? (lookup(var.internet_gateway_ids, route_value.target, null) != null ? var.internet_gateway_ids[route_value.target] : lookup(var.nat_gateway_ids, route_value.target, null)) : null
      }
    ]
  ])
}

locals {
  route_table_associations = {
    for idx, association in flatten([
      for rt_key, rt_value in var.subnet_route_tables : [
        for subnet_name in rt_value.subnets_names : {
          key            = "${rt_key}-${subnet_name}"
          subnet_id      = var.subnet_ids[subnet_name]
          route_table_id = aws_route_table.this[rt_key].id
        }
      ]
    ]) : idx => association
  }
}
