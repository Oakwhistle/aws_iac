output "rds_instance_identifiers" {
  description = "Identifiers of the RDS instances"
  value = {
    for instance in aws_db_instance.rds_instance:
    "db_identifier" => instance.identifier
  }
}

output "rds_instance_usernames" {
  description = "Usernames for the RDS instances"
  value = {
    for instance in aws_db_instance.rds_instance:
    "db_user" => instance.username
  }
}

output "db_password_parameters" {
  description = "SSM parameters where DB passwords are stored"
  value = {
    for param in aws_ssm_parameter.db_password:
    "db_password" => param.name
  }
}