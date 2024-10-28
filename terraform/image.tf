data "azurerm_image" "master" {
  name_regex          = "^img-${var.project}-master-[0-9]{14}$"
  resource_group_name = azurerm_resource_group.glr.name

  depends_on = [
    azurerm_resource_group.glr
  ]
}

data "azurerm_image" "slave" {
  name_regex          = "^img-${var.project}-slave-[0-9]{14}$"
  resource_group_name = azurerm_resource_group.glr.name

  depends_on = [
    azurerm_resource_group.glr
  ]
}
