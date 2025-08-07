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

variable "eneable_data_network" {
  type = bool
  default = false
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
}

variable "cloudinit_dns" {
  type = string
}

variable "cloudinit_subnet" {
  type = string
}

variable "cloudinit_net_first_ip_master" {
  type = number
}

variable "cloudinit_net_first_ip_worker" {
  type = number
}

variable "cloudinit_gateway" {
  type = string
}

variable "cloudinit_subnet_data" {
  type = string
  default = "Null"
}

variable "cloudinit_net_first_ip_data" {
  type = string
  default = "Null"
}

variable "cloudinit_gateway_data" {
  type = string
  default = "Null"
}
