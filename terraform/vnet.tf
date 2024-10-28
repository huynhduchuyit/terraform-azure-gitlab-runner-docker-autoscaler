resource "azurerm_virtual_network" "glr" {
  name                = "vnet-${var.project}"
  location            = azurerm_resource_group.glr.location
  resource_group_name = azurerm_resource_group.glr.name
  address_space       = [var.vnet_cidr]

  depends_on = [
    azurerm_resource_group.glr
  ]
}

resource "azurerm_subnet" "glr" {
  name                 = "subnet-${var.project}"
  resource_group_name  = azurerm_resource_group.glr.name
  virtual_network_name = azurerm_virtual_network.glr.name
  address_prefixes     = [var.subnet_cidr]

  depends_on = [
    azurerm_resource_group.glr,
    azurerm_virtual_network.glr
  ]
}
