variable "PROXMOX_URL" {
  type = string
}

variable "PROXMOX_TOKEN_ID" {
  type = string
}

variable "PROXMOX_TOKEN_SECRET" {
  type      = string
  sensitive = true
}
