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
}

output "aem_author_public_ip_address" {
  value = module.aem_author.public_ip_address
}

