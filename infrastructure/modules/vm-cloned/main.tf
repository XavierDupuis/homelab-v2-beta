resource "proxmox_virtual_environment_cloned_vm" "ubuntu_clone" {
  node_name = var.PROXMOX_NODE_NAME
  name      = var.VM_NAME

  clone = {
    source_vm_id = var.VM_TEMPLATE_ID
    full         = true
  }

  # Only explicitly listed devices are managed
  # Network device inherited from template is preserved but not managed
  # To manage it, explicitly list it here:
  network = {
    net0 = {
      bridge = "vmbr0"
      model  = "virtio"
    }
  }

  # Memory configuration using new terminology
  memory = {
    size    = 2048  # Total memory available to VM
    balloon = 512   # Minimum guaranteed memory via balloon device
  }

  cpu = {
    cores = 2
  }
}

output "vm_id" {
  value = proxmox_virtual_environment_cloned_vm.ubuntu_clone.id
}