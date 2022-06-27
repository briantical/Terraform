resource "digitalocean_loadbalancer" "load-balancer" {
  name   = "lb-${var.group_name}"
  region = "fra1"

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  healthcheck {
    port     = 22
    protocol = "tcp"
  }

  droplet_ids = var.droplet_ids
}