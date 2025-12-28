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

provider "proxmox" {
  pm_api_url          = var.PROXMOX_URL
  pm_api_token_id     = var.PROXMOX_TOKEN_ID
  pm_api_token_secret = var.PROXMOX_TOKEN_SECRET
  pm_tls_insecure     = true
}
