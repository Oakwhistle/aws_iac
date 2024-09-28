# Based on https://github.com/unfor19/terraform-multienv/blob/dev/live/backend.tf.tpl
terraform {
  backend "s3" {
    region         = "eu-central-1"
    bucket         = "devops-STRING_DATA-terraform-state-bucket"
    dynamodb_table = "ACCOUNT_ID-terraform-state-lock-INFRA_TYPE-PROJECT-AWS_DEFAULT_REGION"
    encrypt        = true
    key            = "ACCOUNT_ID/terraform-aws-INFRA_TYPE-PROJECT-AWS_DEFAULT_REGION.tfstate"
  }
}