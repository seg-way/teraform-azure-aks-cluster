
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


resource "azuread_group_member" "managers" {
  for_each = toset(var.admins_group_ids)
  group_object_id  = each.key
  member_object_id = azuread_service_principal.automation.object_id
}


resource "azurerm_role_assignment" "automation_admin" {
  scope                = module.aks_cluster_name.aks_id
  role_definition_name = "Azure Kubernetes Service RBAC Admin"
  principal_id         = azuread_service_principal.automation.object_id
}