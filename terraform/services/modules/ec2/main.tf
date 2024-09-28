resource "null_resource" "gaviton_instance_types" {
  provisioner "local-exec" {
    command = <<-EOT
      aws ec2 describe-instance-types --query 'InstanceTypes[*].[InstanceType, join(`, `, ProcessorInfo.SupportedArchitectures[])]' --output table | awk 'BEGIN{ORS=""; counter=1; print "["} /\<arm64\>/ {arch_list[$2]} END {for(arch in arch_list){print "\""arch"\""; if(length(arch_list) > counter++){print ","}}; print "]"}'
    EOT
  }
}
resource "aws_iam_role" "ssm_role" {
  name = "${var.name_prefix}-${var.project}-${var.service}-Role-Instances"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ec2.amazonaws.com",
          "ssm.amazonaws.com"]
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_patch_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = aws_iam_role.ssm_role.name
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.name_prefix}-${var.project}-${var.service}-instance_profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_instance" "instance" {
  for_each = var.instances

  ami                  = contains(local.gaviton_instance_types, each.value.instance_type) ? lookup(local.ami_ids, "linux_graviton", each.value.ami) : lookup(local.ami_ids, each.value.ami, each.value.ami)
  instance_type        = each.value.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name


  user_data = each.value.ami == "linux" || each.value.ami == "linux_graviton" && each.value.role != "appliance" ? local.user_admin_linux : each.value.ami == "windows" && each.value.role == "appliance" ? local.user_admin_windows : each.value.role == "appliance" && (each.value.ami != "linux" || each.value.ami != "windows") ? each.value.user_data : ""

  key_name = each.value.key_pair != null ? "${var.name_prefix}${each.value.key_pair}" : null

  root_block_device {
    volume_size = coalesce(each.value.volume_size, each.value.ami == "linux" ? 20 : each.value.ami == "windows" ? 80 : 50)
    volume_type = coalesce(each.value.volume_type, "gp3")
    tags = merge(
      contains(keys(each.value), "schedule") ? { "Schedule" = each.value.schedule } : {},
      {
        Name = "${var.name_prefix}${each.value.name}"
        Role = "${each.value.role}"
      },
    var.tags)
  }

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.service[each.key].id
  }

  dynamic "network_interface" {
    for_each = each.value.management_ip != null ? [each.value] : []
    content {
      device_index         = 1
      network_interface_id = aws_network_interface.management[each.key].id
    }
  }

  dynamic "ebs_block_device" {
    for_each = each.value.ami == "linux" && each.value.role == "database" ? [
      {
        # Disco opt
        device_name = "/dev/sdb"
        volume_size = each.value.opt_disk != null ? each.value.opt_disk: 20
        volume_type = each.value.volume_type
      },
      {
        # Disco 
        device_name = "/dev/sdc"
        volume_size = each.value.swap_disk != null ? each.value.swap_disk: 8
        volume_type = each.value.volume_type
      },
      {
        device_name = "/dev/sdd"
        volume_size = each.value.logs_disk != null ? each.value.logs_disk: 10 
        volume_type = each.value.volume_type
      },
      {
        device_name = "/dev/sde"
        volume_size = each.value.backups_disk != null ? each.value.backups_disk: 20
        volume_type = each.value.volume_type
      },
      ] : each.value.ami == "linux" ? [
      {
        device_name = "/dev/sdb"
        volume_size = each.value.opt_disk != null ? each.value.opt_disk: 20
        volume_type = each.value.volume_type
      },
      {
        device_name = "/dev/sdc"
        volume_size = each.value.swap_disk != null ? each.value.swap_disk: 8
        volume_type = each.value.volume_type
      },
      ] : each.value.ami == "windows" && each.value.role == "database" ? [
      {
        #Disco paginacion
        device_name = "/dev/sdb"
        volume_size = each.value.paging_disk != null ? each.value.paging_disk: 8
        volume_type = each.value.volume_type
      },
      {
        #Disco datos 
        device_name = "/dev/sdc"
        volume_size = each.value.data_disk != null ? each.value.data_disk: 50
        volume_type = each.value.volume_type
      },
      {
        #Disco TEMP
        device_name = "/dev/sdd"
        volume_size = each.value.temp_disk != null ? each.value.temp_disk: 20
        volume_type = each.value.volume_type
      },
      {
        #Disco logs
        device_name = "/dev/sde"
        volume_size = each.value.logs_disk != null ? each.value.logs_disk: 10
        volume_type = each.value.volume_type
      },
      {
        #Disco Backups
        device_name = "/dev/sdf"
        volume_size = each.value.backups_disk != null ? each.value.backups_disk: 20
        volume_type = each.value.volume_type
      }
      ] : each.value.ami == "windows" && (each.value.role == "appserver" || each.value.role == "webserver") ? [
      {
        # Paginacion   each.value.swap_disk != null ? each.value.swap_disk
        device_name = "/dev/sdb"
        volume_size = each.value.paging_disk != null ? each.value.paging_disk: 8 
        volume_type = each.value.volume_type
      },
      {
        # Datos
        device_name = "/dev/sdc"
        volume_size = each.value.data_disk != null ? each.value.data_disk: 20
        volume_type = each.value.volume_type
      },
      {
        # Logs
        device_name = "/dev/sdd"
        volume_size = each.value.logs_disk != null ? each.value.logs_disk: 10
        volume_type = each.value.volume_type
      }
      ] : each.value.ami == "windows" && each.value.role == "dfs" ? [
      {
        # Paginacion   each.value.swap_disk != null ? each.value.swap_disk
        device_name = "/dev/sdb"
        volume_size = each.value.paging_disk != null ? each.value.paging_disk: 120 
        volume_type = each.value.volume_type
      },
      {
        # Datos
        device_name = "/dev/sdc"
        volume_size = each.value.data_disk != null ? each.value.data_disk: 100
        volume_type = each.value.volume_type
      },
      {
        # Logs
        device_name = "/dev/sdd"
        volume_size = each.value.logs_disk != null ? each.value.logs_disk: 110
        volume_type = each.value.volume_type
      }
      ] : each.value.ami == "windows" ? [
      {
        # Paginacion
        device_name = "/dev/sdb"
        volume_size = each.value.paging_disk != null ? each.value.paging_disk: 8
        volume_type = each.value.volume_type
      },
    ] : []
    content {
      device_name = ebs_block_device.value["device_name"]
      volume_size = ebs_block_device.value["volume_size"]
      volume_type = ebs_block_device.value["volume_type"]
      # other ebs_block_device settings
      tags = merge(
        contains(keys(each.value), "schedule") ? { "Schedule" = each.value.schedule } : {},
        {
          Name = "${var.name_prefix}${each.value.name}"
          Role = "${each.value.role}"
        },
      var.tags)
    }
  }

  dynamic "metadata_options" {
    for_each = each.value.enable_metadata ? [1] : []
    content {
      http_tokens                 = "optional"
      http_endpoint               = "enabled"
      http_put_response_hop_limit = 1
    }
  }

  lifecycle {
    ignore_changes = [
      ami,
      ebs_block_device, # Ignorar cambios en los discos EBS
      root_block_device # Ignorar cambios en el volumen raíz
    ]
  }

  tags = merge(
    contains(keys(each.value), "schedule") ? { "Schedule" = each.value.schedule } : {},
    {
      Name = "${var.name_prefix}${each.value.name}"
      Role = "${each.value.role}"
    },
  var.tags , each.value.tags)
}

