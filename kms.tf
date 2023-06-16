resource "azurerm_key_vault_key" "kms" {
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
  name            = "etcdenc"
  expiration_date = timeadd("${formatdate("YYYY-MM-DD", timestamp())}T00:00:00Z", "168h")
  key_size        = 2048


  lifecycle {
    ignore_changes = [expiration_date]
  }
}

resource "azurerm_role_assignment" "kms_seu" {
  scope                            = var.vault_id
  role_definition_name             = "Key Vault Crypto Officer"
  principal_id                     = azurerm_user_assigned_identity.cluster.principal_id
}
