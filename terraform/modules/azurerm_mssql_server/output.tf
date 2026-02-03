output "mssql_server_ids" {
  value = {
    name = azurerm_mssql_server.mssql_server.name
    id   = azurerm_mssql_server.mssql_server.id
  }
}
