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

