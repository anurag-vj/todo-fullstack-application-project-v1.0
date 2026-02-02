output "subnet_ids" {
  value = {
    name             = azurerm_subnet.subnet.name
    address_prefixes = azurerm_subnet.subnet.address_prefixes
    id               = azurerm_subnet.subnet.id
  }
}
