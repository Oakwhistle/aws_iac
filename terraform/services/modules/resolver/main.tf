# Recursos para los endpoints de inbound
resource "aws_route53_resolver_endpoint" "inbound" {
  for_each = var.inbound_resolvers

  name      = "${var.name_prefix}-${each.value.name}"
  direction = "INBOUND"

  security_group_ids = each.value.security_group_names != null ? flatten([for sg_name in each.value.security_group_names : [for k, v in var.security_groups : v if can(regex(sg_name, k))]]) : []
  # [
  #   for sg_name in each.value.security_group_names :
  #   lookup(var.security_groups, "${var.name_prefix}-${sg_name}", null)
  # ]

  dynamic "ip_address" {
    for_each = each.value.ip_addresses

    content {
      subnet_id = lookup(var.subnet_ids, "${var.name_prefix}-${ip_address.value.subnet_name}", lookup(var.subnet_ids, ip_address.value.subnet_name, null))
      ip        = ip_address.value.ip_address
    }
  }

  protocols              = ["Do53", "DoH"]
  resolver_endpoint_type = "IPV4"
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.value.name}"
    }
  )
}

resource "aws_route53_resolver_endpoint" "outbound" {
  for_each = var.outbound_resolvers

  name      = "${var.name_prefix}-${each.value.name}"
  direction = "OUTBOUND"

  security_group_ids = each.value.security_group_names != null ? flatten([for sg_name in each.value.security_group_names : [for k, v in var.security_groups : v if can(regex(sg_name, k))]]) : []
  # [
  #   for sg_name in each.value.security_group_names :
  #   lookup(var.security_groups, "${var.name_prefix}-${sg_name}", null)
  # ]

  dynamic "ip_address" {
    for_each = each.value.ip_addresses

    content {
      subnet_id = lookup(var.subnet_ids, "${var.name_prefix}-${ip_address.value.subnet_name}", lookup(var.subnet_ids, ip_address.value.subnet_name, null))
      ip        = ip_address.value.ip_address
    }
  }

  protocols              = ["Do53", "DoH"]
  resolver_endpoint_type = "IPV4"
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.value.name}"
    }
  )
}

resource "aws_route53_resolver_rule" "outbound_rules" {
  for_each = var.outbound_resolvers

  name                 = "resolver-rule-${each.key}"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound[each.key].id
  rule_type            = "FORWARD"
  domain_name          = values(each.value.routes)[0].domain_name

  dynamic "target_ip" {
    for_each = flatten([for route_key, route in each.value.routes : values(route.destination_ips)])

    content {
      ip = target_ip.value
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "resolver-rule-${each.key}"
    }
  )
}


