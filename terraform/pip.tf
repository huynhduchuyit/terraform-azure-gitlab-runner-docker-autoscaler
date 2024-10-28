resource "azurerm_public_ip" "glr" {
  name                = "pip-${var.project}"
  resource_group_name = azurerm_resource_group.glr.name
  location            = azurerm_resource_group.glr.location
  allocation_method   = "Static"

  depends_on = [
    azurerm_resource_group.glr
  ]
}
