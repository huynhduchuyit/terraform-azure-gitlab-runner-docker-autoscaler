resource "azurerm_network_security_group" "glr" {
  name                = "nsg-${var.project}"
  location            = azurerm_resource_group.glr.location
  resource_group_name = azurerm_resource_group.glr.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_resource_group.glr
  ]
}

resource "azurerm_network_interface_security_group_association" "glr" {
  network_interface_id      = azurerm_network_interface.glr.id
  network_security_group_id = azurerm_network_security_group.glr.id

  depends_on = [
    azurerm_network_interface.glr,
    azurerm_network_security_group.glr
  ]
}
