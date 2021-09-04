resource "azurerm_public_ip" "vm_public_ip_address" {
  name = "${var.vm_name}-public-ip-address"
  resource_group_name = var.resource_group_name
  location = var.location
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "vm_nic" {
  name = "${var.vm_name}-vm-nic"
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name = "internal"
    subnet_id = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_public_ip_address.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name = var.vm_name
  resource_group_name = var.resource_group_name
  location = var.location
  size = var.vm_size
  admin_username = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id]

  admin_ssh_key {
    username = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer = "0001-com-ubuntu-server-focal"
    sku = "20_04-lts"
    version = "latest"
  }
  custom_data = var.custom_data
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}