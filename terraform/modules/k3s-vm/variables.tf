# K3s VM module variables

variable "name" {
	type = string
}

variable "target_node" {
	type = string
}

variable "clone" {
	type = string
}

variable "memory" {
	type = number
}

variable "cores" {
	type    = number
	default = 2
}

variable "sockets" {
	type    = number
	default = 1
}

variable "cpu_type" {
	type    = string
	default = "host"
}

variable "bridge" {
	type    = string
	default = "vmbr0"
}

variable "vlan_tag" {
	type    = number
	default = 0
}

variable "ipconfig0" {
	type = string
}

variable "cloudinit_storage" {
	type = string
}

variable "disk_storage" {
	type    = string
	default = "local-lvm"
}

variable "disk_size" {
	type    = number
	default = 20
}

variable "agent" {
	type    = number
	default = 1
}

variable "full_clone" {
	type    = bool
	default = true
}

variable "onboot" {
	type    = bool
	default = true
}

variable "manage_os_disk" {
	description = "If true, explicitly define an OS disk (may conflict with clone template)."
	type        = bool
	default     = true
}

variable "nameserver" {
	type = string
	default = "8.8.8.8"
}

variable "searchdomain" {
  	type = string
	default = "lan.prpr.one"
}

variable "user_account" {
	type = string
	default = "lexun"
}

variable "user_password" {
	type = string
}

variable "vmid" {
	type        = number
	description = "VM ID"
	default     = null
}