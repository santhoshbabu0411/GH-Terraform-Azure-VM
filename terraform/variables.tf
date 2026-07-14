variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.environment)
    error_message = "Environment must be dev, stage, or prod."
  }
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "Central India"
}

variable "project_name" {
  description = "Project name."
  type        = string
  default     = "github-tf"
}

variable "address_space" {
  description = "VNet address range."
  type        = list(string)
}

variable "subnet_prefix" {
  description = "Subnet address range."
  type        = list(string)
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
}

variable "admin_username" {
  description = "VM administrator username."
  type        = string
  default     = "azureadmin"
}

variable "admin_ssh_public_key" {
  description = "SSH public key."
  type        = string
  sensitive   = true
}