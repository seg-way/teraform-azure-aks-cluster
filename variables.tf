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

variable "agent_compute_size" {
  type = string
  description = "(optional) describe your variable"
}
variable "agent_compute_min" {
  type = number
  default = 1
  description = "(optional) describe your variable"
}
variable "agent_compute_max" {
  type = number
  description = "(optional) describe your variable"
}
variable "agent_nvme_size" {
  type = string
  description = "(optional) describe your variable"
}
variable "agent_nvme_min" {
  type = number
  default = 1
  description = "(optional) describe your variable"
}
variable "agent_nvme_max" {
  type = number
  description = "(optional) describe your variable"
}
variable "disk_encryption_set_id" {
  default     = null
  description = "(optional) describe your variable"
}
