output "subnet_nsg_ids" {
  value = azurerm_subnet_network_security_group_association.subnet-nsg.id
}
