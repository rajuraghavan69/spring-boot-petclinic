variable resource_group_name {
  type        = string
  description = "Resource group name"
  default     = "mqk-rg"
}

variable location {
  type        = string
  description = "Azure location where the infrastructure will be provisioned"
  default     = "eastus"
}
