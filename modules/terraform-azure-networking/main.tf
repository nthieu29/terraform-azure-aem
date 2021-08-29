module "network-security-group" {
  source = "Azure/network-security-group/azurerm"
  resource_group_name = var.resource_group_name
  location = var.location
  security_group_name = "aem-nsg"
  predefined_rules = [
    {
      name = "SSH"
      priority = "500"
    },
    {
      name = "HTTP"
      priority = "600"
    }
  ]
}

module "vnet" {
  source = "Azure/vnet/azurerm"
  vnet_name = "aem-vnet"
  resource_group_name = var.resource_group_name
  address_space = [
    "10.2.0.0/16"]
  subnet_prefixes = [
    "10.2.1.0/24"]
  subnet_names = [
    "public"]

  nsg_ids = {
    public = module.network-security-group.network_security_group_id
  }
}