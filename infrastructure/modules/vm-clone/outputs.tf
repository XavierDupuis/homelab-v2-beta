# output "VM_IPV4_ADDRESS" {
#   description   = "The ipv4 address of the cloned VM"
#   value         = flatten(proxmox_virtual_environment_cloned_vm.this.ipv4_addresses[1])
# }

output "VM_ID" {
  description   = "The ID of the cloned VM"
  value         = proxmox_virtual_environment_cloned_vm.this.id
}