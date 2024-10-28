locals {
  gitlab_runner_config = templatefile("${path.module}/config.toml", {
    runner_name  = var.runner.name
    runner_token = var.runner.token

    vmss_name       = azurerm_linux_virtual_machine_scale_set.glr.name
    subscription_id = var.subscription_id
    rg_name         = var.project
  })
}
