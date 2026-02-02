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
