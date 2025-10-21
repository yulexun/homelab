variable "pm_api_url" { type = string }
variable "pm_api_token_id" { type = string }
variable "pm_api_token_secret" {
	type      = string
	sensitive = true
}

variable "clone_template" {
	type        = string
	description = "Cloud-init ready template name"
}

variable "bridge" {
	type    = string
	default = "vmbr0"
}
variable "vlan_tag" {
	type    = number
	default = 0
}

variable "cloudinit_storage" {
	type        = string
	description = "Storage where cloud-init drive resides"
}
variable "disk_storage" {
	type    = string
	default = "local-lvm"
}

variable "disk_storage_pve2" {
    type    = string
	default = "local-lvm"
}

variable "disk_size" {
	type    = number
	default = 20
}

variable "server_pve_ipconfig" { type = string }
variable "server_proxmox2_ipconfig" { type = string }
variable "server_proxmox3_ipconfig" { type = string }
variable "agent_proxmox3_ipconfig" { type = string }
variable "agent_proxmox2_ipconfig" { type = string }
variable "agent_pve_ipconfig" { type = string }

variable "server_memory" {
  type = number
  default = 4096
}
variable "agent_memory" {
	type    = number
	default = 3072
}
variable "agent_cores" {
	type    = number
	default = 3
}

variable "nameserver" {
	type = string
	default = "8.8.8.8"
}

variable "user_password" {
  type = string
  sensitive = true
}