output "network_security_group_ids" {
  value = {
    name = azurerm_network_security_group.network_security_group.name
    id   = azurerm_network_security_group.network_security_group.id
  }
}
