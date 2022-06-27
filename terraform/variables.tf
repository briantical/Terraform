variable "do_token" {}

variable "pvt_key" {}

variable "pub_key" {}

variable "environment" {
  type = string
  default = "staging"
}

variable "environment_names" {
  type    = list(string)
  default = ["staging", "production"]
}

variable "group_name" {
  type = string
  default = "load-balancer"
}

variable "droplet_names" {
  type    = list(string)
  default = ["master", "worker-one", "worker-two"]
}
