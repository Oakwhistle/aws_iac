terraform {
  required_version = ">= 1.5.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.15.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.1"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.0"
    }
    external = {
      source  = "hashicorp/external"
      version = ">= 2.2.2"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0" # Nota: El proveedor template está descontinuado y sus funcionalidades están integradas en otros proveedores como el de aws.
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.4"
    }
  }
}
provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/buildautomation-iac-iam-role"
    session_name = "deployment_session_${var.service}_${var.environment}"
  }
  region  = var.region
}
