variable "vm_name" {
  type      = string
  default   = "debian-cis"
}

variable "disk_size" {
  type    = number
  default = 20480
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "ssh_password" {
  type      = string
  sensitive = true
  default   = "packer"
}

packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
  }
}

source "qemu" "debian" {
  iso_url            = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso"
  iso_checksum       = "sha256:9c418e3a7b4c09f4e3fdc89cd99f938c5e021c3bd8c3a1a0a3ae3db91c7c122e"
  output_directory   = "output/${var.vm_name}"
  shutdown_command   = "shutdown -P now"
  format             = "qcow2"
  headless           = true
  accelerator        = "kvm"
  boot_wait          = "10s"
  vm_name            = var.vm_name
  disk_size          = var.disk_size
  http_directory     = "http"
  ssh_username       = var.ssh_username
  ssh_password       = var.ssh_password
  ssh_timeout        = "20m"

  boot_command = [
    "<esc><wait>",
    "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "debian-installer=en_US auto locale=en_US ",
    "kbd-chooser/method=us ",
    "hostname={{ .Name }} ",
    "fb=false debconf/frontend=noninteractive ",
    "initrd=/install.amd/initrd.gz -- <enter>"
  ]
}

build {
  name    = "debian-cis"
  sources = ["source.qemu.debian"]

  provisioner "shell" {
    inline = [
      "echo 'Provisioning done.'"
    ]
  }

  provisioner "shell" {
    script = "scripts/cleanup.sh"
  }
}
