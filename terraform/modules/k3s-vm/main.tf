terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}

resource "proxmox_vm_qemu" "this" {
  name        = var.name
  target_node = var.target_node
  vmid        = var.vmid

  clone      = var.clone
  full_clone = var.full_clone

  agent = 1
  os_type = "cloud-init"
  onboot = var.onboot
#   cores   = var.cores
#   sockets = var.sockets
  # memory  = var.memory
  # cpu {
  #       cores = var.cores
  #       type = "host"
  #   }

  # scsihw  = "virtio-scsi-single"
  # os_type = "cloud-init"

  # # Rely on the clone source template to provide the cloud-init drive (ide2)

  # # Optionally define an OS disk if template does not provide one
  # dynamic "disk" {
  #   for_each = var.manage_os_disk ? [1] : []
  #   content {
  #     slot    = "scsi0"
  #     type    = "disk"
  #     storage = var.disk_storage
  #     size    = var.disk_size
  #     iothread = true
  #   }
  # }
    cpu {
        cores = var.cores
        sockets = var.sockets
    }
    memory = var.memory
    scsihw  = "virtio-scsi-pci"

    # Setup the disks using the newer disks block
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = var.cloudinit_storage
                }
            }
        }
        
        # Optionally define an OS disk if template does not provide one
        dynamic "scsi" {
            for_each = var.manage_os_disk ? ["scsi0"] : []
            content {
                scsi0 {
                    disk {
                        storage = var.disk_storage
                        size = var.disk_size
                        iothread = true
                    }
                }
            }
        }
    }

  network {
    id = 0
    model  = "virtio"
    bridge = var.bridge
    tag    = var.vlan_tag
  }

  ipconfig0 = var.ipconfig0
  nameserver = var.nameserver
  searchdomain = var.searchdomain
  boot        = "order=scsi0"
  cicustom   = "vendor=plexlib:snippets/qemu-guest-agent.yml"
  ciupgrade  = true
  skip_ipv6  = true
  ciuser = var.user_account
  cipassword = var.user_password
  sshkeys = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTybEjma1hLkjxfGnCylRKOGbxgq4dPeq2QxgP1tv+ceFjVpBT0ZDmKv7TLeLBAd6vc1AVdTJEZLqnYZBirzCFcsNQmyXhLEii+9yUgXKMJ4h3vfT0bZf0HZ3hvTjUw/pzwKVDheqZygTI+HJ8yEoz8KWVm7Ip9KCvg/wonzSHfCCIVNjFblBC3WqhihbCueTj2etwAUxFTDHuJvwju5PPst2GL+gk2wNna09qFmvYLqmBOnJ3rbHcgecVjrGwDGbXpEg+IjnaDAvVKolGE4F4BmmivQl+ALuhV7czm46W2V7QlInd5K/5TLKu1V6jyCJkRdCb68G6kj8E8WomY4mg11Dc8jwDXkfBXYKsq5pHrZFcNlq/TF85v8OwloEJysXJ2a++CD23lmue1PbT0/Jaxw1zrip6oIl0+f9iq56q2n8OoDS3+FxznKkzOe1eB+1oqSQdeQdcmoSqq7EWIf+niaEi420fFfwpDbkxA0ZV8VGp2wzqqyzynck1dDdwhsIl4mTLc6TBWYv9aed2XIqb57k/OHXMpopUYBaduzZSiVRtBqCIz+2dE9cGGC3urvDYKiaer89mc+psse+Ga40HeXli5TJrYkQjTUf8Efi7Xv9jqy68rYMnTKLtDZ70voCfXYMuwxo7RL/Iklea5L+La5mpPY6v5WNFsGL1zCHGlQ== lexun@op
  EOF
  serial {
    id = 0
  }

  lifecycle {
    ignore_changes = [
      # Avoid churn when source template updates
      clone,
      full_clone,
      # Cloud-init assigns fields that can drift
      ipconfig0,
      network,
      tags,
    ]
  }
}
