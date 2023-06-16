resource "azurerm_key_vault_key" "des_key" {
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  key_type        = "RSA"
  key_vault_id    = var.vault_id
  name            = "disk"
  expiration_date = timeadd("${formatdate("YYYY-MM-DD", timestamp())}T00:00:00Z", "168h")
  key_size        = 2048

  lifecycle {
    ignore_changes = [expiration_date]
  }
}

resource "azurerm_disk_encryption_set" "des" {
  key_vault_key_id    = azurerm_key_vault_key.des_key.id
  location            = var.location
  name                = "des"
  resource_group_name = var.resource_group

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "des_seu" {
  scope                            = var.vault_id
  role_definition_name             = "Key Vault Crypto Service Encryption User"
  principal_id                     = azurerm_disk_encryption_set.des.identity[0].principal_id
}
