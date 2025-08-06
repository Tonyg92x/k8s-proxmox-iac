variable "pm_api_url" {
  type = string
}

variable "pm_api_token_id" {
    type = string
    sensitive = true
}

variable "pm_api_token_secret" {
  type = string
  sensitive = true
}

variable "pm_node_1" {
  type = string
}

variable "k8s_master_nb" {
  type = number
}

variable "k8s_worker_nb" {
  type = number
}

variable "cloudinit_username" {
  type = string
  sensitive = true
}

variable "cloudinit_password" {
  type = string
  sensitive = true
}

variable "cloudinit_ssh_pub" {
  type = string
  sensitive = true
}

variable "cloudinit_searchdomain" {
  type = string
  sensitive = true
}

variable "cloudinit_dns" {
  type = string
  sensitive = true
}

variable "cloudinit_ipconfig" {
  type = string
  sensitive = true
}
