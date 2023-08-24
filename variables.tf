variable "prefix" {
  type        = string
  default     = "cwd"
  description = "(optional) describe your variable"
}
variable "cluster_name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "resource_group" {
  type        = string
  description = "(optional) describe your variable"
}
variable "location" {
  type        = string
  description = "(optional) describe your variable"
}
variable "tags" {
  type        = map(string)
  description = "(optional) describe your variable"
}
variable "admins_group_ids" {
  type = list(string)
  default = []
  description = "(optional) describe your variable"
}
variable "subnet_id" {
  type        = string
  description = "(optional) describe your variable"
}
variable "subnet_id_ag" {
  type        = string
  description = "(optional) describe your variable"
}

variable "agent_size" {
  type        = string
  description = "(optional) describe your variable"
}
variable "agent_min" {
  type        = number
  default = 1
  description = "(optional) describe your variable"
}
variable "agent_max" {
  type        = number
  default = 10
  description = "(optional) describe your variable"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.27"
  description = "(optional) describe your variable"
}
variable "ingress_application_gateway_enabled" {
  type        = bool
  default     = false
  description = "(optional) describe your variable"
}
variable "http_application_routing_enabled" {
  type        = bool
  default     = false
  description = "(optional) describe your variable"
}
variable "sku_tier" {
  type        = string
  default     = "Free"
  description = "(optional) describe your variable"
}


variable "workload_identity_enabled" {
  type = bool
  default = false
  description = "(optional) describe your variable"
}

variable "private_cluster_enabled" {
  type = bool
  default = false
  description = "(optional) describe your variable"
}
variable "dns_service_ip" {
  type = string
  default = "10.0.0.10"
  description = "(optional) describe your variable"
}

variable "service_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "(optional) describe your variable"
}

variable "rbac_aad_tenant_id" {
  type = string
  default = null
  description = "(optional) describe your variable"
}

variable "environemnt" {
  type = string
  default = "AzurePublicCloud"
  description = "(optional) describe your variable"
}