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

variable "init_script_for_aem_author_vm" {
  description = "The path to init script file which will be executed after provisioned VMs for AEM Author instances"
  default = "./scripts/init-aem-author.sh"
}

variable "init_script_for_aem_publish_vm" {
  description = "The path to init script file which will be executed after provisioned VMs for AEM Publish instances"
  default = "./scripts/init-aem-publish.sh"
}

variable "init_script_for_dispatcher_vm" {
  description = "The path to init script file which will be executed after provisioned VMs for AEM Dispatcher instances"
  default = "./scripts/init-dispatcher.sh"
}