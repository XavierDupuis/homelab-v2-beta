# https://registry.terraform.io/providers/bpg/proxmox/latest/docs
# https://github.com/bpg/terraform-provider-proxmox
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    proxmox = {
      source = "bgp/proxmox"
      version = "0.91.0"
    }
  }
}

provider "proxmox" {
  endpoint            = var.PROXMOX_URL
  api_token           = "${var.PROXMOX_TOKEN_ID}=${var.PROXMOX_TOKEN_SECRET}"
  insecure            = true
}
