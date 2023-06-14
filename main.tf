resource "azuread_group" "admins" {
  display_name = "${var.prefix}-admins"
  security_enabled = true

}

module "aks_cluster_name" {
  source  = "Azure/aks/azurerm"
  version = "6.8.0"

  prefix = var.prefix

  resource_group_name  = var.resource_group
  admin_username       = null
  azure_policy_enabled = true

  identity_type                   = "SystemAssigned"
  log_analytics_workspace_enabled = false

  maintenance_window = {
    allowed = [
      {
        day   = "Sunday",
        hours = [22, 23]
      },
    ]
    not_allowed = []
  }
  # net_profile_pod_cidr              = "10.1.0.0/16"
  private_cluster_enabled           = false
  rbac_aad_managed                  = true
  rbac_aad_azure_rbac_enabled       = true
  role_based_access_control_enabled = true
  public_network_access_enabled     = false

  rbac_aad_admin_group_object_ids = [
    azuread_group.admins.object_id
  ]

  kubernetes_version        = var.kubernetes_version # don't specify the patch version!
  automatic_channel_upgrade = "patch"
  agents_availability_zones = ["1", "2", "3"]
  #agents_count              = null
  agents_max_count = var.agent_max
  agents_max_pods  = 100
  agents_min_count = 1
  agents_pool_name = "system"
  agents_type      = "VirtualMachineScaleSets"
  # client_id                               = var.client_id
  # client_secret                           = var.client_secret
  enable_auto_scaling = true
  # enable_host_encryption                = true
  http_application_routing_enabled      = var.http_application_routing_enabled
  ingress_application_gateway_enabled   = var.ingress_application_gateway_enabled
  ingress_application_gateway_name      = "${var.prefix}-agw"
  ingress_application_gateway_subnet_id = var.subnet_id_ag
  local_account_disabled                = true

  net_profile_dns_service_ip = "10.0.0.10"
  net_profile_service_cidr   = "10.0.0.0/16"
  network_plugin             = "azure"
  network_policy             = "azure"
  os_disk_size_gb            = 60
  sku_tier                   = var.sku_tier
  vnet_subnet_id             = var.subnet_id

  agents_size = var.agent_size
  agents_tags = var.tags
}


resource "azurerm_role_assignment" "aks_subnet" {
  scope                = var.subnet_id
  role_definition_name = "Network Contributor"
  principal_id = module.aks_cluster_name.cluster_identity.principal_id
  # principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

# resource "azurerm_role_assignment" "aks_acr" {
#   scope                = var.container_registry_id
#   role_definition_name = "AcrPull"
#   principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
# }
