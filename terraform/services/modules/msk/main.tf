resource "aws_msk_cluster" "msk_cluster" {
  for_each = var.msk-clusters

  cluster_name           = each.value.name
  kafka_version          = each.value.kafka_version
  number_of_broker_nodes = each.value.number_of_broker_nodes

  broker_node_group_info {
    instance_type = each.value.instance_type
    storage_info {
      ebs_storage_info {
        volume_size = each.value.ebs_volume_size
      }
    }

    # Aquí buscamos los IDs de las subredes usando el mapeo
   client_subnets = [
      for subnet_name in split(",", each.value.subnets) :
      [for key, value in var.subnets : value if can(regex(subnet_name, key))][0]
    ]
    # Aquí buscamos los IDs de los grupos de seguridad
   security_groups = [
      for sg_name in split(",", each.value.security_groups) :
      [for key, value in var.security_groups : value if can(regex(sg_name, key))][0]
    ]
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }
    client_authentication {
    sasl {
      iam = each.value.enable_iam_auth
    }
    tls {
      certificate_authority_arns = []
    }
    unauthenticated = true
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  tags = merge(each.value.tags, var.tags)
}
