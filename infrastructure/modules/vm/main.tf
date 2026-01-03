# resource "proxmox_vm_qemu" "this" {
#   vmid        = var.VM_ID
#   name        = var.VM_NAME
#   target_node = var.PROXMOX_NODE_NAME
#   agent       = 1
#   cpu {
#         cores       = 2
#   }
#   memory      = 1024
#   boot        = "order=scsi0" # has to be the same as the OS disk of the template
#   clone       = "debian13-template" # The name of the template
#   scsihw      = "virtio-scsi-single"
#   vm_state    = "running"
#   automatic_reboot = true

#   # Cloud-Init configuration
# #  cicustom   = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml
#   ciupgrade  = true
#   nameserver = "1.1.1.1 8.8.8.8"
#   ipconfig0  = "ip=192.168.1.10/24,gw=192.168.1.1,ip6=dhcp"
#   skip_ipv6  = true
#   ciuser     = "root"
#   cipassword = "Enter123!"
#   sshkeys    = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/Pjg7YXZ8Yau9heCc4YWxFlzhThnI+IhUx2hLJRxYE Cloud-Init@Terraform"

#   # Most cloud-init images require a serial device for their display
#   serial {
#     id = 0
#   }

#   disks {
#     scsi {
#       scsi0 {
#         # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
#         disk {
#           storage = "local-lvm"
#           # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
#           size    = "4G"
#         }
#       }
#     }
#     ide {
#       # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
#       ide1 {
#         cloudinit {
#           storage = "local-lvm"
#         }
#       }
#     }
#   }

#   network {
#     id = 0
#     bridge = "vmbr0"
#     model  = "virtio"
#   }
# }

resource "proxmox_virtual_environment_vm" "this" {
  name      = var.VM_NAME
  node_name = var.PROXMOX_NODE_NAME

  clone {
    vm_id = 9002
  }

  agent {
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, see cloud-config.tf
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = true
  }

  memory {
    dedicated = 1024
  }

  initialization {
    # dns {
    #   servers = ["1.1.1.1"]
    # }
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }
}