resource "aws_network_interface" "service" {
  for_each = var.instances

  #subnet_id = (each.value.subnet_type != null && each.value.subnet_type != "" && each.value.az != null) ? lookup(var.subnets, format("%s-%s-%s", var.name_prefix, each.value.subnet_type, each.value.az), each.value.subnet_id) : each.value.subnet_id
  private_ips = compact([each.value.service_ip != null ? each.value.service_ip : null])
  subnet_id   = (each.value.subnet_type != null && each.value.subnet_type != "" && each.value.az != null) ? lookup(var.subnets, format("%s-%s-%s", var.name_prefix, each.value.subnet_type, each.value.az)) : each.value.subnet_name != null ? lookup(var.subnets, each.value.subnet_name) : each.value.subnet_id

  security_groups = compact(concat(
    [
      each.value.security_group_name != null ? lookup(var.security_groups, format("%s-%s", var.name_prefix, each.value.security_group_name), null) : null,
      each.value.management_ip == null ? lookup(var.security_groups, format("%s-REMOTE-ACCESS-SG", var.name_prefix), null) : null,
      each.value.ami == "windows" ? lookup(var.security_groups, format("%s-IAM-SG", var.name_prefix), null) : null,
      lookup(var.security_groups, format("%s-INTERNET-SG", var.name_prefix), null), lookup(var.security_groups, format("%s-SHARED-SERVICES-SG", var.name_prefix), null), lookup(var.security_groups, format("%s-CIBERSECURITY-TOOLS-SG", var.name_prefix), null), lookup(var.security_groups, format("%s-CIBERSECURITY-SCAN-TOOLS-SG", var.name_prefix), null)
    ],
    each.value.security_groups != null ? flatten([for sg_name in each.value.security_groups : [for k, v in var.security_groups : v if can(regex(sg_name, k))]]) : []
  ))
  lifecycle {
    ignore_changes = [
      private_ips,
    ]
  }
}

resource "aws_network_interface" "management" {
  for_each        = { for k, v in var.instances : k => v if v.management_ip != null }
  subnet_id       = lookup(var.subnets, format("%s-%s-%s", var.name_prefix, "MGMT", each.value.az))
  security_groups = compact([var.name_prefix == "" ? lookup(var.security_groups, "REMOTE-ACCESS-SG") : lookup(var.security_groups, format("%s-REMOTE-ACCESS-SG", var.name_prefix))])
  private_ips     = compact([each.value.management_ip != null ? each.value.management_ip : null])
}
