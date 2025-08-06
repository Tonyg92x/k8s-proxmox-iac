terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "3.0.2-rc03"
        }
    }
}

provider "proxmox" {
    pm_api_url          = var.pm_api_url
    pm_api_token_id     = var.pm_api_token_id
    pm_api_token_secret = var.pm_api_token_secret
    pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "k8s-master" {
    count               = var.k8s_master_nb
    name                = "k8s-master-${count.index + 1}"
    description         = "K8s master node ${count.index + 1}"
    vmid                = 100 + count.index
    target_node         = var.pm_node_1
    onboot              = true
    tablet              = true
    agent               = 1
    clone               = "debian-12-template"
    full_clone          = true
    memory              = 4096
    scsihw              = "virtio-scsi-pci"
    tags                = "k8s-master,debian-12"
    os_type             = "debian"
    skip_ipv6           = true
    ci_wait             = 10
    ciuser              = var.cloudinit_username
    cipassword          = var.cloudinit_password
    sshkeys             = var.cloudinit_ssh_pub
    searchdomain        = var.cloudinit_searchdomain
    nameserver          = var.cloudinit_dns
    ipconfig0           = var.cloudinit_ipconfig
    ciupgrade           = true

    cpu {
        cores           = 2
        sockets         = 1
        type            = "x86-64-v2-AES"
    }

    disks {
        scsi {
            scsi0 {
                disk {
                    size            = "32G"
                    storage         = "local-lvm"
                }
            }
            scsi1 {
                cloudinit {
                    storage         = "local-lvm"
                }
            }
        }
    }

    network {
        id          = 0
        model       = "virtio"
        bridge      = "vmbr0"
        firewall    = false
    }
}

resource "proxmox_vm_qemu" "k8s-worker" {
    count               = var.k8s_worker_nb
    name                = "k8s-worker-${count.index + 1}"
    description         = "K8s worker node ${count.index + 1}"
    vmid                = 200 + count.index
    target_node         = var.pm_node_1
    onboot              = true
    tablet              = true
    agent               = 1
    clone               = "debian-12-template"
    full_clone          = true
    memory              = 3072
    scsihw              = "virtio-scsi-pci"
    tags                = "k8s-node,debian-12"
    os_type             = "debian"
    skip_ipv6           = true
    ci_wait             = 10
    ciuser              = var.cloudinit_username
    cipassword          = var.cloudinit_password
    sshkeys             = var.cloudinit_ssh_pub
    searchdomain        = var.cloudinit_searchdomain
    nameserver          = var.cloudinit_dns
    ipconfig0           = var.cloudinit_ipconfig
    ciupgrade           = true

    cpu {
        cores           = 2
        sockets         = 1
        type            = "x86-64-v2-AES"
    }

    disks {
        scsi {
            scsi0 {
                disk {
                    size            = "32G"
                    storage         = "local-lvm"
                }
            }
            scsi1 {
                cloudinit {
                    storage         = "local-lvm"
                }
            }
        }
    }

    network {
        id          = 0
        model       = "virtio"
        bridge      = "vmbr0"
        firewall    = false
    }
}
