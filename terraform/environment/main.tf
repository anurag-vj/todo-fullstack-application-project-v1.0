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
