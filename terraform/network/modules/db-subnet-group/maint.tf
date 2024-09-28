resource "aws_db_subnet_group" "db_subnet_group" {
  name = var.name_prefix != null ? lower(replace("${var.name_prefix}-db-subnet-group", " ", "-")) : "default-db-subnet-group"

  subnet_ids = local.filtered_subnet_ids

  tags = merge(
    var.tags,
    {
      Name = var.name_prefix != null ? lower(replace("${var.name_prefix}-db-subnet-group", " ", "-")) : "default-db-subnet-group"
    }
  )
}
