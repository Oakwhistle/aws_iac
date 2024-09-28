locals {
  # Filtrar los subnet_ids cuyo nombre coincide con el patrón 'BCK-'
  filtered_subnet_ids = [
    for subnet_name, subnet_id in var.subnet_ids :
    subnet_id if length(regexall("BCK-", subnet_name)) > 0
  ]
}