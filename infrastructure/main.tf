module "vm_template" {
  source            = "./modules/vm-template"
  PROXMOX_NODE_NAME = var.PROXMOX_NODE_NAME
  VM_NAME           = "UbuntuTemplate"
}

module "mission_critical_vm" {
  source         = "./modules/vm-cloned"
  PROXMOX_NODE_NAME = var.PROXMOX_NODE_NAME
  VM_NAME        = "MissionCritical"
#   VM_ID          = 8101
  VM_TEMPLATE_ID = module.vm_template.VM_ID
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

