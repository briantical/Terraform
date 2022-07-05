# Ansible Inventory File
resource "local_file" "ansible_inventory" {
  content = templatefile("../../templates/inventory.tmpl",{
    user = "root"
    prefix = "swarm"
    workers = [for droplet in var.droplets: droplet.ipv4_address if "${droplet.name}" != "${var.droplet_names[0]}"]
    managers = [for droplet in var.droplets: droplet.ipv4_address if "${droplet.name}" == "${var.droplet_names[0]}"]
  })
  filename = "../../../ansible/inventories/${var.environment}/inventory"
}


resource "null_resource" "ansible_provisioner" {
  triggers = {
      # https://stackoverflow.com/a/66501021
      ansible_sha1 = sha1(join("", [for f in fileset("../../../ansible", "**"): filesha1("../../../ansible/${f}")]))
  }

  provisioner "local-exec" {
    command = "cd ../../../ansible && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'inventories/${var.environment}/inventory' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' playbook.yml"
  }

  depends_on = [
    local_file.ansible_inventory
  ]
}