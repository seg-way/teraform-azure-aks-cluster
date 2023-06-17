
resource "azurerm_disk_encryption_set" "des" {
  key_vault_key_id    = var.des_vault_key_id
  location            = var.location
  name                = var.prefix
  resource_group_name = var.resource_group

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "des_seu" {
  scope                            = var.des_vault_id
  role_definition_name             = "Key Vault Crypto Service Encryption User"
  principal_id                     = azurerm_disk_encryption_set.des.identity[0].principal_id
}
