output "module_dhcp_option_sets" {
  value = {
    for key, dhcp_option in aws_vpc_dhcp_options.dhcp : key => {
      dhcp_option_id = dhcp_option.id
    }
  }
}
