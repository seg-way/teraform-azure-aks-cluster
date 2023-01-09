# User Assigned Identities 
resource "azurerm_user_assigned_identity" "aid" {
  resource_group_name = var.resource_group
  location            = var.location

  name = "${var.prefix}-azgwidentity"

  tags = var.tags
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group
}

resource "azurerm_role_assignment" "rgreader" {
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.aid.principal_id
}
