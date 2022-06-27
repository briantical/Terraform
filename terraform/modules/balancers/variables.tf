variable "do_token" {}

variable "group_name" {}

variable "droplet_ids" {
  type = list(string)
  default = [ ]
}