output "mssql_database_ids" {
  value = {
    name = azurerm_mssql_database.mssql_database.name
    id   = azurerm_mssql_database.mssql_database.id
  }
}
