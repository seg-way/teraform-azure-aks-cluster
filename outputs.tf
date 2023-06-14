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
