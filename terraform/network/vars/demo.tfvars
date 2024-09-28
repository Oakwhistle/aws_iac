account_id  = "090876143603"
business    = "OCLOUD"
environment = "devel"
region      = "eu-central-1"
accountable = "oakroot"
project     = "Automation"
service     = "<service-name>"

# vpcs = {
#   vpc-GlobalExchange = {
#     name                 = "vpc-GlobalExchange"
#     cidr_block           = "172.16.0.0/16"
#     instance_tenancy     = "default"
#     enable_dns_support   = true
#     enable_dns_hostnames = true
#   }
# }
# subnets = {
#   subnet-GlobalExchange-front-a = {
#     name              = "subnet-GlobalExchange-front-a"
#     cidr_block        = "172.16.1.0/24"
#     availability_zone = "eu-central-1a"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-front-b = {
#     name              = "subnet-GlobalExchange-front-b"
#     cidr_block        = "172.16.2.0/24"
#     availability_zone = "eu-central-1b"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-bbdd-a = {
#     name              = "subnet-GlobalExchange-bbdd-a"
#     cidr_block        = "172.16.3.0/24"
#     availability_zone = "eu-central-1a"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-bbdd-b = {
#     name              = "subnet-GlobalExchange-bbdd-b"
#     cidr_block        = "172.16.4.0/24"
#     availability_zone = "eu-central-1b"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-lb-a = {
#     name              = "subnet-GlobalExchange-lb-a"
#     cidr_block        = "172.16.5.0/24"
#     availability_zone = "eu-central-1a"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-lb-b = {
#     name              = "subnet-GlobalExchange-lb-b"
#     cidr_block        = "172.16.6.0/24"
#     availability_zone = "eu-central-1b"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-mgmt-a = {
#     name              = "subnet-GlobalExchange-mgmt-a"
#     cidr_block        = "172.16.7.0/24"
#     availability_zone = "eu-central-1a"

#     vpc_name         = "vpc-GlobalExchange"
#     network_acl_name = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-mgmt-b = {
#     name              = "subnet-GlobalExchange-mgmt-b"
#     cidr_block        = "172.16.8.0/24"
#     availability_zone = "eu-central-1b"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-transit-a = {
#     name              = "subnet-GlobalExchange-transit-a"
#     cidr_block        = "172.16.9.0/24"
#     availability_zone = "eu-central-1a"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   subnet-GlobalExchange-transit-b = {
#     name              = "subnet-GlobalExchange-transit-b"
#     cidr_block        = "172.16.10.0/24"
#     availability_zone = "eu-central-1b"
#     vpc_name          = "vpc-GlobalExchange"
#     network_acl_name  = "network-acl-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
# }
# network_acls = {
#   network-acl-GlobalExchange = {
#     name     = "network-acl-GlobalExchange"
#     vpc_name = "vpc-GlobalExchange"
#     rules = {
#       rule_all_inbound = {
#         rule_number = 100
#         type        = "inbound"
#         protocol    = "tcp"
#         rule_action = "allow"
#         cidr_block  = "0.0.0.0/0"
#         from_port   = 0
#         to_port     = 65535
#       }
#       rule_all_outbound = {
#         rule_number = 100
#         type        = "outbound"
#         protocol    = "tcp"
#         rule_action = "allow"
#         cidr_block  = "0.0.0.0/0"
#         from_port   = 0
#         to_port     = 65535
#       }
#     }
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }

