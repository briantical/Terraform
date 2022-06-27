output "droplet_ip_addresses" {
  value = digitalocean_droplet.web[*].ipv4_address
}

output "droplet_ids" {
  value = digitalocean_droplet.web[*].id
}

output "droplet_urns" {
  value = digitalocean_droplet.web[*].urn
}

output "droplets" {
  value = digitalocean_droplet.web[*]
}