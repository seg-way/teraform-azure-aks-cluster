output "name" {
  value = module.aks_cluster_name.aks_name
}
output "admin_host" {
  value     = module.aks_cluster_name.admin_host
  sensitive = true
}
output "admin_client_certificate" {
  value     = module.aks_cluster_name.admin_client_certificate
  sensitive = true
}
output "admin_client_key" {
  value     = module.aks_cluster_name.admin_client_key
  sensitive = true
}
output "admin_cluster_ca_certificate" {
  value     = module.aks_cluster_name.admin_cluster_ca_certificate
  sensitive = true
}

output "endpoint" {
  value     = module.aks_cluster_name.admin_host
  sensitive = true

}
output "ca_certificate" {
  value     = module.aks_cluster_name.admin_cluster_ca_certificate
  sensitive = true
}
output "exec_host" {
  value     = module.aks_cluster_name.admin_host
  sensitive = true
}
output "exec_api" {
  value = "client.authentication.k8s.io/v1beta1"
}
output "exec_command" {
  value = "kubelogin"
}
output "exec_args" {
  sensitive = true
  value = [
    "get-token",
    "--login",
    "spn",
    "--environment",
    "AzurePublicCloud",
    "--tenant-id",
    data.azurerm_kubernetes_cluster.automation.azure_active_directory_role_based_access_control[0].tenant_id,
    "--server-id",
    "6dae42f8-4368-4678-94ff-3960e28e3630", #Google says this is a constant I'm not sold
    "--client-id",
    azuread_application.automation.application_id,
    "--client-secret",
    azuread_service_principal_password.automation.value
  ]
}
