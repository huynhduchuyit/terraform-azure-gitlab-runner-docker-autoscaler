resource "azurerm_role_definition" "glr_master_role" {
  name  = "gitlab-runner-master"
  scope = azurerm_resource_group.glr.id

  permissions {
    actions = [
      "Microsoft.Compute/virtualMachineScaleSets/*"
    ]
  }

  depends_on = [
    azurerm_resource_group.glr
  ]
}

resource "azurerm_role_assignment" "glr_assign_master_role" {
  scope              = azurerm_resource_group.glr.id
  role_definition_id = azurerm_role_definition.glr_master_role.role_definition_resource_id
  principal_id       = azurerm_linux_virtual_machine.glr.identity[0].principal_id

  depends_on = [
    azurerm_resource_group.glr,
    azurerm_role_definition.glr_master_role,
    azurerm_linux_virtual_machine.glr
  ]
}
