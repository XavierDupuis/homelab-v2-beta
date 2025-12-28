module "mission_critical_vm" {
  source         = "./modules/vm"
  VM_NAME        = "MissionCritical"
  VM_ID          = 8101
}

module "data_critical_vm" {
  source         = "./modules/vm"
  VM_NAME        = "DataCritical"
  VM_ID          = 8102
}
 
module "common_vm" {
  source         = "./modules/vm"
  VM_NAME        = "Common"
  VM_ID          = 8103
}

provider "proxmox" {
  pm_api_url          = var.PROXMOX_URL
  pm_api_token_id     = var.PROXMOX_TOKEN_ID
  pm_api_token_secret = var.PROXMOX_TOKEN_SECRET
  pm_tls_insecure     = true
}