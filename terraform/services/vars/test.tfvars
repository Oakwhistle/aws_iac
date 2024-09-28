account_id  = "992382412713"
business    = "GETD"
environment = "production"
region      = "eu-central-1"
accountable = "sistemas"
project     = "BuildAutomate"
service     = "infra-test"

vpc_name = "PRO-DEPLOYMENT-VPC"

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
# outbound_resolvers = {
#   outbound-resolver-1 = {
#     name                 = "outbound-resolver-1"
#     security_group_names = ["BCK-SG", "REMOTE-ACCESS-SG"]
#     ip_addresses = {
#       ip_1 = {
#         subnet_name = "BCK-A"
#         ip_address  = "10.255.244.201"
#       }
#       ip_2 = {
#         subnet_name = "BCK-B"
#         ip_address  = "10.255.244.231"
#       }
#     }
#     routes = {
#       route-globex-local = {
#         domain_name     = "globex.local"
#         destination_ips = {
#           ip_1 = "203.0.113.5"
#           ip_2 = "198.51.100.5"
#         }
#         tags            = {
#           test = "test"
#         }
#       }
#       route-testglobex-local = {
#         domain_name     = "testglobex.local"
#         destination_ips = {
#           ip_1 = "203.0.113.6"
#           ip_2 = "198.51.100.6"
#         }
#         tags            = {
#           test = "test"
#         }
#       }
#     }
#     tags = {
#       test = "test"
#     }
#   }
#   outbound-resolver-2 = {
#     name                 = "outbound-resolver-2"
#     security_group_names = ["BCK-SG", "REMOTE-ACCESS-SG"]
#     ip_addresses = {
#       ip_1 = {
#         subnet_name = "BCK-A"
#         ip_address  = "10.255.244.202"
#       }
#       ip_2 = {
#         subnet_name = "BCK-B"
#         ip_address  = "10.255.244.232"
#       }
#     }
#     routes = {
#       route-monex-local = {
#         domain_name     = "monex.local"
#         destination_ips = {
#           ip_1 = "203.0.125.5"
#           ip_2 = "198.51.180.5"
#         }
#         tags            = {
#           test = "test"
#         }
#       }
#       route-testmonex-local = {
#         domain_name     = "testmonex.local"
#         destination_ips = {
#           ip_1 = "203.0.125.6"
#           ip_2 = "198.51.180.6"
#         }
#         tags            = {
#           test = "test"
#         }
#       }
#     }
#     tags = {
#       test = "test"
#     }
#   }
# }
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
#   example-instance-2 = {
#     name                = "example-instance-2"
#     role                = "webserver"
#     instance_role       = "example-instance-role"
#     ami                 = "windows"
#     instance_type       = "t3.micro"
#     subnet_type         = "FRT"
#     az                  = "B"
#     security_group_name = "example-aplication-sg"
#     schedule            = "example-schedule"
#   }
# }

# s3 = {
#   bucket-example = {
#     bucket_name = "bucket-example"
#     role        = "storage"
#     versioning  = "Enabled"
#   }
#   bucket-website-example = {
#     bucket_name   = "bucket-website-example"
#     role          = "webserver"
#     versioning    = "Enabled"
#     force_destroy = false
#     website_configuration = {
#       error_document = "error.html"
#       index_document = "index.html"
#     }
#     cors_configuration = {
#       allowed_headers = ["*"]
#       allowed_methods = ["GET", "HEAD", "PUT"]
#       allowed_origins = ["*"]
#       expose_headers  = ["Etag"]
#       max_age_seconds = 3000
#     }

#     bucket_acl = {
#       object_ownership        = "BucketOwnerPreferred"
#       block_public_acls       = true
#       block_public_policy     = false
#       ignore_public_acls      = false
#       restrict_public_buckets = false
#       type_acl                = "public-read"
#     }
#   }
# }

# cloudfront = {
#   cloudfront-bucket-example = {
#     name = "cloudfront-bucket-example"
#     bucket_name = "bucket-example"
#     comment             = "Example distribution with full configuration"
#     default_root_object = "index.html"
#     default_ttl         = 3600
#     max_ttl             = 86400
#     #alternate_domain_names = ["test-terr.global-exchange.com"]
#     #domain = "global-exchange.com"
#     ordered_cache_behaviors = [
#       {
#         path_pattern     = "/images/*"
#         allowed_methods  = ["GET", "HEAD"]
#         cached_methods   = ["GET", "HEAD"]
#         forwarded_values = {
#           query_string = false
#           cookies = {
#             forward = "none"
#           }
#         }
#         min_ttl     = 0
#         default_ttl = 3600
#         max_ttl     = 86400
#       },
#       {
#         path_pattern     = "/api/*"
#         allowed_methods  = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
#         cached_methods   = ["GET", "HEAD"]
#         forwarded_values = {
#           query_string = true
#           cookies = {
#             forward = "all"
#           }
#         }
#         min_ttl     = 0
#         default_ttl = 0
#         max_ttl     = 0
#       }
#     ]
#   },
#   cloudfront-bucket-website-example = {
#     name = "cloudfront-bucket-website-example"
#     bucket_name   = "bucket-website-example"
#     comment             = "Example distribution with minimal configuration"
#     default_root_object = "index.html"
#     default_ttl         = 3600
#     max_ttl             = 86400
#     # alternate_domain_names = ["test-terr.getd.es"]
#     # domain = "getd.es"
#   }
# }


# rds_instances = {
#   exampledb = {
#     name              = "exampledb"
#     allocated_storage = 20 # Valor mínimo de ejemplo
#     instance_class    = "db.t3.micro"
#     engine_version    = "16.2"
#     engine            = "postgres"
#   }
# }


msk-clusters = {
  msk-cluster-1 = {
    name                   = "msk-cluster-1"
    kafka_version          = "3.5.1"
    number_of_broker_nodes = "2"
    instance_type          = "kafka.t3.small"
    ebs_volume_size        = 50
    # subnets = ["FRT-B", "BCK-A", "LB-C"]
    # security_groups = ["IAM-SG", "BCK-SG", "INTERNET-SG"]
    subnets         = "BCK-A,BCK-B"
    security_groups = "IAM-SG,BCK-SG,INTERNET-SG"
    enable_iam_auth = true
  }
}
