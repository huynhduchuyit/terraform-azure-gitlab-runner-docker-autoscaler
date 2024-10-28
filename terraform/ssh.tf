resource "tls_private_key" "glr" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
