resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.mssql_server_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  version                      = var.mssql_server_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  tags                         = var.tags
}
