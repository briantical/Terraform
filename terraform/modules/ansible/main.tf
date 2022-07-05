# Ansible Inventory File
resource "local_file" "ansible_inventory" {
  content = templatefile("../../templates/inventory.tmpl",{
    user = "root"
    prefix = "swarm"
    workers = [for droplet in var.droplets: droplet.ipv4_address if "${droplet.name}" != "${var.droplet_names[0]}"]
    managers = [for droplet in var.droplets: droplet.ipv4_address if "${droplet.name}" == "${var.droplet_names[0]}"]
  })
  filename = "../../../ansible/inventories/${var.environment}/inventory"

  depends_on = [
    module.droplets.droplets,
  ]
}


resource "null_resource" "ansible_provisioner" {
  triggers = {
      checksum = "${var.ansible_checksum}-${var.terraform_checksum}"
  }

  provisioner "local-exec" {
    command = "cd ../../../ansible && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'inventories/${var.environment}/inventory' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' playbook.yml"
  }

  depends_on = [
    local_file.ansible_inventory
  ]
}