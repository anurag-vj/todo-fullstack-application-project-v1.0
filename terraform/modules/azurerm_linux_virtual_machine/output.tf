output "virtual_machine_ids" {
  value = {
    name = azurerm_linux_virtual_machine.linux_virtual_machine.name
    id   = azurerm_linux_virtual_machine.linux_virtual_machine.id
  }
}
