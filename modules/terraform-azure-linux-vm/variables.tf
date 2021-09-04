variable "location" {
  description = "This is the cloud hosting location where your vm will be deployed"
  default = "Southeast Asia"
}

variable "resource_group_name" {
  description = "This is the name of resource group"
}

variable "subnet_id" {
  description = "ID of subnet which VM will be attached to"
}

variable "ssh_public_key" {
  description = "The value of SSH public key"
}

variable "vm_name" {
  description = "Name of VM"
}

variable "custom_data" {
  description = "Custom Data which should be used for this Virtual Machine"
  default = ""
}

variable "vm_size" {
  description = "Size of VM"
  default = "Standard_D2as_v4"
}

variable "domain_name" {
  description = "Domain name of VM"
}