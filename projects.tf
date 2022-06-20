resource "digitalocean_project" "terraform" {
  name        = "terraform"
  description = "A project to test working with terraform"
  purpose     = "API development"
  environment = "Development"
  resources   = [digitalocean_droplet.web[count.index].urn]
}