output "resourcve_group_ids" {
  value = module.resource_group.resource_group_ids
}

output "virtual_network_ids" {
  value = module.virtual_network.virtual_network_ids
}

output "subnet_ids" {
  value = {
    for key, module in module.subnet : key => module.subnet_ids
  }
}

output "network_security_group_ids" {
  value = {
    for key, module in module.network_security_group : key => module.network_security_group_ids
  }
}

output "subnet_nsg_ids" {
  value = {
    for key, module in module.subnet_nsg : key => module.subnet_nsg_ids
  }
}

output "pubic_ip_ids" {
  value = {
    for key, module in module.public_ip : key => module.public_ip_ids
  }
}

output "network_interface_ids" {
  value = {
    for key, module in module.network_interface : key => module.network_interface_ids
  }
}
