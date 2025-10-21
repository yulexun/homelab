# k3s-vm Terraform Module

Reusable module to create a cloud-init based VM for k3s on Proxmox VE using the Telmate/proxmox provider.

Assumptions
- You clone from a cloud-init ready template that already has the cloud-init drive attached (usually ide2).
- Storage, network bridge, and VLAN are provided via variables.

Inputs
- name (string): VM name
- target_node (string): Proxmox node name (e.g., pve)
- clone (string): Source template name
- memory (number): RAM in MiB
- cores (number): vCPU cores
- sockets (number): CPU sockets
- cpu_type (string): CPU model (default host)
- bridge (string): Network bridge (default vmbr0)
- vlan_tag (number): VLAN tag (0 to disable)
- ipconfig0 (string): Cloud-init IP configuration
- cloudinit_storage (string): Storage for cloud-init if you later manage the disk block yourself (not used currently)
- disk_storage (string): Storage for OS disk if manage_os_disk=true
- disk_size (string): OS disk size (e.g., 20G)
- agent (number): 1 to enable qemu-guest-agent
- full_clone (bool): Full or linked clone
- onboot (bool): Start on boot
- manage_os_disk (bool): If true, add an OS disk block (scsi0)

Notes
- If your template does not include a cloud-init drive, you can update this module to add a disk block of type cloudinit in slot ide2 or use the disks nested block as per your provider version.
- Boot order defaults to scsi0;net0 and relies on the template to have a bootable OS disk.