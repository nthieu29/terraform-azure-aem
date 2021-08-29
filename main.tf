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

