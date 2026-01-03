resource "proxmox_virtual_environment_vm" "this" {
  name      = var.VM_NAME
  node_name = var.PROXMOX_NODE_NAME

  on_boot = true
  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true

  template = true

  initialization {
    # uncomment and specify the datastore for cloud-init disk if default `local-lvm` is not available
    # datastore_id = "local-lvm"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = "user"
      password = "test"
    }
  }

  disk {
    datastore_id = "local-lvm"
    import_from  = proxmox_virtual_environment_download_file.debian_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 4
  }

  network_device {
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [initialization["user_account"], ]
  }
}

resource "proxmox_virtual_environment_download_file" "debian_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = var.PROXMOX_NODE_NAME
  url          = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.qcow2"
  # need the file to be *.qcow2 to indicate the actual file format for import
  file_name    = "debian-13-generic-amd64.qcow2"
}