# }
# dhcp_option_sets = {
#   dhcp-option-set-GlobalExchange = {
#     name        = "dhcp-option-set-GlobalExchange"
#     domain_name = "globex.local"
#     vpc_name    = "vpc-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
# }
# internet_gateways = {
#   igw-GlobalExchange = {
#     name     = "igw-GlobalExchange"
#     vpc_name = "vpc-GlobalExchange"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
# }
# nat_gateways = {
#   nat-gateway-GlobalExchange-az-a = {
#     name              = "nat-gateway-GlobalExchange-az-a"
#     subnet_name       = "subnet-GlobalExchange-lb-a"
#     connectivity_type = "public"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
#   nat-gateway-GlobalExchange-az-b = {
#     name              = "nat-gateway-GlobalExchange-az-b"
#     subnet_name       = "subnet-GlobalExchange-lb-b"
#     connectivity_type = "public"
#     #eip_allocation_id    = "eipalloc-87654321" # Elastic IP preexistente
#     primary_private_ipv4 = "172.16.6.253"
#     tags = {
#       TestTag = "Test-tag"
#     }
#   }
# }
# security_groups = {
#   remote-access-sg = {
#     name        = "remote-access-sg"
#     description = "Security group for web servers"
#     vpc_name    = "vpc-GlobalExchange"
#     ingress = {
#       rule_1 = {
#         type        = "All Traffic"
#         protocol    = "-1"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["10.254.6.64/26"]
#         description = "EU01-JUMP-BACKEND-NET"
#       }
#     }
#     egress = {
#       rule_1 = {
#         type        = "rdp"
#         protocol    = "tcp"
#         from_port   = 3389
#         to_port     = 3389
#         cidr_blocks = ["10.254.6.64/26"]
#         description = "EU01-JUMP-BACKEND-NET"
#       }
#       rule_2 = {
#         type        = "ssh"
#         protocol    = "tcp"
#         from_port   = 22
#         to_port     = 22
#         cidr_blocks = ["10.254.6.64/26"]
#         description = "EU01-JUMP-BACKEND-NET"
#       }
#     }
#   }
#   icinga-monitoring-sg = {
#     name        = "icinga-monitoring-sg"
#     description = "Security group for monitoring"
#     vpc_name    = "vpc-GlobalExchange"
#     ingress = {
#       rule_1 = {
#         type        = "All Traffic"
#         protocol    = "All"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["10.255.11.72/32"]
#         description = "EU01ICINGA02"
#       }
#       rule_2 = {
#         type        = "All Traffic"
#         protocol    = "All"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["10.255.4.11/32"]
#         description = "EU01MON01"
#       }
#       rule_3 = {
#         type        = "All Traffic"
#         protocol    = "ICMP"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "GE-SUMMARY-NET"
#       }
#     }
#     egress = {
#       rule_1 = {
#         type        = "Custom TCP"
#         protocol    = "ICMP"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["0.0.0.0/0"]
#         description = "GENERIC-PING"
#       }
#       rule_2 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 5665
#         to_port     = 5667
#         cidr_blocks = ["10.255.4.11/32"]
#         description = "EU01ICINGA01"
#       }
#       rule_3 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 5665
#         to_port     = 5667
#         cidr_blocks = ["10.255.11.72/32"]
#         description = "EU01ICINGA02"
#       }
#       rule_4 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 8243
#         to_port     = 8243
#         cidr_blocks = ["10.255.4.11/32"]
#         description = "EU01ICINGA01"
#       }
#       rule_5 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 8243
#         to_port     = 8243
#         cidr_blocks = ["10.255.11.72/32"]
#         description = "EU01ICINGA02"
#       }
#       rule_6 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 12489
#         to_port     = 12489
#         cidr_blocks = ["10.255.4.11/32"]
#         description = "EU01ICINGA01"
#       }
#       rule_7 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 12489
#         to_port     = 12489
#         cidr_blocks = ["10.255.11.72/32"]
#         description = "EU01ICINGA02"
#       }
#     }
#   }
#   example-aplication-sg = {
#     name        = "example-aplication-sg"
#     description = "Security group for example application"
#     vpc_name    = "vpc-GlobalExchange"
#     ingress = {
#       rule_1 = {
#         type        = "All Traffic"
#         protocol    = "All"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["10.0.0.0/16"]
#         description = "ingress-example-aplication-sg"
#       }
#     }
#     egress = {
#       rule_1 = {
#         type        = "Custom TCP or UDP"
#         protocol    = "TCP"
#         from_port   = 8000
#         to_port     = 8999
#         cidr_blocks = ["10.0.0.0/16"]
#         description = "ingress-example-aplication-sg"
#       }
#     }
#   }
#   name-bbdd-sg = {
#     name        = "name-bbdd-sg"
#     description = "Security group for database servers"
#     vpc_name    = "vpc-GlobalExchange"
#     ingress = {
#       rule_1 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["172.16.1.0/24"]
#         description = "subnet-GlobalExchange-front-a"
#       }
#       rule_2 = {
#         type        = "Custom UDP"
#         protocol    = "UDP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["172.16.2.0/24"]
#         description = "subnet-GlobalExchange-front-b"
#       }
#       rule_3 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["172.16.5.0/24"]
#         description = "subnet-GlobalExchange-lb-a"
#       }
#       rule_4 = {
#         type        = "Custom UDP"
#         protocol    = "UDP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["172.16.6.0/24"]
#         description = "subnet-GlobalExchange-lb-a"
#       }
#       rule_5 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["192.168.100.100/32"]
#         description = "motor-replica-1"
#       }
#       rule_6 = {
#         type        = "Custom UDP"
#         protocol    = "UDP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["192.168.100.100/32"]
#         description = "motor-replica-1"
#       }
#     }
#     egress = {
#       rule_1 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["172.16.1.0/24"]
#         description = "subnet-GlobalExchange-front-a"
#       }
#       rule_2 = {
#         type        = "Custom UDP"
#         protocol    = "UDP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["172.16.2.0/24"]
#         description = "subnet-GlobalExchange-front-b"
#       }
#       rule_3 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["172.16.5.0/24"]
#         description = "subnet-GlobalExchange-lb-a"
#       }
#       rule_4 = {
#         type        = "Custom UDP"
#         protocol    = "UDP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["172.16.6.0/24"]
#         description = "subnet-GlobalExchange-lb-a"
#       }
#       rule_5 = {
#         type        = "Custom TCP"
#         protocol    = "TCP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["192.168.100.100/32"]
#         description = "motor-replica-1"
#       }
#       rule_6 = {
#         type        = "Custom UDP"
#         protocol    = "UDP"
#         from_port   = 1433
#         to_port     = 1436
#         cidr_blocks = ["192.168.100.100/32"]
#         description = "motor-replica-1"
#       }
#     }
#   }
# }
# transit_gateway_attachments = {
#   transit-gw-attach-GlobalExchange = {
#     name         = "transit-gw-attach-GlobalExchange"
#     vpc_name     = "vpc-GlobalExchange"
#     subnet_names = ["subnet-GlobalExchange-transit-a", "subnet-GlobalExchange-transit-b"]
#   }
# }
# subnet_route_tables = {
#   subnet-route-table-GlobalExchange-az-a = {
#     name          = "subnet-route-table-GlobalExchange-az-a"
#     vpc_name      = "vpc-GlobalExchange"
#     subnets_names = ["subnet-GlobalExchange-front-a", "subnet-GlobalExchange-bbdd-a", "subnet-GlobalExchange-mgmt-a", "subnet-GlobalExchange-transit-a"]
#     routes = {
#       route-transitGW = {
#         destiny = "0.0.0.0/0"
#         target  = "transit-gw-attach-GlobalExchange"
#       }
#       route-natGW = {
#         destiny = "192.168.0.0/16"
#         target  = "nat-gateway-GlobalExchange-az-a"
#       }
#     }
#   }
#   subnet-route-table-GlobalExchange-az-b = {
#     name          = "subnet-route-table-GlobalExchange-az-b"
#     vpc_name      = "vpc-GlobalExchange"
#     subnets_names = ["subnet-GlobalExchange-front-b", "subnet-GlobalExchange-bbdd-b", "subnet-GlobalExchange-mgmt-b", "subnet-GlobalExchange-transit-b"]
#     routes = {
#       route-transitGW = {
#         destiny = "0.0.0.0/0"
#         target  = "transit-gw-attach-GlobalExchange"
#       }
#       route-natGW = {
#         destiny = "192.168.0.0/16"
#         target  = "nat-gateway-GlobalExchange-az-b"
#       }
#     }
#   }
#   subnet-route-table-GlobalExchange-public = {
#     name          = "subnet-route-table-GlobalExchange-public"
#     vpc_name      = "vpc-GlobalExchange"
#     subnets_names = ["subnet-GlobalExchange-lb-a", "subnet-GlobalExchange-lb-b", ]
#     routes = {
#       route-internet-gw = {
#         destiny = "0.0.0.0/0"
#         target  = "igw-GlobalExchange"
#       }
#       route-eu01 = {
#         destiny = "10.255.9.4/32"
#         target  = "transit-gw-attach-GlobalExchange"
#       }
#     }
#     route-SharedResources = {
#       destiny = "10.255.176.0/21"
#       target  = "transit-gw-attach-GlobalExchange"
#     }
#   }
# }

# transit_gateways = {
#   tg1 = {
#     name            = "tg1"
#     description     = "Primary Transit Gateway"
#     amazon_side_asn = 64512
#     tags = {
#       test = "Primary-TGW"
#     }
#   },

#   tg2 = {
#     name            = "tg2"
#     description     = "Secondary Transit Gateway"
#     amazon_side_asn = 64513
#     tags = {
#       test = "Secondary-TGW"
#     }
#   }
# }


# transit_gateway_route_tables = {
#   tg-rt-1 = {
#     name                 = "tg-rt-1"
#     transit_gateway_name = "tg1"
#     tags                 = { Team = "network" }
#   }
#   tg-rt-2 = {
#     name                 = "tg-rt-2"
#     transit_gateway_name = "tg2"
#     tags                 = { Team = "development" }
#   }
# }
