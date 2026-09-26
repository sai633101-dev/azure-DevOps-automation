variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group for infra"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "hostpool_name" {
  description = "Name of the AVD Host Pool"
  type        = string
}

variable "workspace_name" {
  description = "Name of the AVD Workspace"
  type        = string
}

variable "application_group_name" {
  description = "Name of the AVD Application Group"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B2s"
}

variable "vm_names" {
  description = "List of VM names for scaling"
  type        = list(string)
  default     = []
}
