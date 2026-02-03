module "resource_group" {
  source = "../modules/azurerm_resource_group"

  resource_group_name = "${local.name_prefix}-rg"
  location            = local.location

  tags = local.common_tags
}

module "virtual_network" {
  source = "../modules/azurerm_virtual_network"

  virtual_network_name = "${local.name_prefix}-vnet"
  location             = local.location
  resource_group_name  = module.resource_group.resource_group_ids.name
  address_space        = var.address_space

  tags = local.common_tags
}

module "subnet" {
  source = "../modules/azurerm_subnet"

  for_each = var.subnets

  subnet_name          = replace(each.value.name, "$${local.name_prefix}", local.name_prefix)
  virtual_network_name = module.virtual_network.virtual_network_ids.name
  resource_group_name  = module.resource_group.resource_group_ids.name
  address_prefixes     = each.value.address_prefixes
}

module "network_security_group" {
  source = "../modules/azurerm_network_security"

  for_each = var.network_security_group

  network_security_group_name = replace(each.value.name, "$${local.name_prefix}", local.name_prefix)
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

  tags = local.common_tags
}

module "subnet_nsg" {
  source = "../modules/azurerm_subnet_nsg_association"

  for_each = var.subnet_nsg

  subnet_id                 = module.subnet[each.value.subnet_key].subnet_ids.id
  network_security_group_id = module.network_security_group[each.value.nsg_key].network_security_group_ids.id
}

module "public_ip" {
  source = "../modules/azurerm_public_ip"

  for_each = var.public_ip

  public_ip_name      = replace(each.value.name, "$${local.name_prefix}", local.name_prefix)
  location            = local.location
  resource_group_name = module.resource_group.resource_group_ids.name
  allocation_method   = each.value.allocation_method

  tags = local.common_tags
}

module "network_interface" {
  source = "../modules/azurerm_network_interface"

  for_each = var.network_interface

  network_interface_name        = replace(each.value.name, "$${local.name_prefix}", local.name_prefix)
  location                      = local.location
  resource_group_name           = module.resource_group.resource_group_ids.name
  subnet_id                     = module.subnet[each.value.subnet_key].subnet_ids.id
  private_ip_address_allocation = each.value.public_ip_address_allocation
  public_ip_address_id          = each.value.public_ip_address ? module.public_ip[each.value.public_ip_key].public_ip_ids.id : null

  tags = local.common_tags
}

module "linux_virtual_machine" {
  source = "../modules/azurerm_linux_virtual_machine"

  for_each = var.linux_virtual_machine

  virtual_machine_name  = replace(each.value.name, "$${local.name_prefix}", local.name_prefix)
  location              = local.location
  resource_group_name   = module.resource_group.resource_group_ids.name
  size                  = each.value.size
  admin_username        = data.azurerm_key_vault_secret.username.value
  admin_password        = data.azurerm_key_vault_secret.password.value
  network_interface_ids = [module.network_interface[each.value.network_interface_key].network_interface_ids.id]

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = each.value.offer
    sku       = each.value.sku
    version   = "latest"
  }

  tags = local.common_tags
}

module "mssql_server" {
  source = "../modules/azurerm_mssql_server"

  mssql_server_name            = "${local.name_prefix}-mssql-server"
  location                     = local.location
  resource_group_name          = module.resource_group.resource_group_ids.name
  mssql_server_version         = var.mssql_server_version
  administrator_login          = data.azurerm_key_vault_secret.username.value
  administrator_login_password = data.azurerm_key_vault_secret.password.value

  tags = local.common_tags
}
