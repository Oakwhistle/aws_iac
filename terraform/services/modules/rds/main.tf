resource "aws_db_instance" "rds_instance" {
  for_each = var.rds_instances

  allocated_storage                     = each.value.allocated_storage != null ? each.value.allocated_storage : 50
  max_allocated_storage                 = each.value.max_allocated_storage != null ? each.value.max_allocated_storage : 100
  identifier                            = lower("${var.name_prefix}${each.value.name}")
  storage_type                          = each.value.storage_type != null ? each.value.storage_type : "gp3"
  engine                                = each.value.engine != null ? each.value.engine : "postgres"
  engine_version                        = each.value.engine_version
  instance_class                        = each.value.instance_class
  db_name                               = each.value.db_name != null ? each.value.db_name : null
  username                              = each.value.username != null ? each.value.username : "db_admin"
  password                              = random_password.db_password.result
  publicly_accessible                   = each.value.publicly_accessible != null ? each.value.publicly_accessible : false
  skip_final_snapshot                   = each.value.skip_final_snapshot != null ? each.value.skip_final_snapshot : true
  performance_insights_retention_period = each.value.performance_insights_retention_period != null ? each.value.performance_insights_retention_period : 7
  performance_insights_enabled          = each.value.performance_insights_enabled != null ? each.value.performance_insights_enabled : false
  storage_encrypted                     = each.value.storage_encrypted != null ? each.value.storage_encrypted : true
vpc_security_group_ids = compact(concat(
  [lookup(var.security_groups, format("%s-BCK-SG", var.name_prefix), null)],  // Envolverlo en una lista
  each.value.security_group_names != null ? flatten([for sg_name in each.value.security_group_names : [for k, v in var.security_groups : v if can(regex(sg_name, k))]]) : []
))
  db_subnet_group_name        = local.existing_db_subnet_group
  allow_major_version_upgrade = each.value.allow_major_version_upgrade != null ? each.value.allow_major_version_upgrade : false
  auto_minor_version_upgrade  = each.value.auto_minor_version_upgrade != null ? each.value.auto_minor_version_upgrade : false
  deletion_protection         = each.value.deletion_protection != null ? each.value.deletion_protection : false
  tags = merge(var.tags, each.value.tags, {
    Name = "${var.name_prefix}${each.value.name}",
    Role = "db"
  })
  lifecycle {
    ignore_changes = [
      storage_type,
      password
    ]
  }
}

resource "random_password" "db_password" {
  length  = 16
  lower   = true
  upper   = true
  special = true
}

resource "aws_ssm_parameter" "db_password" {
  for_each = var.rds_instances
  name     = "/${var.environment}/DB/${each.value.name}"
  type     = "SecureString"
  value    = random_password.db_password.result
  # Optionally set additional attributes for parameter store
  # like "allowed_pattern", "description", "tier", "tags", etc.
  depends_on = [random_password.db_password]
}
