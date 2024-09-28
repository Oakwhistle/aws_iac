locals { 
  existing_db_subnet_group = lower("${var.name_prefix}-db-subnet-group")
}