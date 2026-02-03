resource "azurerm_mssql_database" "mssql_database" {
  name      = var.mssql_database_name
  server_id = var.server_id

  tags = var.tags
}
