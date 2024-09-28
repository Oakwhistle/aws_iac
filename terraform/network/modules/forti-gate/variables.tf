variable "region" {
  default = "eu-west-1"
}

// Availability zone 1 for the region
variable "az1" {
  default = "eu-west-1a"
}

// Availability zone 2 for the region
variable "az2" {
  default = "eu-west-1c"
}

variable "vpccidr" {
  default = "20.1.0.0/16"
}

variable "publiccidraz1" {
  default = "20.1.0.0/24"
}

variable "privatecidraz1" {
  default = "20.1.1.0/24"
}

variable "hasynccidraz1" {
  default = "20.1.2.0/24"
}

variable "hamgmtcidraz1" {
  default = "20.1.3.0/24"
}
variable "transitcidraz1" {
  default = ""
}
variable "publiccidraz2" {
  default = "20.1.10.0/24"
}

variable "privatecidraz2" {
  default = "20.1.11.0/24"
}

variable "hasynccidraz2" {
  default = "20.1.12.0/24"
}
variable "hamgmtcidraz2" {
  default = "20.1.13.0/24"
}
variable "transitcidraz2" {
  default =   ""
}
// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
  default = "payg"
}
// BYOL License format to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either token or file.
variable "license_format" {
  default = "token"
}
// instance architect
// Either arm or x86
variable "arch" {
  default = "x86"
}
// instance type needs to match the architect
// c5n.xlarge is x86_64
// c6g.xlarge is arm
// For detail, refer to https://aws.amazon.com/ec2/instance-types/
variable "size" {
  default = "c5n.xlarge"
}
// HTTPS access port
variable "adminsport" {
  default = "8443"
}
variable "activeport1" {
  default = "20.1.0.10"
}

variable "activeport1mask" {
  default = "255.255.255.0"
}
variable "activeport2" {
  default = "20.1.1.10"
}
variable "activeport2mask" {
  default = "255.255.255.0"
}
variable "activeport3" {
  default = "20.1.2.10"
}
variable "activeport3mask" {
  default = "255.255.255.0"
}

variable "activeport4" {
  default = "20.1.3.10"
}

variable "activeport4mask" {
  default = "255.255.255.0"
}

variable "passiveport1" {
  default = "20.1.10.10"
}

variable "passiveport1mask" {
  default = "255.255.255.0"
}

variable "passiveport2" {
  default = "20.1.11.10"
}

variable "passiveport2mask" {
  default = "255.255.255.0"
}

variable "passiveport3" {
  default = "20.1.12.10"
}

variable "passiveport3mask" {
  default = "255.255.255.0"
}

variable "passiveport4" {
  default = "20.1.13.10"
}

variable "passiveport4mask" {
  default = "255.255.255.0"
}

variable "activeport1gateway" {
  default = "20.1.0.1"
}

variable "activeport2gateway" {
  default = "20.1.1.1"
}

variable "activeport4gateway" {
  default = "20.1.3.1"
}

variable "passiveport1gateway" {
  default = "20.1.10.1"
}

variable "passiveport2gateway" {
  default = "20.1.11.1"
}

variable "passiveport4gateway" {
  default = "20.1.13.1"
}


variable "bootstrap-active" {
  // Change to your own path
  type    = string
  default = "config-active.conf"
}

variable "bootstrap-passive" {
  // Change to your own path
  type    = string
  default = "config-passive.conf"
}

// license file for the active fgt
variable "license" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license.lic"
}

// license file for the passive fgt
variable "license2" {
  // Change to your own byol license file, license2.lic
  type    = string
  default = "license2.lic"
}

variable "name_prefix" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "keypair_name" {
  type    = string
  default = null
}
variable "environment" {
  type = string
}