# https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
# https://github.com/Telmate/terraform-provider-proxmox
terraform {
  required_version = ">= 0.13.0"
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc04" # Needed for PVE 9
    }
  }
}
