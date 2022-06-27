variable "do_token" {}

variable "pvt_key" {}

variable "pub_key" {}

variable "environment" {
  type = string
  default = "production"
}

variable "droplet_names" {
  type    = list(string)
  default = ["master", "worker-one", "worker-two"]
}