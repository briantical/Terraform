variable "do_token" {}

variable "pvt_key" {}

variable "pub_key" {}

variable "environment" {
  type = string
  default = "master"
}

variable "droplet_names" {
  type    = list(string)
  default = ["master", "worker-one", "worker-two"]
}

variable "ansible_checksum" {}

variable "terraform_checksum" {}
