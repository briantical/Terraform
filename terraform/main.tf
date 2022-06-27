module "projects-staging" {
  source = "./modules/projects"

  do_token = var.do_token
  resources = concat( module.staging.droplet_urns, tolist([module.balancers-staging.balancer_urn]) )
  environment = "staging"
}

module "projects-production" {
  source = "./modules/projects"

  do_token = var.do_token
  resources = concat( module.production.droplet_urns, tolist([module.balancers-production.balancer_urn]) )
  environment = "production"
}

module "staging" {
  source = "./modules/droplets"

  do_token = var.do_token
  pvt_key = var.pvt_key
  pub_key = var.pub_key
  droplet_names = var.droplet_names
}

module "production" {
  source = "./modules/droplets"

  do_token = var.do_token
  pvt_key = var.pvt_key
  pub_key = var.pub_key
  droplet_names = var.droplet_names
}

module "ansible-staging" {
  source = "./modules/ansible"

  do_token = var.do_token
  droplet_names = var.droplet_names
  droplets = module.staging.droplets
  environment = "staging"
}

module "ansible-production" {
  source = "./modules/ansible"

  do_token = var.do_token
  droplet_names = var.droplet_names
  droplets = module.production.droplets
  environment = "production"
}

module "balancers-staging" {
  source = "./modules/balancers"

  do_token = var.do_token
  group_name = "${var.group_name}-staging"
  droplet_ids = module.staging.droplet_ids
}

module "balancers-production" {
  source = "./modules/balancers"

  do_token = var.do_token
  group_name = "${var.group_name}-production"
  droplet_ids = module.production.droplet_ids
}

output "loadbalancer-production-ip" {
  value = module.balancers-production.balancer_ip
}

output "loadbalancer-staging-ip" {
  value = module.balancers-staging.balancer_ip
}