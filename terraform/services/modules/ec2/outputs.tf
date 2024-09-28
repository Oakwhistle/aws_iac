output "instances" {
  value = {
    for instance in aws_instance.instance :
    instance.tags.Name => instance.id
  }
}
