variable "prefix" {
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
  type = number
  description = "(optional) describe your variable"
}

variable "kubernetes_version" {
  type = string
  default = "1.27"
  description = "(optional) describe your variable"
}
variable "ingress_application_gateway_enabled" {
  type = bool
  default = false
  description = "(optional) describe your variable"
}
variable "http_application_routing_enabled" {
  type = bool
  default = false
  description = "(optional) describe your variable"
}
variable "sku_tier" {
  type = string
  default = "Free"
  description = "(optional) describe your variable"
}