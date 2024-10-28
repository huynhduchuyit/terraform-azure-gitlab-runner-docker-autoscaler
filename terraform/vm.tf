resource "azurerm_linux_virtual_machine" "glr" {
  name                = "vm-${var.project}"
  resource_group_name = azurerm_resource_group.glr.name
  location            = azurerm_resource_group.glr.location
  size                = "Standard_B1s"
  admin_username      = "ubuntu"

  network_interface_ids = [azurerm_network_interface.glr.id]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = tls_private_key.glr.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Copy SSH private key
  provisioner "file" {
    content     = tls_private_key.glr.private_key_pem
    destination = "/home/ubuntu/.ssh/id_rsa"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.glr.private_key_pem
      host        = azurerm_public_ip.glr.ip_address
    }
  }

  # Copy config.toml to /etc/gitlab-runner/config.toml
  provisioner "file" {
    content     = local.gitlab_runner_config
    destination = "/tmp/config.toml"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.glr.private_key_pem
      host        = azurerm_public_ip.glr.ip_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/config.toml /etc/gitlab-runner/config.toml",
      "sudo systemctl restart gitlab-runner"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.glr.private_key_pem
      host        = azurerm_public_ip.glr.ip_address
    }
  }

  source_image_id = data.azurerm_image.master.id

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_resource_group.glr,
    azurerm_linux_virtual_machine_scale_set.glr,
    azurerm_network_interface.glr,
    azurerm_public_ip.glr,
    tls_private_key.glr
  ]
}
