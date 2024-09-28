
module "vpc" {
  source      = "./modules/vpc"
  name_prefix = local.name_prefix
  tags        = local.tags
  vpcs        = var.vpcs
}
module "subnet" {
  source          = "./modules/subnet"
  name_prefix     = local.name_prefix
  tags            = local.tags
  subnets         = var.subnets
  vpc_ids         = module.vpc.vpc_ids
  network_acl_ids = module.network_acl.network_acl_ids
}
module "network_acl" {
  source       = "./modules/network-acl"
  name_prefix  = local.name_prefix
  tags         = local.tags
  network_acls = var.network_acls
  vpc_ids      = module.vpc.vpc_ids
}
module "dhcp_option_set" {
  source           = "./modules/dhcp"
  name_prefix      = local.name_prefix
  tags             = local.tags
  dhcp_option_sets = var.dhcp_option_sets
  vpc_ids          = module.vpc.vpc_ids
  region           = var.region
}
module "internet_gateways" {
  source            = "./modules/intenet-gw"
  name_prefix       = local.name_prefix
  tags              = local.tags
  internet_gateways = var.internet_gateways
  vpc_ids           = module.vpc.vpc_ids
}
module "nat_gw" {
  source       = "./modules/nat-gw"
  region       = var.region
  name_prefix  = local.name_prefix
  tags         = local.tags
  nat_gateways = var.nat_gateways
  subnet_ids   = module.subnet.subnet_ids
}
module "security_group" {
  source           = "./modules/security-group"
  name_prefix      = local.name_prefix
  tags             = local.tags
  vpc_ids          = module.vpc.vpc_ids
  security_groups  = var.security_groups
  existin_vpc_name = local.vpc_id
}
module "transit_gateway_attachment" {
  source                      = "./modules/transit-gw-attach"
  region                      = var.region
  name_prefix                 = local.name_prefix
  tags                        = local.tags
  vpc_ids                     = module.vpc.vpc_ids
  subnet_ids                  = module.subnet.subnet_ids
  transit_gateway_id          = local.tgw
  transit_gateway_attachments = var.transit_gateway_attachments
}
module "subnet_route_table" {
  source                         = "./modules/subnet-route-table"
  subnet_route_tables            = var.subnet_route_tables
  vpc_ids                        = module.vpc.vpc_ids
  subnet_ids                     = module.subnet.subnet_ids
  transit_gateway_id             = local.tgw
  name_prefix                    = local.name_prefix
  tags                           = local.tags
  transit_gateway_attachment_ids = module.transit_gateway_attachment.transit_gateway_attachment_ids
  internet_gateway_ids           = module.internet_gateways.internet_gateway_ids
  nat_gateway_ids                = module.nat_gw.nat_gateway_ids
}
module "vpc_flow_logs" {
  source = "./modules/vpc_flow_logs"
  # vpcs            = { for k, v in var.vpcs : k => merge(v, { id = module.vpc.vpc_ids[k] }) if v.enable_flow_logs }
  # count           = var.enable_flow_logs ? 1: 0
  tags             = local.tags
  region           = var.region
  name_prefix      = local.name_prefix
  vpc_flow_logs    = var.vpc_flow_logs
  existin_vpc_name = local.vpc_id
}

module "transit_gateway" {
  source           = "./modules/transit-gw"
  name_prefix      = local.name_prefix
  tags             = local.tags
  transit_gateways = var.transit_gateways
}

module "transit_gateway_route_table" {
  source                       = "./modules/transit-gw-route-table"
  count                        = length(var.transit_gateway_route_tables) > 0 ? 1 : 0
  name_prefix                  = local.name_prefix
  tags                         = local.tags
  transit_gateway_route_tables = var.transit_gateway_route_tables
  transit_gateway_ids          = module.transit_gateway.transit_gateway_ids
  depends_on                   = [module.transit_gateway]
}

