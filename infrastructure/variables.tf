variable "PROXMOX_ENDPOINT" {
  type = string
}

variable "PROXMOX_NODE_NAME" {
  type = string
}

variable "PROXMOX_USERNAME" {
  type = string
}

variable "PROXMOX_TOKEN_ID" {
  type = string
}

variable "PROXMOX_TOKEN_SECRET" {
  type      = string
  sensitive = true
}
