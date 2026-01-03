# https://registry.terraform.io/providers/bpg/proxmox/latest/docs
# https://github.com/bpg/terraform-provider-proxmox
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.91.0"
    }
  }
}

provider "proxmox" {
  endpoint            = var.PROXMOX_ENDPOINT
  # api_token           = "${var.PROXMOX_USERNAME}!${var.PROXMOX_TOKEN_ID}=${var.PROXMOX_TOKEN_SECRET}"
  insecure            = true
  username = "PROXMOX_USERNAME"
  password = "PROXMOX_PASSWORD"

  # ssh {
  #   # agent = true
  # }

  random_vm_ids       = true
  random_vm_id_start  = 8000 
  random_vm_id_end    = 8099
}
