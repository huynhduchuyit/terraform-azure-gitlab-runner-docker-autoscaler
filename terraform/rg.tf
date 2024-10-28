resource "azurerm_resource_group" "glr" {
  name     = var.project
  location = var.location
}
