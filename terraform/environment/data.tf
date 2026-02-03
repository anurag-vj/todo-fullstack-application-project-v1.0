data "azurerm_key_vault" "key_vault" {
  name                = "bootstrapresource-kv"
  resource_group_name = "bootstrapresource-rg"
}

data "azurerm_key_vault_secret" "username" {
  name         = "user-name"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "user-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
