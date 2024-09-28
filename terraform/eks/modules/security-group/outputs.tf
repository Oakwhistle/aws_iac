output "security_group_ids" {
  value = {
    for sg in aws_security_group.security_group :
    sg.tags["Name"] => sg.id
    if contains(keys(sg.tags), "Name")
  }
}
