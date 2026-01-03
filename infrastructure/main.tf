module "vm_template" {
  source            = "./modules/vm-template"
  PROXMOX_NODE_NAME = var.PROXMOX_NODE_NAME
  VM_NAME           = "DebianTemplate"
}

module "mission_critical_vm" {
  source         = "./modules/vm-clone"
  PROXMOX_NODE_NAME = var.PROXMOX_NODE_NAME
  VM_TEMPLATE_ID = module.vm_template.VM_ID
  VM_NAME        = "MissionCritical"
}

# module "data_critical_vm" {
#   source         = "./modules/cloned-vm"
#   PROXMOX_NODE_NAME = var.PROXMOX_NODE_NAME
#   VM_NAME        = "DataCritical"
#   VM_ID          = 8102
# }
 
# module "common_vm" {
#   source         = "./modules/cloned-vm"
#   PROXMOX_NODE_NAME = var.PROXMOX_NODE_NAME
#   VM_NAME        = "Common"
#   VM_ID          = 8103
# }

