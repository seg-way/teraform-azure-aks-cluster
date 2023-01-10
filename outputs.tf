output "name" {
    value = module.aks_cluster_name.aks_name
}
output "admin_host" {
    value = module.aks_cluster_name.admin_host
}
output "admin_client_certificate" {
    value = module.aks_cluster_name.admin_client_certificate
}
output "admin_client_key" {
    value = module.aks_cluster_name.admin_client_key
}
output "admin_cluster_ca_certificate" {
    value = module.aks_cluster_name.admin_cluster_ca_certificate
}