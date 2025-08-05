packer {
  required_plugins {
    proxmox = {
      source  = "github.com/hashicorp/proxmox"
      version = "~> 1.2.3"
    }
  }
}

variable "domain_name" {
    type = string
}

variable "proxmox_url" {
  type = string
}

variable "proxmox_username" {
  type = string
  sensitive = true
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "vm_name" {
  type    = string
  default = "debian-cis"
}

variable "storage_pool" {
  type      = string
}

variable "disk_size" {
  type    = string
  default = "32G"
}

source "proxmox-iso" "debian-12-cis" {
  proxmox_url               = var.proxmox_url
  username                  = var.proxmox_username
  password                  = var.proxmox_password
  insecure_skip_tls_verify  = true

  node                      = "pmox-s01"
  vm_name                   = var.vm_name
  vm_id                     = 9000
  tags                      = "debian-12;template"
  cpu_type                  = "x86-64-v2-AES"
  cores                     = 2
  memory                    = 2048
  qemu_agent                = true
  onboot                    = true
  template_name             = "debian-12-template"
  cloud_init                = true
  cloud_init_storage_pool   = "pmox-nas"

  ssh_username              = "packer"
  ssh_password              = "packer"
  ssh_timeout               = "20m"

  disks {
        type                = "scsi"
        disk_size           = var.disk_size
        storage_pool        = var.storage_pool
    }

  boot_iso {
    type                    = "scsi"
    iso_file                = "pmox-nas:iso/debian-12.11.0-amd64-netinst.iso"
    unmount                 = true
    iso_checksum            = "sha512:0921d8b297c63ac458d8a06f87cd4c353f751eb5fe30fd0d839ca09c0833d1d9934b02ee14bbd0c0ec4f8917dde793957801ae1af3c8122cdf28dde8f3c3e0da"
  }

  network_adapters {
    model                   = "virtio"
    bridge                  = "vmbr0"
    firewall                = false
  }

  boot_command = [
    "<esc><wait>",
    "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "debian-installer=en_US auto locale=en_US ",
    "kbd-chooser/method=us ",
    "hostname=debian-12-cis ",
    "fb=false debconf/frontend=noninteractive ",
    "initrd=/install.amd/initrd.gz -- <enter>"
  ]

  http_directory            = "packer-debian-cis/http"
}

build {
  name    = "debian-12.11.0-cis"
  sources = ["source.proxmox-iso.debian-12-cis"]

  provisioner "shell" {
    inline = ["echo 'Provisioning done'"]
  }

  provisioner "shell" {
    script = "packer-debian-cis/scripts/cleanup.sh"
    execute_command = "echo 'packer' | sudo -S sh '{{ .Path }}'"
  }
}
