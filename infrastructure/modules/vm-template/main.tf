resource "proxmox_virtual_environment_vm" "this" {
  name      = "debian-template"
  node_name = var.virtual_environment_node_name

  template = true
  started  = false

  machine     = "q35"
  bios        = "ovmf"
  description = "Debian 13 template. Managed by Terraform."

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
  }

  efi_disk {
    datastore_id = var.datastore_id
    type         = "4m"
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = proxmox_virtual_environment_download_file.debian_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 4
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  network_device {
    bridge = "vmbr0"
  }

}

resource "proxmox_virtual_environment_download_file" "debian_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = var.virtual_environment_node_name
  url          = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.qcow2"
  # need the file to be *.qcow2 to indicate the actual file format for import
  file_name = "debian-13-generic-amd64.qcow2"
}