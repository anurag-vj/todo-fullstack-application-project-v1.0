output "virtual_network_ids" {
  value = {
    name          = azurerm_virtual_network.virtual_network.name
    location      = azurerm_virtual_network.virtual_network.location
    address_space = azurerm_virtual_network.virtual_network.address_space
    id            = azurerm_virtual_network.virtual_network.id
  }
}
