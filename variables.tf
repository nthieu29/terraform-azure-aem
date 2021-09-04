variable "location" {
  description = "This is the cloud hosting location where your infrastructure will be deployed"
  default = "Southeast Asia"
}

variable "resource_group_name" {
  description = "This is the name of resource group"
  default = "aem-wknd-demo"
}

variable "ssh_public_key" {
  description = "The value of SSH public key"
}