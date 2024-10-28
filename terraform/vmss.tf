resource "azurerm_linux_virtual_machine_scale_set" "glr" {
  name                = "vmss-${var.project}"
  resource_group_name = azurerm_resource_group.glr.name
  location            = azurerm_resource_group.glr.location
  sku                 = "Standard_DS1_v2"
  admin_username      = "packer"

  admin_ssh_key {
    username   = "packer"
    public_key = tls_private_key.glr.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "vmss-nic-${var.project}"
    primary = true

    ip_configuration {
      name      = "vmss-nic-ipconfig-${var.project}"
      primary   = true
      subnet_id = azurerm_subnet.glr.id
    }
  }

  source_image_id = data.azurerm_image.slave.id

  priority        = "Spot"
  eviction_policy = "Delete"

  depends_on = [
    azurerm_resource_group.glr,
    azurerm_subnet.glr,
    tls_private_key.glr
  ]
}
