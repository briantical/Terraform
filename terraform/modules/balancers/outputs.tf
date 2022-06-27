output "balancer_ip" {
  value = digitalocean_loadbalancer.load-balancer.ip
}

output "balancer_urn" {
  value = digitalocean_loadbalancer.load-balancer.urn
}