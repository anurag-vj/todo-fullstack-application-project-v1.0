module "resource_group" {
  source = "../modules/azurerm_resource_group"

  resource_group_name = "${local.name_pattern}-rg"
  location            = local.location

  tags = local.common_tags
}

module "virtual_network" {
  source = "../modules/azurerm_virtual_network"

  virtual_network_name = "${local.name_pattern}-vnet"
  location             = local.location
  resource_group_name  = module.resource_group.resource_group_ids.name
  address_space        = var.address_space

  tags = local.common_tags
}

module "subnet" {
  source = "../modules/azurerm_subnet"

  for_each = var.subnets

  subnet_name          = replace(each.value.name, "$${local.name_pattern}", local.name_pattern)
  virtual_network_name = module.virtual_network.virtual_network_ids.name
  resource_group_name  = module.resource_group.resource_group_ids.name
  address_prefixes     = each.value.address_prefixes
}
