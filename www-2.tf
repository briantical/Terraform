resource "digitalocean_droplet" "www-2" {
  image = "ubuntu-20-04-x64"
  name = "www-2"
  region = "fra1"
  size = "s-1vcpu-1gb"
  ssh_keys = [ 
    data.digitalocean_ssh_key.terraform.id
  ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = var.pvt_key
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt update -y",
      "sudo apt install -y nginx"
    ]
  }
}