module "forti_gate_ha" {
  source              = "./modules/forti-gate"
  count               = local.is_forti_gate_ha_valid ? 1 : 0
  region              = var.region
  az1                 = var.forti-gate-ha.az1
  az2                 = var.forti-gate-ha.az2
  vpccidr             = var.forti-gate-ha.vpccidr
  publiccidraz1       = var.forti-gate-ha.publiccidraz1
  privatecidraz1      = var.forti-gate-ha.privatecidraz1
  hasynccidraz1       = var.forti-gate-ha.hasynccidraz1
  hamgmtcidraz1       = var.forti-gate-ha.hamgmtcidraz1
  transitcidraz1      = var.forti-gate-ha.transitcidraz1
  publiccidraz2       = var.forti-gate-ha.publiccidraz2
  privatecidraz2      = var.forti-gate-ha.privatecidraz2
  hasynccidraz2       = var.forti-gate-ha.hasynccidraz2
  hamgmtcidraz2       = var.forti-gate-ha.hamgmtcidraz2
  transitcidraz2      = var.forti-gate-ha.transitcidraz2
  license_type        = var.forti-gate-ha.license_type
  license_format      = var.forti-gate-ha.license_format
  arch                = var.forti-gate-ha.arch
  size                = var.forti-gate-ha.size
  adminsport          = var.forti-gate-ha.adminsport
  activeport1         = var.forti-gate-ha.activeports["activeport1"].ip
  activeport1mask     = var.forti-gate-ha.activeports["activeport1"].mask
  activeport2         = var.forti-gate-ha.activeports["activeport2"].ip
  activeport2mask     = var.forti-gate-ha.activeports["activeport2"].mask
  activeport3         = var.forti-gate-ha.activeports["activeport3"].ip
  activeport3mask     = var.forti-gate-ha.activeports["activeport3"].mask
  activeport4         = var.forti-gate-ha.activeports["activeport4"].ip
  activeport4mask     = var.forti-gate-ha.activeports["activeport4"].mask
  passiveport1        = var.forti-gate-ha.passiveports["passiveport1"].ip
  passiveport1mask    = var.forti-gate-ha.passiveports["passiveport1"].mask
  passiveport2        = var.forti-gate-ha.passiveports["passiveport2"].ip
  passiveport2mask    = var.forti-gate-ha.passiveports["passiveport2"].mask
  passiveport3        = var.forti-gate-ha.passiveports["passiveport3"].ip
  passiveport3mask    = var.forti-gate-ha.passiveports["passiveport3"].mask
  passiveport4        = var.forti-gate-ha.passiveports["passiveport4"].ip
  passiveport4mask    = var.forti-gate-ha.passiveports["passiveport4"].mask
  activeport1gateway  = var.forti-gate-ha.activeports["activeport1"].gateway
  activeport2gateway  = var.forti-gate-ha.activeports["activeport2"].gateway
  activeport4gateway  = var.forti-gate-ha.activeports["activeport4"].gateway
  passiveport1gateway = var.forti-gate-ha.passiveports["passiveport1"].gateway
  passiveport2gateway = var.forti-gate-ha.passiveports["passiveport2"].gateway
  passiveport4gateway = var.forti-gate-ha.passiveports["passiveport4"].gateway
  bootstrap-active    = var.forti-gate-ha.bootstrap_active
  bootstrap-passive   = var.forti-gate-ha.bootstrap_passive
  license             = var.forti-gate-ha.license
  license2            = var.forti-gate-ha.license2
  name_prefix         = local.name_prefix
  tags                = local.tags
  keypair_name        = var.forti-gate-ha.keypair_name
  environment         = var.environment
}

module "db_subnet_group" {
  count       =  var.enable_rds_subnet_group ? 1 : 0
  source      = "./modules/db-subnet-group" # Ruta al módulo
  subnet_ids  = module.subnet.subnet_ids
  name_prefix = local.name_prefix
  depends_on = [ module.subnet ]
  tags = local.tags
}



