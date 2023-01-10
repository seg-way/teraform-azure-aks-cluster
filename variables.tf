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
variable "disk_encryption_set_id" {
  default     = null
  description = "(optional) describe your variable"
}
