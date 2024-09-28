locals {
  vpc_id = data.aws_vpcs.vpc_id.ids[0]
}

locals {
  tags = {
    Deploy      = var.deploy
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
  # Subredes privadas para el ALB
  private_subnet_ids = [
    for subnet in data.aws_subnet.subnet_details :
    subnet.id if !subnet.map_public_ip_on_launch && contains(["eu-central-1a", "eu-central-1b", "eu-central-1c"], subnet.availability_zone)
  ]
}
