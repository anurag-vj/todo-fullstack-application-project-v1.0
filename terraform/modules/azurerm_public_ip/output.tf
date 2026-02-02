output "pubic_ip_ids" {
  value = {
    name       = azurerm_public_ip.public_ip.name
    ip_address = azurerm_public_ip.public_ip.ip_address
    id         = azurerm_public_ip.public_ip.id
  }
}
