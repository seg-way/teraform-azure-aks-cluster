
resource "azuread_application" "automation" {
  display_name               = "${var.cluster_name}-automation"
  
}

resource "azuread_service_principal" "automation" {
  application_id               = azuread_application.automation.application_id
  app_role_assignment_required = true
  feature_tags = {
    hide = true
  }
}

resource "azuread_service_principal_password" "automation" {
  service_principal_id = azuread_service_principal.automation.object_id
}

data "azurerm_kubernetes_cluster" "automation" {
  name                = module.aks_cluster_name.cluster_name
  resource_group_name = var.resource_group
}