output "VM_ID" {
  description = "The ID of the created VM template"
  value       = proxmox_virtual_environment_vm.this.id
}