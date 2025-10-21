terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure     = true
}

module "server_pve" {
  source            = "../../modules/k3s-vm"
  name              = "k3s-server-pve"
  target_node       = "pve"
  clone             = var.clone_template
  memory            = var.server_memory
  cores             = 4
  sockets           = 1
  cpu_type          = "host"
  bridge            = var.bridge
  vlan_tag          = var.vlan_tag
  ipconfig0         = var.server_pve_ipconfig
  nameserver        = var.nameserver
  cloudinit_storage = var.cloudinit_storage
  disk_storage      = var.disk_storage
  disk_size         = 40
  agent             = 1
  user_password     = var.user_password
  vmid              = 7001
}

module "server_proxmox3" {
  source            = "../../modules/k3s-vm"
  name              = "k3s-server-proxmox3"
  target_node       = "proxmox3"
  clone             = var.clone_template
  memory            = var.server_memory
  cores             = 2
  sockets           = 1
  cpu_type          = "host"
  bridge            = var.bridge
  vlan_tag          = var.vlan_tag
  ipconfig0         = var.server_proxmox3_ipconfig
  nameserver        = var.nameserver
  cloudinit_storage = var.cloudinit_storage
  disk_storage      = var.disk_storage
  disk_size         = 35
  agent             = 1
  user_password     = var.user_password
  vmid              = 7003
}

module "server_proxmox2" {
  source            = "../../modules/k3s-vm"
  name              = "k3s-server-proxmox2"
  target_node       = "proxmox2"
  clone             = var.clone_template
  memory            = var.server_memory
  cores             = 2
  sockets           = 1
  cpu_type          = "host"
  bridge            = var.bridge
  vlan_tag          = var.vlan_tag
  ipconfig0         = var.server_proxmox2_ipconfig
  nameserver        = var.nameserver
  cloudinit_storage = var.cloudinit_storage
  disk_storage      = "local-lvm"
  disk_size         = 30
  agent             = 1
  user_password     = var.user_password
  vmid              = 7002
}


module "agent_proxmox3" {
  source            = "../../modules/k3s-vm"
  name              = "k3s-agent-proxmox3"
  target_node       = "proxmox3"
  clone             = var.clone_template
  memory            = var.agent_memory
  cores             = var.agent_cores
  sockets           = 1
  cpu_type          = "host"
  bridge            = var.bridge
  vlan_tag          = var.vlan_tag
  ipconfig0         = var.agent_proxmox3_ipconfig
  nameserver        = var.nameserver
  cloudinit_storage = var.cloudinit_storage
  disk_storage      = var.disk_storage
  disk_size         = 50
  agent             = 1
  user_password     = var.user_password
  vmid              = 7013
}

module "agent_proxmox2" {
  source            = "../../modules/k3s-vm"
  name              = "k3s-agent-proxmox2"
  target_node       = "proxmox2"
  clone             = var.clone_template
  memory            = var.agent_memory
  cores             = var.agent_cores
  sockets           = 1
  cpu_type          = "host"
  bridge            = var.bridge
  vlan_tag          = var.vlan_tag
  ipconfig0         = var.agent_proxmox2_ipconfig
  nameserver        = var.nameserver
  cloudinit_storage = var.cloudinit_storage
  disk_storage      = var.disk_storage_pve2
  disk_size         = 40
  agent             = 1
  user_password     = var.user_password
  vmid              = 7012
}

module "agent_pve" {
  source            = "../../modules/k3s-vm"
  name              = "k3s-agent-pve"
  target_node       = "pve"
  clone             = var.clone_template
  memory            = var.agent_memory
  cores             = 3
  sockets           = 1
  cpu_type          = "host"
  bridge            = var.bridge
  vlan_tag          = var.vlan_tag
  ipconfig0         = var.agent_pve_ipconfig
  nameserver        = var.nameserver
  cloudinit_storage = var.cloudinit_storage
  disk_storage      = var.disk_storage
  disk_size         = 100
  agent             = 1
  user_password     = var.user_password
  vmid              = 7011
}

output "server_pve_vmid" {
  value = module.server_pve.vmid
}

output "server_proxmox3_vmid" {
  value = module.server_proxmox3.vmid
}

output "agents_vmids" {
  value = [
    module.agent_proxmox3.vmid,
    module.agent_proxmox2.vmid,
    module.agent_pve.vmid,
  ]
}