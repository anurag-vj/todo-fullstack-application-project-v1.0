output "network_interface_ids" {
  value = {
    name = azurerm_network_interface.network_interface.name
    id   = azurerm_network_interface.network_interface.id
  }
}
