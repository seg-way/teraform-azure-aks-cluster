
resource "azurerm_user_assigned_identity" "cluster" {
  location            = var.location
  name                = "${var.cluster_name}-identity"
  resource_group_name = var.resource_group
}


resource "azurerm_role_assignment" "aks_subnet" {
  scope                = var.subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.cluster.principal_id
}

resource "azurerm_role_assignment" "acrpull" {
  principal_id                     = azurerm_user_assigned_identity.cluster.principal_id
  role_definition_name             = "AcrPull"
  scope                            = var.registry_id
  skip_service_principal_aad_check = true
}

module "aks_cluster_name" {
  source  = "Azure/aks/azurerm"
  version = "7.2.0"

  prefix               = var.prefix
  resource_group_name  = var.resource_group
  admin_username       = null
  azure_policy_enabled = true

  log_analytics_workspace_enabled = false

  kubernetes_version        = var.kubernetes_version # don't specify the patch version!
  automatic_channel_upgrade = "patch"

  cluster_name = var.cluster_name

  public_network_access_enabled = true

  identity_ids  = [azurerm_user_assigned_identity.cluster.id]
  identity_type = "UserAssigned"

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
  rbac_aad                          = true
  rbac_aad_managed                  = true
  role_based_access_control_enabled = true


  rbac_aad_admin_group_object_ids = [
    var.admins_group_id
  ]

  depends_on = [
    azurerm_role_assignment.aks_subnet
  ]

  agents_availability_zones = ["1", "2", "3"]

  agents_max_count = var.agent_max
  agents_max_pods  = 100
  agents_min_count = 1
  agents_pool_name = "system"
  agents_type      = "VirtualMachineScaleSets"

  enable_auto_scaling = true
  # # enable_host_encryption                = true
  http_application_routing_enabled      = var.http_application_routing_enabled
  ingress_application_gateway_enabled   = var.ingress_application_gateway_enabled
  ingress_application_gateway_name      = "${var.prefix}-agw"
  ingress_application_gateway_subnet_id = var.subnet_id_ag
  local_account_disabled                = false
  workload_identity_enabled             = var.workload_identity_enabled
  oidc_issuer_enabled                   = var.workload_identity_enabled
  # net_profile_dns_service_ip            = "10.0.0.10"
  # net_profile_service_cidr              = "10.0.0.0/16"
  network_plugin  = "azure"
  network_policy  = "azure"
  os_disk_size_gb = 30
  sku_tier        = var.sku_tier

  agents_size = var.agent_size
  agents_tags = var.tags

  vnet_subnet_id = var.vnet_subnet_id
}


resource "azurerm_eventhub_namespace_authorization_rule" "main" {
  name                = var.prefix
  namespace_name      = var.eventhub_namespace
  resource_group_name = var.eventhub_resource_group

  listen = false
  send   = true
  manage = false
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  name               = "eventhub"
  target_resource_id = module.aks_cluster_name.aks_id

  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = azurerm_eventhub_namespace_authorization_rule.main.id

  enabled_log {
    category = "cloud-controller-manager"
  }
  enabled_log {
    category = "cluster-autoscaler"
  }
  enabled_log {
    category = "guard"
  }
  enabled_log {
    category = "kube-apiserver"
  }
  enabled_log {
    category = "kube-audit"
  }
  enabled_log {
    category = "kube-audit-admin"
  }
  enabled_log {
    category = "kube-controller-manager"
  }
  enabled_log {
    category = "kube-scheduler"
  }

}
