resource "digitalocean_project" "terraform" {
  name        = "terraform"
  description = "A project to test working with terraform"
  purpose     = "API development"
  environment = "Development"
  
  resources   = [
    for droplet in  digitalocean_droplet.web:
    droplet.urn
  ]
}