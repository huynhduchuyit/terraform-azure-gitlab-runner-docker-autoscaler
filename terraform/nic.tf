resource "azurerm_network_interface" "glr" {
  name                = "nic-${var.project}"
  location            = azurerm_resource_group.glr.location
  resource_group_name = azurerm_resource_group.glr.name

  ip_configuration {
    name                          = "nic-ipconfig-${var.project}"
    subnet_id                     = azurerm_subnet.glr.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.glr.id
  }

  depends_on = [
    azurerm_resource_group.glr,
    azurerm_subnet.glr,
    azurerm_public_ip.glr
  ]
}
