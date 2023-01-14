resource "azurerm_user_assigned_identity" "aks" {
  location            = var.location
  name                = "${var.prefix}-identity"
  resource_group_name = var.resource_group
}


module "aks_cluster_name" {
  source  = "Azure/aks/azurerm"
  version = "6.5.0"

  prefix                          = var.prefix
  resource_group_name             = var.resource_group
  admin_username                  = null
  azure_policy_enabled            = true
  cluster_name                    = "logscale"
  disk_encryption_set_id          = var.disk_encryption_set_id
  identity_ids                    = [azurerm_user_assigned_identity.aks.id]
  identity_type                   = "UserAssigned"
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
  role_based_access_control_enabled = true




  kubernetes_version        = "1.24" # don't specify the patch version!
  automatic_channel_upgrade = "patch"
  agents_availability_zones = ["1", "2", "3"]
  #agents_count              = null
  agents_max_count = var.agent_size_max
  agents_max_pods  = 100
  agents_min_count = 1
  agents_pool_name = "utilitypool"
  agents_type      = "VirtualMachineScaleSets"
  # client_id                               = var.client_id
  # client_secret                           = var.client_secret
  enable_auto_scaling                   = true
  enable_host_encryption                = true
  http_application_routing_enabled      = true
  ingress_application_gateway_enabled   = true
  ingress_application_gateway_name      = "logscale-agw"
  ingress_application_gateway_subnet_id = var.subnet_id_ag
  # local_account_disabled                = true

  net_profile_dns_service_ip     = "10.0.0.10"
  net_profile_docker_bridge_cidr = "170.10.0.1/16"
  net_profile_service_cidr       = "10.0.0.0/16"
  network_plugin                 = "azure"
  network_policy                 = "azure"
  os_disk_size_gb                = 60
  sku_tier                       = "Paid"
  vnet_subnet_id                 = var.subnet_id

  agents_size = var.agent_size
  agents_tags = var.tags
}


resource "azurerm_kubernetes_cluster_node_pool" "logscale" {
  name                  = "logscale"
  kubernetes_cluster_id = module.aks_cluster_name.aks_id

  enable_host_encryption = true


  vm_size = var.agent_size_logscale

  enable_auto_scaling = true
  node_count          = 1
  # min_count           = 0
  max_count           = var.agent_size_logscale_max

  tags = var.tags
}
