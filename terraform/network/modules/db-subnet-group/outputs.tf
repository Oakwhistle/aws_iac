output "db_subnet_group_name" {
  description = "El nombre del grupo de subredes de la base de datos"
  value       = aws_db_subnet_group.db_subnet_group.name
}

output "db_subnet_group_subnet_ids" {
  description = "Los IDs de las subredes en el grupo de subredes de la base de datos"
  value       = aws_db_subnet_group.db_subnet_group.subnet_ids
}