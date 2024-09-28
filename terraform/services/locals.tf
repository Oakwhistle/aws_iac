locals {
  vpc_id = data.aws_vpcs.vpc_id.ids[0]
}

locals {
  tags = {
    Deploy      = "terraform"
    Accountable = var.accountable
    Environment = var.environment
    Business    = var.business
    Service     = var.service
    Project     = var.project
  }
}

locals {
  accounts = {
    "<account-id>" = { Account_name = "<name>", Acronim = "OAWS" }
    "<account-id>" = { Account_name = "<name>", Acronim = "<ACR>" }
  }
  regions = {
    "<aws-region-1>"      = { region_num = 1 }
    "<aws-region-1>"       = { region_num = 2 }
  }
  environments = {
    "develop"     = { reference = "D" }
    "quality"     = { reference = "Q" }
    "staging"     = { reference = "S" }
    "prod"        = { reference = "P" }
  }

  account_acronym = lookup(local.accounts, var.account_id, null).Acronim
  region_num      = lookup(local.regions, var.region, null).region_num
  environment_ref = lookup(local.environments, var.environment, null).reference

  name_prefix = (can(local.account_acronym) && can(local.region_num) && can(local.environment_ref) ? format("AW%s%s%s", local.account_acronym, local.region_num, local.environment_ref) : "")

}

locals {
  subnets = {
    for subnet in data.aws_subnet.subnet_ids :
    subnet.tags["Name"] => subnet.id
  }
}

locals {
  security_groups = merge({
    for sg_key, sg_value in data.aws_security_group.security_group_ids :
    sg_value.tags.Name => sg_key
    if length(sg_value.tags) > 0 && contains(keys(sg_value.tags), "Name")
  }, module.security_groups.security_group_ids)
}

locals {
  should_create_ec2 = length(var.ec2_instances) > 0
}

locals {
  
  all_buckets = merge(module.s3.existing_buckets, module.s3.new_buckets)

}

