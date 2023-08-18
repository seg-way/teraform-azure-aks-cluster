
resource "azuread_application" "automation" {
  display_name = "${var.cluster_name}-automation"
}

resource "azuread_service_principal" "automation" {
  application_id               = azuread_application.automation.application_id
  app_role_assignment_required = true
  feature_tags {
    hide = true
  }
}

resource "azuread_service_principal_password" "automation" {
  service_principal_id = azuread_service_principal.automation.object_id
}

data "azurerm_kubernetes_cluster" "automation" {
  name                = module.aks_cluster_name.aks_name
  resource_group_name = var.resource_group
  depends_on          = [module.aks_cluster_name.aks_name]
}


resource "azurerm_role_assignment" "automation_admin" {
  scope                = module.aks_cluster_name.aks_id
  role_definition_name = "Azure Kubernetes Service RBAC Admin"
  principal_id         = azuread_service_principal.automation.object_id
}
resource "azurerm_role_assignment" "admins" {
  for_each = toset(var.admins_group_ids)
  scope                = module.aks_cluster_name.aks_id
  role_definition_name = "Azure Kubernetes Service RBAC Admin"
  principal_id         = each.key
}