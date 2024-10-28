variable "project" {
  type    = string
  default = "gitlab-runner"
}

variable "location" {
  type    = string
  default = "Southeast Asia"
}

variable "subscription_id" {
  type    = string
  default = ""
}

variable "vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "runner" {
  type = object({
    name  = string
    token = string
  })
  default = {
    name  = ""
    token = ""
  }
}
