output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "vm_name" {
  value = module.azure_vm.vm_name
}

output "public_ip_address" {
  value = module.azure_vm.public_ip_address
}