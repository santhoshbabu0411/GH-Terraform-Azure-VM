variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_prefix" {
  type = list(string)
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_ssh_public_key" {
  type      = string
  sensitive = true
}