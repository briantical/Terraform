resource "digitalocean_project" "terraform" {
  name = var.environment
  description = "A project to test working with terraform"
  purpose     = "API development"
  environment = "Development"
  resources   = var.resources
}