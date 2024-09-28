output "route_table_ids" {
  value = { for rt_id, rt in aws_route_table.this : rt_id => {
    id = rt.id
    routes = {
      for route in rt.route : route.cidr_block => {
        gateway_id         = route.gateway_id
        nat_gateway_id     = route.nat_gateway_id
        transit_gateway_id = route.transit_gateway_id
      }
    }
  } }
}
