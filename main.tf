# Configure required provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main_resource_group" {
  name = var.resource_group_name
  location = var.location
}

module "aem_networking" {
  source = "./modules/terraform-azure-networking"
  location = var.location
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.main_resource_group]
}

module "aem_author" {
  source = "./modules/terraform-azure-linux-vm"
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = module.aem_networking.vnet_subnet_id
  ssh_public_key = var.ssh_public_key
  depends_on = [
    azurerm_resource_group.main_resource_group,
    module.aem_networking.vnet_subnet_id]
  vm_name = "aem-author"
  vm_size = "Standard_D2as_v4"
  custom_data = filebase64(var.init_script_for_aem_author_vm)
  domain_name = "aemauthor"
}

module "aem_publish" {
  source = "./modules/terraform-azure-linux-vm"
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = module.aem_networking.vnet_subnet_id
  ssh_public_key = var.ssh_public_key
  depends_on = [
    azurerm_resource_group.main_resource_group,
    module.aem_networking.vnet_subnet_id]
  vm_name = "aem-publish"
  vm_size = "Standard_D2as_v4"
  custom_data = filebase64(var.init_script_for_aem_publish_vm)
  domain_name = "aempublish"
}

module "aem_dispatcher" {
  source = "./modules/terraform-azure-linux-vm"
  location = var.location
  resource_group_name = var.resource_group_name
  subnet_id = module.aem_networking.vnet_subnet_id
  ssh_public_key = var.ssh_public_key
  depends_on = [
    azurerm_resource_group.main_resource_group,
    module.aem_networking.vnet_subnet_id]
  vm_name = "aem-dispatcher"
  vm_size = "Standard_DS1_v2"
  custom_data = filebase64(var.init_script_for_dispatcher_vm)
  domain_name = "aemdispatcher"
}

output "aem_author_public_ip_address" {
  value = module.aem_author.public_ip_address
}

output "aem_author_dns_name" {
  value = module.aem_author.fqdn
}

output "aem_publish_public_ip_address" {
  value = module.aem_publish.public_ip_address
}

output "aem_publish_dns_name" {
  value = module.aem_publish.fqdn
}

output "aem_dispatcher_public_ip_address" {
  value = module.aem_dispatcher.public_ip_address
}

output "aem_dispatcher_dns_name" {
  value = module.aem_dispatcher.fqdn
}

