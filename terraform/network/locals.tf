locals {
  tags = {
    Deploy      = "terraform"
    Accountable = var.accountable
    Environment = var.environment
    Business    = var.business
    Service     = var.service
    Role        = "network"
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
  name_prefix = format(
    "AW%s%s%s",
    local.accounts[var.account_id].Acronim,
    local.regions[var.region].region_num,
    local.environments[var.environment].reference
  )
}

locals {
  tgw_ids = ["tgw-0ddd2248f73542c36", "tgw-05302905b271ee1ad", "tgw-0df8e37f5f874da34"]
  tgw     = contains(["us-east-1"], var.region) ? local.tgw_ids[0] : contains(["ap-southeast-1"], var.region) ? local.tgw_ids[1] : contains(["eu-central-1"], var.region) ? local.tgw_ids[2] : null
}

locals {
  vpc_id = var.vpc_name != null && length(data.aws_vpcs.vpc_id) > 0 ? try(data.aws_vpcs.vpc_id[0].ids[0], null) : null
}

locals {
  is_forti_gate_ha_valid = (
    var.forti-gate-ha.az1 != "" &&
    var.forti-gate-ha.az2 != "" &&
    var.forti-gate-ha.vpccidr != "" &&
    var.forti-gate-ha.publiccidraz1 != "" &&
    var.forti-gate-ha.privatecidraz1 != "" &&
    var.forti-gate-ha.hasynccidraz1 != "" &&
    var.forti-gate-ha.hamgmtcidraz1 != "" &&
    var.forti-gate-ha.transitcidraz1 != "" &&
    var.forti-gate-ha.publiccidraz2 != "" &&
    var.forti-gate-ha.privatecidraz2 != "" &&
    var.forti-gate-ha.hasynccidraz2 != "" &&
    var.forti-gate-ha.hamgmtcidraz2 != "" &&
    var.forti-gate-ha.transitcidraz2 != "" &&
    var.forti-gate-ha.license_type != "" &&
    var.forti-gate-ha.license_format != "" &&
    var.forti-gate-ha.arch != "" &&
    var.forti-gate-ha.size != "" &&
    var.forti-gate-ha.adminsport != "" &&
    var.forti-gate-ha.keypair_name != "" &&
    var.forti-gate-ha.bootstrap_active != "" &&
    var.forti-gate-ha.bootstrap_passive != "" &&
    var.forti-gate-ha.license != "" &&
    var.forti-gate-ha.license2 != ""
  )
}