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
variable "admins_group_id" {
  type = string
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
variable "agent_max" {
  type        = number
  description = "(optional) describe your variable"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.26"
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

variable "registry_id" {
  type = string  
  description = "(optional) describe your variable"
}

variable "workload_identity_enabled" {
  type = bool
  default = false
  description = "(optional) describe your variable"
}

variable "eventhub_resource_group" {
  type = string
  description = "(optional) describe your variable"
}
variable "eventhub_namespace" {
  type = string
  description = "(optional) describe your variable"
}
variable "eventhub_name" {
  type = string
  description = "(optional) describe your variable"
}