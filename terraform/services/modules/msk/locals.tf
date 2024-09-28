locals {
  bck_subnets = [
    for subnet_key, subnet_value in var.subnets : subnet_value if can(index(subnet_key, "BCK-"))
  ]
}


# security_group_ids = {
#     AWDPY3P-BCK-SG                      = "sg-0b61619d584eaed0e"
#     AWDPY3P-CIBERSECURITY-SCAN-TOOLS-SG = "sg-0d30870f91e0db30c"
#     AWDPY3P-CIBERSECURITY-TOOLS-SG      = "sg-002b4d9f0e708d0a5"
#     AWDPY3P-IAM-SG                      = "sg-002736d9d8d09c69e"
#     AWDPY3P-INTERNET-SG                 = "sg-00f0f1430259526db"
#     AWDPY3P-REMOTE-ACCESS-SG            = "sg-05541bf023eca4689"
#     AWDPY3P-SHARED-SERVICES-SG          = "sg-0c97a77c864a08668"
# }
# subnet_ids = {
#     BCK-A     = "subnet-0c7fa44f6307f1dc1"
#     BCK-B     = "subnet-020914ff033352a00"
#     BCK-C     = "subnet-0445eac26a3a07946"
#     FRT-A     = "subnet-0e6ce2665bfe27491"
#     FRT-B     = "subnet-0005edfb95f033bba"
#     FRT-C     = "subnet-0b623589a6c2b3f29"
#     LB-A      = "subnet-00fec92decaceb460"
#     LB-B      = "subnet-0144e385c2f3c7a39"
#     LB-C      = "subnet-0b93eee69948908ee"
#     MGMT-A    = "subnet-0d199a1865dfbe4a0"
#     MGMT-B    = "subnet-0d3e62feebfce1863"
#     MGMT-C    = "subnet-08168263654ee4600"
#     TRANSIT-A = "subnet-0f830ff0b7dcdcce6"
#     TRANSIT-B = "subnet-02a06b87991d3bbca"
#     TRANSIT-C = "subnet-092dff72ecdbedfda"
# }