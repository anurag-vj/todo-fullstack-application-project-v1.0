module "resource_group" {
  source = "../modules/azurerm_resource_group"

  resource_group_name = "${local.name_pattern}-rg"
  location            = local.location
}
