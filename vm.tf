resource "azurerm_linux_virtual_machine" "testvm" {
  name                = "testvm"
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform-github-actions.name
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vmnic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}



resource "azurerm_network_interface" "vmnic" {
  name                = "vmnic"
  location            = var.location
  resource_group_name = azurerm_resource_group.terraform-github-actions.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}