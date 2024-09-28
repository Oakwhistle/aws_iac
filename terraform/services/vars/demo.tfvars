account_id  = "090876143603"
business    = "OCLOUD"
environment = "devel"
region      = "eu-central-1"
accountable = "oakroot"
project     = "Automation"
service     = "<service-name>"

# vpc_name = "PRO-DEPLOYMENT-VPC"

# security_groups = {
#   test= {
#     name        = "test"
#     description = "Security group for example application"
#     ingress = {
#       rule_1 = {
#         type        = "All Traffic"
#         protocol    = "All"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["10.255.244.0/22"]
#         description = "ingress-example-aplication-sg"
#       }
#       rule_2 = {
#         type        = "All Traffic"
#         protocol    = "All"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["0.0.0.0/0"]
#         description = "test-internet"
#       }

#     }
#     egress = {
#       rule_1 = {
#         type        = "All Traffic"
#         protocol    = "All"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["10.255.244.0/22"]
#         description = "ingress-example-aplication-sg"
#       }
#       rule_2 = {
#         type        = "All Traffic"
#         protocol    = "All"
#         from_port   = 0
#         to_port     = 0
#         cidr_blocks = ["0.0.0.0/0"]
#         description = "test-internet"
#       }

#     }
#   }
# }

# inbound_resolvers = {
#   inbound-resolver-1 = {
#     name                 = "inbound-resolver-1"
#     security_group_names = ["BCK-SG", "REMOTE-ACCESS-SG", "test" ]
#     ip_addresses = {
#       ip_1 = {
#         subnet_name = "BCK-A"
#         ip_address  = "10.255.244.200"
#       }
#       ip_2 = {
#         subnet_name = "BCK-B"
#         ip_address  = "10.255.244.230"
#       }
#     }
#     tags = {
#       test = "test"
#     }
#   }
# }

# # outbound_resolvers = {
# #   outbound-resolver-1 = {
# #     name                 = "outbound-resolver-1"
# #     security_group_names = ["BCK-SG", "REMOTE-ACCESS-SG"]
# #     ip_addresses = {
# #       ip_1 = {
# #         subnet_name = "BCK-A"
# #         ip_address  = "10.255.244.201"
# #       }
# #       ip_2 = {
# #         subnet_name = "BCK-B"
# #         ip_address  = "10.255.244.231"
# #       }
# #     }
# #     routes = {
# #       route-globex-local = {
# #         domain_name     = "globex.local"
# #         destination_ips = {
# #           ip_1 = "203.0.113.5"
# #           ip_2 = "198.51.100.5"
# #         }
# #         tags            = {
# #           test = "test"
# #         }
# #       }
# #       route-testglobex-local = {
# #         domain_name     = "testglobex.local"
# #         destination_ips = {
# #           ip_1 = "203.0.113.6"
# #           ip_2 = "198.51.100.6"
# #         }
# #         tags            = {
# #           test = "test"
# #         }
# #       }
# #     }
# #     tags = {
# #       test = "test"
# #     }
# #   }
# #   outbound-resolver-2 = {
# #     name                 = "outbound-resolver-2"
# #     security_group_names = ["BCK-SG", "REMOTE-ACCESS-SG"]
# #     ip_addresses = {
# #       ip_1 = {
# #         subnet_name = "BCK-A"
# #         ip_address  = "10.255.244.202"
# #       }
# #       ip_2 = {
# #         subnet_name = "BCK-B"
# #         ip_address  = "10.255.244.232"
# #       }
# #     }
# #     routes = {
# #       route-monex-local = {
# #         domain_name     = "monex.local"
# #         destination_ips = {
# #           ip_1 = "203.0.125.5"
# #           ip_2 = "198.51.180.5"
# #         }
# #         tags            = {
# #           test = "test"
# #         }
# #       }
# #       route-testmonex-local = {
# #         domain_name     = "testmonex.local"
# #         destination_ips = {
# #           ip_1 = "203.0.125.6"
# #           ip_2 = "198.51.180.6"
# #         }
# #         tags            = {
# #           test = "test"
# #         }
# #       }
# #     }
# #     tags = {
# #       test = "test"
# #     }
# #   }
# # }


# ec2_instances = {
#   example-instance-1 = {
#     name                = "example-instance-1"
#     role                = "appserver"
#     ami                 = "linux"
#     instance_type       = "t3.micro"
#     subnet_type         = "BCK"
#     az                  = "A"
#     security_group_name = "example-aplication-sg"
#     schedule            = "example-schedule"
#   }
#   # example-instance-2 = {
#   #   name                = "example-instance-2"
#   #   role                = "webserver"
#   #   instance_role       = "example-instance-role"
#   #   ami                 = "windows"
#   #   instance_type       = "t3.micro"
#   #   subnet_type         = "FRT"
#   #   az                  = "B"
#   #   security_group_name = "example-aplication-sg"
#   #   schedule            = "example-schedule"
#   # }
# }


# rds_instances = {
#   mydb = {
#     name                                  = "mydb"
#     allocated_storage                     = 20
#     max_allocated_storage                 = 100
#     instance_class                        = "db.t3.micro"
#     engine_version                        = "16.2"
#     db_name                               = "mydatabase"
#     username                              = "masteruser"
#     publicly_accessible                   = false
#     skip_final_snapshot                   = true
#     performance_insights_enabled          = true
#     storage_encrypted                     = true
#     allow_major_version_upgrade           = false
#     auto_minor_version_upgrade            = true
#     deletion_protection                   = false
#     tags                                  = { Environment = "Production" }
#   }
# }