# Ansible Inventory File
resource "local_file" "ansible_inventory" {
  content = templatefile("./templates/inventory.tmpl",{
    user = "root"
    prefix = "swarm"
    workers = [for droplet in var.droplets: droplet.ipv4_address if "${droplet.name}" != "${var.droplet_names[0]}"]
    managers = [for droplet in var.droplets: droplet.ipv4_address if "${droplet.name}" == "${var.droplet_names[0]}"]
  })
  filename = "../../../ansible/inventories/${var.environment}/inventory"
}