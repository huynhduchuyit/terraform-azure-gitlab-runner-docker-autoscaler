source "azure-arm" "ubuntu" {
  managed_image_name                = format("img-gitlab-runner-master-%s", formatdate("YYYYMMDDhhmmss", timestamp()))
  managed_image_resource_group_name = "gitlab-runner"
  build_resource_group_name         = "gitlab-runner"
  vm_size                           = "Standard_B1s"

  os_type         = "Linux"
  image_offer     = "ubuntu-24_04-lts"
  image_publisher = "canonical"
  image_sku       = "server-gen1"

  use_azure_cli_auth = true
}

build {
  sources = ["source.azure-arm.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt upgrade -y"
    ]
  }

  provisioner "file" {
    source      = "./master.sh"
    destination = "/tmp/"
  }

  provisioner "shell" {
    inline = [
      "bash /tmp/master.sh"
    ]
  }
}
