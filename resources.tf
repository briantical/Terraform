# Digital Ocean Project
resource "digitalocean_project" "terraform" {
  name        = "terraform"
  description = "A project to test working with terraform"
  purpose     = "API development"
  environment = "Development"
  
  resources   = digitalocean_droplet.web[*].urn
}

# Ansible Inventory File
resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",{
    user = "root"
    prefix = "swarm"
    workers = [for droplet in digitalocean_droplet.web: droplet.ipv4_address if "${droplet.name}" != "${var.droplet_names[0]}"]
    managers = [for droplet in digitalocean_droplet.web: droplet.ipv4_address if "${droplet.name}" == "${var.droplet_names[0]}"]
  })
  filename = "inventory"
}