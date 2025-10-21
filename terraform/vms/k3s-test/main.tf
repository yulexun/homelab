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