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

module "network_security_group" {
  source = "../modules/azurerm_network_security"

  for_each = var.network_security_group

  network_security_group_name = replace(each.value.name, "$${local.name_pattern}", local.name_pattern)
  location                    = local.location
  resource_group_name         = module.resource_group.resource_group_ids.name
  security_rule = {
    for security_rule in each.value.security_rule :
    "allow-${security_rule}" => {
      name                       = "Allow-${security_rule}"
      priority                   = ceil((security_rule % 9) + 100)
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
