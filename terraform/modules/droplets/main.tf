resource "digitalocean_droplet" "web" {
  count = length(var.droplet_names)
  image = "ubuntu-20-04-x64"
  name = var.droplet_names[count.index]
  region = "fra1"
  size = "s-1vcpu-1gb"
  ssh_keys = [ 
    data.digitalocean_ssh_key.terraform.id
  ]

  tags = ["briantical","terraform"]

  connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }

  # As was noted, the local-exec provisioner runs without waiting for the Droplet to become available, 
  # so the execution of the playbook may precede the actual availability of the Droplet. To remedy this, 
  # you define the remote-exec provisioner to contain commands to execute on the target server.
  # provisioner "remote-exec" {
  #   inline = ["echo Done!"]
  # }

  # provisioner "local-exec" {
  #   command = "cd ../../../ansible && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i 'inventories/${var.environment}/inventory' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' playbook.yml"
  # }
}

data "digitalocean_ssh_key" "terraform" {
  name = "terraform"
}

